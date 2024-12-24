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
    <title>Manage Bookings - Hair Saloon</title>
    <link rel="stylesheet" href="../bootstrap1/boot/css/bootstrap.min.css">
    <link rel="stylesheet" href="../fontawesome/css/all.min.css">
     <script src="https://cdnjs.cloudflare.com/ajax/libs/jspdf/2.5.1/jspdf.umd.min.js"></script>
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
        .table-responsive {
            overflow-x: auto;
        }
        .btn {
            cursor: pointer;
        }
        .modal-body {
            padding: 20px;
        }
        .form-control {
            margin-bottom: 15px;
        }
        .alert {
            margin-top: 20px;
        }
    </style>
</head>
<body>

    <!-- Sidebar -->
    <div class="sidebar">
        <ul class="navbar-nav">
            <li class="nav-item">
                <a class="nav-link" href="dashboard.jsp"><i class="fas fa-tachometer-alt"></i> Dashboard</a>
            </li>
            <li class="nav-item">
                <a class="nav-link" href="#"><i class="fas fa-calendar-alt"></i> Manage Bookings</a>
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

            <!-- Status Message -->
            <% if (request.getParameter("status") != null) { %>
                <div class="alert alert-<%= request.getParameter("status").equals("success") ? "success" : "danger" %>">
                    <%= request.getParameter("status").equals("success") ? "Booking status updated successfully!" : "Failed to update booking status." %>
                </div>
            <% } %>
<a href="#" id="downloadPdfBtn" class="d-none d-sm-inline-block btn btn-sm btn-primary shadow-sm">
    <i class="fas fa-download fa-sm text-white-50"></i> Generate Report
</a>
            <!-- Search Form -->
            <div class="row mb-4">
                <div class="col-md-12">
                    <form method="get" action="manage-bookings.jsp">
                        <div class="form-group">
                            <input type="text" class="form-control" name="search" placeholder="Search bookings by keyword..." value="<%= request.getParameter("search") %>">
                        </div>
                        <button type="submit" class="btn btn-primary">Search</button>
                    </form>
                </div>
            </div>

            <!-- Manage Bookings Section -->
            <div id="manage-bookings" class="row">
                <div class="col-md-12">
                    <div class="card">
                        <div class="card-header">
                            <h3>Manage Bookings</h3>
                        </div>
                        <div class="card-body">
                            <div class="table-responsive">
                                <table class="table table-striped">
                                    <thead>
                                        <tr>
                                            <th>#</th>
                                            <th>Customer Name</th>
                                            <th>Date</th>
                                            <th>Time</th>
                                            <th>Service</th>
                                            <th>Stylist</th>
                                            <th>Status</th>
                                            <th>Action</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <%
                                            // Get search parameter from request
                                            String search = request.getParameter("search");
                                            String whereClause = "";

                                            if (search != null && !search.trim().isEmpty()) {
                                                search = "%" + search.trim() + "%"; // Prepare search term
                                                whereClause = " WHERE c.customer_name LIKE ? OR a.appointment_date LIKE ? OR a.appointment_time LIKE ? OR s.service_name LIKE ? OR a.stylist_name LIKE ? OR a.status LIKE ?";
                                            }

                                            // Fetch bookings from the database with search functionality
                                            try {
                                                String sql = "SELECT a.app_id, c.customer_name, a.appointment_date, a.appointment_time, s.service_name, a.stylist_name, a.status " +
                                                             "FROM appointments a " +
                                                             "JOIN customers c ON a.c_id = c.c_id " +
                                                             "JOIN services s ON a.service_id = s.service_id" + whereClause;
                                                PreparedStatement pstmt = conn.prepareStatement(sql);

                                                if (!whereClause.isEmpty()) {
                                                    for (int i = 1; i <= 6; i++) {
                                                        pstmt.setString(i, search);
                                                    }
                                                }

                                                ResultSet result = pstmt.executeQuery();
                                                int count = 0;
                                                while (result.next()) {
                                                    count++;
                                                    int bookingId = result.getInt("app_id");
                                                    String customerName = result.getString("customer_name");
                                                    String appointmentDate = result.getString("appointment_date");
                                                    String appointmentTime = result.getString("appointment_time");
                                                    String serviceName = result.getString("service_name");
                                                    String stylistName = result.getString("stylist_name");
                                                    String status = result.getString("status");
                                        %>
                                        <tr>
                                            <td><%= count %></td>
                                            <td><%= customerName %></td>
                                            <td><%= appointmentDate %></td>
                                            <td><%= appointmentTime %></td>
                                            <td><%= serviceName %></td>
                                            <td><%= stylistName %></td>
                                            <td><span class="badge badge-<%= status.equals("Confirmed") ? "success" : "warning" %>"><%= status %></span></td>
                                            <td>
                                                <a href="update_booking.jsp?action=confirm&booking_id=<%= bookingId %>" class="btn btn-sm btn-success">Confirm</a>
                                                <a href="update_booking.jsp?action=cancel&booking_id=<%= bookingId %>" class="btn btn-sm btn-danger">Cancel</a>
                                                <a href="message.jsp?booking_id=<%= bookingId %>" class="btn btn-sm btn-primary"><i class="fa fa-envelope"></i> Message</a>
                                            </td>
                                        </tr>
                                        <% 
                                                }
                                                result.close();
                                                pstmt.close();
                                            } catch (SQLException e) {
                                                e.printStackTrace();
                                            }
                                        %>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <!-- End Manage Bookings Section -->

        </div>
    </div>
    <script>
    document.getElementById('downloadPdfBtn').addEventListener('click', function() {
        const { jsPDF } = window.jspdf;
        const pdf = new jsPDF();

        // Add title
        pdf.setFontSize(18);
        pdf.text("Bookings List", 14, 20);

        // Fetch table data
        const table = document.querySelector('table');
        const rows = Array.from(table.querySelectorAll('tr'));

        // Column headers (excluding the last column for actions)
        const headers = Array.from(rows[0].querySelectorAll('th')).map(th => th.textContent);

        // Add column headers to PDF
        pdf.setFontSize(12);
        pdf.setTextColor(0);
        let y = 30;
        let x = 10;
        headers.forEach(header => {
            pdf.text(header, x, y);
            x += 50; // Adjust column width as needed
        });
        y += 10;

        // Table rows (excluding the last column for actions)
        rows.slice(1).forEach(row => {
            x = 10;
            Array.from(row.querySelectorAll('td')).forEach(cell => { // Include all cells
                pdf.text(cell.textContent, x, y);
                x += 50; // Adjust column width as needed
            });
            y += 10;
        });

        // Save the PDF
        pdf.save("bookings_list.pdf");
    });
</script>


    <!-- Bootstrap and jQuery -->
    <script src="../bootstrap1/boot/js/jquery.min.js"></script>
    <script src="../bootstrap1/boot/js/bootstrap.min.js"></script>

</body>
</html>
