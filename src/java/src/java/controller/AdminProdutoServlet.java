package controller;

import dao.CategoriaDAO;
import dao.ProdutoDAO;
import model.Produto;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.math.BigDecimal;

@WebServlet("/admin/produtos")
public class AdminProdutoServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String acao = req.getParameter("acao");

        if ("excluir".equals(acao)) {
            int id = Integer.parseInt(req.getParameter("id"));
            new ProdutoDAO().excluir(id);
            resp.sendRedirect(req.getContextPath() + "/admin/produtos");
            return;
        }

        req.setAttribute("produtos", new ProdutoDAO().listarTodos());
        req.setAttribute("categorias", new CategoriaDAO().listarTodas());
        req.getRequestDispatcher("/admin/produtos.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        Produto p = new Produto();
        p.setNome(req.getParameter("nome"));
        p.setDescricao(req.getParameter("descricao"));
        p.setPreco(new BigDecimal(req.getParameter("preco").replace(",", ".")));
        p.setTamanho(req.getParameter("tamanho"));
        p.setCor(req.getParameter("cor"));
        p.setEstoque(Integer.parseInt(req.getParameter("estoque")));
        p.setImagemUrl(req.getParameter("imagemUrl"));
        p.setCategoriaId(Integer.parseInt(req.getParameter("categoriaId")));

        new ProdutoDAO().inserir(p);

        resp.sendRedirect(req.getContextPath() + "/admin/produtos");
    }
}
