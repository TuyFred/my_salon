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
    <title>Delete Customer - Hair Saloon</title>
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
        <h2>Delete Customer</h2>
        <% 
            int c_id = Integer.parseInt(request.getParameter("c_id"));
        %>
        <form action="delete-customer-confirm.jsp" method="post">
            <input type="hidden" name="c_id" value="<%= c_id %>">
            <p>Are you sure you want to delete this customer?</p>
            <button type="submit" class="btn btn-danger">Delete Customer</button>
            <a href="manage-customers.jsp" class="btn btn-secondary">Cancel</a>
        </form>
    </div>

    <!-- Bootstrap and jQuery -->
    <script src="../bootstrap1/boot/js/jquery.min.js"></script>
    <script src="../bootstrap1/boot/js/bootstrap.min.js"></script>

</body>
</html>
