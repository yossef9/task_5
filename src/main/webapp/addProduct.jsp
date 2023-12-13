<%@ page import="java.sql.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.io.*,java.util.*" %>

<%
    // Retrieve form data
    String productName = request.getParameter("productName");
    int productId = Integer.parseInt(request.getParameter("productId"));
    float productPrice = Float.parseFloat(request.getParameter("productPrice"));

    // JDBC URL for MariaDB
    String jdbcUrl = "jdbc:mariadb://localhost:3306/scmdb";
    String username = "root";
    String password = "Abdes3536";

    try {
        // Load the JDBC driver
        Class.forName("org.mariadb.jdbc.Driver");

        // Establish the connection
        Connection connection = DriverManager.getConnection(jdbcUrl, username, password);

        // Insert the product into the database
        String insertQuery = "INSERT INTO products (name, id, price) VALUES (?, ?, ?)";
        try (PreparedStatement preparedStatement = connection.prepareStatement(insertQuery)) {
            preparedStatement.setString(1, productName);
            preparedStatement.setInt(2, productId);
            preparedStatement.setFloat(3, productPrice);
            preparedStatement.executeUpdate();
        }

        connection.close();
        response.sendRedirect("viewProduct.jsp");
    } catch (ClassNotFoundException | SQLException e) {
        e.printStackTrace();
        response.getWriter().println("Error adding product to the database.");
    }
%>
