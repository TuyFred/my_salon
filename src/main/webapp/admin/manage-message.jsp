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

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="javax.servlet.http.*" %>
<%@ page import="javax.servlet.*" %>
<%@ page session="true" %>
<%@ include file="../conn.jsp" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Manage Messages - Hair Saloon</title>
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
        .table th, .table td {
            vertical-align: middle;
        }
        .table td {
            word-wrap: break-word;
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
            <h1 class="my-4">Manage Messages</h1>
                     <a href="#" id="downloadPdfBtn" class="d-none d-sm-inline-block btn btn-sm btn-primary shadow-sm">
    <i class="fas fa-download fa-sm text-white-50"></i> Generate Report
</a>
            <!-- Search Form -->
            <div class="card mb-4">
                <div class="card-header">
                    <h3 class="card-title">Search Messages</h3>
                </div>
       
                <div class="card-body">
                    <form method="get" action="manage_messages.jsp">
                        <div class="form-group">
                            <input type="text" class="form-control" name="search" placeholder="Search by name or email..." value="<%= request.getParameter("search") %>">
                        </div>
                        <button type="submit" class="btn btn-primary">Search</button>
                    </form>
                </div>
            </div>
            
            <div class="table-responsive">
                <table class="table table-bordered table-striped">
                    <thead>
                        <tr>
                            <th>Name</th>
                            <th>Email</th>
                            <th>Message</th>
                            <th>Action</th>
                        </tr>
                    </thead>
                    <tbody>
                        <% 
                            String search = request.getParameter("search");
                            String query = "SELECT names, email, message FROM feedback";
                            if (search != null && !search.trim().isEmpty()) {
                                query += " WHERE names LIKE ? OR email LIKE ?";
                            }
                            
                            try {
                                PreparedStatement pstmt = conn.prepareStatement(query);
                                if (search != null && !search.trim().isEmpty()) {
                                    pstmt.setString(1, "%" + search.trim() + "%");
                                    pstmt.setString(2, "%" + search.trim() + "%");
                                }
                                ResultSet result = pstmt.executeQuery();
                                
                                while (result.next()) {
                                    String feedbackName = result.getString("names");
                                    String feedbackEmail = result.getString("email");
                                    String feedbackMessage = result.getString("message");
                        %>
                        <tr>
                            <td><%= feedbackName %></td>
                            <td><%= feedbackEmail %></td>
                            <td><%= feedbackMessage %></td>
                              <td>
                                        
                                        <button class="btn btn-danger btn-sm" onclick="location.href='delete_customer.jsp>'"><i class="fas fa-trash-alt"></i> Delete</button>
                                    </td>
                        </tr>
                        <% 
                                }
                                result.close();
                                pstmt.close();
                            } catch (SQLException e) {
                                out.println("Error retrieving messages: " + e.getMessage());
                                e.printStackTrace();
                            }
                        %>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
    <script>
  document.getElementById('downloadPdfBtn').addEventListener('click', function() {
        const { jsPDF } = window.jspdf;
        const pdf = new jsPDF();

        // Add title
        pdf.setFontSize(18);
        pdf.text("Messages List", 14, 20);

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
            x += 44; // Adjust column width as needed
        });
        y += 10;

        // Table rows (excluding the last column for actions)
        rows.slice(1).forEach(row => {
            x = 10;
            Array.from(row.querySelectorAll('td')).slice(0, -1).forEach(cell => { // Exclude the last cell (action column)
                pdf.text(cell.textContent, x, y);
                x += 44; // Adjust column width as needed
            });
            y += 10;
        });

        // Save the PDF
        pdf.save("message_list.pdf");
    });
</script>
</body>
</html>
