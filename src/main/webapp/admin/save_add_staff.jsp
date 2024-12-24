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
    <title>Add Staff - Action</title>
    <link rel="stylesheet" href="../bootstrap1/boot/css/bootstrap.min.css">
</head>
<body>
    <div class="container my-5">
        <div class="alert alert-info">
            <%
                String staff_name = request.getParameter("staff_name");
                String position = request.getParameter("position");
                String contact_number = request.getParameter("contact_number");

                try {
                    String query = "INSERT INTO staff (staff_name, position, contact_number) VALUES (?, ?, ?)";
                    PreparedStatement pstmt = conn.prepareStatement(query);
                    pstmt.setString(1, staff_name);
                    pstmt.setString(2, position);
                    pstmt.setString(3, contact_number);
                    int rowCount = pstmt.executeUpdate();
                    if (rowCount > 0) {
                        out.println("Staff member added successfully.");
                    } else {
                        out.println("Error adding staff member.");
                    }
                    pstmt.close();
                } catch (SQLException e) {
                    out.println("Database error: " + e.getMessage());
                }
            %>
            <br>
            <a href="manage-staff.jsp" class="btn btn-primary mt-3">Back to Staff Management</a>
        </div>
    </div>

    <!-- Bootstrap -->
    <script src="../bootstrap1/boot/js/bootstrap.min.js"></script>
</body>
</html>
