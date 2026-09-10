package controller;

import dao.CategoriaDAO;
import dao.ProdutoDAO;
import model.Produto;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.util.List;

@WebServlet("/catalogo")
public class CatalogoServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        ProdutoDAO produtoDAO = new ProdutoDAO();
        CategoriaDAO categoriaDAO = new CategoriaDAO();

        String categoriaParam = req.getParameter("categoria");
        List<Produto> produtos;

        if (categoriaParam != null && !categoriaParam.isEmpty()) {
            int categoriaId = Integer.parseInt(categoriaParam);
            produtos = produtoDAO.listarPorCategoria(categoriaId);
            req.setAttribute("categoriaSelecionada", categoriaDAO.buscarPorId(categoriaId));
        } else {
            produtos = produtoDAO.listarAtivos();
        }

        req.setAttribute("produtos", produtos);
        req.setAttribute("categorias", categoriaDAO.listarTodas());
        req.getRequestDispatcher("/catalogo.jsp").forward(req, resp);
    }
}
