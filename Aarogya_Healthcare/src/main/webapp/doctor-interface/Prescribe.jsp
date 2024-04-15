<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.*" %>
<%@ page import="java.io.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Prescription Form</title>
    <style>
        /* CSS styles for form */
        form {
            margin: 20px auto;
            width: 50%;
            background-color: #f2f2f2;
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0 4px 8px 0 rgba(0, 0, 0, 0.2);
        }
        label {
            font-weight: bold;
        }
        input[type="text"], input[type="date"], input[type="time"], input[type="number"], textarea {
            width: 98%;
            padding: 10px;
            margin: 5px 0;
            border-radius: 5px;
            border: 1px solid #ccc;
        }
        textarea {
            resize: vertical;
        }
        input[type="submit"] {
            background-color: #4CAF50;
            color: white;
            padding: 10px 20px;
            border: none;
            cursor: pointer;
            border-radius: 5px;
        }
        input[type="submit"]:hover {
            background-color: #45a049;
        }
    </style>
</head>
<body>
    <form method="post" onsubmit="return validateForm()">
        <label for="date">Date:</label>
        <input type="date" id="date" name="date" required><br>

        <label for="time">Time:</label>
        <input type="time" id="time" name="time" required><br>

        <label for="diagnosis">Diagnosis:</label>
        <input type="text" id="diagnosis" name="diagnosis" required><br>

        <label for="medication_info">Medication Info:</label>
        <input type="text" id="medication_info" name="medication_info" required><br>

        <label for="refill">Refill:</label>
        <input type="number" id="refill" name="refill" required><br>

        <label for="instructions">Instructions:</label>
        <textarea id="instructions" name="instructions" rows="4" required></textarea><br>

        <input type="submit" value="Submit">
    </form>

    <script>
        function validateForm() {
            var date = document.getElementById("date").value;
            var time = document.getElementById("time").value;
            var diagnosis = document.getElementById("diagnosis").value;
            var medication_info = document.getElementById("medication_info").value;
            var refill = document.getElementById("refill").value;
            var instructions = document.getElementById("instructions").value;

            if (date === "" || time === "" || diagnosis === "" || medication_info === "" || refill === "" || instructions === "") {
                alert("Please fill in all fields.");
                return false;
            }
            return true;
        }

        // Check if there is a success or error message in the URL and display appropriate alert
        var urlParams = new URLSearchParams(window.location.search);
        var successMessage = urlParams.get('success');
        var errorMessage = urlParams.get('error');

        if (successMessage) {
            alert(successMessage);
        }
        if (errorMessage) {
            alert(errorMessage);
        }
    </script>
</body>
</html>

<%
// JDBC driver name and database URL
String JDBC_DRIVER = "com.mysql.jdbc.Driver";
String DB_URL = "jdbc:mysql://localhost/aarogya_healthcare_db";

// Database credentials
String USER = "root";
String PASS = "admin";

Connection conn = null;
PreparedStatement pstmt = null;

try {
    // Register JDBC driver
    Class.forName(JDBC_DRIVER);

    // Open a connection
    conn = DriverManager.getConnection(DB_URL, USER, PASS);

    // Prepare SQL query
    String sql = "INSERT INTO prescription (date, time, diagnosis, medication_info, refill, instructions) VALUES (?, ?, ?, ?, ?, ?)";

    // Create a prepared statement
    pstmt = conn.prepareStatement(sql);

    // Set parameters from the form
    pstmt.setString(1, request.getParameter("date"));
    pstmt.setString(2, request.getParameter("time"));
    pstmt.setString(3, request.getParameter("diagnosis"));
    pstmt.setString(4, request.getParameter("medication_info"));
    pstmt.setInt(5, Integer.parseInt(request.getParameter("refill")));
    pstmt.setString(6, request.getParameter("instructions"));

    // Execute the query
    int rowsAffected = pstmt.executeUpdate();

    // Check if the insertion was successful
    if (rowsAffected > 0) {
        response.sendRedirect("prescription.jsp?success=Prescription saved successfully!");
    } else {
        response.sendRedirect("prescription.jsp?error=Failed to save prescription.");
    }
} catch (SQLException se) {
    se.printStackTrace();
} catch (Exception e) {
    e.printStackTrace();
} finally {
    // Clean-up environment
    try {
        if (pstmt != null) pstmt.close();
    } catch (SQLException se2) {
    }
    try {
        if (conn != null) conn.close();
    } catch (SQLException se) {
        se.printStackTrace();
    }
}
%>
