package dao;

import model.Produto;
import util.ConnectionFactory;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class ProdutoDAO {

    private Produto mapear(ResultSet rs) throws SQLException {
        Produto p = new Produto();
        p.setId(rs.getInt("id"));
        p.setNome(rs.getString("nome"));
        p.setDescricao(rs.getString("descricao"));
        p.setPreco(rs.getBigDecimal("preco"));
        p.setTamanho(rs.getString("tamanho"));
        p.setCor(rs.getString("cor"));
        p.setEstoque(rs.getInt("estoque"));
        p.setImagemUrl(rs.getString("imagem_url"));
        p.setCategoriaId(rs.getInt("categoria_id"));
        p.setAtivo(rs.getBoolean("ativo"));
        p.setDataCadastro(rs.getTimestamp("data_cadastro"));
        try { p.setCategoriaNome(rs.getString("categoria_nome")); } catch (SQLException ignore) {}
        return p;
    }

    public List<Produto> listarTodos() {
        List<Produto> lista = new ArrayList<>();
        String sql = "SELECT p.*, c.nome AS categoria_nome FROM produtos p "
                   + "JOIN categorias c ON c.id = p.categoria_id ORDER BY p.data_cadastro DESC";
        try (Connection con = ConnectionFactory.getConnection();
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) lista.add(mapear(rs));
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return lista;
    }

    public List<Produto> listarAtivos() {
        List<Produto> lista = new ArrayList<>();
        String sql = "SELECT p.*, c.nome AS categoria_nome FROM produtos p "
                   + "JOIN categorias c ON c.id = p.categoria_id WHERE p.ativo = 1 ORDER BY p.data_cadastro DESC";
        try (Connection con = ConnectionFactory.getConnection();
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) lista.add(mapear(rs));
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return lista;
    }

    public List<Produto> listarPorCategoria(int categoriaId) {
        List<Produto> lista = new ArrayList<>();
        String sql = "SELECT p.*, c.nome AS categoria_nome FROM produtos p "
                   + "JOIN categorias c ON c.id = p.categoria_id "
                   + "WHERE p.categoria_id = ? AND p.ativo = 1 ORDER BY p.nome";
        try (Connection con = ConnectionFactory.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, categoriaId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) lista.add(mapear(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return lista;
    }

    public Produto buscarPorId(int id) {
        String sql = "SELECT p.*, c.nome AS categoria_nome FROM produtos p "
                   + "JOIN categorias c ON c.id = p.categoria_id WHERE p.id = ?";
        try (Connection con = ConnectionFactory.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, id);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) return mapear(rs);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public boolean inserir(Produto p) {
        String sql = "INSERT INTO produtos (nome, descricao, preco, tamanho, cor, estoque, imagem_url, categoria_id, ativo) "
                   + "VALUES (?,?,?,?,?,?,?,?,1)";
        try (Connection con = ConnectionFactory.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, p.getNome());
            ps.setString(2, p.getDescricao());
            ps.setBigDecimal(3, p.getPreco());
            ps.setString(4, p.getTamanho());
            ps.setString(5, p.getCor());
            ps.setInt(6, p.getEstoque());
            ps.setString(7, p.getImagemUrl());
            ps.setInt(8, p.getCategoriaId());
            ps.executeUpdate();
            return true;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public boolean atualizar(Produto p) {
        String sql = "UPDATE produtos SET nome=?, descricao=?, preco=?, tamanho=?, cor=?, estoque=?, "
                   + "imagem_url=?, categoria_id=?, ativo=? WHERE id=?";
        try (Connection con = ConnectionFactory.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, p.getNome());
            ps.setString(2, p.getDescricao());
            ps.setBigDecimal(3, p.getPreco());
            ps.setString(4, p.getTamanho());
            ps.setString(5, p.getCor());
            ps.setInt(6, p.getEstoque());
            ps.setString(7, p.getImagemUrl());
            ps.setInt(8, p.getCategoriaId());
            ps.setBoolean(9, p.isAtivo());
            ps.setInt(10, p.getId());
            ps.executeUpdate();
            return true;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public boolean excluir(int id) {
        // Exclusão lógica (mantém histórico de pedidos íntegro)
        String sql = "UPDATE produtos SET ativo = 0 WHERE id = ?";
        try (Connection con = ConnectionFactory.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, id);
            ps.executeUpdate();
            return true;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public boolean baixarEstoque(int produtoId, int quantidade) {
        String sql = "UPDATE produtos SET estoque = estoque - ? WHERE id = ? AND estoque >= ?";
        try (Connection con = ConnectionFactory.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, quantidade);
            ps.setInt(2, produtoId);
            ps.setInt(3, quantidade);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
}
