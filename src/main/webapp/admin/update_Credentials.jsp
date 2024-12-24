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
    String currentPassword = request.getParameter("currentPassword");
    String newUsername = request.getParameter("username");
    String newPassword = request.getParameter("newPassword");
    String confirmPassword = request.getParameter("confirmPassword");
    String message = "";

    // Check if all parameters are provided
    if (currentPassword != null && newUsername != null && newPassword != null && confirmPassword != null) {
        // Check if the new password and confirm password match
        if (!newPassword.equals(confirmPassword)) {
            message = "New password and confirm password do not match.";
        } else {
            PreparedStatement checkPstmt = null;
            PreparedStatement updatePstmt = null;
            ResultSet checkRs = null;
            try {
                // Check if the current password is correct
                String checkQuery = "SELECT * FROM admin WHERE id = 1 AND password = ?";
                checkPstmt = conn.prepareStatement(checkQuery);
                checkPstmt.setString(1, currentPassword);
                checkRs = checkPstmt.executeQuery();

                if (checkRs.next()) {
                    // Update the username and password
                    String updateQuery = "UPDATE admin SET username = ?, password = ? WHERE id = 1";
                    updatePstmt = conn.prepareStatement(updateQuery);
                    updatePstmt.setString(1, newUsername);
                    updatePstmt.setString(2, newPassword);
                    int updatedRows = updatePstmt.executeUpdate();

                    if (updatedRows > 0) {
                        message = "Credentials updated successfully!";
                    } else {
                        message = "Error updating credentials.";
                    }
                } else {
                    message = "Current password is incorrect.";
                }
            } catch (SQLException e) {
                e.printStackTrace();
                message = "Error: " + e.getMessage();
            } finally {
                // Close the ResultSet and PreparedStatement
                if (checkRs != null) {
                    try { checkRs.close(); } catch (SQLException e) { e.printStackTrace(); }
                }
                if (checkPstmt != null) {
                    try { checkPstmt.close(); } catch (SQLException e) { e.printStackTrace(); }
                }
                if (updatePstmt != null) {
                    try { updatePstmt.close(); } catch (SQLException e) { e.printStackTrace(); }
                }
            }
        }
    } else {
        message = "Please fill in all fields.";
    }

    // Set the message attribute and forward to the settings page
    request.setAttribute("message", message);
    request.getRequestDispatcher("settings.jsp").forward(request, response);
%>
