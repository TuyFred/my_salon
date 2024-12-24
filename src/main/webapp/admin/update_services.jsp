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
    <title>Update Service - Hair Saloon</title>
    <link rel="stylesheet" href="../bootstrap1/boot/css/bootstrap.min.css">
    <link rel="stylesheet" href="../fontawesome/css/all.min.css">
    <style>
        /* Custom CSS for form styling */
        .container {
            max-width: 500px;
            margin-top: 50px;
        }
        .form-group {
            margin-bottom: 20px;
        }
        .btn {
            font-size: 0.9rem;
            padding: 8px 16px;
        }
    </style>
</head>
<body>

    <div class="container">
        <h2>Update Service</h2>
        <%
            // Retrieve service ID from query parameter
            int serviceId = Integer.parseInt(request.getParameter("service_id"));
            
            // Fetch existing service details from database
            String query = "SELECT * FROM services WHERE service_id = ?";
            PreparedStatement pstmt = null;
            ResultSet resultSet = null;

            try {
                pstmt = conn.prepareStatement(query);
                pstmt.setInt(1, serviceId);
                resultSet = pstmt.executeQuery();

                if (resultSet.next()) {
                    String serviceName = resultSet.getString("service_name");
                    String description = resultSet.getString("description");
                    double price = resultSet.getDouble("price");
                    String duration = resultSet.getString("duration");
        %>
        <form action="save_update_services.jsp" method="post">
            <input type="hidden" name="service_id" value="<%= serviceId %>">
            <div class="form-group">
                <label for="serviceName">Service Name</label>
                <input type="text" class="form-control" id="serviceName" name="service_name" value="<%= serviceName %>" required>
            </div>
            <div class="form-group">
                <label for="description">Description</label>
                <input type="text" class="form-control" id="Description" name="description" value="<%= description %>" required>
            </div>
            <div class="form-group">
                <label for="price">Price ($)</label>
                <input type="text" class="form-control" id="price" name="price" value="<%= price %>" step="0.01" required>
            </div>
            <div class="form-group">
                <label for="duration">Duration</label>
                <input type="text" class="form-control" id="duration" name="duration" value="<%= duration %>" required>
            </div>
            <button type="submit" class="btn btn-primary">Update Service</button>
            <a href="manage-services.jsp" class="btn btn-secondary">Cancel</a>
        </form>
        <%
                } else {
                    out.println("<p>Service not found.</p>");
                }
            } catch (SQLException e) {
                out.println("<p>Error fetching service details: " + e.getMessage() + "</p>");
            } finally {
                if (resultSet != null) {
                    try { resultSet.close(); } catch (SQLException e) { e.printStackTrace(); }
                }
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
