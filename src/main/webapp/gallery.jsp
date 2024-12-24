<%@ include file="conn.jsp" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Gallery - Hair Saloon</title>
    <link rel="stylesheet" href="bootstrap1/boot/css/bootstrap.min.css">
    <link rel="stylesheet" href="fontawesome/css/all.min.css">
    <style>
        /* Custom CSS for styling */
        .gallery-item {
            margin-bottom: 30px;
        }
        .gallery-item img {
            width: 100%;
            height: 300px; /* Set a fixed height for uniformity */
            object-fit: cover; /* Ensure images cover the entire space */
            border-radius: 5px;
            cursor: pointer;
        }
        .carousel-inner {
            max-height: 500px; /* Limit the maximum height of the carousel */
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
        <h2 class="text-center mb-4">Professional Gallery</h2>
        <div id="carouselGallery" class="carousel slide" data-ride="carousel">
            <div class="carousel-inner">
                <div class="carousel-item active">
                    <img class="d-block w-100" src="images/1.jpg" alt="Image 1">
                </div>
                <div class="carousel-item">
                    <img class="d-block w-100" src="images/2.jpg" alt="Image 2">
                </div>
                <div class="carousel-item">
                    <img class="d-block w-100" src="images/3.jpg" alt="Image 3">
                </div>
            </div>
            <a class="carousel-control-prev" href="#carouselGallery" role="button" data-slide="prev">
                <span class="carousel-control-prev-icon" aria-hidden="true"></span>
                <span class="sr-only">Previous</span>
            </a>
            <a class="carousel-control-next" href="#carouselGallery" role="button" data-slide="next">
                <span class="carousel-control-next-icon" aria-hidden="true"></span>
                <span class="sr-only">Next</span>
            </a>
        </div>
    </div>

    <!-- Additional Gallery Features (static images) -->
    <div class="container my-5">
        <h2 class="text-center mb-4">More Gallery Images</h2>
        <div class="row">
            <div class="col-md-4 gallery-item">
                <img src="images/4.jpg" alt="Image 4">
            </div>
            <div class="col-md-4 gallery-item">
                <img src="images/5.jpg" alt="Image 5">
            </div>
            <div class="col-md-4 gallery-item">
                <img src="images/6.jpg" alt="Image 6">
            </div>
        </div>
    </div>

    <!-- Scripts -->
    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.5.4/dist/umd/popper.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
    <script>
        $(document).ready(function() {
            $('.carousel').carousel({
                interval: 2000 // Adjust the time interval for auto sliding in milliseconds
            });
        });
    </script>
</body>
</html>
