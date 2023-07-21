<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>New Poll</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-rbsA2VBKQhggwzxH7pPCaAqO46MgnOM80zW1RWuH61DGLwZJEdK2Kadq2F9CUG65" crossorigin="anonymous">
    <link rel="stylesheet" type="text/css" runat="server" href="css/style.css">
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.6/dist/umd/popper.min.js" integrity="sha384-oBqDVmMz9ATKxIep9tiCxS/Z9fNfEXiDAYTujMAeBAsjFuCZSmKbSSUnQlmh/jp3" crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.min.js" integrity="sha384-cuYeSxntonz0PPNlHhBs68uyIAVpIIOZZ5JqeqvYYIcEL727kskC66kF92t6Xl2V" crossorigin="anonymous"></script>
</head>
<body>
<%int oid=Integer.parseInt(request.getParameter("oid")); %>
<div class="container login-container">
        <div class="row">
            <div class="col-md-6 login-form-1" style="margin-left:25%;">
                <h3>Create Poll</h3>
                <form action="CreatePoll?oid=<%=Integer.toString(oid)%>" method="post">
                    <div class="form-group">
                        <input type="text" name="name" class="form-control" placeholder="Poll Name *" value="" />
                    </div>
                    <div class="form-group">
                        <input type="text" name="op1" class="form-control" placeholder="First Option *" value="" />
                    </div>
                    <div class="form-group">
                        <input type="text" name="op2" class="form-control" placeholder="Second Option *" value="" />
                    </div>
                    <div class="form-group">
                        <input type="text" name="op3" class="form-control" placeholder="Third Option *" value="" />
                    </div>
                    <div class="form-group">
                        <input type="text" name="op4" class="form-control" placeholder="Fourth Option *" value="" />
                    </div>
                    <div class="form-group" style="margin-left:30% ;">
                        <input type="submit" class="btnSubmit" value="Create" />
                    </div>            
                </form>
            </div>
            <!-- 
            <div class="col-md-6 login-form-2">
                <h3>Organizer Login</h3>
                <form>
                    <div class="form-group">
                        <input type="text" class="form-control" placeholder="Your Email *" value="" />
                    </div>
                    <div class="form-group">
                        <input type="password" class="form-control" placeholder="Your Password *" value="" />
                    </div>
                    <div class="form-group">
                        <input type="submit" class="btnSubmit" value="Login" />
                    </div>
                    <div class="form-group">
                        <a href="#" class="ForgetPwd">New User? Register!</a>
                    </div>
                </form>
            </div>
             -->
        </div>
    </div>
</body>
</body>
</html>