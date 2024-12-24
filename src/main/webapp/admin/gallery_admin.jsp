<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="javax.servlet.http.*" %>
<%@ page import="javax.servlet.*" %>
<%@ page import="java.io.*" %>
<%@ page session="true" %>
<%@ include file="../conn.jsp" %>

<%
    // Check if the session exists and if the username attribute is set
    if (session.getAttribute("username") == null) {
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

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Gallery Management - Hair Saloon</title>
    <link rel="stylesheet" href="../bootstrap1/boot/css/bootstrap.min.css">
    <link rel="stylesheet" href="../fontawesome/css/all.min.css">
    <style>
        .sidebar {
            position: fixed;
            top: 0;
            left: 0;
            height: 100%;
            width: 250px;
            background-color: #343a40;
            padding-top: 15px;
        }
        .sidebar ul.navbar-nav {
            flex-direction: column;
        }
        .sidebar .nav-item {
            width: 100%;
            padding: 10px 15px;
        }
        .sidebar .nav-link {
            color: #fff;
            padding: 10px 15px;
            text-align: center;
        }
        .sidebar .nav-link:hover {
            background-color: #495057;
        }
        .main-content {
            margin-left: 250px;
            padding: 20px;
        }
        .card {
            margin-bottom: 20px;
            border: none;
            box-shadow: 0 0 20px rgba(0,0,0,0.1);
        }
        .card-header {
            background-color: #007bff;
            color: #fff;
        }
        .card-header h3 {
            margin-bottom: 0;
        }
        .card-body {
            padding: 20px;
        }
        .number-stat {
            font-size: 2.5rem;
            font-weight: bold;
            text-align: center;
        }
        .number-label {
            font-size: 1.2rem;
            text-align: center;
            color: #6c757d;
        }
        .gallery-img {
            width: 100%;
            height: auto;
        }
    </style>
</head>
<body>

    <!-- Sidebar -->
    <div class="sidebar">
        <ul class="navbar-nav">
            <li class="nav-item">
                <a class="nav-link" href="#"><i class="fas fa-tachometer-alt"></i> Dashboard</a>
            </li>
            <li class="nav-item">
                <a class="nav-link" href="manage-bookings.jsp"><i class="fas fa-calendar-alt"></i> Manage Bookings</a>
            </li>
            <li class="nav-item">
                <a class="nav-link" href="manage-services.jsp"><i class="fas fa-concierge-bell"></i> Manage Services</a>
            </li>
            <li class="nav-item">
                <a class="nav-link" href="manage-staff.jsp"><i class="fas fa-users"></i> Manage Staff</a>
            </li>
            <li class="nav-item">
                <a class="nav-link" href="manage-customers.jsp"><i class="fas fa-user"></i> Manage Customers</a>
            </li>
            <li class="nav-item">
                <a class="nav-link" href="gallery_admin.jsp"><i class="fas fa-image"></i> Gallery Management</a>
            </li>
            <li class="nav-item">
                <a class="nav-link" href="manage-message.jsp"><i class="fas fa-envelope"></i> Manage Messages</a>
            </li>
            <li class="nav-item">
                <a class="nav-link" href="settings.jsp"><i class="fas fa-cog"></i> Settings</a>
            </li>
            <li class="nav-item">
                <a class="nav-link" href="logout.jsp"><i class="fas fa-sign-out-alt"></i> Logout</a>
            </li>
        </ul>
    </div>

    <!-- Main Content -->
    <div class="main-content">
        <div class="container-fluid">
            <!-- Gallery Management Section -->
            <div id="gallery-management">
                <div class="row">
                    <div class="col-md-12">
                        <div class="card">
                            <div class="card-header">
                                <h3>Gallery Management</h3>
                            </div>
                            <div class="card-body">
                                <!-- Insert Image Form -->
                                <h2 class="text-center">Insert an Image into the Gallery</h2>
                                <form action="upload_image.jsp" method="post" enctype="multipart/form-data">
                                    <div class="form-group">
                                        <label for="description">Description</label>
                                        <input type="text" class="form-control" id="description" name="description" required>
                                    </div>
                                 
                                    <div class="form-group">
                                        <label for="myimg">Image</label>
                                        <input type="file" class="form-control" id="image_path" name="image_path" required>
                                    </div>
                                    <button type="submit" class="btn btn-primary">Submit</button>
                                </form>
                                <hr>
                                <h4>Gallery Images</h4>
                                <div class="row">
                                    <%-- Fetch and display gallery images --%>
                                    <%
                                        try {
                                            Statement stmt7 = conn.createStatement();
                                            ResultSet rs7 = stmt7.executeQuery("SELECT * FROM gallery");
                                            while (rs7.next()) {
                                                String image_path = rs7.getString("image_path");
                                    %>
                                    <div class="col-md-3">
                                        <div class="card">
                                            <img src="<%= image_path %>" alt="Gallery Image" class="gallery-img">
                                            <div class="card-body text-center">
                                                <form action="gallery_delete_admin.jsp" method="post">
                                                    <input type="hidden" name="imageId" value="<%= rs7.getInt("id") %>">
                                                    <button type="submit" class="btn btn-danger">Delete</button>
                                                </form>
                                            </div>
                                        </div>
                                    </div>
                                    <% }
                                       rs7.close();
                                       stmt7.close();
                                     } catch (SQLException e) {
                                         out.println("Error in gallery images query: " + e.getMessage());
                                         e.printStackTrace();
                                     } %>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

        </div>
    </div>

    <script src="../bootstrap1/boot/js/jquery.min.js"></script>
    <script src="../bootstrap1/boot/js/popper.min.js"></script>
    <script src="../bootstrap1/boot/js/bootstrap.min.js"></script>
</body>
</html>
