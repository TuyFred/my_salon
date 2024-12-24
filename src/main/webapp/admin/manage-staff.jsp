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
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Manage Staff - Hair Saloon</title>
    <link rel="stylesheet" href="../bootstrap1/boot/css/bootstrap.min.css">
    <link rel="stylesheet" href="../fontawesome/css/all.min.css">
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jspdf/2.5.1/jspdf.umd.min.js"></script>
    
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
        .table {
            margin-top: 20px;
        }
        .table th, .table td {
            vertical-align: middle;
            text-align: center;
        }
        .btn {
            font-size: 0.9rem;
            padding: 8px 16px;
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
                <a class="nav-link" href="manage-bookings.jsp"><i class="fas fa-calendar-alt"></i> Manage Bookings</a>
            </li>
            <li class="nav-item">
                <a class="nav-link" href="manage-services.jsp"><i class="fas fa-concierge-bell"></i> Manage Services</a>
            </li>
            <li class="nav-item">
                <a class="nav-link" href="#"><i class="fas fa-users"></i> Manage Staff</a>
            </li>
            <li class="nav-item">
                <a class="nav-link" href="manage-customers.jsp"><i class="fas fa-user"></i> Manage Customers</a>
            </li>
            <li class="nav-item">
                 <a class="nav-link" href="reports.jsp"><i class="fas fa-file-alt"></i> Report</a>
            </li>
            <li class="nav-item">
                <a class="nav-link" href="manage-messages.jsp"><i class="fas fa-envelope"></i> Manage Messages</a>
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

            <!-- Page Heading -->
            <div class="d-sm-flex align-items-center justify-content-between mb-4">
                <h1 class="h3 mb-0 text-gray-800">Manage Staff</h1>
                <a href="add_staff.jsp" class="d-none d-sm-inline-block btn btn-sm btn-primary shadow-sm"><i class="fas fa-plus"></i> Add Staff Member</a>
                <a href="#" id="downloadPdfBtn" class="d-none d-sm-inline-block btn btn-sm btn-primary shadow-sm">
    <i class="fas fa-download fa-sm text-white-50"></i> Generate Report
</a>
                
            </div>

            <!-- Search Form -->
            <div class="card mb-4">
                <div class="card-header">
                    <h3 class="card-title">Search Staff</h3>
                </div>
                <div class="card-body">
                    <form method="get" action="manage_staff.jsp">
                        <div class="form-group">
                            <input type="text" class="form-control" name="search" placeholder="Search by name..." value="<%= request.getParameter("search") %>">
                        </div>
                        <button type="submit" class="btn btn-primary">Search</button>
                    </form>
                </div>
            </div>

            <!-- Staff Table -->
            <div class="card">
                <div class="card-header">
                    <h3 class="card-title">Staff List</h3>
                </div>
                <div class="card-body">
                    <div class="table-responsive">
                        <table class="table table-bordered table-hover">
                            <thead>
                                <tr>
                                    <th>ID</th>
                                    <th>Name</th>
                                    <th>Position</th>
                                    <th>Contact</th>
                                    <th>Action</th>
                                </tr>
                            </thead>
                            <tbody>
                                <%
                                    PreparedStatement pstmt = null;
                                    ResultSet resultSet = null;
                                    try {
                                        String search = request.getParameter("search");
                                        String query = "SELECT * FROM staff";
                                        if (search != null && !search.trim().isEmpty()) {
                                            query += " WHERE staff_name LIKE ?";
                                        }
                                        pstmt = conn.prepareStatement(query);
                                        if (search != null && !search.trim().isEmpty()) {
                                            pstmt.setString(1, "%" + search.trim() + "%");
                                        }
                                        resultSet = pstmt.executeQuery();
                                        
                                        while (resultSet.next()) {
                                            int s_id = resultSet.getInt("s_id");
                                            String staff_name = resultSet.getString("staff_name");
                                            String position = resultSet.getString("position");
                                            String contact_number = resultSet.getString("contact_number");
                                %>
                                <tr>
                                    <td><%= s_id %></td>
                                    <td><%= staff_name %></td>
                                    <td><%= position %></td>
                                    <td><%= contact_number %></td>
                                    <td>
                                        <button class="btn btn-info btn-sm" onclick="location.href='update_staff.jsp?s_id=<%= s_id %>'"><i class="fas fa-edit"></i> Edit</button>
                                        <button class="btn btn-danger btn-sm" onclick="location.href='delete_staff.jsp?s_id=<%= s_id %>'"><i class="fas fa-trash-alt"></i> Delete</button>
                                    </td>
                                </tr>
                                <%
                                        }
                                    } catch (SQLException e) {
                                        out.println("<p>Error fetching staff: " + e.getMessage() + "</p>");
                                    } finally {
                                        if (resultSet != null) {
                                            try { resultSet.close(); } catch (SQLException e) { e.printStackTrace(); }
                                        }
                                        if (pstmt != null) {
                                            try { pstmt.close(); } catch (SQLException e) { e.printStackTrace(); }
                                        }
                                    }
                                %>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>

        </div>
    </div>

    <!-- JavaScript to Export Table to pdf -->
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
        const headers = Array.from(rows[0].querySelectorAll('th')).slice(0, -1).map(th => th.textContent);

        // Add column headers to PDF
        pdf.setFontSize(12);
        pdf.setTextColor(0);
        let y = 30;
        let x = 10;
        headers.forEach(header => {
            pdf.text(header, x, y);
            x += 40; // Adjust column width as needed
        });
        y += 10;

        // Table rows (excluding the last column for actions)
        rows.slice(1).forEach(row => {
            x = 10;
            Array.from(row.querySelectorAll('td')).slice(0, -1).forEach(cell => { // Exclude the last cell (action column)
                pdf.text(cell.textContent, x, y);
                x += 40; // Adjust column width as needed
            });
            y += 10;
        });

        // Save the PDF
        pdf.save("staff_list.pdf");
    });
</script>


    <!-- Bootstrap and jQuery -->
    <script src="../bootstrap1/boot/js/jquery.min.js"></script>
    <script src="../bootstrap1/boot/js/bootstrap.min.js"></script>

</body>
</html>
