<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="javax.servlet.http.*" %>
<%@ page import="javax.servlet.*" %>
<%@ page import="java.io.*" %>
<%@ page session="true" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login as Client</title>
    <link rel="stylesheet" href="../bootstrap1/boot/css/bootstrap.min.css">
    <link rel="stylesheet" href="../fontawesome/css/all.min.css">
    <style>
        body {
            background-color: #f8f9fa;
        }
        .card {
            border-radius: 10px; /* Smaller border radius */
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
            max-width: 400px; /* Set max width for the card */
            margin: auto; /* Center the card */
        }
        .form-control {
            border-radius: 20px; /* Adjusted radius */
            height: 32px; /* Smaller height for inputs */
            font-size: 14px; /* Smaller font size */
        }
        .btn {
            border-radius: 20px; /* Adjusted radius */
            height: 32px; /* Match button height with inputs */
            font-size: 14px; /* Smaller font size */
        }
        .icon-input {
            position: relative;
        }
        .icon-input i {
            position: absolute;
            left: 10px;
            top: 50%;
            transform: translateY(-50%);
            color: #999;
        }
        .icon-input input {
            padding-left: 40px; /* Adjust padding for icon */
        }
    </style>
</head>
<body>

    <nav class="navbar navbar-expand-lg navbar-light bg-light">
        <a class="navbar-brand" href="../index.jsp"><i class="fas fa-cut"></i> Hair Saloon</a>
        <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
        </button>
    </nav>

    <div class="container my-5">
        <h2 class="text-center mb-4">Login as Client</h2>
        <div class="card p-4">
            <form action='log-process.jsp' method='POST'>
                <div class="form-group icon-input">
                    <i class="fas fa-user"></i>
                    <label for="names" class="sr-only">Names</label>
                    <input type="text" class="form-control" placeholder="Enter your Names" name="customer_name" required>
                </div>
                <div class="form-group icon-input">
                    <i class="fas fa-lock"></i>
                    <label for="clientPassword" class="sr-only">Password</label>
                    <input type="password" class="form-control" placeholder="Enter your password" name="password" required>
                </div>
                <button type="submit" class="btn btn-primary btn-block">Login</button>
                <a href="../login.jsp" class="btn btn-secondary btn-block mt-2">Back</a> <!-- Back button -->
            </form>
            <div class="text-center mt-3">
                <small>If you don't have an account, <a href="/client/register_client.jsp">go to register</a>.</small> <!-- Updated registration link -->
            </div>
        </div>
    </div>

    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.10.2/dist/umd/popper.min.js"></script>
    <script src="../bootstrap1/boot/js/bootstrap.min.js"></script>
</body>
</html>
