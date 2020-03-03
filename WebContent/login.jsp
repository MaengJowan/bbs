<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width", initial-scale="1">
<link rel="stylesheet" href="css/bootstrap.css">
<link rel="stylesheet" href="css/custom.css">
<title>JSP BBS WebSite</title>
</head>
<script src="https://ajax.aspnetcdn.com/ajax/jQuery/jquery-3.3.1.min.js"></script>
<script src="js/bootstrap.js"></script>
<body>
	<%
		System.out.println("로그인 페이지로 이동");
	%>
	<nav class="navbar navbar-default">
		<div class="navbar-header">
			<button type="button" class="navbar-toggle collapsed"
				data-toggle="collapse" data-target="#bs-example-navbar-collapse-1"
				aria-expanded="false">
				<span class="icon-bar"></span>
				<span class="icon-bar"></span>	
				<span class="icon-bar"></span>
			</button>
			<a class="navbar-brand" href="main.jsp">JSP BBS WebSite</a>
		</div>
		<div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
			<ul class="nav navbar-nav">
				<li><a href="main.jsp">MAIN</a></li>
				<li><a href="bbs.jsp">BBS</a></li>
			</ul>
			<ul class="nav navbar-nav navbar-right">
				<li class="dropdown">
					<a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true"
					aria-expanded="false">접속하기<span class="caret"></span></a>
					<ul class="dropdown-menu">
						<li class="active"><a href="login.jsp">로그인</a></li>
						<li ><a href="join.jsp">회원가입</a></li>
					</ul>
				</li>
			</ul>
		</div>	
	</nav>
	<div class="container">
		<div class="col-lg-4"></div>
		<div class="col-lg-4">
			<div class="jumbotron" style="padding-top: 20px;">
				<form method="post" action="loginAction.jsp">
					<h3 style="text-align:center;">LOG IN</h3>
					<div class="form-group">
						<input type="text" class="form-control" placeholder="id" name="userID" maxlength="20">
					</div>
					<div class="form-group">
						<input type="password" class="form-control" placeholder="pw" name="userPassword" maxlength="20">
					</div>
					<input type="submit" class="btn-primary form-control" value="login">					
				</form>
					<button class="btn-primary form-control" onclick="location.href='join.jsp'" style="margin-top:10px;">JOIN IN</button>
			</div>
		</div>
		<div class="col-lg-4"></div>
	</div>
</body>
</html>