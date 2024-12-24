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
    <title>Update Customer - Hair Saloon</title>
    <link rel="stylesheet" href="../bootstrap1/boot/css/bootstrap.min.css">
    <link rel="stylesheet" href="../fontawesome/css/all.min.css">
</head>
<body>
    <div class="container">
        <h2 class="my-4">Update Customer</h2>
        <%
            int c_id = Integer.parseInt(request.getParameter("c_id"));
            PreparedStatement pstmt = null;
            ResultSet resultSet = null;
            String customer_name = "", email = "", phone_number = "";
            try {
                String query = "SELECT * FROM customers WHERE c_id = ?";
                pstmt = conn.prepareStatement(query);
                pstmt.setInt(1, c_id);
                resultSet = pstmt.executeQuery();
                if (resultSet.next()) {
                    customer_name = resultSet.getString("customer_name");
                    email = resultSet.getString("email");
                    phone_number = resultSet.getString("phone_number");
                }
            } catch (SQLException e) {
                out.println("<p>Error fetching customer details: " + e.getMessage() + "</p>");
            } finally {
                if (resultSet != null) {
                    try { resultSet.close(); } catch (SQLException e) { e.printStackTrace(); }
                }
                if (pstmt != null) {
                    try { pstmt.close(); } catch (SQLException e) { e.printStackTrace(); }
                }
            }
        %>
        <form action="save_update_customer.jsp" method="post">
            <input type="hidden" name="c_id" value="<%= c_id %>">
            <div class="form-group">
                <label for="customer_name">Customer Name</label>
                <input type="text" class="form-control" id="customer_name" name="customer_name" value="<%= customer_name %>" required>
            </div>
            <div class="form-group">
                <label for="email">Email</label>
                <input type="email" class="form-control" id="email" name="email" value="<%= email %>" required>
            </div>
            <div class="form-group">
                <label for="phone_number">Phone Number</label>
                <input type="text" class="form-control" id="phone_number" name="phone_number" value="<%= phone_number %>" required>
            </div>
            <button type="submit" class="btn btn-primary">Save Changes</button>
        </form>
    </div>
</body>
</html>
