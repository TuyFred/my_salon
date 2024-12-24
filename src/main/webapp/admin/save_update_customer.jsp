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
<%
    int c_id = Integer.parseInt(request.getParameter("c_id"));
    String customer_name = request.getParameter("customer_name");
    String email = request.getParameter("email");
    String phone_number = request.getParameter("phone_number");

    PreparedStatement pstmt = null;
    try {
        String query = "UPDATE customers SET customer_name = ?, email = ?, phone_number = ? WHERE c_id = ?";
        pstmt = conn.prepareStatement(query);
        pstmt.setString(1, customer_name);
        pstmt.setString(2, email);
        pstmt.setString(3, phone_number);
        pstmt.setInt(4, c_id);

        int rowCount = pstmt.executeUpdate();
        if (rowCount > 0) {
            out.println("<p>Customer details updated successfully.</p>");
        } else {
            out.println("<p>Error updating customer details.</p>");
        }
    } catch (SQLException e) {
        out.println("<p>Error: " + e.getMessage() + "</p>");
    } finally {
        if (pstmt != null) {
            try { pstmt.close(); } catch (SQLException e) { e.printStackTrace(); }
        }
    }
%>
<a href="manage-customers.jsp">Back to Manage Customers</a>
