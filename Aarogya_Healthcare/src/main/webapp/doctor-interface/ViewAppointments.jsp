<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.*"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="ISO-8859-1">
    <link rel="stylesheet" href="doctor_interface.css">
    <title>All Appointments</title>
</head>
<body>
    <table>
        <tr>
            <th>ID</th>
            <th>Date</th>
            <th>Time 24h</th>
            <th>Type</th>
            <th>Patient Email</th>
            <th>Status</th>
            <th>Actions</th>
        </tr>
		
        <%
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection con=DriverManager.getConnection("jdbc:mysql://localhost:3306/aarogya_healthcare_db","root","admin");
            Statement st=con.createStatement();
            ResultSet rs=st.executeQuery("SELECT * FROM appointment_records");

            while(rs.next()) {
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
        <tr id="<%=rs.getString(1) %>">
            <td><%=rs.getString(1) %></td>
            <td><%=rs.getString(2) %></td>
            <td><%=rs.getString(3) %></td>
            <td><%=rs.getString(4) %></td>
            <td><%=rs.getString(6) %></td>
            <td><button class="<%= buttonClass %>"><%= rs.getString(5) %></button></td>
            <td>
                <a href="#" class="Accept-App"><button class="Accept-btn" id="Accept-btn">Accept</button></a>
                <a href="#" class="Decline-App"><button class="Decline-btn" id="Decline-btn">Decline</button></a>
            </td>
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

    <!-- jQuery CDN -->
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
    <script src="doctor_interface.js"></script>
    <script>
    $(document).ready(function() {
        $('.Accept-btn').click(function() {
            var row = $(this).closest('tr');
            $(this).hide("slow");
        });

        $('.Decline-btn').click(function() {
            var row = $(this).closest('tr');
            row.hide("slow");
        });
    });

    </script>
</body>
</html>
