<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>

<%@ page import="java.sql.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<link rel="stylesheet" href="user_interface.css">
<title>Patients Lists</title>
</head>
<body>
    <table>
        <tr>
            <th>Email Address</th>
            <th>First Name</th>
            <th>Last Name</th>
            <th>Phone Number</th>
        </tr>

        <%
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection con=DriverManager.getConnection("jdbc:mysql://localhost:3306/aarogya_healthcare_db","root","admin");
            Statement st=con.createStatement();
            ResultSet rs=st.executeQuery("SELECT * FROM registered_users");

            while(rs.next()) {
        %>
        <tr>
            <td><%=rs.getString(1) %></td>
            <td><%=rs.getString(2) %></td>
            <td><%=rs.getString(3) %></td>
            <td><%=rs.getString(4) %></td>
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
</body>
</html>
    