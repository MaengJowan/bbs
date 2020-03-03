<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="user.UserDAO" %>
<% request.setCharacterEncoding("utf-8"); %>
<jsp:useBean id="user" class="user.User" scope="page"/>
<jsp:setProperty name="user" property="userID"/>
<jsp:setProperty name="user" property="userPassword"/>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>loginAction</title>
</head>
<body>
	<%
		String userID = null;
		if(session.getAttribute("userID") != null){
			userID = (String) session.getAttribute("userID");
		}
		if (userID != null){
	%>
		<script>
			alert("이미 로그인 되어 있습니다");
			location.href="main.jsp";
		</script>
	<%	
		}	
		UserDAO dao = new UserDAO();
		int result = dao.login(user.getUserID(), user.getUserPassword());
		
		if(result == 1){
		session.setAttribute("userID", user.getUserID());
	%>
		
		<script>
			location.href="main.jsp";
		</script>
	<%
		} else if(result == 0){
	%>
		<script>
			alert("incorrect PW!");
			history.back();
		</script>
	<%
		} else if(result == -1){
	%>
		<script>
			alert('unknown ID!');
			history.back();
		</script>
	<%
		} else if(result == -2){
	%>
		<script>
			alert('Error Server!');
			history.back();
		</script>
	<%
		}
	%>
</body>
</html>