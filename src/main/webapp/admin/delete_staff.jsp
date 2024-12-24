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
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Delete Staff - Hair Saloon</title>
    <link rel="stylesheet" href="../bootstrap1/boot/css/bootstrap.min.css">
    <link rel="stylesheet" href="../fontawesome/css/all.min.css">
    <style>
        /* Custom CSS for form styling */
        .container {
            max-width: 500px;
            margin-top: 50px;
        }
        .btn {
            font-size: 0.9rem;
            padding: 8px 16px;
        }
    </style>
</head>
<body>

    <div class="container">
        <h2>Delete Staff</h2>
        <% 
            // Retrieve staff_id from request
            int staff_id = Integer.parseInt(request.getParameter("staff_id"));
            
            // Perform deletion operation
            PreparedStatement pstmt = null;
            try {
                String query = "DELETE FROM staff WHERE staff_id = ?";
                pstmt = conn.prepareStatement(query);
                pstmt.setInt(1, staff_id);
                int rowsAffected = pstmt.executeUpdate();
                if (rowsAffected > 0) {
        %>
        <div class="alert alert-success" role="alert">
            Staff member deleted successfully.
        </div>
        <% } else { %>
        <div class="alert alert-danger" role="alert">
            Failed to delete staff member. Please try again.
        </div>
        <% }
            } catch (SQLException e) {
                out.println("<p>Error deleting staff member: " + e.getMessage() + "</p>");
            } finally {
                if (pstmt != null) {
                    try { pstmt.close(); } catch (SQLException e) { e.printStackTrace(); }
                }
            }
        %>
        <a href="manage-staff.jsp" class="btn btn-primary">Back to Staff</a>
    </div>

    <!-- Bootstrap and jQuery -->
    <script src="../bootstrap1/boot/js/jquery.min.js"></script>
    <script src="../bootstrap1/boot/js/bootstrap.min.js"></script>

</body>
</html>
