package controller;

import dao.EventoDAO;
import model.Evento;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.sql.Date;

@WebServlet("/admin/eventos")
public class AdminEventoServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String acao = req.getParameter("acao");

        if ("desativar".equals(acao) || "ativar".equals(acao)) {
            int id = Integer.parseInt(req.getParameter("id"));
            new EventoDAO().alternarAtivo(id, "ativar".equals(acao));
            resp.sendRedirect(req.getContextPath() + "/admin/eventos");
            return;
        }

        req.setAttribute("eventos", new EventoDAO().listarTodos());
        req.getRequestDispatcher("/admin/eventos.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        Evento e = new Evento();
        e.setTitulo(req.getParameter("titulo"));
        e.setDescricao(req.getParameter("descricao"));
        e.setImagemUrl(req.getParameter("imagemUrl"));
        e.setDataInicio(Date.valueOf(req.getParameter("dataInicio")));
        e.setDataFim(Date.valueOf(req.getParameter("dataFim")));

        new EventoDAO().inserir(e);

        resp.sendRedirect(req.getContextPath() + "/admin/eventos");
    }
}
