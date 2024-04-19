<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.*"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<link rel="stylesheet" href="user_interface.css">
<title>Prescription Lists</title>
</head>
<body>
    <div id="prescription-table-scroll">
    	<table>
        <tr>
            <th>ID</th>
            <th>Date</th>
            <th>Time 24h</th>
            <th>Diagnosis</th>
            <th>Medication_Info</th>
            <th>Refill</th>
            <th>Instructions</th>
            <th>Doctor Email</th>
        </tr>

        <%
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection con=DriverManager.getConnection("jdbc:mysql://localhost:3306/aarogya_healthcare_db","root","admin");
            Statement st=con.createStatement();
            ResultSet rs=st.executeQuery("SELECT * FROM prescription");

            while(rs.next()) {
        %>
        <tr>
            <td><%=rs.getString(1) %></td>
            <td><%=rs.getString(2) %></td>
            <td><%=rs.getString(3) %></td>
            <td><%=rs.getString(4) %></td>
            <td><%=rs.getString(5) %></td>
            <td><%=rs.getString(6) %></td>
            <td><%=rs.getString(7) %></td>
            <td><%=rs.getString(9) %></td>
        </tr>
        <%
            }

            con.close();
            st.close();
        }
        catch(Exception e) {
            System.out.println("Error Occurred: "+e.getMessage());
            e.printStackTrace();
        }
        %>
    </table>
    </div>
</body>
</html>
    