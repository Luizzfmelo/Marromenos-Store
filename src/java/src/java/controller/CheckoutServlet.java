package controller;

import dao.CupomDAO;
import dao.PedidoDAO;
import dao.ProdutoDAO;
import model.*;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.math.BigDecimal;
import java.util.Map;

@WebServlet("/checkout")
public class CheckoutServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession();
        if (session.getAttribute("usuarioLogado") == null) {
            resp.sendRedirect(req.getContextPath() + "/login");
            return;
        }
        req.getRequestDispatcher("/checkout.jsp").forward(req, resp);
    }

    @SuppressWarnings("unchecked")
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession();
        Usuario usuario = (Usuario) session.getAttribute("usuarioLogado");
        if (usuario == null) {
            resp.sendRedirect(req.getContextPath() + "/login");
            return;
        }

        Map<Integer, ItemCarrinho> carrinho = (Map<Integer, ItemCarrinho>) session.getAttribute("carrinho");
        if (carrinho == null || carrinho.isEmpty()) {
            resp.sendRedirect(req.getContextPath() + "/carrinho.jsp");
            return;
        }

        String tipoEntrega = req.getParameter("tipoEntrega");
        String enderecoEntrega = req.getParameter("enderecoEntrega");
        String formaPagamento = req.getParameter("formaPagamento");

        BigDecimal subtotal = CarrinhoServlet.calcularSubtotal(carrinho);
        BigDecimal desconto = BigDecimal.ZERO;
        Cupom cupom = (Cupom) session.getAttribute("cupomAplicado");
        String codigoCupom = null;

        if (cupom != null) {
            desconto = cupom.calcularDesconto(subtotal);
            codigoCupom = cupom.getCodigo();
        }

        BigDecimal total = subtotal.subtract(desconto);
        if (total.compareTo(BigDecimal.ZERO) < 0) total = BigDecimal.ZERO;

        Pedido pedido = new Pedido();
        pedido.setUsuarioId(usuario.getId());
        pedido.setTipoEntrega(tipoEntrega);
        pedido.setEnderecoEntrega("ENTREGA".equals(tipoEntrega) ? enderecoEntrega : null);
        pedido.setFormaPagamento(formaPagamento);
        pedido.setCupomCodigo(codigoCupom);
        pedido.setSubtotal(subtotal);
        pedido.setDesconto(desconto);
        pedido.setTotal(total);

        ProdutoDAO produtoDAO = new ProdutoDAO();
        for (ItemCarrinho ic : carrinho.values()) {
            ItemPedido ip = new ItemPedido();
            ip.setProdutoId(ic.getProduto().getId());
            ip.setNomeProduto(ic.getProduto().getNome());
            ip.setQuantidade(ic.getQuantidade());
            ip.setPrecoUnitario(ic.getProduto().getPreco());
            pedido.getItens().add(ip);
            produtoDAO.baixarEstoque(ic.getProduto().getId(), ic.getQuantidade());
        }

        int pedidoId = new PedidoDAO().salvar(pedido);

        if (codigoCupom != null) {
            new CupomDAO().registrarUso(codigoCupom);
        }

        carrinho.clear();
        session.removeAttribute("cupomAplicado");
        session.setAttribute("ultimoPedidoId", pedidoId);
        session.setAttribute("ultimoPedidoTotal", total);

        resp.sendRedirect(req.getContextPath() + "/pedido-confirmado.jsp");
    }
}
