<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <%@ include file="conn.jsp" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login Selection</title>
    <link rel="stylesheet" href="bootstrap1/boot/css/bootstrap.min.css">
    <link rel="stylesheet" href="fontawesome/css/all.min.css">
</head>
<body>

    <nav class="navbar navbar-expand-lg navbar-light bg-light">
        <a class="navbar-brand" href="index.jsp"><i class="fas fa-cut"></i> Hair Saloon</a>
        <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
        </button>
    </nav>


    <div class="container my-5">
        <h2 class="text-center mb-4">Login Selection</h2>
        <div class="row">
            <div class="col-md-6">
                <div class="card text-center">
                    <div class="card-body">
                        <h5 class="card-title">Login as Admin</h5>
                        <p class="card-text">Access administrative functions.</p>
                        <a href="admin/login_admin.jsp" class="btn btn-primary">Login as Admin</a>
                    </div>
                </div>
            </div>
            <div class="col-md-6">
                <div class="card text-center">
                    <div class="card-body">
                        <h5 class="card-title">Login as Client</h5>
                        <p class="card-text">Access client account and services.</p>
                        <a href="client/login_client.jsp" class="btn btn-primary">Login as Client</a>
                    </div>
                </div>
            </div>
        </div>
    </div>
</body>
</html>

