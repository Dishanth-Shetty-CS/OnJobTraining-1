<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ page import ="jakarta.servlet.http.HttpSession" %>

<%
	String appointment_date=request.getParameter("appointment_date");
	String appointment_time=request.getParameter("appointment_time");
	String appointment_type=request.getParameter("appointment_type");
	String registered_users_email_address = request.getParameter("registered_users_email_address");
	String registered_doctors_email_address = null;
	String sql="INSERT INTO appointment_records (appointment_date,appointment_time,appointment_type,appointment_status,registered_users_email_address,registered_doctors_email_address ) VALUES (?,?,?,'Awaiting',?,?)";
	
	try{
		Class.forName("com.mysql.cj.jdbc.Driver");
		Connection con=DriverManager.getConnection("jdbc:mysql://localhost:3306/aarogya_healthcare_db","root","admin");
		PreparedStatement ps=con.prepareStatement(sql);
		ps.setString(1, appointment_date);
		ps.setString(2, appointment_time);
		ps.setString(3, appointment_type);
		ps.setString(4, registered_users_email_address);
		ps.setString(5, registered_doctors_email_address);
		
		ps.executeUpdate();
		con.close();
	}
	catch(Exception e)
	{
		e.printStackTrace();
		
	}
%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Appointment Form</title>
<style>
	

body {
	font-family: sans-serif;
	background-color: #f0f9ff;
}

h2 {
	text-align: center;
	margin-bottom: 20px;
	color: #333;
}

.form-group {
	margin-bottom: 15px;
}

label {
	display: block;
	margin-bottom: 5px;
	font-weight: bold;
	color: #333;
}

input[type="date"], input[type="time"], select {
	width: 100%;
	padding: 10px;
	border: 1px solid #ccc;
	border-radius: 4px;
	box-sizing: border-box;
	outline: none;
	cursor: pointer;
	font-size: 16px;
}

input:focus{
	border: 1px solid #2196f3;
}

button[type="submit"] {
	background-color: #2196f3;
	color: white;
	font-weight: bold;
	font-size: 16px;
	padding: 10px;
	border: none;
	border-radius: 4px;
	cursor: pointer;
	transition: 0.3s;
	width: 100%;
}

button[type="submit"]:hover {
	background-color: #177dff;
}
	
</style>
</head>
<body>
	<form method="post" onsubmit="return bookAppointments(event)">
		<h2>Book Appointment</h2>
		<div class="form-group">
			<label for="appointment_date">Date:</label> <input type="date"
				name="appointment_date" id="appointment_date" required>
		</div>
		<div class="form-group">
			<label for="appointment_time">Time:</label> <input type="time"
				name="appointment_time" id="appointment_time" required>
		</div>
		<div class="form-group">
			<label for="appointment_type">Appointment Type:</label> <select
				name="appointment_type" id="appointment_type" required>
				<option value="">--- select type ---</option>
				<option value="Orthopedics">Orthopedics</option>
				<option value="Gastroenterology">Gastroenterology</option>
				<option value="Neurology">Neurology</option>
				<option value="Dermatology">Dermatology</option>
				<option value="Cardiology">Cardiology</option>	
			</select>
		</div>
		<button type="submit">Book Appointment</button>
	</form>
	
	<script src="user_interface.js"></script>
</body>

</html>
