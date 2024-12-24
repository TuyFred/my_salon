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

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Dashboard - Hair Saloon</title>
    <link rel="stylesheet" href="../bootstrap1/boot/css/bootstrap.min.css">
    <link rel="stylesheet" href="../fontawesome/css/all.min.css">
    <style>
        /* Custom CSS for dashboard styling */
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
                 <a class="nav-link" href="reports.jsp"><i class="fas fa-file-alt"></i> Report</a>
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

            <!-- Dashboard Metrics -->
            <div id="dashboard-metrics" class="row">
                <%-- Fetch and display total bookings --%>
                <%
                    try {
                        Statement stmt1 = conn.createStatement();
                        ResultSet rs1 = stmt1.executeQuery("SELECT COUNT(*) AS totalBookings FROM appointments");
                        if (rs1.next()) {
                            int totalBookings = rs1.getInt("totalBookings");
                %>
                <div class="col-md-4">
                    <div class="card">
                        <div class="card-body">
                            <div class="number-stat"><%= totalBookings %></div>
                            <div class="number-label">Total Bookings</div>
                        </div>
                    </div>
                </div>
                <% } else { %>
                <div class="col-md-4">
                    <div class="card">
                        <div class="card-body">
                            <div class="number-stat">N/A</div>
                            <div class="number-label">Total Bookings</div>
                        </div>
                    </div>
                </div>
                <% }
                   rs1.close();
                   stmt1.close();
                 } catch (SQLException e) {
                     out.println("Error in total bookings query: " + e.getMessage());
                     e.printStackTrace();
                 } %>

                <%-- Fetch and display pending bookings --%>
                <%
                    try {
                        Statement stmt2 = conn.createStatement();
                        ResultSet rs2 = stmt2.executeQuery("SELECT COUNT(*) AS pendingBookings FROM appointments WHERE status = 'pending' ");
                        if (rs2.next()) {
                            int pendingBookings = rs2.getInt("pendingBookings");
                %>
                <div class="col-md-4">
                    <div class="card">
                        <div class="card-body">
                            <div class="number-stat"><%= pendingBookings %></div>
                            <div class="number-label">Pending Bookings</div>
                        </div>
                    </div>
                </div>
                <% } else { %>
                <div class="col-md-4">
                    <div class="card">
                        <div class="card-body">
                            <div class="number-stat">N/A</div>
                            <div class="number-label">Pending Bookings</div>
                        </div>
                    </div>
                </div>
                <% }
                   rs2.close();
                   stmt2.close();
                 } catch (SQLException e) {
                     out.println("Error in pending bookings query: " + e.getMessage());
                     e.printStackTrace();
                 } %>

                <%-- Fetch and display confirmed bookings --%>
                <%
                    try {
                        Statement stmt3 = conn.createStatement();
                        ResultSet rs3 = stmt3.executeQuery("SELECT COUNT(*) AS confirmedBookings FROM appointments WHERE status = 'confirmed' ");
                        if (rs3.next()) {
                            int confirmedBookings = rs3.getInt("confirmedBookings");
                %>
                <div class="col-md-4">
                    <div class="card">
                        <div class="card-body">
                            <div class="number-stat"><%= confirmedBookings %></div>
                            <div class="number-label">Confirmed Bookings</div>
                        </div>
                    </div>
                </div>
                <% } else { %>
                <div class="col-md-4">
                    <div class="card">
                        <div class="card-body">
                            <div class="number-stat">N/A</div>
                            <div class="number-label">Confirmed Bookings</div>
                        </div>
                    </div>
                </div>
                <% }
                   rs3.close();
                   stmt3.close();
                 } catch (SQLException e) {
                     out.println("Error in confirmed bookings query: " + e.getMessage());
                     e.printStackTrace();
                 } %>

                <!-- Add more metrics cards as needed -->
            </div>

            <!-- Additional Metrics -->
            <div id="additional-metrics" class="row">
                <%-- Fetch and display active staff members --%>
                <%
                    try {
                        Statement stmt4 = conn.createStatement();
                        ResultSet rs4 = stmt4.executeQuery("SELECT COUNT(*) AS activeStaffMembers FROM staff");
                        if (rs4.next()) {
                            int activeStaffMembers = rs4.getInt("activeStaffMembers");
                %>
                <div class="col-md-4">
                    <div class="card">
                        <div class="card-body">
                            <div class="number-stat"><%= activeStaffMembers %></div>
                            <div class="number-label">Active Staff Members</div>
                        </div>
                    </div>
                </div>
                <% } else { %>
                <div class="col-md-4">
                    <div class="card">
                        <div class="card-body">
                            <div class="number-stat">N/A</div>
                            <div class="number-label">Active Staff Members</div>
                        </div>
                    </div>
                </div>
                <% }
                   rs4.close();
                   stmt4.close();
                 } catch (SQLException e) {
                     out.println("Error in active staff members query: " + e.getMessage());
                     e.printStackTrace();
                 } %>

                <%-- Fetch and display total message --%>
                <%
                    try {
                        Statement stmt5 = conn.createStatement();
                        ResultSet rs5 = stmt5.executeQuery("SELECT COUNT(*) AS totalmessages FROM feedback");
                        if (rs5.next()) {
                            int totalmessages = rs5.getInt("totalmessages");
                %>
                <div class="col-md-4">
                    <div class="card">
                        <div class="card-body">
                            <div class="number-stat"><%= totalmessages %></div>
                            <div class="number-label">Total Messages</div>
                        </div>
                    </div>
                </div>
                <% } else { %>
                <div class="col-md-4">
                    <div class="card">
                        <div class="card-body">
                            <div class="number-stat">N/A</div>
                            <div class="number-label">Total Messages</div>
                        </div>
                    </div>
                </div>
                <% }
                   rs5.close();
                   stmt5.close();
                 } catch (SQLException e) {
                     out.println("Error in Total Messages query: " + e.getMessage());
                     e.printStackTrace();
                 } %>
				<%-- Fetch and display total customers --%>
                <%
                    try {
                        Statement stmt5 = conn.createStatement();
                        ResultSet rs5 = stmt5.executeQuery("SELECT COUNT(*) AS totalcustomers FROM customers");
                        if (rs5.next()) {
                            int totalcustomers = rs5.getInt("totalcustomers");
                %>
                <div class="col-md-4">
                    <div class="card">
                        <div class="card-body">
                            <div class="number-stat"><%= totalcustomers %></div>
                            <div class="number-label">Total Customers</div>
                        </div>
                    </div>
                </div>
                <% } else { %>
                <div class="col-md-4">
                    <div class="card">
                        <div class="card-body">
                            <div class="number-stat">N/A</div>
                            <div class="number-label">Total Messages</div>
                        </div>
                    </div>
                </div>
                <% }
                   rs5.close();
                   stmt5.close();
                 } catch (SQLException e) {
                     out.println("Error in Total Messages query: " + e.getMessage());
                     e.printStackTrace();
                 } %>
				
                <%-- Fetch and display services offered --%>
                <%
                    try {
                        Statement stmt6 = conn.createStatement();
                        ResultSet rs6 = stmt6.executeQuery("SELECT COUNT(*) AS servicesOffered FROM services");
                        if (rs6.next()) {
                            int servicesOffered = rs6.getInt("servicesOffered");
                %>
                <div class="col-md-4">
                    <div class="card">
                        <div class="card-body">
                            <div class="number-stat"><%= servicesOffered %></div>
                            <div class="number-label">Services Offered</div>
                        </div>
                    </div>
                </div>
                <% } else { %>
                <div class="col-md-4">
                    <div class="card">
                        <div class="card-body">
                            <div class="number-stat">N/A</div>
                            <div class="number-label">Services Offered</div>
                        </div>
                    </div>
                </div>
                <% }
                   rs6.close();
                   stmt6.close();
                 } catch (SQLException e) {
                     out.println("Error in services offered query: " + e.getMessage());
                     e.printStackTrace();
                 } %>

                <!-- Add more metrics cards as needed -->
            </div>

        </div>
    </div>

</body>
</html>
