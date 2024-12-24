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
    <title>Processing Add Service - Hair Saloon</title>
    <link rel="stylesheet" href="../bootstrap1/boot/css/bootstrap.min.css">
    <link rel="stylesheet" href="../fontawesome/css/all.min.css">
    <style>
        /* Custom CSS for styling */
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
            String serviceName = request.getParameter("service_name");
            String description = request.getParameter("Description");
            double price = Double.parseDouble(request.getParameter("price"));
            String duration = request.getParameter("Duration");

            // SQL query to insert a new service into the database
            String query = "INSERT INTO services (service_name, Description, price, duration) VALUES (?, ?, ?, ?)";
            PreparedStatement pstmt = null;

            try {
                // Create prepared statement and set parameters
                pstmt = conn.prepareStatement(query);
                pstmt.setString(1, serviceName);
                pstmt.setString(2, description);
                pstmt.setDouble(3, price);
                pstmt.setString(4, duration);

                // Execute the update
                int rowsAffected = pstmt.executeUpdate();

                // Check if insertion was successful
                if (rowsAffected > 0) {
        %>
        <div>
            <h2>Service Added Successfully</h2>
            <p>The service "<%= serviceName %>" has been added to the database.</p>
            <a href="manage-services.jsp" class="btn btn-primary">Back to Manage Services</a>
        </div>
        <%
                } else {
        %>
        <div>
            <h2>Error Adding Service</h2>
            <p>Failed to add the service "<%= serviceName %>". Please try again.</p>
            <a href="add_service.jsp" class="btn btn-primary">Try Again</a>
        </div>
        <%
                }
            } catch (SQLException e) {
                out.println("<p>Error adding service: " + e.getMessage() + "</p>");
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
