<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.util.*"%>

<%
Connection con = null;
PreparedStatement st = null;
ResultSet rs = null;

int totalAppointments = 0;
int totalPrescriptions=0;
int totalVisited=0;

try {
    Class.forName("com.mysql.cj.jdbc.Driver");
    con = DriverManager.getConnection("jdbc:mysql://localhost:3306/aarogya_healthcare_db","root","admin");
    
    // Query to get total prescriptions
    String getTotalPrescriptions = "SELECT COUNT(*) FROM prescription";
    st = con.prepareStatement(getTotalPrescriptions);
    rs = st.executeQuery();
    if (rs.next()) {
        totalPrescriptions = rs.getInt(1);     
    }
    rs.close();
    st.close();
    
    // Query to get total appointments
    String getTotalAppointments = "SELECT COUNT(*) FROM appointment_records";    
    st = con.prepareStatement(getTotalAppointments);
    rs = st.executeQuery();
    if (rs.next()) {
        totalAppointments = rs.getInt(1);
    }
    rs.close();
    st.close();
    
    // Query to get total visited appointments
    String getTotalVisited = "SELECT COUNT(*) FROM appointment_records WHERE appointment_status ='VISITED'";    
    st = con.prepareStatement(getTotalVisited);
    rs = st.executeQuery();
    if (rs.next()) {
        totalVisited = rs.getInt(1);
    }
    rs.close();
    st.close();
      
    con.close();
}

catch(Exception e) {
    e.printStackTrace();
}
%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link rel="shortcut icon" href="assets/images/HealthCareLogo.png"
	type="image/x-icon">
<title>Patient Interface</title>
<link rel="stylesheet" href="user_interface.css">
<link rel="icon" href="./assets/images/favicon.png" type="image/x-icon">
<link
	href="https://fonts.googleapis.com/css?family=Open+Sans:300,300i,400,400i,600,600i,700,700i|Raleway:300,300i,400,400i,500,500i,600,600i,700,700i|Poppins:300,300i,400,400i,500,500i,600,600i,700,700i"
	rel="stylesheet">
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css"
	integrity="sha512-DTOQO9RWCH3ppGqcWaEA1BIZOC6xxalwEsw9c2QQeAIftl+Vegovlnee1c9QX4TctnWMn13TZye+giMm8e2LwA=="
	crossorigin="anonymous" referrerpolicy="no-referrer" />
</head>
<body>
	<header id="header">
		<a href="#" id="logo"> Aarogya Healthcare </a>
		<nav>
			<div class="logout-container" onclick="window.location.replace('../logins/patient_login.html')">
				<i class="fa-solid fa-right-from-bracket"></i>
				<button>Logout</button>
			</div>
		</nav>
	</header>
	<main id="main">
		<div id="sidebar">
			<div class="sidebar-options" onclick="loadDashboard()">
				<i class="fa-solid fa-house-chimney"></i>
				<p>Dashboard</p>
			</div>

			<div class="sidebar-options">
				<i class="fa-solid fa-book-medical"></i> <a href="#"
					id="BookAppointment"><p>Book Appointment</p></a>
			</div>

			<div class="sidebar-options">
				<i class="fa-solid fa-calendar-check"></i> <a href="#"
					id="AppointmentHistory"><p>Appointment History</p></a>
			</div>
			
			<div class="sidebar-options">
				<i class="fa-solid fa-calendar-check"></i> <a href="#"
					id="MyAppointments"><p>My Appointments</p></a>
			</div>

			<div class="sidebar-options">
				<i class="fa-solid fa-prescription"></i> <a href="#"
					id="Prescriptions"><p>Prescriptions</p></a>
			</div>
		</div>
		<div id="right-body">
			<div class="dashboard-top-container">
				<div class="view-details" style="border-left: 10px solid orange;">
					<p>
						Total Appointments :
						<%=totalAppointments %></p>
				</div>

				<div class="view-details"
					style="border-left: 10px solid rgb(1, 234, 255);">
					<p>
						Total Prescription :
						<%=totalPrescriptions %></p>
				</div>

				<div class="view-details"
					style="border-left: 10px solid greenyellow;">
					<p>
						Total Visits :
						<%=totalVisited %></p>
				</div>
			</div>
			<div class="table-scroll-items">
				<table>
				<tr>
					<th>ID</th>
					<th>Date</th>
					<th>Time 24h</th>
					<th>Type</th>
					<th>Doctor Email</th>
					<th>Status</th>
				</tr>
				<%
                try {
                    Class.forName("com.mysql.cj.jdbc.Driver");
                    con = DriverManager.getConnection("jdbc:mysql://localhost:3306/aarogya_healthcare_db", "root", "admin");
                    st = con.prepareStatement("SELECT * FROM appointment_records");
                    rs = st.executeQuery();
                    while (rs.next()) {
                        String status = rs.getString(5);
                        String buttonClass = "";
                        if (status.equals("Awaiting")) {
                            buttonClass = "awaiting-button";
                        } else if (status.equals("Approved")) {
                            buttonClass = "approved-button";
                        } else if (status.equals("Visited")){
                            buttonClass = "visited-button";   
                        }
                        else if (status.equals("Not Visited")){
                            buttonClass = "not-visited-button";
                        } else if (status.equals("Cancelled")){
                            buttonClass = "cancelled-button";
                		}
                %>
				<tr>
					<td><%= rs.getString(1) %></td>
					<td><%= rs.getString(2) %></td>
					<td><%= rs.getString(3) %></td>
					<td><%= rs.getString(4) %></td>
					<td><%= rs.getString(7) %></td>
					<td><button style="position:relative; left: 30px;" class="<%= buttonClass %>"><%= rs.getString(5) %></button></td>
				</tr>
				<%
                    }
                } catch (Exception e) {
                    e.printStackTrace();
                } finally {
                    try {
                        if (rs != null) rs.close();
                        if (st != null) st.close();
                        if (con != null) con.close();
                    } catch (SQLException e) {
                        e.printStackTrace();
                    }
                }
                %>
			</table>
			</div>
		</div>
	</main>
<script src="user_interface.js"></script>
</body>
</html>