<%@ page import="java.io.InputStream" %>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.SQLException" %>
<%@ page import="javax.servlet.http.Part" %>
<%@ page contentType="text/html" pageEncoding="UTF-8" %>

<%
Connection conn = null;
PreparedStatement pstmt = null;
String dbUrl = "jdbc:mysql://localhost:3306/saloon_db";
String dbUser = "root";
String dbPassword = "";


InputStream inputStream = null; // input stream of the upload file

try {
    // Connects to the database
    Class.forName("com.mysql.cj.jdbc.Driver");
    conn = DriverManager.getConnection(dbUrl, dbUser, dbPassword);

    // Constructs SQL statement
    String sql = "INSERT INTO gallery ( image) VALUES ( ?)";
    pstmt = conn.prepareStatement(sql);


    // Obtains the upload file part in this multipart request
    Part filePart = request.getPart("myimg");
    if (filePart != null && filePart.getSize() > 0) {
        // Obtains input stream of the upload file
        inputStream = filePart.getInputStream();
        pstmt.setBinaryStream(1, inputStream, (int) filePart.getSize());

        // Sends the statement to the database server
        int count = pstmt.executeUpdate();
        if (count > 0) {
            out.println("<div class='alert alert-success'>Image inserted successfully!</div>");
        } else {
            out.println("<div class='alert alert-danger'>Failed to insert image!</div>");
        }
    } else {
        // Handle no file uploaded case
        out.println("<div class='alert alert-warning'>No file uploaded or file is empty. Please select a file to upload.</div>");
    }
} catch (SQLException ex) {
    ex.printStackTrace();
    out.println("<div class='alert alert-danger'>Database error: " + ex.getMessage() + "</div>");
} catch (Exception ex) {
    ex.printStackTrace();
    out.println("<div class='alert alert-danger'>Error: " + ex.getMessage() + "</div>");
} finally {
    // Close resources in finally block
    if (pstmt != null) {
        try { pstmt.close(); } catch (SQLException ignored) {}
    }
    if (conn != null) {
        try { conn.close(); } catch (SQLException ignored) {}
    }
    if (inputStream != null) {
        try { inputStream.close(); } catch (Exception ignored) {}
    }
}
%>
