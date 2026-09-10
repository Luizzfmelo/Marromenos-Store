package dao;

import model.Cupom;
import util.ConnectionFactory;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class CupomDAO {

    private Cupom mapear(ResultSet rs) throws SQLException {
        Cupom c = new Cupom();
        c.setId(rs.getInt("id"));
        c.setCodigo(rs.getString("codigo"));
        c.setTipoDesconto(rs.getString("tipo_desconto"));
        c.setValor(rs.getBigDecimal("valor"));
        c.setValidade(rs.getDate("validade"));
        c.setAtivo(rs.getBoolean("ativo"));
        int limite = rs.getInt("limite_uso");
        c.setLimiteUso(rs.wasNull() ? null : limite);
        c.setUsos(rs.getInt("usos"));
        return c;
    }

    public List<Cupom> listarTodos() {
        List<Cupom> lista = new ArrayList<>();
        String sql = "SELECT * FROM cupons ORDER BY id DESC";
        try (Connection con = ConnectionFactory.getConnection();
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) lista.add(mapear(rs));
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return lista;
    }

    /** Busca um cupom válido (ativo, dentro da validade e com usos disponíveis). */
    public Cupom buscarValido(String codigo) {
        String sql = "SELECT * FROM cupons WHERE codigo = ? AND ativo = 1 AND validade >= CURDATE() "
                   + "AND (limite_uso IS NULL OR usos < limite_uso)";
        try (Connection con = ConnectionFactory.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, codigo);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) return mapear(rs);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public boolean inserir(Cupom c) {
        String sql = "INSERT INTO cupons (codigo, tipo_desconto, valor, validade, limite_uso) VALUES (?,?,?,?,?)";
        try (Connection con = ConnectionFactory.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, c.getCodigo().toUpperCase());
            ps.setString(2, c.getTipoDesconto());
            ps.setBigDecimal(3, c.getValor());
            ps.setDate(4, c.getValidade());
            if (c.getLimiteUso() == null) ps.setNull(5, Types.INTEGER);
            else ps.setInt(5, c.getLimiteUso());
            ps.executeUpdate();
            return true;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public boolean registrarUso(String codigo) {
        String sql = "UPDATE cupons SET usos = usos + 1 WHERE codigo = ?";
        try (Connection con = ConnectionFactory.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, codigo);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public boolean alternarAtivo(int id, boolean ativo) {
        String sql = "UPDATE cupons SET ativo = ? WHERE id = ?";
        try (Connection con = ConnectionFactory.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setBoolean(1, ativo);
            ps.setInt(2, id);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
}
