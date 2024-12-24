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
    <title>Delete Staff - Hair Saloon</title>
    <link rel="stylesheet" href="../bootstrap1/boot/css/bootstrap.min.css">
    <link rel="stylesheet" href="../fontawesome/css/all.min.css">
    <style>
        /* Custom CSS for form styling */
        .container {
            max-width: 500px;
            margin-top: 50px;
        }
        .btn {
            font-size: 0.9rem;
            padding: 8px 16px;
        }
    </style>
</head>
<body>
<h2>Delete Booking</h2>
<div class="container">


<%
int app_id=Integer.parseInt(request.getParameter("app_id"));
PreparedStatement pstmt=null;
try
{
String delete="DELETE from appointments where app_id=?";
stmt=conn.prepareStatement(delete);
pstmt.setInt(1,app_id);
int rows=pstmt.executeUpdate();
if(rows>0)
{
%>
<div class="alert alert-success" role="alert">
     		Appointment deleted successfully.
        </div>
<%}else{ %>
  <div class="alert alert-danger" role="alert">
            Failed to delete Appointment. Please try again.
        </div>
<%	
}
} catch (SQLException e) {
    out.println("<p>Error deleting Appointment: " + e.getMessage() + "</p>");
} finally {
    if (pstmt != null) {
        try { pstmt.close(); } catch (SQLException e) { e.printStackTrace(); }
    }
}
%>

 <br>
            <a href="manage-booking.jsp" class="btn btn-primary mt-3">Back to Booking Management</a>
</div>
</body>
</html>