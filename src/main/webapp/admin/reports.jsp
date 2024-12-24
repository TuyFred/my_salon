<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="javax.servlet.http.*" %>
<%@ page import="javax.servlet.*" %>
<%@ page import="java.io.*" %>
<%@ page session="true" %>
<%@ include file="../conn.jsp" %>
<%
    if (session.getAttribute("username") == null) {
%>
        <script type="text/javascript">
            alert("Login to access this page");
            window.location.href = "login_admin.jsp";
        </script>
<%
        return;
    }

    String startDate = request.getParameter("start_date");
    String endDate = request.getParameter("end_date");
    if (startDate == null || endDate == null) {
        startDate = "2020-01-01";
        endDate = "2024-12-31";
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
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
            padding: 20px;
        }
        .number-stat {
            font-size: 2.5rem;
            font-weight: bold;
            text-align: center;
            cursor: pointer;
            display: flex;
            align-items: center;
            justify-content: center;
            margin-bottom: 10px;
        }
        .number-label {
            font-size: 1.2rem;
            text-align: center;
            color: #6c757d;
        }
        #details-modal {
            display: none;
            position: fixed;
            top: 50%;
            left: 50%;
            transform: translate(-50%, -50%);
            width: 80%;
            max-width: 800px;
            background: #fff;
            box-shadow: 0 0 10px rgba(0,0,0,0.2);
            padding: 20px;
            z-index: 1000;
            overflow-y: auto;
        }
        #details-modal h4 {
            margin-top: 0;
        }
        #details-modal .close {
            position: absolute;
            top: 10px;
            right: 10px;
            font-size: 1.5rem;
            cursor: pointer;
        }
        #details-modal .modal-content {
            max-height: 400px;
            overflow-y: auto;
        }
        #overlay {
            display: none;
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: rgba(0,0,0,0.5);
            z-index: 999;
        }
    </style>
    <script>
        function showDetails(type, data) {
            const modal = document.getElementById('details-modal');
            const overlay = document.getElementById('overlay');
            const modalContent = document.getElementById('modal-content');
            
            modalContent.innerHTML = `<h4>${type} Details</h4><pre>${data}</pre>`;
            modal.style.display = 'block';
            overlay.style.display = 'block';
        }

        function closeModal() {
            const modal = document.getElementById('details-modal');
            const overlay = document.getElementById('overlay');
            
            modal.style.display = 'none';
            overlay.style.display = 'none';
        }
    </script>
</head>
<body>

    <!-- Sidebar -->
    <div class="sidebar">
        <ul class="navbar-nav">
            <li class="nav-item">
                <a class="nav-link" href="dashboard.jsp"><i class="fas fa-tachometer-alt"></i> Dashboard</a>
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
                 <a class="nav-link" href="#"><i class="fas fa-file-alt"></i> Report</a>
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

            <!-- Date Range Filter Form -->
            <form method="get" action="reports.jsp">
                <div class="row mb-3">
                    <div class="col-md-4">
                        <label for="start_date" class="form-label">Start Date</label>
                        <input type="date" id="start_date" name="start_date" class="form-control" value="<%= startDate %>">
                    </div>
                    <div class="col-md-4">
                        <label for="end_date" class="form-label">End Date</label>
                        <input type="date" id="end_date" name="end_date" class="form-control" value="<%= endDate %>">
                    </div>
                    <div class="col-md-4">
                        <label for="submit" class="form-label">&nbsp;</label>
                        <button type="submit" class="btn btn-primary form-control">Filter</button>
                    </div>
                </div>
            </form>

            <!-- Dashboard Metrics -->
            <div id="dashboard-metrics" class="row">
                <%-- Total Bookings --%>
                <%
                    try {
                        PreparedStatement pstmt1 = conn.prepareStatement(
                            "SELECT COUNT(*) AS totalBookings FROM appointments WHERE appointment_date BETWEEN ? AND ?");
                        pstmt1.setString(1, startDate);
                        pstmt1.setString(2, endDate);
                        ResultSet rs1 = pstmt1.executeQuery();
                        if (rs1.next()) {
                            int totalBookings = rs1.getInt("totalBookings");
                            // Fetch detailed bookings data
                            PreparedStatement pstmtDetails1 = conn.prepareStatement(
                                "SELECT * FROM appointments WHERE appointment_date BETWEEN ? AND ?");
                            pstmtDetails1.setString(1, startDate);
                            pstmtDetails1.setString(2, endDate);
                            ResultSet rsDetails1 = pstmtDetails1.executeQuery();
                            StringBuilder bookingDetails = new StringBuilder();
                            while (rsDetails1.next()) {
                                bookingDetails.append("ID: ").append(rsDetails1.getInt("app_id")).append(", ");
                                bookingDetails.append("Customer ID: ").append(rsDetails1.getInt("c_id")).append(", ");
                                bookingDetails.append("Stylist: ").append(rsDetails1.getString("stylist_name")).append(", ");
                                bookingDetails.append("Date: ").append(rsDetails1.getString("appointment_date")).append(", ");
                                bookingDetails.append("Time: ").append(rsDetails1.getString("appointment_time")).append(", ");
                                bookingDetails.append("Status: ").append(rsDetails1.getString("status")).append("\n");
                            }
                            rsDetails1.close();
                            out.println("<div class='col-md-4'><div class='card'>");
                            out.println("<div class='card-header'><h3>Total Bookings</h3></div>");
                            out.println("<div class='card-body'><div class='number-stat' onclick=\"showDetails('Bookings', '" + bookingDetails.toString().replace("\n", "\\n").replace("'", "\\'") + "')\">" + totalBookings + "</div>");
                            out.println("<div class='number-label'>Total Bookings</div></div></div></div>");
                        }
                        rs1.close();
                    } catch (SQLException e) {
                        e.printStackTrace();
                    }
                %>

                <%-- Total Customers --%>
                <%
                    try {
                        PreparedStatement pstmt2 = conn.prepareStatement(
                            "SELECT COUNT(*) AS totalCustomers FROM customers WHERE created_at BETWEEN ? AND ?");
                        pstmt2.setString(1, startDate);
                        pstmt2.setString(2, endDate);
                        ResultSet rs2 = pstmt2.executeQuery();
                        if (rs2.next()) {
                            int totalCustomers = rs2.getInt("totalCustomers");
                            // Fetch detailed customers data
                            PreparedStatement pstmtDetails2 = conn.prepareStatement(
                                "SELECT * FROM customers WHERE created_at BETWEEN ? AND ?");
                            pstmtDetails2.setString(1, startDate);
                            pstmtDetails2.setString(2, endDate);
                            ResultSet rsDetails2 = pstmtDetails2.executeQuery();
                            StringBuilder customerDetails = new StringBuilder();
                            while (rsDetails2.next()) {
                                customerDetails.append("ID: ").append(rsDetails2.getInt("c_id")).append(", ");
                                customerDetails.append("Name: ").append(rsDetails2.getString("customer_name")).append(", ");
                                customerDetails.append("Email: ").append(rsDetails2.getString("email")).append(", ");
                                customerDetails.append("Phone: ").append(rsDetails2.getString("phone_number")).append(", ");
                                customerDetails.append("Address: ").append(rsDetails2.getString("address")).append("\n");
                            }
                            rsDetails2.close();
                            out.println("<div class='col-md-4'><div class='card'>");
                            out.println("<div class='card-header'><h3>Total Customers</h3></div>");
                            out.println("<div class='card-body'><div class='number-stat' onclick=\"showDetails('Customers', '" + customerDetails.toString().replace("\n", "\\n").replace("'", "\\'") + "')\">" + totalCustomers + "</div>");
                            out.println("<div class='number-label'>Total Customers</div></div></div></div>");
                        }
                        rs2.close();
                    } catch (SQLException e) {
                        e.printStackTrace();
                    }
                %>

                <%-- Total Services --%>
           <%
    // Define the start and end dates for filtering
  // Replace with your actual end date

    try {
        // Query to get total number of services created between startDate and endDate
        PreparedStatement pstmt3 = conn.prepareStatement(
            "SELECT COUNT(*) AS totalServices FROM services WHERE created BETWEEN ? AND ?");
        pstmt3.setString(1, startDate);
        pstmt3.setString(2, endDate);
        ResultSet rs3 = pstmt3.executeQuery();
        if (rs3.next()) {
            int totalServices = rs3.getInt("totalServices");

            // Fetch detailed services data created between startDate and endDate
            PreparedStatement pstmtDetails3 = conn.prepareStatement(
                "SELECT * FROM services WHERE created BETWEEN ? AND ?");
            pstmtDetails3.setString(1, startDate);
            pstmtDetails3.setString(2, endDate);
            ResultSet rsDetails3 = pstmtDetails3.executeQuery();
            StringBuilder serviceDetails = new StringBuilder();
            while (rsDetails3.next()) {
                serviceDetails.append("ID: ").append(rsDetails3.getInt("service_id")).append(", ");
                serviceDetails.append("Name: ").append(rsDetails3.getString("service_name")).append(", ");
                serviceDetails.append("Description: ").append(rsDetails3.getString("description")).append(", ");
                serviceDetails.append("Price: ").append(rsDetails3.getDouble("price")).append(", ");
                serviceDetails.append("Duration: ").append(rsDetails3.getString("duration")).append(", ");
                
                // Assuming there is a date field 'created_date' in the 'services' table
                java.sql.Date createdDate = rsDetails3.getDate("created");
                if (createdDate != null) {
                    serviceDetails.append("Created Date: ").append(new java.text.SimpleDateFormat("yyyy-MM-dd").format(createdDate)).append("\n");
                } else {
                    serviceDetails.append("Created Date: Not Available\n");
                }
            }
            rsDetails3.close();

            // Output the service metric card
            out.println("<div class='col-md-4'>");
            out.println("<div class='card'>");
            out.println("<div class='card-header'><h3>Total Services</h3></div>");
            out.println("<div class='card-body'>");
            out.println("<div class='number-stat' onclick=\"showDetails('Services', '" + serviceDetails.toString().replace("\n", "\\n").replace("'", "\\'") + "')\">" + totalServices + "</div>");
            out.println("<div class='number-label'>Total Services</div>");
            out.println("</div></div></div>");
        }
        rs3.close();
    } catch (SQLException e) {
        e.printStackTrace();
    }
%>
           

                <%-- Total Staff --%>
    <%
    

    try {
        // Query to get total number of staff who joined between startDate and endDate
        PreparedStatement pstmt4 = conn.prepareStatement(
            "SELECT COUNT(*) AS totalStaff FROM staff WHERE join_date BETWEEN ? AND ?");
        pstmt4.setString(1, startDate);
        pstmt4.setString(2, endDate);
        ResultSet rs4 = pstmt4.executeQuery();
        if (rs4.next()) {
            int totalStaff = rs4.getInt("totalStaff");

            // Fetch detailed staff data who joined between startDate and endDate
            PreparedStatement pstmtDetails4 = conn.prepareStatement(
                "SELECT * FROM staff WHERE join_date BETWEEN ? AND ?");
            pstmtDetails4.setString(1, startDate);
            pstmtDetails4.setString(2, endDate);
            ResultSet rsDetails4 = pstmtDetails4.executeQuery();
            StringBuilder staffDetails = new StringBuilder();
            while (rsDetails4.next()) {
                staffDetails.append("ID: ").append(rsDetails4.getInt("s_id")).append(", ");
                staffDetails.append("Name: ").append(rsDetails4.getString("staff_name")).append(", ");
                staffDetails.append("Position: ").append(rsDetails4.getString("position")).append(", ");
                staffDetails.append("Contact: ").append(rsDetails4.getString("contact_number")).append(", ");
                
                // Assuming there is a date field 'joining_date' in the 'staff' table
                java.sql.Date joiningDate = rsDetails4.getDate("join_date");
                if (joiningDate != null) {
                    staffDetails.append("Joining Date: ").append(new java.text.SimpleDateFormat("yyyy-MM-dd").format(joiningDate)).append("\n");
                } else {
                    staffDetails.append("Joining Date: Not Available\n");
                }
            }
            rsDetails4.close();

            // Output the staff metric card
            out.println("<div class='col-md-4'>");
            out.println("<div class='card'>");
            out.println("<div class='card-header'><h3>Total Staff</h3></div>");
            out.println("<div class='card-body'>");
            out.println("<div class='number-stat' onclick=\"showDetails('Staff', '" + staffDetails.toString().replace("\n", "\\n").replace("'", "\\'") + "')\">" + totalStaff + "</div>");
            out.println("<div class='number-label'>Total Staff</div>");
            out.println("</div></div></div>");
        }
        rs4.close();
    } catch (SQLException e) {
        e.printStackTrace();
    }
%>


                <%-- Total Registered Customers --%>
                <%
  

    try {
        // Query to get total number of customers who were registered between startDate and endDate
        PreparedStatement pstmt5 = conn.prepareStatement(
            "SELECT COUNT(*) AS totalCustomers FROM customers WHERE created BETWEEN ? AND ?");
        pstmt5.setString(1, startDate);
        pstmt5.setString(2, endDate);
        ResultSet rs5 = pstmt5.executeQuery();
        if (rs5.next()) {
            int totalCustomers = rs5.getInt("totalCustomers");

            // Fetch detailed customer data who registered between startDate and endDate
            PreparedStatement pstmtDetails5 = conn.prepareStatement(
                "SELECT * FROM customers WHERE created BETWEEN ? AND ?");
            pstmtDetails5.setString(1, startDate);
            pstmtDetails5.setString(2, endDate);
            ResultSet rsDetails5 = pstmtDetails5.executeQuery();
            StringBuilder customerDetails = new StringBuilder();
            while (rsDetails5.next()) {
                customerDetails.append("ID: ").append(rsDetails5.getInt("c_id")).append(", ");
                customerDetails.append("Name: ").append(rsDetails5.getString("customer_name")).append(", ");
                customerDetails.append("Email: ").append(rsDetails5.getString("email")).append(", ");
                customerDetails.append("Phone: ").append(rsDetails5.getString("phone_number")).append(", ");
                customerDetails.append("Address: ").append(rsDetails5.getString("address")).append(", ");
                
                // Assuming there is a date field 'created' in the 'customers' table
                java.sql.Date createdDate = rsDetails5.getDate("created");
                if (createdDate != null) {
                    customerDetails.append("Registered Date: ").append(new java.text.SimpleDateFormat("yyyy-MM-dd").format(createdDate)).append("\n");
                } else {
                    customerDetails.append("Registered Date: Not Available\n");
                }
            }
            rsDetails5.close();

            // Output the customer metric card
            out.println("<div class='col-md-4'>");
            out.println("<div class='card'>");
            out.println("<div class='card-header'><h3>Total Registered Customers</h3></div>");
            out.println("<div class='card-body'>");
            out.println("<div class='number-stat' onclick=\"showDetails('Registered Customers', '" + customerDetails.toString().replace("\n", "\\n").replace("'", "\\'") + "')\">" + totalCustomers + "</div>");
            out.println("<div class='number-label'>Total Registered Customers</div>");
            out.println("</div></div></div>");
        }
        rs5.close();
    } catch (SQLException e) {
        e.printStackTrace();
    }
%>

            </div>

            <!-- Modal for Details -->
            <div id="details-modal">
                <div class="modal-content">
                    <span class="close" onclick="closeModal()">&times;</span>
                    <div id="modal-content"></div>
                </div>
            </div>
            <div id="overlay"></div>

            <!-- Footer -->
            <footer>
           

        </div>
    </div>

    <!-- Scripts -->
    <script src="../bootstrap1/boot/js/bootstrap.bundle.min.js"></script>
</body>
</html>
