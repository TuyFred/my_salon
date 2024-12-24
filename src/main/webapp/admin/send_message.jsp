<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../conn.jsp" %>
<%@ page import="java.sql.*" %>
<%
    String bookingId = request.getParameter("booking_id");
    String message = request.getParameter("message");

    if (bookingId != null && message != null) {
        try {
            // Update the appointments table with the message for the given booking ID
            String sql = "UPDATE appointments SET message = ? WHERE app_id = ?";
            PreparedStatement pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, message);
            pstmt.setInt(2, Integer.parseInt(bookingId));
            int rowsUpdated = pstmt.executeUpdate();
            pstmt.close();
            conn.close();

            if (rowsUpdated > 0) {
                // Redirect to manage-bookings page with success status
                response.sendRedirect("manage-bookings.jsp?booking_id=" + bookingId + "&status=success");
            } else {
                // Print error message if no rows were updated (invalid booking ID)
                out.println("<p>Error: No booking found with ID " + bookingId + ".</p>");
            }
        } catch (SQLException e) {
            // Capture the error details and print them
            String errorMessage = e.getMessage();
            out.println("<p>Error updating booking message: " + errorMessage + "</p>");
        }
    } else {
        // Print an error message if booking ID or message is missing
        out.println("<p>Error: Missing booking ID or message.</p>");
    }
%>
