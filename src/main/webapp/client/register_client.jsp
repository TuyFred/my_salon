<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Register as Client</title>
    <link rel="stylesheet" href="../bootstrap1/boot/css/bootstrap.min.css">
    <link rel="stylesheet" href="../fontawesome/css/all.min.css">
    <style>
        body {
            background-color: #f8f9fa;
        }
        .card {
            border-radius: 10px; /* Rounded corners */
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
            max-width: 400px; /* Set max width for the card */
            margin: auto; /* Center the card */
            padding: 20px; /* Add padding */
        }
        .form-control {
            border-radius: 20px; /* Rounded corners for inputs */
            height: 38px; /* Height for inputs */
            font-size: 14px; /* Font size */
        }
        .btn {
            border-radius: 20px; /* Rounded corners for buttons */
            height: 38px; /* Height for buttons */
            font-size: 14px; /* Font size */
        }
    </style>
</head>
<body>

<nav class="navbar navbar-expand-lg navbar-light bg-light">
    <a class="navbar-brand" href="../index.jsp"><i class="fas fa-cut"></i> Hair Saloon</a>
    <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarNav"
            aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
        <span class="navbar-toggler-icon"></span>
    </button>
</nav>

<div class="container my-5">
    <h2 class="text-center mb-4">Register as Client</h2>
    <div class="card">
        <form action='reg-process.jsp' method='POST'>
            <div class="form-group">
                <label for="clientName">Name</label>
                <input type="text" class="form-control" id="clientName" placeholder="Enter your name" name="name" required>
            </div>
            <div class="form-group">
                <label for="clientEmail">Email</label>
                <input type="email" class="form-control" id="clientEmail" placeholder="Enter your email" name="email" required>
            </div>
            <div class="form-group">
                <label for="clientPhone">Phone Number</label>
                <input type="text" class="form-control" id="clientPhone" placeholder="Enter your phone number" name="number" required>
            </div>
            <div class="form-group">
                <label for="clientAddress">Address</label>
                <input type="text" class="form-control" id="clientAddress" placeholder="Enter your address" name="address" required>
            </div>
            <div class="form-group">
                <label for="clientPassword">Password</label>
                <input type="password" class="form-control" id="clientPassword" placeholder="Enter your password" name="password" required>
            </div>
            <div class="form-group">
                <label for="confirmPassword">Confirm Password</label>
                <input type="password" class="form-control" id="confirmPassword" placeholder="Confirm your password" name="confirmPassword" required>
            </div>
            <button type="submit" class="btn btn-primary btn-block">Register</button>
        </form>
    </div>
</div>

<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.10.2/dist/umd/popper.min.js"></script>
<script src="../bootstrap1/boot/js/bootstrap.min.js"></script>
</body>
</html>
