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
    <title>Update Staff - Hair Saloon</title>
    <link rel="stylesheet" href="../bootstrap1/boot/css/bootstrap.min.css">
    <link rel="stylesheet" href="../fontawesome/css/all.min.css">
    <style>
        .form-container {
            max-width: 600px;
            margin: auto;
            padding: 20px;
            background-color: #f8f9fa;
            border-radius: 10px;
            box-shadow: 0 0 10px rgba(0,0,0,0.1);
        }
        .btn-primary {
            width: 100%;
        }
    </style>
</head>
<body>
    <div class="container my-5">
        <div class="form-container">
            <h2 class="text-center mb-4">Update Staff Details</h2>
            <%
                int s_id = Integer.parseInt(request.getParameter("s_id"));
                String staff_name = "";
                String position = "";
                String contact_number = "";
                try {
                    String query = "SELECT * FROM staff WHERE s_id = ?";
                    PreparedStatement pstmt = conn.prepareStatement(query);
                    pstmt.setInt(1, s_id);
                    ResultSet resultSet = pstmt.executeQuery();
                    if (resultSet.next()) {
                        staff_name = resultSet.getString("staff_name");
                        position = resultSet.getString("position");
                        contact_number = resultSet.getString("contact_number");
                    }
                    pstmt.close();
                } catch (SQLException e) {
                    out.println("Database error: " + e.getMessage());
                }
            %>
            <form action="save_update_staff.jsp" method="post">
                <input type="hidden" name="s_id" value="<%= s_id %>">
                <div class="form-group">
                    <label for="staffName">Staff Name</label>
                    <input type="text" class="form-control" id="staff_name" name="staff_name" value="<%= staff_name %>" required>
                </div>
                <div class="form-group">
                    <label for="position">Position</label>
                    <input type="text" class="form-control" id="position" name="position" value="<%= position %>" required>
                </div>
                <div class="form-group">
                    <label for="contact">Contact Number</label>
                    <input type="text" class="form-control" id="contact" name="contact_number" value="<%= contact_number %>" required>
                </div>
                <button type="submit" class="btn btn-primary">Update Staff</button>
            </form>
        </div>
    </div>

    <!-- Bootstrap and jQuery -->
    <script src="../bootstrap1/boot/js/jquery.min.js"></script>
    <script src="../bootstrap1/boot/js/bootstrap.min.js"></script>
</body>
</html>
