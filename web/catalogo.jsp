<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<c:set var="tituloPagina" value="Catálogo" scope="request"/>
<c:import url="/includes/header.jsp"/>

<div class="container">
    <h1 style="color:#ff8c00;">
        <c:choose>
            <c:when test="${not empty categoriaSelecionada}">${categoriaSelecionada.nome}</c:when>
            <c:otherwise>Catálogo completo</c:otherwise>
        </c:choose>
    </h1>

    <div class="categorias-grid">
        <a class="categoria-card" href="${pageContext.request.contextPath}/catalogo">Todos</a>
        <c:forEach var="cat" items="${categorias}">
            <a class="categoria-card" href="${pageContext.request.contextPath}/catalogo?categoria=${cat.id}">${cat.nome}</a>
        </c:forEach>
    </div>

    <c:choose>
        <c:when test="${empty produtos}">
            <div class="vazio">Nenhum produto encontrado nesta categoria.</div>
        </c:when>
        <c:otherwise>
            <div class="produtos-grid">
                <c:forEach var="p" items="${produtos}">
                    <a class="produto-card" href="${pageContext.request.contextPath}/produto?id=${p.id}">
                        <img src="${p.imagemUrl}" alt="${p.nome}">
                        <div class="corpo">
                            <span class="categoria-tag">${p.categoriaNome}</span>
                            <h4>${p.nome}</h4>
                            <div class="preco">
                                <fmt:formatNumber value="${p.preco}" type="currency" currencySymbol="R$ "/>
                            </div>
                        </div>
                    </a>
                </c:forEach>
            </div>
        </c:otherwise>
    </c:choose>
</div>

<c:import url="/includes/footer.jsp"/>
