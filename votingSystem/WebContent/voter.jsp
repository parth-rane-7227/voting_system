<%@page import="com.votingSystem.DbConnection"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Voter</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-rbsA2VBKQhggwzxH7pPCaAqO46MgnOM80zW1RWuH61DGLwZJEdK2Kadq2F9CUG65" crossorigin="anonymous">
    <link rel="stylesheet" type="text/css" runat="server" href="css/style.css">
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.6/dist/umd/popper.min.js" integrity="sha384-oBqDVmMz9ATKxIep9tiCxS/Z9fNfEXiDAYTujMAeBAsjFuCZSmKbSSUnQlmh/jp3" crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.min.js" integrity="sha384-cuYeSxntonz0PPNlHhBs68uyIAVpIIOZZ5JqeqvYYIcEL727kskC66kF92t6Xl2V" crossorigin="anonymous"></script>
</head>
<body>
<%@ page import="java.sql.*" %>
<%
	Connection con=DbConnection.connect();
	int vid=Integer.parseInt(request.getParameter("value"));
	String email=null;
	PreparedStatement psmt = con.prepareStatement("select * from voter where voter_id=?");
	psmt.setInt(1, vid);
	ResultSet rs=psmt.executeQuery();
	while(rs.next()){
		email=rs.getString(3);
	}
	
	psmt = con.prepareStatement("select * from add_voters,polls where add_voters.pid=polls.pid and vemail=? and vote='null' group by add_voters.pid");
	psmt.setString(1, email);
	ResultSet rs1 = psmt.executeQuery();
%>
<div class="container login-container">
        <div class="row">
            <div class="col-md-6 login-form-1" style="margin-left:25%;">
                <h3>Polls</h3>
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
            <th data-breakpoints="xs">Poll ID</th>
            <th data-breakpoints="xs">Name</th>
            <th data-breakpoints="xs">Vote</th>
            <th data-breakpoints="xs">Vote</th>
            <th data-breakpoints="xs">Vote</th>
            <th data-breakpoints="xs">Vote</th>
          </tr>
        </thead>
        <tbody>
        	<%while(rs1.next()){ %>
          <tr data-expanded="true">
            <td><%=rs1.getInt(3) %></td>
            <td><%=rs1.getString(6) %></td>
            <td><a href="Vote?op=<%=rs1.getString(8) %>&vid=<%=Integer.toString(vid) %>&pid=<%=Integer.toString(rs1.getInt(3))%>"><%=rs1.getString(8) %></a></td>
            <td><a href="Vote?op=<%=rs1.getString(9) %>&vid=<%=Integer.toString(vid) %>&pid=<%=Integer.toString(rs1.getInt(3))%>"><%=rs1.getString(9) %></a></td>
            <td><a href="Vote?op=<%=rs1.getString(10) %>&vid=<%=Integer.toString(vid) %>&pid=<%=Integer.toString(rs1.getInt(3))%>"><%=rs1.getString(10) %></a></td>
            <td><a href="Vote?op=<%=rs1.getString(11) %>&vid=<%=Integer.toString(vid) %>&pid=<%=Integer.toString(rs1.getInt(3))%>"><%=rs1.getString(11) %></a></td>
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