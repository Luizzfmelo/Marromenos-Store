<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="pt-br">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title><c:if test="${not empty tituloPagina}">${tituloPagina} | </c:if>MarroMenos Store</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>

<header class="topo">
    <a href="${pageContext.request.contextPath}/index.jsp" class="logo">
        <img src="${pageContext.request.contextPath}/images/logo-marromenos.png" alt="MarroMenos Store" class="logo-img">
    </a>
    <nav class="menu">
        <a href="${pageContext.request.contextPath}/index.jsp">Início</a>
        <a href="${pageContext.request.contextPath}/catalogo">Catálogo</a>
        <a href="${pageContext.request.contextPath}/carrinho.jsp">
            Carrinho
            <c:set var="qtd" value="0"/>
            <c:if test="${not empty sessionScope.carrinho}">
                <c:forEach var="item" items="${sessionScope.carrinho}">
                    <c:set var="qtd" value="${qtd + item.value.quantidade}"/>
                </c:forEach>
            </c:if>
            <span class="carrinho-badge">${qtd}</span>
        </a>

        <c:choose>
            <c:when test="${not empty sessionScope.usuarioLogado}">
                <c:if test="${sessionScope.usuarioLogado.admin}">
                    <a href="${pageContext.request.contextPath}/admin/painel.jsp">Admin</a>
                </c:if>
                <span style="color:#ff8c00; font-weight:600;">Olá, ${sessionScope.usuarioLogado.nome}</span>
                <a href="${pageContext.request.contextPath}/logout">Sair</a>
            </c:when>
            <c:otherwise>
                <a href="${pageContext.request.contextPath}/login">Entrar</a>
                <a href="${pageContext.request.contextPath}/registro" class="btn" style="padding:8px 16px;">Cadastrar</a>
            </c:otherwise>
        </c:choose>
    </nav>
</header>
