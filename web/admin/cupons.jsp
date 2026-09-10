<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<c:set var="tituloPagina" value="Cupons - Admin" scope="request"/>
<c:import url="/includes/header.jsp"/>

<div class="container">
    <h1 style="color:#ff8c00;">Cupons de Desconto</h1>

    <div class="admin-tabs">
        <a href="${pageContext.request.contextPath}/admin/painel.jsp">Visão geral</a>
        <a href="${pageContext.request.contextPath}/admin/produtos">Produtos</a>
        <a href="${pageContext.request.contextPath}/admin/cupons" class="ativo">Cupons</a>
        <a href="${pageContext.request.contextPath}/admin/eventos">Eventos e Promoções</a>
    </div>

    <div class="form-box" style="max-width:none;">
        <h3 style="margin-top:0; color:#ff8c00;">Novo cupom</h3>
        <form method="post" action="${pageContext.request.contextPath}/admin/cupons">
            <label for="codigo">Código</label>
            <input type="text" id="codigo" name="codigo" placeholder="Ex: NATAL15" required style="text-transform:uppercase;">

            <div style="display:flex; gap:12px; flex-wrap:wrap;">
                <div style="flex:1; min-width:160px;">
                    <label for="tipoDesconto">Tipo de desconto</label>
                    <select id="tipoDesconto" name="tipoDesconto">
                        <option value="PERCENTUAL">Percentual (%)</option>
                        <option value="VALOR_FIXO">Valor fixo (R$)</option>
                    </select>
                </div>
                <div style="flex:1; min-width:120px;">
                    <label for="valor">Valor</label>
                    <input type="text" id="valor" name="valor" placeholder="10" required>
                </div>
                <div style="flex:1; min-width:160px;">
                    <label for="validade">Válido até</label>
                    <input type="date" id="validade" name="validade" required>
                </div>
                <div style="flex:1; min-width:140px;">
                    <label for="limiteUso">Limite de usos (opcional)</label>
                    <input type="number" id="limiteUso" name="limiteUso" placeholder="Ilimitado">
                </div>
            </div>

            <button type="submit" class="btn" style="margin-top:20px;">Criar cupom</button>
        </form>
    </div>

    <h3 style="color:#ff8c00; margin-top:30px;">Cupons cadastrados</h3>
    <table class="admin-table">
        <thead>
            <tr><th>Código</th><th>Tipo</th><th>Valor</th><th>Validade</th><th>Usos</th><th>Status</th><th>Ações</th></tr>
        </thead>
        <tbody>
        <c:forEach var="c" items="${cupons}">
            <tr>
                <td>${c.codigo}</td>
                <td>${c.tipoDesconto == 'PERCENTUAL' ? 'Percentual' : 'Valor fixo'}</td>
                <td>
                    <c:choose>
                        <c:when test="${c.tipoDesconto == 'PERCENTUAL'}">${c.valor}%</c:when>
                        <c:otherwise><fmt:formatNumber value="${c.valor}" type="currency" currencySymbol="R$ "/></c:otherwise>
                    </c:choose>
                </td>
                <td><fmt:formatDate value="${c.validade}" pattern="dd/MM/yyyy"/></td>
                <td>${c.usos}${c.limiteUso != null ? ' / '.concat(c.limiteUso) : ''}</td>
                <td>${c.ativo ? 'Ativo' : 'Inativo'}</td>
                <td>
                    <c:choose>
                        <c:when test="${c.ativo}">
                            <a href="${pageContext.request.contextPath}/admin/cupons?acao=desativar&id=${c.id}" class="btn btn-perigo" style="padding:6px 12px; font-size:12px;">Desativar</a>
                        </c:when>
                        <c:otherwise>
                            <a href="${pageContext.request.contextPath}/admin/cupons?acao=ativar&id=${c.id}" class="btn" style="padding:6px 12px; font-size:12px;">Ativar</a>
                        </c:otherwise>
                    </c:choose>
                </td>
            </tr>
        </c:forEach>
        </tbody>
    </table>
</div>

<c:import url="/includes/footer.jsp"/>
