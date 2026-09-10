<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="tituloPagina" value="Criar conta" scope="request"/>
<c:import url="/includes/header.jsp"/>

<div class="container">
    <div class="form-box">
        <h2>Criar conta</h2>

        <c:if test="${not empty erro}">
            <div class="alerta alerta-erro">${erro}</div>
        </c:if>

        <form method="post" action="${pageContext.request.contextPath}/registro">
            <label for="nome">Nome completo</label>
            <input type="text" id="nome" name="nome" required>

            <label for="email">E-mail</label>
            <input type="email" id="email" name="email" required>

            <label for="senha">Senha</label>
            <input type="password" id="senha" name="senha" required minlength="4">

            <label for="telefone">Telefone</label>
            <input type="tel" id="telefone" name="telefone" placeholder="(61) 90000-0000">

            <label for="endereco">Endereço (para entregas)</label>
            <input type="text" id="endereco" name="endereco" placeholder="Rua, quadra, número - Recanto das Emas">

            <button type="submit" class="btn" style="width:100%; margin-top:20px;">Cadastrar</button>
        </form>

        <p style="text-align:center; margin-top:16px;">
            Já tem conta? <a href="${pageContext.request.contextPath}/login" style="color:#ff8c00; font-weight:700;">Entrar</a>
        </p>
    </div>
</div>

<c:import url="/includes/footer.jsp"/>
