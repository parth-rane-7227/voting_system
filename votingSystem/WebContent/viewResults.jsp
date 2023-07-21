<%@page import="java.util.Map"%>
<%@page import="java.util.HashMap"%>
<%@page import="com.votingSystem.SecurityKey"%>
<%@page import="com.votingSystem.DbConnection"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Poll Result</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-rbsA2VBKQhggwzxH7pPCaAqO46MgnOM80zW1RWuH61DGLwZJEdK2Kadq2F9CUG65" crossorigin="anonymous">
    <link rel="stylesheet" type="text/css" runat="server" href="css/style.css">
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.6/dist/umd/popper.min.js" integrity="sha384-oBqDVmMz9ATKxIep9tiCxS/Z9fNfEXiDAYTujMAeBAsjFuCZSmKbSSUnQlmh/jp3" crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.min.js" integrity="sha384-cuYeSxntonz0PPNlHhBs68uyIAVpIIOZZ5JqeqvYYIcEL727kskC66kF92t6Xl2V" crossorigin="anonymous"></script>
</head>
<body>
<%@ page import="java.sql.*" %>
<%
	Connection con=DbConnection.connect();
	int pid=Integer.parseInt(request.getParameter("pid"));
	PreparedStatement psmt = con.prepareStatement("select rid,vid,vemail,pid,cast(aes_decrypt(voted,?) as char(100)),salt from result where pid=?");
	psmt.setString(1, SecurityKey.getKey());
	psmt.setInt(2, pid);
	ResultSet rs = psmt.executeQuery();
	
	PreparedStatement psmt1 = con.prepareStatement("select * from polls where pid=?");
	psmt1.setInt(1, pid);
	ResultSet rs1 = psmt1.executeQuery();
	String op1=null,op2=null,op3=null,op4=null;
	int countOp1=0,countOp2=0,countOp3=0,countOp4=0;
	HashMap<String,Integer> map=new HashMap<String,Integer>();
	while(rs1.next()){
		if(!rs1.getString(4).equals("null")){
			op1=rs1.getString(4);
		}
		if(!rs1.getString(5).equals("null")){
			op2=rs1.getString(5);
		}
		if(!rs1.getString(6).equals("null")){
			op3=rs1.getString(6);
		}
		if(!rs1.getString(7).equals("null")){
			op4=rs1.getString(7);
		}
	}
	while(rs.next()){
		String voted=rs.getString(5).substring(0, rs.getString(5).length()/2);
		if(op1!=null && op1.equals(voted)){
			countOp1++;
			map.put(op1, countOp1);
		}
		if(op2!=null && op2.equals(voted)){
			countOp2++;
			map.put(op2, countOp2);
		}
		if(op3!=null && op3.equals(voted)){
			countOp3++;
			map.put(op3, countOp3);
		}
		if(op4!=null && op4.equals(voted)){
			countOp4++;
			map.put(op4, countOp4);
		}
	}
	PreparedStatement psmt2 = con.prepareStatement("select * from result where pid=?");
	psmt2.setInt(1, pid);
	ResultSet rs2=psmt2.executeQuery();
%>

<div class="container login-container">
        <div class="row">
            <div class="col-md-6 login-form-1" style="margin-left:25%;">
                <h3>Poll Result</h3>
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
            <th data-breakpoints="xs">Candidate</th>
            <th data-breakpoints="xs">Votes</th>
          </tr>
        </thead>
        <tbody>
 		
 		<%if(op1!=null){ %>
          <tr data-expanded="true">
            	<td><%=op1 %></td>
            	<td><%=countOp1 %></td>
          </tr>
        <%} %>
        <%if(op2!=null){ %>
          <tr data-expanded="true">
            	<td><%=op2 %></td>
            	<td><%=countOp2 %></td>
          </tr>
        <%} %>
        <%if(op3!=null){ %>
          <tr data-expanded="true">
            	<td><%=op3 %></td>
            	<td><%=countOp3 %></td>
          </tr>
        <%} %>
        <%if(op4!=null){ %>
          <tr data-expanded="true">
            	<td><%=op4 %></td>
            	<td><%=countOp4 %></td>
          </tr>
        <%} %>
        </tbody>
      </table>
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
            <th data-breakpoints="xs">Voter Email</th>
            <th data-breakpoints="xs">Voted</th>
          </tr>
        </thead>
        <tbody>
        	<%while(rs2.next()){ %>
          <tr data-expanded="true">
            <td><%=rs2.getString(3) %></td>
            <td><%=rs2.getString(5) %></td>
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