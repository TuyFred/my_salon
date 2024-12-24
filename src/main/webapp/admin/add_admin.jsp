<%
    // Check if the session exists and if the username attribute is set
    if (session.getAttribute("username") == null) {
        // If not, use JavaScript to show an alert and then redirect
%>
        <script type="text/javascript">
            alert("Login to access this page");
            window.location.href = "login_admin.jsp"; // Redirect to the login page
        </script>
<%
        // Prevent further processing of the page
        return;
    }
%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../conn.jsp" %>
<%@ page import="java.sql.*" %>

<%
    String newAdminNames = request.getParameter("newAdminNames");
    String newAdminUsername = request.getParameter("newAdminUsername");
    String newAdminPassword = request.getParameter("newAdminPassword");
    String confirmAdminPassword = request.getParameter("confirmAdminPassword");
    String message = "";

    if (newAdminNames != null && newAdminUsername != null && newAdminPassword != null && confirmAdminPassword != null) {
        if (!newAdminPassword.equals(confirmAdminPassword)) {
            message = "New admin password and confirm password do not match.";
        } else {
            PreparedStatement pstmt = null;
            try {
                String insertQuery = "INSERT INTO admin (names, username, password) VALUES (?, ?, ?)";
                pstmt = conn.prepareStatement(insertQuery);
                pstmt.setString(1, newAdminNames);
                pstmt.setString(2, newAdminUsername);
                pstmt.setString(3, newAdminPassword);
                int insertedRows = pstmt.executeUpdate();

                if (insertedRows > 0) {
                    message = "New admin added successfully!";
                } else {
                    message = "Error adding new admin.";
                }
            } catch (SQLException e) {
                e.printStackTrace();
                message = "Error: " + e.getMessage();
            } finally {
                if (pstmt != null) {
                    try { pstmt.close(); } catch (SQLException e) { e.printStackTrace(); }
                }
            }
        }
    } else {
        message = "Please fill in all fields.";
    }

    request.setAttribute("message", message);
    request.getRequestDispatcher("settings.jsp").forward(request, response);
%>
