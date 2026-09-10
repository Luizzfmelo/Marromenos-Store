<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<c:set var="tituloPagina" value="Produtos - Admin" scope="request"/>
<c:import url="/includes/header.jsp"/>

<div class="container">
    <h1 style="color:#ff8c00;">Gerenciar Produtos</h1>

    <div class="admin-tabs">
        <a href="${pageContext.request.contextPath}/admin/painel.jsp">Visão geral</a>
        <a href="${pageContext.request.contextPath}/admin/produtos" class="ativo">Produtos</a>
        <a href="${pageContext.request.contextPath}/admin/cupons">Cupons</a>
        <a href="${pageContext.request.contextPath}/admin/eventos">Eventos e Promoções</a>
    </div>

    <div class="form-box" style="max-width:none;">
        <h3 style="margin-top:0; color:#ff8c00;">Novo produto</h3>
        <form method="post" action="${pageContext.request.contextPath}/admin/produtos">
            <label for="nome">Nome</label>
            <input type="text" id="nome" name="nome" required>

            <label for="descricao">Descrição</label>
            <textarea id="descricao" name="descricao"></textarea>

            <div style="display:flex; gap:12px; flex-wrap:wrap;">
                <div style="flex:1; min-width:120px;">
                    <label for="preco">Preço (R$)</label>
                    <input type="text" id="preco" name="preco" placeholder="99.90" required>
                </div>
                <div style="flex:1; min-width:120px;">
                    <label for="estoque">Estoque</label>
                    <input type="number" id="estoque" name="estoque" value="0" required>
                </div>
                <div style="flex:1; min-width:120px;">
                    <label for="tamanho">Tamanho</label>
                    <input type="text" id="tamanho" name="tamanho" placeholder="M, 40, Único...">
                </div>
                <div style="flex:1; min-width:120px;">
                    <label for="cor">Cor</label>
                    <input type="text" id="cor" name="cor">
                </div>
            </div>

            <label for="categoriaId">Categoria</label>
            <select id="categoriaId" name="categoriaId" required>
                <c:forEach var="cat" items="${categorias}">
                    <option value="${cat.id}">${cat.nome}</option>
                </c:forEach>
            </select>

            <label for="imagemUrl">URL da imagem</label>
            <input type="text" id="imagemUrl" name="imagemUrl" placeholder="https://...">

            <button type="submit" class="btn" style="margin-top:20px;">Cadastrar produto</button>
        </form>
    </div>

    <h3 style="color:#ff8c00; margin-top:30px;">Produtos cadastrados</h3>
    <table class="admin-table">
        <thead>
            <tr><th>Nome</th><th>Categoria</th><th>Preço</th><th>Estoque</th><th>Status</th><th>Ações</th></tr>
        </thead>
        <tbody>
        <c:forEach var="p" items="${produtos}">
            <tr>
                <td>${p.nome}</td>
                <td>${p.categoriaNome}</td>
                <td><fmt:formatNumber value="${p.preco}" type="currency" currencySymbol="R$ "/></td>
                <td>${p.estoque}</td>
                <td>${p.ativo ? 'Ativo' : 'Inativo'}</td>
                <td>
                    <a href="${pageContext.request.contextPath}/admin/produtos?acao=excluir&id=${p.id}"
                       class="btn btn-perigo" style="padding:6px 12px; font-size:12px;"
                       onclick="return confirm('Desativar este produto?');">Desativar</a>
                </td>
            </tr>
        </c:forEach>
        </tbody>
    </table>
</div>

<c:import url="/includes/footer.jsp"/>
