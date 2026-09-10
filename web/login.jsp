<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="tituloPagina" value="Entrar" scope="request"/>
<c:import url="/includes/header.jsp"/>

<div class="container">
    <div class="form-box">
        <h2>Entrar na conta</h2>

        <c:if test="${not empty erro}">
            <div class="alerta alerta-erro">${erro}</div>
        </c:if>
        <c:if test="${not empty sucesso}">
            <div class="alerta alerta-sucesso">${sucesso}</div>
        </c:if>

        <form method="post" action="${pageContext.request.contextPath}/login">
            <label for="email">E-mail</label>
            <input type="email" id="email" name="email" required>

            <label for="senha">Senha</label>
            <input type="password" id="senha" name="senha" required>

            <button type="submit" class="btn" style="width:100%; margin-top:20px;">Entrar</button>
        </form>

        <p style="text-align:center; margin-top:16px;">
            Não tem conta? <a href="${pageContext.request.contextPath}/registro" style="color:#ff8c00; font-weight:700;">Cadastre-se</a>
        </p>
        <p style="text-align:center; font-size:12px; color:#999;">
            Acesso admin de teste: admin@marromenos.com / admin123
        </p>
    </div>
</div>

<c:import url="/includes/footer.jsp"/>
