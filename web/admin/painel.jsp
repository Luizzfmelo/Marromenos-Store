<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="tituloPagina" value="Painel Admin" scope="request"/>
<c:import url="/includes/header.jsp"/>

<div class="container">
    <h1 style="color:#ff8c00;">Painel Administrativo</h1>
    <p style="color:#999;">Bem-vindo, ${sessionScope.usuarioLogado.nome}. Gerencie a loja por aqui.</p>

    <div class="admin-tabs">
        <a href="${pageContext.request.contextPath}/admin/painel.jsp" class="ativo">Visão geral</a>
        <a href="${pageContext.request.contextPath}/admin/produtos">Produtos</a>
        <a href="${pageContext.request.contextPath}/admin/cupons">Cupons</a>
        <a href="${pageContext.request.contextPath}/admin/eventos">Eventos e Promoções</a>
    </div>

    <div class="categorias-grid">
        <a class="categoria-card" href="${pageContext.request.contextPath}/admin/produtos">📦<br>Cadastrar / gerenciar produtos</a>
        <a class="categoria-card" href="${pageContext.request.contextPath}/admin/cupons">🏷️<br>Criar cupons de desconto</a>
        <a class="categoria-card" href="${pageContext.request.contextPath}/admin/eventos">📢<br>Criar eventos e promoções</a>
    </div>
</div>

<c:import url="/includes/footer.jsp"/>
