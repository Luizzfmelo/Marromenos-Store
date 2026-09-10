<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<c:set var="tituloPagina" value="Finalizar compra" scope="request"/>
<c:import url="/includes/header.jsp"/>

<div class="container">
    <h1 style="color:#ff8c00;">Finalizar compra</h1>

    <c:choose>
        <c:when test="${empty sessionScope.carrinho}">
            <div class="vazio">Seu carrinho está vazio.</div>
        </c:when>
        <c:otherwise>
            <c:set var="subtotal" value="0"/>
            <c:forEach var="entry" items="${sessionScope.carrinho}">
                <c:set var="subtotal" value="${subtotal + (entry.value.produto.preco * entry.value.quantidade)}"/>
            </c:forEach>
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
            </c:if>

            <form method="post" action="${pageContext.request.contextPath}/checkout" style="display:flex; gap:30px; flex-wrap:wrap;">
                <div style="flex:2; min-width:300px;">

                    <div class="form-box" style="max-width:none; margin:0 0 20px;">
                        <h3 style="color:#ff8c00; margin-top:0;">Entrega</h3>
                        <div class="radio-group">
                            <label><input type="radio" name="tipoEntrega" value="RETIRADA" checked onclick="document.getElementById('campoEndereco').style.display='none'"> Retirar na loja</label>
                            <label><input type="radio" name="tipoEntrega" value="ENTREGA" onclick="document.getElementById('campoEndereco').style.display='block'"> Receber em casa</label>
                        </div>
                        <div id="campoEndereco" style="display:none;">
                            <label for="enderecoEntrega">Endereço de entrega</label>
                            <input type="text" id="enderecoEntrega" name="enderecoEntrega"
                                   value="${sessionScope.usuarioLogado.endereco}"
                                   placeholder="Rua, quadra, número - Recanto das Emas">
                        </div>
                        <p style="font-size:13px; color:#999; margin-top:10px;">
                            Retirada na loja: MarroMenos Store, Recanto das Emas - DF.
                        </p>
                    </div>

                    <div class="form-box" style="max-width:none; margin:0;">
                        <h3 style="color:#ff8c00; margin-top:0;">Forma de pagamento</h3>
                        <div class="pagamento-opcoes">
                            <label><input type="radio" name="formaPagamento" value="PIX" checked> <span>Pix</span></label>
                            <label><input type="radio" name="formaPagamento" value="Cartão de Crédito"> <span>Cartão de Crédito</span></label>
                            <label><input type="radio" name="formaPagamento" value="Cartão de Débito"> <span>Cartão de Débito</span></label>
                            <label><input type="radio" name="formaPagamento" value="Boleto"> <span>Boleto</span></label>
                            <label><input type="radio" name="formaPagamento" value="Dinheiro na retirada"> <span>Dinheiro (retirada)</span></label>
                        </div>
                        <p style="font-size:12px; color:#999; margin-top:10px;">* Formas de pagamento ilustrativas para fins do projeto acadêmico.</p>
                    </div>
                </div>

                <div style="flex:1; min-width:280px;">
                    <div class="resumo-box">
                        <h3 style="margin-top:0; color:#ff8c00;">Resumo do pedido</h3>
                        <div class="linha"><span>Subtotal</span><span><fmt:formatNumber value="${subtotal}" type="currency" currencySymbol="R$ "/></span></div>
                        <c:if test="${desconto > 0}">
                            <div class="linha"><span>Desconto</span><span>- <fmt:formatNumber value="${desconto}" type="currency" currencySymbol="R$ "/></span></div>
                        </c:if>
                        <div class="linha total"><span>Total</span><span><fmt:formatNumber value="${subtotal - desconto}" type="currency" currencySymbol="R$ "/></span></div>
                        <button type="submit" class="btn" style="width:100%; margin-top:16px;">Confirmar pedido</button>
                    </div>
                </div>
            </form>
        </c:otherwise>
    </c:choose>
</div>

<c:import url="/includes/footer.jsp"/>
