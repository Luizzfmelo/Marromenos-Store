package controller;

import dao.CupomDAO;
import dao.ProdutoDAO;
import model.Cupom;
import model.ItemCarrinho;
import model.Produto;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.math.BigDecimal;
import java.util.LinkedHashMap;
import java.util.Map;

/**
 * Gerencia o carrinho de compras, guardado na sessão do usuário
 * como um Map<produtoId, ItemCarrinho>.
 */
@WebServlet("/carrinho")
public class CarrinhoServlet extends HttpServlet {

    @SuppressWarnings("unchecked")
    private Map<Integer, ItemCarrinho> getCarrinho(HttpSession session) {
        Map<Integer, ItemCarrinho> carrinho = (Map<Integer, ItemCarrinho>) session.getAttribute("carrinho");
        if (carrinho == null) {
            carrinho = new LinkedHashMap<>();
            session.setAttribute("carrinho", carrinho);
        }
        return carrinho;
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession();
        String acao = req.getParameter("acao");
        Map<Integer, ItemCarrinho> carrinho = getCarrinho(session);

        if ("adicionar".equals(acao)) {
            int produtoId = Integer.parseInt(req.getParameter("produtoId"));
            int quantidade = req.getParameter("quantidade") != null
                    ? Integer.parseInt(req.getParameter("quantidade")) : 1;

            Produto produto = new ProdutoDAO().buscarPorId(produtoId);
            if (produto != null) {
                ItemCarrinho item = carrinho.get(produtoId);
                if (item == null) {
                    carrinho.put(produtoId, new ItemCarrinho(produto, quantidade));
                } else {
                    item.setQuantidade(item.getQuantidade() + quantidade);
                }
            }
        } else if ("remover".equals(acao)) {
            int produtoId = Integer.parseInt(req.getParameter("produtoId"));
            carrinho.remove(produtoId);
        } else if ("atualizar".equals(acao)) {
            int produtoId = Integer.parseInt(req.getParameter("produtoId"));
            int quantidade = Integer.parseInt(req.getParameter("quantidade"));
            ItemCarrinho item = carrinho.get(produtoId);
            if (item != null) {
                if (quantidade <= 0) carrinho.remove(produtoId);
                else item.setQuantidade(quantidade);
            }
        } else if ("limpar".equals(acao)) {
            carrinho.clear();
            session.removeAttribute("cupomAplicado");
        } else if ("aplicarCupom".equals(acao)) {
            String codigo = req.getParameter("codigo");
            Cupom cupom = new CupomDAO().buscarValido(codigo == null ? "" : codigo.trim().toUpperCase());
            if (cupom != null) {
                session.setAttribute("cupomAplicado", cupom);
            } else {
                session.setAttribute("erroCupom", "Cupom inválido ou expirado.");
            }
        } else if ("removerCupom".equals(acao)) {
            session.removeAttribute("cupomAplicado");
        }

        resp.sendRedirect(req.getContextPath() + "/carrinho.jsp");
    }

    /** Utilitário estático usado pelas JSPs/servlets para calcular o subtotal do carrinho. */
    public static BigDecimal calcularSubtotal(Map<Integer, ItemCarrinho> carrinho) {
        BigDecimal total = BigDecimal.ZERO;
        if (carrinho == null) return total;
        for (ItemCarrinho item : carrinho.values()) {
            total = total.add(item.getSubtotal());
        }
        return total;
    }
}
