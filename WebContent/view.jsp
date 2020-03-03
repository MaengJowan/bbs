<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="bbs.BBSDAO" %>
<%@ page import="bbs.BBS" %>
<%@ page import="java.io.PrintWriter" %>

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

		System.out.println("글보기 페이지로 이동");
		String userID = null;
		if (session.getAttribute("userID") != null){
			userID = (String) session.getAttribute("userID");
			System.out.println("아이디 " + userID);
		}
		
		int bbsID = 0;
		if (request.getParameter("bbsID") != null){
			bbsID = Integer.parseInt(request.getParameter("bbsID"));
			
		} System.out.println("글번호 " + bbsID);
		if(bbsID == 0){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('유효하지 않습니다')");
			script.println("location.href='bbs.jsp'");
			script.println("</script>");
		}
		BBS bbs = new BBSDAO().getBbs(bbsID);
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
				<li class="active"><a href="bbs.jsp">BBS</a></li>
			</ul>
			<%
				if( userID == null){
			%>
<!-- 로그아웃 되어 있을 때 -->
				<ul class="nav navbar-nav navbar-right">
					<li class="dropdown">
						<a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true"
						aria-expanded="false">접속하기<span class="caret"></span></a>
						<ul class="dropdown-menu">
							<li><a href="login.jsp">로그인</a></li>
							<li ><a href="join.jsp">회원가입</a></li>
						</ul>
					</li>
				</ul>				
			<%		
				} else {
			%>
<!-- 로그인 되어 있을 때 -->
				<ul class="nav navbar-nav navbar-right">
					<li class="dropdown">
						<a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true"
						aria-expanded="false">더 보기<span class="caret"></span></a>
						<ul class="dropdown-menu">
							<li><a href="logout.jsp">Log out</a></li>
						</ul>
					</li>
				</ul>				
			<%
				}
			%>

		</div>	
	</nav>
	<div class="container">
		<div class="row">
			<table class="table table-striped" style="text-align: center; border: 1px solid #dddddd">
				<thead>
					<tr>
						<th colspan="3" style="background-color: #eeeeee; text-align: center;">View</th>
					</tr>
					<tr>
						<th colspan="3" style="background-color: #eeeeee; text-align: center;"></th>
					</tr>					
				</thead>
				<tbody>
					<tr>
						<td style="width:20%;">Title</td>
						<td colspan="2"><%= bbs.getBbsTitle() %></td>
					</tr>
					<tr>
						<td>Name</td>
						<td colspan="2"><%= bbs.getUserID() %></td>
					</tr>
					<tr>
						<td>Date</td>
						<td colspan="2"><%= bbs.getBbsDate().substring(0, 11) + bbs.getBbsDate().substring(11, 13) + "시" + bbs.getBbsDate().substring(14,16) + "분" %></td>
					</tr>		
					<tr>
						<td>Content</td>
						<td colspan="2" style="min-height:200px; text-align:left;"><%= bbs.getBbsContent() %></td>
					</tr>								
				</tbody>
			</table>
			<a href="bbs.jsp" class="btn btn-primary">목록</a>
			<%
				if(userID != null && userID.equals(bbs.getUserID())){
			%>
				<a href="update.jsp?bbsID=<%= bbsID %>" class="btn btn-primary">수정</a>
				<a onclick="return confirm('삭제 하시겠습니까?')"href="deleteAction.jsp?bbsID=<%= bbsID %>" class="btn btn-primary">삭제</a>
			<%		
				}
			%>
			
		</div>
	</div>
</body>
</html>