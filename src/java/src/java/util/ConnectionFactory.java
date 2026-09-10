package util;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

/**
 * Fábrica de conexões com o MySQL (XAMPP).
 * Ajuste USUARIO e SENHA se o seu MySQL do XAMPP tiver senha configurada
 * (por padrão o XAMPP vem com usuário "root" e senha em branco).
 */
public class ConnectionFactory {

    private static final String URL =
        "jdbc:mysql://localhost:3306/marromenos_db?useTimezone=true&serverTimezone=America/Sao_Paulo&useSSL=false";
    private static final String USUARIO = "root";
    private static final String SENHA = "";

    static {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
        } catch (ClassNotFoundException e) {
            throw new RuntimeException(
                "Driver do MySQL (mysql-connector-j) não encontrado. "
                + "Adicione o .jar na pasta lib do projeto (veja o README).", e);
        }
    }

    public static Connection getConnection() throws SQLException {
        return DriverManager.getConnection(URL, USUARIO, SENHA);
    }
}
