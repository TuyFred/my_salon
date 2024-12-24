<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="javax.servlet.*" %>
<%@ page import="javax.servlet.http.*" %>
<%@ include file="conn.jsp" %>
<%
    // Retrieve form data
    String name = request.getParameter("name");
    String email = request.getParameter("email");
    String message = request.getParameter("message");

    // Establish database connection and insert data
    try {
        String insertQuery = "INSERT INTO feedback (names, email, message) VALUES (?, ?, ?)";
        PreparedStatement pstmt = conn.prepareStatement(insertQuery);
        pstmt.setString(1, name);
        pstmt.setString(2, email);
        pstmt.setString(3, message);

        int rowCount = pstmt.executeUpdate();
        if (rowCount > 0) {
%>
            <script type="text/javascript">
                alert("Message sent successfully!");
                window.location.href = "index.jsp"; // Redirect to the contact page or any other page
            </script>
<%
        } else {
%>
            <script type="text/javascript">
                alert("Failed to send message. Please try again.");
                window.location.href = "index.jsp"; // Redirect to the contact page or any other page
            </script>
<%
        }
        pstmt.close();
    } catch (SQLException e) {
        out.println("Error: " + e.getMessage());
        e.printStackTrace();
    }
%>
