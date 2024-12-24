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
    <title>Processing Update Service - Hair Saloon</title>
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
            // Retrieve parameters from the form submission
            int serviceId = Integer.parseInt(request.getParameter("service_id"));
            String serviceName = request.getParameter("service_name");
            String description = request.getParameter("description");
            double price = Double.parseDouble(request.getParameter("price"));
            String duration = request.getParameter("duration");

            // SQL query to update the service in the database
            String query = "UPDATE services SET service_name = ?, description = ?, price = ?, duration = ? WHERE service_id = ?";
            PreparedStatement pstmt = null;

            try {
                // Create prepared statement and set parameters
                pstmt = conn.prepareStatement(query);
                pstmt.setString(1, serviceName);
                pstmt.setString(2, description);
                pstmt.setDouble(3, price);
                pstmt.setString(4, duration);
                pstmt.setInt(5, serviceId);

                // Execute the update
                int rowsAffected = pstmt.executeUpdate();

                // Check if update was successful
                if (rowsAffected > 0) {
        %>
        <div>
            <h2>Service Updated Successfully</h2>
            <p>The service "<%= serviceName %>" has been updated.</p>
            <a href="manage-services.jsp" class="btn btn-primary">Back to Manage Services</a>
        </div>
        <%
                } else {
        %>
        <div>
            <h2>Error Updating Service</h2>
            <p>Failed to update the service "<%= serviceName %>". Please try again.</p>
            <a href="update_services.jsp?service_id=<%= serviceId %>" class="btn btn-primary">Try Again</a>
        </div>
        <%
                }
            } catch (SQLException e) {
                out.println("<p>Error updating service: " + e.getMessage() + "</p>");
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
