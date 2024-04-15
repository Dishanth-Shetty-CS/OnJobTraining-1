<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.*"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<link rel="stylesheet" href="user_interface.css">
<title>All Appointments</title>
</head>
<body>
   <table>
			<tr>
					<th>ID</th>
					<th>Date</th>
					<th>Time 24h</th>
					<th>Type</th>
					<th>Status</th>
					<th>Patient Email</th>
					<th>Doctor Email</th>
				</tr>
				<%
				Connection con = null;
				Statement st = null;
				ResultSet rs = null;
				
                try {
                    Class.forName("com.mysql.cj.jdbc.Driver");
                    con = DriverManager.getConnection("jdbc:mysql://localhost:3306/aarogya_healthcare_db", "root", "admin");
                    st = con.createStatement();
                    rs = st.executeQuery("SELECT * FROM appointment_records WHERE appointment_status='Visited' OR appointment_status='Cancelled';");
                    while (rs.next()) {
                        String status = rs.getString(5);
                        String buttonClass = "";
                        if (status.equals("Awaiting")) {
                            buttonClass = "awaiting-button";
                        } else if (status.equals("Approved")) {
                            buttonClass = "approved-button";
                        } else if (status.equals("Visited")){
                            buttonClass = "visited-button";
                        } else if (status.equals("Cancelled")){
                            buttonClass = "cancelled-button";

                		}
                %>
				<tr>
					<td><%= rs.getString(1) %></td>
					<td><%= rs.getString(2) %></td>
					<td><%= rs.getString(3) %></td>
					<td><%= rs.getString(4) %></td>
					<td><button class="<%= buttonClass %>"><%= rs.getString(5) %></button></td>
					<td><%= rs.getString(6) %></td>
					<td><%= rs.getString(7) %></td>
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
</body>
</html>