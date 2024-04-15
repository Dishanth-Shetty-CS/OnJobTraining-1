<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>

<%
Connection con = null;
Statement st = null;
ResultSet rs = null;

int totalAdmins = 0;

String opname = request.getParameter("opname");
 
try {
	 Class.forName("com.mysql.cj.jdbc.Driver");
     con = DriverManager.getConnection("jdbc:mysql://localhost:3306/aarogya_healthcare_db","root","admin");
     
     st = con.createStatement();
          
     if (opname.equals("deleteAdmin")) {
    	 String deleteId = request.getParameter("id");    	 
    	 
    	 String deleteAdminSQL = "DELETE FROM registered_admins where email_address = \"" + deleteId + "\"";
    	 st.executeUpdate(deleteAdminSQL);
     }
     
     //Gets the count of the total registered users
     rs = st.executeQuery("SELECT COUNT(*) FROM registered_admins");     
     rs.next();
     totalAdmins = rs.getInt(1);
     
     //Gets the Patient List
     String getAdminList = "SELECT * FROM registered_admins";
     rs = st.executeQuery(getAdminList);
     
     //---------------------------------------

%>

<div class="list-header">
	<h3>Admin List</h3>
	<h3>Number of Admins: <%= totalAdmins %></h3>
</div>

<div class="query-records-container" style="border-top-left-radius: 10px;">		
	<table>
		<tr>
			<th>First Name</th>
			<th>Last Name</th>
			<th>Phone Number</th>
			<th>Email Address</th>
			<th>Delete Account</th>
		</tr>
		
		<%
			for (int i = 1; i <= totalAdmins; i++) {
				rs.next();
		%>
				<tr>
					<td><%= rs.getString(2) %></td>
					<td><%= rs.getString(3) %></td>
					<td style="text-align: center"><%= rs.getString(4) %></td>
					<td><%= rs.getString(1) %></td>
					<td style="text-align: center"><button class="delete-button" id="<%= rs.getString(1) %>" onclick="deleteAdmin(this.id)">Delete</button></td>
				</tr>
		<%
			}
		%>		
	</table>			
</div>

<%
     con.close();
} catch(Exception e) {            
     e.printStackTrace();
} 
%>