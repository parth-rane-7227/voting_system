<%@page import="com.votingSystem.DbConnection"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Home</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-rbsA2VBKQhggwzxH7pPCaAqO46MgnOM80zW1RWuH61DGLwZJEdK2Kadq2F9CUG65" crossorigin="anonymous">
    <link rel="stylesheet" type="text/css" runat="server" href="css/style.css">
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.6/dist/umd/popper.min.js" integrity="sha384-oBqDVmMz9ATKxIep9tiCxS/Z9fNfEXiDAYTujMAeBAsjFuCZSmKbSSUnQlmh/jp3" crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.min.js" integrity="sha384-cuYeSxntonz0PPNlHhBs68uyIAVpIIOZZ5JqeqvYYIcEL727kskC66kF92t6Xl2V" crossorigin="anonymous"></script>
</head>
<body>
<%@ page import="java.sql.*" %>
<%
	Connection con=DbConnection.connect();
	PreparedStatement psmt = con.prepareStatement("select * from organizer_login");
	ResultSet rs = psmt.executeQuery();
%>
<div class="container login-container">
        <div class="row">
            <div class="col-md-6 login-form-1" style="margin-left:25%;">
                <h3>Poll Organizers</h3>
        <table class="table" ui-jq="footable" ui-options='{
        "paging": {
          "enabled": true
        },
        "filtering": {
          "enabled": true
        },
        "sorting": {
          "enabled": true
        }}'>
        <thead>
          <tr>
            <th data-breakpoints="xs">Organizer ID</th>
            <th data-breakpoints="xs">Email</th>
            <th data-breakpoints="xs">Status</th> 
            <th data-breakpoints="xs sm md">Action</th>
          </tr>
        </thead>
        <tbody>
        	<%while(rs.next()){ %>
          <tr data-expanded="true">
            <td><%=rs.getInt(1) %></td>
            <td><%=rs.getString(3) %></td>
            <%String status=rs.getString(5); %>
            	<%if(status.equals("Approved")){%>
            	<td><%=status %></td>
            	<%}else{ %>
            	<td><a href="ApproveOrg?value=<%=rs.getInt(1)%>">Approve</a></td>
            	<%} %>
            <td><a href="DeleteOrg?value=<%=rs.getInt(1)%>">Delete</a></td>
          </tr>
          <%} %>
        </tbody>
      </table>
            </div>
        </div>
    </div>
</body>
</body>
</html>