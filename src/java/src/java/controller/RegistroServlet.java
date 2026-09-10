package controller;

import dao.UsuarioDAO;
import model.Usuario;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;

@WebServlet("/registro")
public class RegistroServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.getRequestDispatcher("/registro.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        UsuarioDAO dao = new UsuarioDAO();
        String email = req.getParameter("email");

        if (dao.emailExiste(email)) {
            req.setAttribute("erro", "Este e-mail já está cadastrado.");
            req.getRequestDispatcher("/registro.jsp").forward(req, resp);
            return;
        }

        Usuario u = new Usuario();
        u.setNome(req.getParameter("nome"));
        u.setEmail(email);
        u.setSenha(req.getParameter("senha"));
        u.setTelefone(req.getParameter("telefone"));
        u.setEndereco(req.getParameter("endereco"));
        u.setTipo("CLIENTE");

        dao.cadastrar(u);

        req.setAttribute("sucesso", "Cadastro realizado com sucesso! Faça login para continuar.");
        req.getRequestDispatcher("/login.jsp").forward(req, resp);
    }
}
