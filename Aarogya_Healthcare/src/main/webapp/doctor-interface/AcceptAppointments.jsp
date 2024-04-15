<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%@ page import="java.sql.*" %>
<%
	try{
		String sql="UPDATE appointment_records set appointment_status='Approved' WHERE appointment_status='Awaiting' ";
		Class.forName("com.mysql.cj.jdbc.Driver");
        Connection con=DriverManager.getConnection("jdbc:mysql://localhost:3306/aarogya_healthcare_db","root","admin");
        PreparedStatement ps=con.prepareStatement(sql);
		ps.executeUpdate();
	}
catch(Exception e)
{
	e.getMessage();
}
%>