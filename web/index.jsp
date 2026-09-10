<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<jsp:useBean id="eventoDAO" class="dao.EventoDAO" scope="page"/>
<jsp:useBean id="categoriaDAO" class="dao.CategoriaDAO" scope="page"/>
<jsp:useBean id="produtoDAO" class="dao.ProdutoDAO" scope="page"/>
<c:set var="tituloPagina" value="Início" scope="request"/>
<c:import url="/includes/header.jsp"/>

<div class="container">

    <section class="hero">
        <h1>Bem-vindo à <span class="store">MARROMENOS STORE</span></h1>
        <p>Moda de rua, tênis e acessórios &mdash; direto do Recanto das Emas para o seu closet.</p>
        <a href="${pageContext.request.contextPath}/catalogo" class="btn">Ver catálogo completo</a>
    </section>

    <c:set var="eventos" value="<%= eventoDAO.listarAtivos() %>"/>
    <c:if test="${not empty eventos}">
        <h2 style="color:#ff8c00;">Promoções &amp; Eventos</h2>
        <c:forEach var="evento" items="${eventos}">
            <div class="evento-card">
                <img src="${evento.imagemUrl}" alt="${evento.titulo}">
                <div class="info">
                    <h3>${evento.titulo}</h3>
                    <p>${evento.descricao}</p>
                    <p style="font-size:13px;color:#999;">
                        <fmt:formatDate value="${evento.dataInicio}" pattern="dd/MM/yyyy"/> até
                        <fmt:formatDate value="${evento.dataFim}" pattern="dd/MM/yyyy"/>
                    </p>
                </div>
            </div>
        </c:forEach>
    </c:if>

    <h2 style="color:#ff8c00;">Categorias</h2>
    <c:set var="categorias" value="<%= categoriaDAO.listarTodas() %>"/>
    <div class="categorias-grid">
        <c:forEach var="cat" items="${categorias}">
            <a class="categoria-card" href="${pageContext.request.contextPath}/catalogo?categoria=${cat.id}">
                ${cat.nome}
            </a>
        </c:forEach>
    </div>

    <h2 style="color:#ff8c00;">Novidades</h2>
    <c:set var="produtos" value="<%= produtoDAO.listarAtivos() %>"/>
    <div class="produtos-grid">
        <c:forEach var="p" items="${produtos}" varStatus="loop" end="7">
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

    <h2 style="color:#ff8c00;">Onde estamos</h2>
    <p>Recanto das Emas, Brasília - DF</p>
    <div class="mapa-wrap">
        <iframe
            src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d3837.0977624348916!2d-48.064209299999995!3d-15.903948399999997!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x935a2d02969bba41%3A0xf051913e471f2db!2sMarromenos%20Store-%20Refer%C3%AAncia%20em%20roupas%20e%20cal%C3%A7ados*21!5e0!3m2!1spt-PT!2sbr!4v1788978094949!5m2!1spt-PT!2sbr"
            width="100%" height="320" style="border:0;" allowfullscreen="" loading="lazy"
            referrerpolicy="strict-origin-when-cross-origin">
        </iframe>
    </div>

</div>

<c:import url="/includes/footer.jsp"/>
