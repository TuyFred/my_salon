<%
    // Check if the session exists and if the customer_name attribute is set
    if (session.getAttribute("customer_name") == null) {
%>
    <script type="text/javascript">
        alert("Login to access this page");
        window.location.href = "client/login_client.jsp"; // Redirect to the login page
    </script>
<%
        // Prevent further processing of the page
        return;
    }
%>

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="conn.jsp" %>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Book Appointment - Hair Saloon</title>
    <link rel="stylesheet" href="bootstrap1/boot/css/bootstrap.min.css">
    <link rel="stylesheet" href="fontawesome/css/all.min.css">
    <style>
        /* Custom CSS for styling */
        .booking-form {
            max-width: 600px;
            margin: auto;
            padding: 20px;
            background-color: #f8f9fa;
            border-radius: 10px;
            box-shadow: 0 0 10px rgba(0,0,0,0.1);
        }
        .form-group {
            margin-bottom: 20px;
        }
        .form-control {
            height: 50px;
        }
        .btn-primary {
            height: 50px;
            width: 100%;
        }
    </style>
</head>
<body>

    <nav class="navbar navbar-expand-lg navbar-light bg-light">
        <a class="navbar-brand" href="index.jsp"><i class="fas fa-cut"></i> Hair Saloon</a>
        <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
        </button>
    </nav>

    <div class="container my-5">
        <div class="booking-form">
            <h2 class="text-center mb-4">Book Appointment</h2>
            <form action="confirmBooking.jsp" method="post">
                <div class="form-group">
                    <label for="serviceSelect">Select Service</label>
                    <select class="form-control" id="serviceSelect" name="service_id" required>
                        <option value="">Choose...</option>
                        <% 
                            try {
                                String query = "SELECT service_id, service_name FROM services";
                                PreparedStatement pstmt = conn.prepareStatement(query);
                                ResultSet resultSet = pstmt.executeQuery();
                                while (resultSet.next()) {
                                    int serviceId = resultSet.getInt("service_id");
                                    String serviceName = resultSet.getString("service_name");
                        %>
                        <option value="<%= serviceId %>"><%= serviceName %></option>
                        <% 
                                }
                                pstmt.close();
                            } catch (SQLException e) {
                                out.println("<p>Error fetching services: " + e.getMessage() + "</p>");
                            }
                        %>
                    </select>
                </div>
                <div class="form-group">
                    <label for="dateInput">Select Date</label>
                    <input type="date" class="form-control" id="dateInput" name="appointment_date" required>
                </div>
                <div class="form-group">
                    <label for="timeInput">Select Time</label>
                    <input type="time" class="form-control" id="timeInput" name="appointment_time" required>
                </div>
                  <div class="form-group">
                    <label for="message">Message</label>
                    <input type="hidden" class="form-control" id="message" name="message" required>
                </div>
                <div class="form-group">
                    <label for="stylistSelect">Select Stylist</label>
                    <select class="form-control" id="stylistSelect" name="stylist_name" required>
                        <option value="">Choose...</option>
                        <% 
                            try {
                                String query = "SELECT s_id, staff_name FROM staff WHERE position='stylist'";
                                PreparedStatement pstmt = conn.prepareStatement(query);
                                ResultSet resultSet = pstmt.executeQuery();
                                while (resultSet.next()) {
                                    int stylistId = resultSet.getInt("s_id");
                                    String stylistName = resultSet.getString("staff_name");
                        %>
                        <option value="<%= stylistName %>"><%= stylistName %></option>
                        <% 
                                }
                                pstmt.close();
                            } catch (SQLException e) {
                                out.println("<p>Error fetching stylists: " + e.getMessage() + "</p>");
                            }
                        %>
                    </select>
                </div>

                <!-- Hidden field to pass customer name -->
                <input type="hidden" name="customer_name" value="<%= session.getAttribute("customer_name") %>">

                <button type="submit" class="btn btn-primary">Book Appointment</button>
            </form>
        </div>
    </div>

    <!-- Bootstrap and jQuery -->
    <script src="bootstrap1/boot/js/jquery.min.js"></script>
    <script src="bootstrap1/boot/js/bootstrap.min.js"></script>

</body>
</html>
