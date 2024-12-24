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
    <title>Update Booking - Hair Saloon</title>
    <link rel="stylesheet" href="../bootstrap1/boot/css/bootstrap.min.css">
    <link rel="stylesheet" href="../fontawesome/css/all.min.css">
</head>
<body>

    <%
        String action = request.getParameter("action");
        int bookingId = Integer.parseInt(request.getParameter("booking_id"));
        String status = null;

        try {
            String sql = null;
            PreparedStatement pstmt = null;

            if ("confirm".equals(action)) {
                // Confirm booking
                sql = "UPDATE appointments SET status = 'Confirmed' WHERE app_id = ?";
                pstmt = conn.prepareStatement(sql);
                pstmt.setInt(1, bookingId);
            } else if ("cancel".equals(action)) {
                // Cancel booking
                sql = "UPDATE appointments SET status = 'Cancelled' WHERE app_id = ?";
                pstmt = conn.prepareStatement(sql);
                pstmt.setInt(1, bookingId);
            } else if ("edit".equals(action)) {
                // Edit booking details
                String customerName = request.getParameter("customer_name");
                String date = request.getParameter("date");
                String time = request.getParameter("time");
                String service = request.getParameter("service");
                String stylist = request.getParameter("stylist");
                
                sql = "UPDATE appointments SET customer_name = ?, appointment_date = ?, appointment_time = ?, service_name = ?, stylist_name = ? WHERE app_id = ?";
                pstmt = conn.prepareStatement(sql);
                pstmt.setString(1, customerName);
                pstmt.setString(2, date);
                pstmt.setString(3, time);
                pstmt.setString(4, service);
                pstmt.setString(5, stylist);
                pstmt.setInt(6, bookingId);
            }

            if (pstmt != null) {
                int rowsAffected = pstmt.executeUpdate();
                if (rowsAffected > 0) {
                    status = "success";
                } else {
                    status = "error";
                }
                pstmt.close();
            }
        } catch (SQLException e) {
            e.printStackTrace();
            status = "error";
        }

        // Redirect back to the manage bookings page with status
        response.sendRedirect("manage-bookings.jsp?status=" + status);
    %>

    <!-- Bootstrap and jQuery -->
    <script src="../bootstrap1/boot/js/jquery.min.js"></script>
    <script src="../bootstrap1/boot/js/bootstrap.min.js"></script>

</body>
</html>
