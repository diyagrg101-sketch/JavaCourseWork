package com.sipserve.util;

import java.io.IOException;
import java.io.InputStream;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.Properties;

public final class DBConnection {

    private static final String CONFIG_FILE = "application.properties";

    private static String url;
    private static String user;
    private static String password;
    private static String driver;

    static {
        load();
        try {
            Class.forName(driver);
        } catch (ClassNotFoundException ex) {
            throw new ExceptionInInitializerError(
                "MySQL driver not found on classpath: " + driver);
        }
    }

    private DBConnection() { }

    private static void load() {
        Properties props = new Properties();
        try (InputStream in = DBConnection.class
                .getClassLoader()
                .getResourceAsStream(CONFIG_FILE)) {

            if (in == null) {
                throw new IllegalStateException(
                    CONFIG_FILE + " not found on classpath");
            }
            props.load(in);
        } catch (IOException ex) {
            throw new ExceptionInInitializerError(ex);
        }

        url      = props.getProperty("db.url");
        user     = props.getProperty("db.username");
        password = props.getProperty("db.password");
        driver   = props.getProperty("db.driver", "com.mysql.cj.jdbc.Driver");
    }

    public static Connection getConnection() throws SQLException {
        return DriverManager.getConnection(url, user, password);
    }
}
