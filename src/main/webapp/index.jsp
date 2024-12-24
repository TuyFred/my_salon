<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="conn.jsp" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Hair Saloon Management System</title>
    <link rel="stylesheet" href="bootstrap1/boot/css/bootstrap.min.css">
    <link rel="stylesheet" href="fontawesome/css/all.min.css">
    <link rel="stylesheet" href="style.css">
</head>
<body>

<%
    String customerName = (String) session.getAttribute("customer_name");
%>

<nav class="navbar navbar-expand-lg navbar-light bg-light">
    <a class="navbar-brand" href="#"><i class="fas fa-cut"></i> Hair Saloon</a>
    <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
        <span class="navbar-toggler-icon"></span>
    </button>
    <div class="collapse navbar-collapse" id="navbarNav">
        <ul class="navbar-nav ml-auto">
            <li class="nav-item active">
                <a class="nav-link" href="#"><i class="fas fa-home"></i> Home <span class="sr-only">(current)</span></a>
            </li>
            <li class="nav-item">
                <a class="nav-link" href="#services"><i class="fas fa-concierge-bell"></i> Services</a>
            </li>
            <li class="nav-item">
                <% if (customerName != null) { %>
                    <a class="nav-link" href="booking.jsp"><i class="fas fa-calendar-alt"></i> Booking</a>
                <% } else { %>
                    <a class="nav-link" href="login.jsp"><i class="fas fa-calendar-alt"></i> Booking</a>
                <% } %>
            </li>
            <li class="nav-item">
                <a class="nav-link" href="gallery.jsp"><i class="fas fa-images"></i> Gallery</a>
            </li>
            <li class="nav-item">
                <a class="nav-link" href="#about"><i class="fas fa-info-circle"></i> About Us</a>
            </li>
            <% if (customerName != null) { %>
                <li class="nav-item">
                    <a class="nav-link" href="client/client_dashboard.jsp"><i class="fas fa-tachometer-alt"></i> Dashboard</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="client/logout.jsp"><i class="fas fa-sign-out-alt"></i> Logout</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="notifications.jsp">
                        <i class="fas fa-bell"></i> 
                        <span class="badge badge-danger" id="notificationCount">0</span>
                    </a>
                </li>
            <% } else { %>
                <li class="nav-item">
                    <a class="nav-link" href="login.jsp"><i class="fas fa-sign-in-alt"></i> Login</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="client/register_client.jsp"><i class="fas fa-user-plus"></i> Register</a>
                </li>
            <% } %>
        </ul>
    </div>
</nav>

<header class="jumbotron text-center">
    <h1 class="display-4">Welcome to Our Hair Saloon</h1>
    <p class="lead">Experience the best hair care services in town.</p>
    <a href="#services" class="btn btn-primary btn-lg">Explore Services</a>
</header>

<section id="services" class="container text-center my-5">
    <h2 class="mb-4">Our Services</h2>
    <div class="row">
        <div class="col-md-4">
            <i class="fas fa-cut fa-3x mb-3"></i>
            <h4>Haircut</h4>
            <p>Get a stylish haircut from our professional stylists.</p>
        </div>
        <div class="col-md-4">
            <i class="fas fa-tint fa-3x mb-3"></i>
            <h4>Hair Coloring</h4>
            <p>Choose from a wide range of hair colors and shades.</p>
        </div>
        <div class="col-md-4">
            <i class="fas fa-spa fa-3x mb-3"></i>
            <h4>Hair Spa</h4>
            <p>Pamper your hair with our relaxing hair spa treatments.</p>
        </div>
        <div class="col-md-4">
            <i class="fas fa-hand-sparkles fa-3x mb-3"></i>
            <h4>Manicure</h4>
            <p>Keep your nails looking their best with our manicure services.</p>
        </div>
        <div class="col-md-4">
            <i class="fa-solid fa-shoe-prints fa-3x mb-3"></i>
            <h4>Pedicure</h4>
            <p>Relax and rejuvenate with our professional pedicure treatments.</p>
        </div>
    </div>
</section>

<section id="testimonials" class="bg-light text-center py-5">
    <div class="container">
        <h2 class="mb-4">What Our Clients Say</h2>
        <div id="testimonialCarousel" class="carousel slide" data-ride="carousel">
            <div class="carousel-inner">
                <div class="carousel-item active">
                    <blockquote class="blockquote">
                        <p class="mb-0">Best hair salon experience ever! Highly recommend their services.</p>
                        <footer class="blockquote-footer">Jane Doe</footer>
                    </blockquote>
                </div>
                <div class="carousel-item">
                    <blockquote class="blockquote">
                        <p class="mb-0">Professional and friendly staff. Loved my new haircut!</p>
                        <footer class="blockquote-footer">John Smith</footer>
                    </blockquote>
                </div>
                <div class="carousel-item">
                    <blockquote class="blockquote">
                        <p class="mb-0">Great ambiance and excellent service. Will visit again!</p>
                        <footer class="blockquote-footer">Emily Johnson</footer>
                    </blockquote>
                </div>
            </div>
            <a class="carousel-control-prev" href="#testimonialCarousel" role="button" data-slide="prev">
                <span class="carousel-control-prev-icon" aria-hidden="true"></span>
                <span class="sr-only">Previous</span>
            </a>
            <a class="carousel-control-next" href="#testimonialCarousel" role="button" data-slide="next">
                <span class="carousel-control-next-icon" aria-hidden="true"></span>
                <span class="sr-only">Next</span>
            </a>
        </div>
    </div>
</section>

<section id="about" class="container text-center my-5">
    <h2 class="mb-4">About Us</h2>
    <p>Welcome to our Hair Saloon, where style meets comfort. Our professional team of stylists is dedicated to providing you with the best hair care services in town. We offer a wide range of services including haircuts, hair coloring, hair spa treatments, manicures, and pedicures. Our mission is to make you look and feel your best. Visit us to experience a relaxing and rejuvenating salon experience.</p>
</section>

<section id="contact" class="container text-center my-5">
    <h2 class="mb-4">Contact Us</h2>
    <form method="post" action="contact-process.jsp">
        <div class="form-row">
            <div class="form-group col-md-6">
                <input type="text" class="form-control" placeholder="Name" name="name" required>
            </div>
            <div class="form-group col-md-6">
                <input type="email" class="form-control" placeholder="Email" name="email" required>
            </div>
        </div>
        <div class="form-group">
            <textarea class="form-control" rows="5" placeholder="Message" name="message" required></textarea>
        </div>
        <button type="submit" class="btn btn-primary">Send Message</button>
    </form>
</section>

<footer class="bg-dark text-white text-center py-3">
    <p>&copy; 2024 fred. All Rights Reserved.</p>
</footer>

<script src="bootstrap1/boot/js/jquery.min.js"></script>
<script src="bootstrap1/boot/js/bootstrap.min.js"></script>
</body>
</html>
