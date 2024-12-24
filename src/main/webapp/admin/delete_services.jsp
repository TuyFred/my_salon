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
    <title>Delete Service - Hair Saloon</title>
    <link rel="stylesheet" href="../bootstrap1/boot/css/bootstrap.min.css">
    <link rel="stylesheet" href="../fontawesome/css/all.min.css">
    <style>
        /* Custom CSS for processing page */
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
        <%
            // Retrieve service ID from query parameter
            int serviceId = Integer.parseInt(request.getParameter("service_id"));

            // SQL query to delete the service from the database
            String query = "DELETE FROM services WHERE service_id = ?";
            PreparedStatement pstmt = null;

            try {
                // Create prepared statement and set parameter
                pstmt = conn.prepareStatement(query);
                pstmt.setInt(1, serviceId);

                // Execute the deletion
                int rowsAffected = pstmt.executeUpdate();

                // Check if deletion was successful
                if (rowsAffected > 0) {
        %>
        <div>
            <h2>Service Deleted Successfully</h2>
            <p>The service with ID <%= serviceId %> has been deleted.</p>
            <a href="manage-services.jsp" class="btn btn-primary">Back to Manage Services</a>
        </div>
        <%
                } else {
        %>
        <div>
            <h2>Error Deleting Service</h2>
            <p>Failed to delete the service with ID <%= serviceId %>. Please try again.</p>
            <a href="manage-services.jsp" class="btn btn-primary">Back to Manage Services</a>
        </div>
        <%
                }
            } catch (SQLException e) {
                out.println("<p>Error deleting service: " + e.getMessage() + "</p>");
            } finally {
                // Close resources
                if (pstmt != null) {
                    try { pstmt.close(); } catch (SQLException e) { e.printStackTrace(); }
                }
            }
        %>
    </div>

    <!-- Bootstrap and jQuery -->
    <script src="../bootstrap1/boot/js/jquery.min.js"></script>
    <script src="../bootstrap1/boot/js/bootstrap.min.js"></script>
</body>
</html>
