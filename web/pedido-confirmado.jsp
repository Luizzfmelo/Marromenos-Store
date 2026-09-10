<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<c:set var="tituloPagina" value="Pedido confirmado" scope="request"/>
<c:import url="/includes/header.jsp"/>

<div class="container">
    <div class="form-box" style="text-align:center; max-width:520px;">
        <h2 style="color:#9bffb0;">Pedido realizado com sucesso!</h2>
        <p>Número do pedido: <strong>#${sessionScope.ultimoPedidoId}</strong></p>
        <p>Total: <strong style="color:#ff8c00;"><fmt:formatNumber value="${sessionScope.ultimoPedidoTotal}" type="currency" currencySymbol="R$ "/></strong></p>
        <p style="color:#ccc;">Em breve entraremos em contato para confirmar os detalhes de entrega ou retirada.</p>
        <a href="${pageContext.request.contextPath}/catalogo" class="btn" style="margin-top:16px;">Continuar comprando</a>
    </div>
</div>

<c:import url="/includes/footer.jsp"/>
