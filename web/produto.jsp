<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<c:set var="tituloPagina" value="${produto.nome}" scope="request"/>
<c:import url="/includes/header.jsp"/>

<div class="container">
    <div style="display:flex; gap:36px; flex-wrap:wrap;">
        <div style="flex:1; min-width:280px;">
            <img src="${produto.imagemUrl}" alt="${produto.nome}" style="width:100%; border-radius:12px; border:1px solid #2b2b2b;">
        </div>
        <div style="flex:1; min-width:280px;">
            <span class="categoria-tag">${produto.categoriaNome}</span>
            <h1 style="margin-top:6px;">${produto.nome}</h1>
            <div class="preco" style="font-size:28px;">
                <fmt:formatNumber value="${produto.preco}" type="currency" currencySymbol="R$ "/>
            </div>
            <p style="color:#ccc;">${produto.descricao}</p>
            <p><strong>Tamanho:</strong> ${produto.tamanho} &nbsp;|&nbsp; <strong>Cor:</strong> ${produto.cor}</p>

            <c:choose>
                <c:when test="${produto.estoque > 0}">
                    <p style="color:#9bffb0;">Em estoque (${produto.estoque} unid.)</p>
                    <form method="get" action="${pageContext.request.contextPath}/carrinho">
                        <input type="hidden" name="acao" value="adicionar">
                        <input type="hidden" name="produtoId" value="${produto.id}">
                        <label for="quantidade">Quantidade</label>
                        <input type="number" id="quantidade" name="quantidade" value="1" min="1" max="${produto.estoque}" style="max-width:120px;">
                        <button type="submit" class="btn" style="margin-top:16px;">Adicionar ao carrinho</button>
                    </form>
                </c:when>
                <c:otherwise>
                    <p style="color:#ff9b9b;">Produto esgotado no momento.</p>
                </c:otherwise>
            </c:choose>

            <a href="${pageContext.request.contextPath}/catalogo" style="display:inline-block; margin-top:20px; color:#ff8c00;">&larr; Voltar ao catálogo</a>
        </div>
    </div>
</div>

<c:import url="/includes/footer.jsp"/>
