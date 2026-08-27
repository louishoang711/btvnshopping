package vn.com.btvn.connection;

import java.sql.Connection;
import java.sql.DriverManager;

public class DBConnection {
    private final String serverName = "localhost";
    private final String dbName = "ShoppingServiceMVC";
    private final String portNumber = "1433";

    public Connection getConnection() throws Exception {
        String url = "jdbc:sqlserver://" + serverName + ":" + portNumber 
                   + ";databaseName=" + dbName 
                   + ";integratedSecurity=true;encrypt=true;trustServerCertificate=true;";
        Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
        return DriverManager.getConnection(url);
    }
}