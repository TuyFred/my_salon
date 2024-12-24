<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="javax.naming.Context" %>
<%@ page import="javax.naming.InitialContext" %>

<html>
<head>
    <title></title>
</head>
<body>
    <h2></h2>
   
    <% 
    // Connecting to Database from JSP
    Connection conn = null;
    Statement stmt = null;
    ResultSet rs = null;
    
    try {
        // Register MySQL JDBC driver
        Class.forName("com.mysql.cj.jdbc.Driver");
        
        // Open a connection
        conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/crud", "root", "");
        
        // Check if connection is successful
        if (conn != null) {
           // out.println("<p>Connected to database successfully!</p>");
        } else {
            out.println("<p>Failed to connect to database.</p>");
        }
    } catch (ClassNotFoundException | SQLException e) {
        out.println("<p>Database connection error: " + e.getMessage() + "</p>");
    } finally {
        // Close connections, statements, and result sets
        // Note: Leaving this section empty means resources are not explicitly closed here.
    }
    %>

</body>
</html>
