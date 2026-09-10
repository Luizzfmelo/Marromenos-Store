package dao;

import model.Evento;
import util.ConnectionFactory;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class EventoDAO {

    private Evento mapear(ResultSet rs) throws SQLException {
        Evento e = new Evento();
        e.setId(rs.getInt("id"));
        e.setTitulo(rs.getString("titulo"));
        e.setDescricao(rs.getString("descricao"));
        e.setImagemUrl(rs.getString("imagem_url"));
        e.setDataInicio(rs.getDate("data_inicio"));
        e.setDataFim(rs.getDate("data_fim"));
        e.setAtivo(rs.getBoolean("ativo"));
        return e;
    }

    public List<Evento> listarAtivos() {
        List<Evento> lista = new ArrayList<>();
        String sql = "SELECT * FROM eventos WHERE ativo = 1 ORDER BY data_inicio DESC";
        try (Connection con = ConnectionFactory.getConnection();
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) lista.add(mapear(rs));
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return lista;
    }

    public List<Evento> listarTodos() {
        List<Evento> lista = new ArrayList<>();
        String sql = "SELECT * FROM eventos ORDER BY id DESC";
        try (Connection con = ConnectionFactory.getConnection();
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) lista.add(mapear(rs));
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return lista;
    }

    public boolean inserir(Evento e) {
        String sql = "INSERT INTO eventos (titulo, descricao, imagem_url, data_inicio, data_fim) VALUES (?,?,?,?,?)";
        try (Connection con = ConnectionFactory.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, e.getTitulo());
            ps.setString(2, e.getDescricao());
            ps.setString(3, e.getImagemUrl());
            ps.setDate(4, e.getDataInicio());
            ps.setDate(5, e.getDataFim());
            ps.executeUpdate();
            return true;
        } catch (SQLException ex) {
            ex.printStackTrace();
            return false;
        }
    }

    public boolean alternarAtivo(int id, boolean ativo) {
        String sql = "UPDATE eventos SET ativo = ? WHERE id = ?";
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
