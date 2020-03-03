<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="bbs.BBSDAO" %>
<%@ page import="bbs.BBS" %>
<%@ page import="java.util.ArrayList" %>
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
		System.out.println("bbs 페이지로 이동");
		String userID = null;
		if (session.getAttribute("userID") != null){
			userID = (String) session.getAttribute("userID");
			System.out.println("아이디 : "+ userID);
		}
		int pageNumber = 1;
		if(request.getParameter("pageNumber") != null){
			pageNumber = Integer.parseInt(request.getParameter("pageNumber"));
		}
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
						<th style="background-color: #eeeeee; text-align: center;">Number</th>
						<th style="background-color: #eeeeee; text-align: center;">Title</th>
						<th style="background-color: #eeeeee; text-align: center;">NicName</th>
						<th style="background-color: #eeeeee; text-align: center;">Date</th>
					</tr>
				</thead>
				<tbody>
					<%
						BBSDAO dao = new BBSDAO();
						ArrayList<BBS> list = dao.getList(pageNumber);
						
						for(int i = 0; i< list.size(); i++){
						
					%>
					<tr>
						<td name="bbsID"><%= list.get(i).getBbsID() %></td>
						<td><a href="view.jsp?bbsID=<%= list.get(i).getBbsID() %>"><%= list.get(i).getBbsTitle() %></a></td>
						<td><%= list.get(i).getUserID() %></td>
						<td><%= list.get(i).getBbsDate().substring(0, 11) + list.get(i).getBbsDate().substring(11, 13) + "시" + list.get(i).getBbsDate().substring(14,16) + "분" %></td>
					</tr>
					<%
						}
					%>
				</tbody>
			</table>
			<%
				if(pageNumber != 1){
			%>
				<a href="bbs.jsp?pageNumber=<%= pageNumber - 1%>" class="btn btn-success btn-arrow-left">이전</a>
			<%
				} if(dao.nextPage(pageNumber + 1)){
			%>	
				<a href="bbs.jsp?pageNumber=<%= pageNumber + 1%>" class="btn btn-success btn-arrow-left">다음</a>
			<%
				}
			%>	
			<a href="write.jsp" class="btn btn-primary pull-right">write</a>
		</div>
	</div>
</body>
</html>