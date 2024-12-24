<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../conn.jsp" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Send Message - Hair Saloon</title>
    <link rel="stylesheet" href="../bootstrap1/boot/css/bootstrap.min.css">
    <link rel="stylesheet" href="../fontawesome/css/all.min.css">
    <style>
        .main-content {
            margin: 20px;
        }
        .card {
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
        .form-control {
            margin-bottom: 15px;
        }
        .btn-primary {
            margin-top: 10px;
        }
    </style>
</head>
<body>

    <div class="main-content">
        <div class="container">
            <div class="card">
                <div class="card-header">
                    <h3>Send Message for Appointment ID: <%= request.getParameter("booking_id") %></h3>
                </div>
                <div class="card-body">
                    <form action="send_message.jsp" method="post">
                        <input type="hidden" name="booking_id" value="<%= request.getParameter("booking_id") %>">
                        <div class="form-group">
                            <label for="message">Message</label>
                            <textarea class="form-control" name="message" id="message" rows="4" required></textarea>
                        </div>
                        <button type="submit" class="btn btn-primary">Send Message</button>
                    </form>
                </div>
            </div>
        </div>
    </div>

    <!-- Bootstrap and jQuery -->
    <script src="../bootstrap1/boot/js/jquery.min.js"></script>
    <script src="../bootstrap1/boot/js/bootstrap.min.js"></script>
</body>
</html>
