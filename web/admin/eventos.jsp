<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<c:set var="tituloPagina" value="Eventos - Admin" scope="request"/>
<c:import url="/includes/header.jsp"/>

<div class="container">
    <h1 style="color:#ff8c00;">Eventos e Promoções</h1>

    <div class="admin-tabs">
        <a href="${pageContext.request.contextPath}/admin/painel.jsp">Visão geral</a>
        <a href="${pageContext.request.contextPath}/admin/produtos">Produtos</a>
        <a href="${pageContext.request.contextPath}/admin/cupons">Cupons</a>
        <a href="${pageContext.request.contextPath}/admin/eventos" class="ativo">Eventos e Promoções</a>
    </div>

    <div class="form-box" style="max-width:none;">
        <h3 style="margin-top:0; color:#ff8c00;">Novo evento / promoção</h3>
        <form method="post" action="${pageContext.request.contextPath}/admin/eventos">
            <label for="titulo">Título</label>
            <input type="text" id="titulo" name="titulo" required>

            <label for="descricao">Descrição</label>
            <textarea id="descricao" name="descricao"></textarea>

            <label for="imagemUrl">URL da imagem do banner</label>
            <input type="text" id="imagemUrl" name="imagemUrl" placeholder="https://...">

            <div style="display:flex; gap:12px; flex-wrap:wrap;">
                <div style="flex:1; min-width:160px;">
                    <label for="dataInicio">Data início</label>
                    <input type="date" id="dataInicio" name="dataInicio" required>
                </div>
                <div style="flex:1; min-width:160px;">
                    <label for="dataFim">Data fim</label>
                    <input type="date" id="dataFim" name="dataFim" required>
                </div>
            </div>

            <button type="submit" class="btn" style="margin-top:20px;">Criar evento</button>
        </form>
    </div>

    <h3 style="color:#ff8c00; margin-top:30px;">Eventos cadastrados</h3>
    <table class="admin-table">
        <thead>
            <tr><th>Título</th><th>Período</th><th>Status</th><th>Ações</th></tr>
        </thead>
        <tbody>
        <c:forEach var="e" items="${eventos}">
            <tr>
                <td>${e.titulo}</td>
                <td><fmt:formatDate value="${e.dataInicio}" pattern="dd/MM/yyyy"/> - <fmt:formatDate value="${e.dataFim}" pattern="dd/MM/yyyy"/></td>
                <td>${e.ativo ? 'Ativo' : 'Inativo'}</td>
                <td>
                    <c:choose>
                        <c:when test="${e.ativo}">
                            <a href="${pageContext.request.contextPath}/admin/eventos?acao=desativar&id=${e.id}" class="btn btn-perigo" style="padding:6px 12px; font-size:12px;">Desativar</a>
                        </c:when>
                        <c:otherwise>
                            <a href="${pageContext.request.contextPath}/admin/eventos?acao=ativar&id=${e.id}" class="btn" style="padding:6px 12px; font-size:12px;">Ativar</a>
                        </c:otherwise>
                    </c:choose>
                </td>
            </tr>
        </c:forEach>
        </tbody>
    </table>
</div>

<c:import url="/includes/footer.jsp"/>
