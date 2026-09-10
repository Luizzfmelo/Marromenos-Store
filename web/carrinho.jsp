<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<c:set var="tituloPagina" value="Carrinho" scope="request"/>
<c:import url="/includes/header.jsp"/>

<div class="container">
    <h1 style="color:#ff8c00;">Seu carrinho</h1>

    <c:choose>
        <c:when test="${empty sessionScope.carrinho}">
            <div class="vazio">
                Seu carrinho está vazio. <br>
                <a href="${pageContext.request.contextPath}/catalogo" class="btn" style="margin-top:14px;">Ver catálogo</a>
            </div>
        </c:when>
        <c:otherwise>
            <div style="display:flex; gap:30px; flex-wrap:wrap;">
                <div style="flex:2; min-width:300px;">
                    <c:set var="subtotal" value="0"/>
                    <c:forEach var="entry" items="${sessionScope.carrinho}">
                        <c:set var="item" value="${entry.value}"/>
                        <c:set var="linhaSub" value="${item.produto.preco * item.quantidade}"/>
                        <c:set var="subtotal" value="${subtotal + linhaSub}"/>
                        <div class="carrinho-item">
                            <img src="${item.produto.imagemUrl}" alt="${item.produto.nome}">
                            <div class="info">
                                <strong>${item.produto.nome}</strong><br>
                                <span style="color:#999; font-size:13px;">${item.produto.tamanho} / ${item.produto.cor}</span><br>
                                <fmt:formatNumber value="${item.produto.preco}" type="currency" currencySymbol="R$ "/> cada
                            </div>
                            <form method="get" action="${pageContext.request.contextPath}/carrinho" style="display:flex; align-items:center; gap:8px;">
                                <input type="hidden" name="acao" value="atualizar">
                                <input type="hidden" name="produtoId" value="${item.produto.id}">
                                <input type="number" name="quantidade" value="${item.quantidade}" min="1" max="${item.produto.estoque}">
                                <button type="submit" class="btn-outline btn" style="padding:8px 14px;">Atualizar</button>
                            </form>
                            <strong><fmt:formatNumber value="${linhaSub}" type="currency" currencySymbol="R$ "/></strong>
                            <a href="${pageContext.request.contextPath}/carrinho?acao=remover&produtoId=${item.produto.id}" class="btn btn-perigo" style="padding:8px 14px;">Remover</a>
                        </div>
                    </c:forEach>

                    <a href="${pageContext.request.contextPath}/carrinho?acao=limpar" style="color:#999; font-size:13px;">Esvaziar carrinho</a>
                </div>

                <div style="flex:1; min-width:280px;">
                    <div class="resumo-box">
                        <h3 style="margin-top:0; color:#ff8c00;">Resumo</h3>

                        <c:if test="${not empty sessionScope.erroCupom}">
                            <div class="alerta alerta-erro" style="font-size:13px;">${sessionScope.erroCupom}</div>
                            <c:remove var="erroCupom" scope="session"/>
                        </c:if>

                        <c:choose>
                            <c:when test="${not empty sessionScope.cupomAplicado}">
                                <div class="alerta alerta-sucesso" style="font-size:13px;">
                                    Cupom "${sessionScope.cupomAplicado.codigo}" aplicado!
                                </div>
                                <a href="${pageContext.request.contextPath}/carrinho?acao=removerCupom" style="font-size:12px; color:#999;">Remover cupom</a>
                            </c:when>
                            <c:otherwise>
                                <form method="get" action="${pageContext.request.contextPath}/carrinho">
                                    <input type="hidden" name="acao" value="aplicarCupom">
                                    <label for="codigo">Cupom de desconto</label>
                                    <div style="display:flex; gap:8px;">
                                        <input type="text" id="codigo" name="codigo" placeholder="Ex: BEMVINDO10">
                                        <button type="submit" class="btn-outline btn">Aplicar</button>
                                    </div>
                                </form>
                            </c:otherwise>
                        </c:choose>

                        <hr style="border-color:#2b2b2b; margin:16px 0;">

                        <div class="linha"><span>Subtotal</span><span><fmt:formatNumber value="${subtotal}" type="currency" currencySymbol="R$ "/></span></div>

                        <c:set var="desconto" value="0"/>
                        <c:if test="${not empty sessionScope.cupomAplicado}">
                            <c:choose>
                                <c:when test="${sessionScope.cupomAplicado.tipoDesconto == 'PERCENTUAL'}">
                                    <c:set var="desconto" value="${subtotal * sessionScope.cupomAplicado.valor / 100}"/>
                                </c:when>
                                <c:otherwise>
                                    <c:set var="desconto" value="${sessionScope.cupomAplicado.valor}"/>
                                </c:otherwise>
                            </c:choose>
                            <div class="linha"><span>Desconto</span><span>- <fmt:formatNumber value="${desconto}" type="currency" currencySymbol="R$ "/></span></div>
                        </c:if>

                        <div class="linha total"><span>Total</span><span><fmt:formatNumber value="${subtotal - desconto}" type="currency" currencySymbol="R$ "/></span></div>

                        <a href="${pageContext.request.contextPath}/checkout" class="btn" style="width:100%; text-align:center; margin-top:16px; display:block;">Finalizar compra</a>
                    </div>
                </div>
            </div>
        </c:otherwise>
    </c:choose>
</div>

<c:import url="/includes/footer.jsp"/>
