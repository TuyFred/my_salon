<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../conn.jsp" %>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Confirm Booking - Hair Saloon</title>
    <link rel="stylesheet" href="bootstrap1/boot/css/bootstrap.min.css">
    <link rel="stylesheet" href="fontawesome/css/all.min.css">
</head>
<body>
    <div class="container my-5">
        <h2 class="text-center mb-4">Confirm Booking</h2>
        <%
            // Check if the session exists and if the customer_name attribute is set
            if (session.getAttribute("customer_name") == null) {
                response.sendRedirect("client/login_client.jsp"); // Redirect to login page if not logged in
                return;
            }

            // Retrieve session attribute
            String customerName = (String) session.getAttribute("customer_name");

            // Retrieve form parameters
            String serviceId = request.getParameter("service_id");
            String appointmentDate = request.getParameter("appointment_date");
            String appointmentTime = request.getParameter("appointment_time");
            String stylistName = request.getParameter("stylist_name");

            // Initialize IDs
            int customerId = -1;
            int stylistId = -1;

            // Get customer ID from customer name
            try {
                String customerQuery = "SELECT c_id FROM customers WHERE customer_name = ?";
                PreparedStatement pstmt = conn.prepareStatement(customerQuery);
                pstmt.setString(1, customerName);
                ResultSet resultSet = pstmt.executeQuery();
                if (resultSet.next()) {
                    customerId = resultSet.getInt("c_id");
                }
                pstmt.close();
            } catch (SQLException e) {
                out.println("<p>Error fetching customer ID: " + e.getMessage() + "</p>");
            }

            // Get stylist ID from stylist name
            try {
                String stylistQuery = "SELECT s_id FROM staff WHERE staff_name = ? AND position = 'stylist'";
                PreparedStatement pstmt = conn.prepareStatement(stylistQuery);
                pstmt.setString(1, stylistName);
                ResultSet resultSet = pstmt.executeQuery();
                if (resultSet.next()) {
                    stylistId = resultSet.getInt("s_id");
                }
                pstmt.close();
            } catch (SQLException e) {
                out.println("<p>Error fetching stylist ID: " + e.getMessage() + "</p>");
            }

            // Insert booking into appointments table if IDs are found
            if (customerId != -1 && stylistId != -1) {
                try {
                    String query = "INSERT INTO appointments (c_id, service_id, appointment_date, appointment_time, stylist_name, status,message) VALUES (?, ?, ?, ?, ?, 'Pending','none')";
                    PreparedStatement pstmt = conn.prepareStatement(query);
                    pstmt.setInt(1, customerId);
                    pstmt.setString(2, serviceId);
                    pstmt.setString(3, appointmentDate);
                    pstmt.setString(4, appointmentTime);
                    pstmt.setInt(5, stylistId);

                    int result = pstmt.executeUpdate();
                    if (result > 0) {
                        out.println("<p>Booking successful!</p>");
                        response.sendRedirect("client/client_dashboard.jsp");
                    } else {
                        out.println("<p>Booking failed. Please try again.</p>");
                    }
                    pstmt.close();
                } catch (SQLException e) {
                    out.println("<p>Error processing booking: " + e.getMessage() + "</p>");
                }
            } else {
                out.println("<p>Error: Customer ID or Stylist ID not found.</p>");
            }
        %>
    </div>

    <!-- Bootstrap and jQuery -->
    <script src="bootstrap1/boot/js/jquery.min.js"></script>
    <script src="bootstrap1/boot/js/bootstrap.min.js"></script>
</body>
</html>
