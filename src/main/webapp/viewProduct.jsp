<%@ page import="java.sql.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.io.*,java.util.*" %>

<%
    // JDBC URL for MariaDB
    String jdbcUrl = "jdbc:mariadb://localhost:3306/scmdb";
    String username = "root";
    String password = "Abdes3536";

    try {
        // Load the JDBC driver
        Class.forName("org.mariadb.jdbc.Driver");

        // Establish the connection
        Connection connection = DriverManager.getConnection(jdbcUrl, username, password);

        // Retrieve all products from the database
        String selectQuery = "SELECT * FROM products";
        try (Statement statement = connection.createStatement();
             ResultSet resultSet = statement.executeQuery(selectQuery)) {

            // Display the products
            while (resultSet.next()) {
                String productName = resultSet.getString("name");
                int productId = resultSet.getInt("id");
                float productPrice = resultSet.getFloat("price");

                out.println("Product ID: " + productId + ", Product Name: " + productName + ", Price: $" + productPrice + "<br>");
            }
        }

        connection.close();
    } catch (ClassNotFoundException | SQLException e) {
        e.printStackTrace();
        response.getWriter().println("Error retrieving products from the database.");
    }
%>
