package dao;

import model.ItemPedido;
import model.Pedido;
import util.ConnectionFactory;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class PedidoDAO {

    /** Salva o pedido e seus itens dentro de uma transação. */
    public int salvar(Pedido pedido) {
        String sqlPedido = "INSERT INTO pedidos (usuario_id, tipo_entrega, endereco_entrega, forma_pagamento, "
                + "cupom_codigo, subtotal, desconto, total, status) VALUES (?,?,?,?,?,?,?,?,?)";
        String sqlItem = "INSERT INTO itens_pedido (pedido_id, produto_id, nome_produto, quantidade, preco_unitario) "
                + "VALUES (?,?,?,?,?)";

        Connection con = null;
        try {
            con = ConnectionFactory.getConnection();
            con.setAutoCommit(false);

            int pedidoId;
            try (PreparedStatement ps = con.prepareStatement(sqlPedido, Statement.RETURN_GENERATED_KEYS)) {
                ps.setInt(1, pedido.getUsuarioId());
                ps.setString(2, pedido.getTipoEntrega());
                ps.setString(3, pedido.getEnderecoEntrega());
                ps.setString(4, pedido.getFormaPagamento());
                ps.setString(5, pedido.getCupomCodigo());
                ps.setBigDecimal(6, pedido.getSubtotal());
                ps.setBigDecimal(7, pedido.getDesconto());
                ps.setBigDecimal(8, pedido.getTotal());
                ps.setString(9, "RECEBIDO");
                ps.executeUpdate();
                try (ResultSet gk = ps.getGeneratedKeys()) {
                    gk.next();
                    pedidoId = gk.getInt(1);
                }
            }

            try (PreparedStatement ps = con.prepareStatement(sqlItem)) {
                for (ItemPedido item : pedido.getItens()) {
                    ps.setInt(1, pedidoId);
                    ps.setInt(2, item.getProdutoId());
                    ps.setString(3, item.getNomeProduto());
                    ps.setInt(4, item.getQuantidade());
                    ps.setBigDecimal(5, item.getPrecoUnitario());
                    ps.addBatch();
                }
                ps.executeBatch();
            }

            con.commit();
            return pedidoId;
        } catch (SQLException e) {
            e.printStackTrace();
            if (con != null) try { con.rollback(); } catch (SQLException ignore) {}
            return -1;
        } finally {
            if (con != null) try { con.setAutoCommit(true); con.close(); } catch (SQLException ignore) {}
        }
    }

    public List<Pedido> listarPorUsuario(int usuarioId) {
        List<Pedido> lista = new ArrayList<>();
        String sql = "SELECT * FROM pedidos WHERE usuario_id = ? ORDER BY data_pedido DESC";
        try (Connection con = ConnectionFactory.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, usuarioId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) lista.add(mapear(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return lista;
    }

    public List<Pedido> listarTodos() {
        List<Pedido> lista = new ArrayList<>();
        String sql = "SELECT * FROM pedidos ORDER BY data_pedido DESC";
        try (Connection con = ConnectionFactory.getConnection();
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) lista.add(mapear(rs));
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return lista;
    }

    private Pedido mapear(ResultSet rs) throws SQLException {
        Pedido p = new Pedido();
        p.setId(rs.getInt("id"));
        p.setUsuarioId(rs.getInt("usuario_id"));
        p.setTipoEntrega(rs.getString("tipo_entrega"));
        p.setEnderecoEntrega(rs.getString("endereco_entrega"));
        p.setFormaPagamento(rs.getString("forma_pagamento"));
        p.setCupomCodigo(rs.getString("cupom_codigo"));
        p.setSubtotal(rs.getBigDecimal("subtotal"));
        p.setDesconto(rs.getBigDecimal("desconto"));
        p.setTotal(rs.getBigDecimal("total"));
        p.setStatus(rs.getString("status"));
        p.setDataPedido(rs.getTimestamp("data_pedido"));
        return p;
    }
}
