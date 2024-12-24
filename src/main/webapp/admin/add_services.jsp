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
    <title>Add New Service - Hair Saloon</title>
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
        <h2>Add New Service</h2>
        <form action="save_service.jsp" method="post">
            <div class="form-group">
                <label for="serviceName">Service Name</label>
                <input type="text" class="form-control" id="serviceName" name="service_name" required>
            </div>
       
             <div class="form-group">
                <label for="description">Description</label>
                <input type="text" class="form-control" id="Description" name="Description" required>
            </div>
            <div class="form-group">
                <label for="price">Price ($)</label>
                <input type="text" class="form-control" id="price" name="price" step="0.01" required>
            </div>
           
            <div class="form-group">
                <label for="Duration">Duration</label>
                <input type="text" class="form-control" id="Duration" name="Duration"  required>
            </div>
            <button type="submit" class="btn btn-primary">Add Service</button>
            <a href="manage-services.jsp" class="btn btn-secondary">Cancel</a>
        </form>
    </div>

    <!-- Bootstrap and jQuery -->
    <script src="../bootstrap1/boot/js/jquery.min.js"></script>
    <script src="../bootstrap1/boot/js/bootstrap.min.js"></script>

</body>
</html>
