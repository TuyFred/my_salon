<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, java.io.*, java.util.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

<%
String fname = request.getParameter("name");
String number = request.getParameter("number");
String email = request.getParameter("email");
String address = request.getParameter("address");
String password = request.getParameter("password");

Connection conn = null;
PreparedStatement pst = null;

try {
    Class.forName("com.mysql.cj.jdbc.Driver");
    conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/saloon_db", "root", "");

    pst = conn.prepareStatement("INSERT INTO customers (customer_name, phone_number, email, address, password) VALUES (?, ?, ?, ?, ?)");
    pst.setString(1, fname);
    pst.setString(2, number);
    pst.setString(3, email);
    pst.setString(4, address);
    pst.setString(5, password);

    int i = pst.executeUpdate();

    if (i > 0) {
        out.println("Thank you for registering! Please <a href='login_client.jsp'>Login</a> to continue.");
    } else {
        out.println("Registration failed. Please try again.");
    }
} catch (ClassNotFoundException | SQLException e) {
    e.printStackTrace();
    out.println("An error occurred: " + e.getMessage());
} finally {
    try {
        if (pst != null) {
            pst.close();
        }
        if (conn != null) {
            conn.close();
        }
    } catch (SQLException e) {
        e.printStackTrace();
        out.println("Error closing connections: " + e.getMessage());
    }
}
%>
</body>
</html>