package controller;

import dao.CupomDAO;
import model.Cupom;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.math.BigDecimal;
import java.sql.Date;

@WebServlet("/admin/cupons")
public class AdminCupomServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String acao = req.getParameter("acao");

        if ("desativar".equals(acao) || "ativar".equals(acao)) {
            int id = Integer.parseInt(req.getParameter("id"));
            new CupomDAO().alternarAtivo(id, "ativar".equals(acao));
            resp.sendRedirect(req.getContextPath() + "/admin/cupons");
            return;
        }

        req.setAttribute("cupons", new CupomDAO().listarTodos());
        req.getRequestDispatcher("/admin/cupons.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        Cupom c = new Cupom();
        c.setCodigo(req.getParameter("codigo"));
        c.setTipoDesconto(req.getParameter("tipoDesconto"));
        c.setValor(new BigDecimal(req.getParameter("valor").replace(",", ".")));
        c.setValidade(Date.valueOf(req.getParameter("validade")));

        String limite = req.getParameter("limiteUso");
        c.setLimiteUso((limite == null || limite.isEmpty()) ? null : Integer.parseInt(limite));

        new CupomDAO().inserir(c);

        resp.sendRedirect(req.getContextPath() + "/admin/cupons");
    }
}
