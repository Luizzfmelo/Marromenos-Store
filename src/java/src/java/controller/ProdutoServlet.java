package controller;

import dao.ProdutoDAO;
import model.Produto;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;

@WebServlet("/produto")
public class ProdutoServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        int id = Integer.parseInt(req.getParameter("id"));
        Produto produto = new ProdutoDAO().buscarPorId(id);

        if (produto == null) {
            resp.sendRedirect(req.getContextPath() + "/catalogo");
            return;
        }

        req.setAttribute("produto", produto);
        req.getRequestDispatcher("/produto.jsp").forward(req, resp);
    }
}
