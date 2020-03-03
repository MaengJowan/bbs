<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<%
		try{
			session.invalidate();
			System.out.println("로그아웃합니다 세션이 해제됩니다.");
		} catch(Exception e){
			e.printStackTrace();
		}
		
	%>
		<script>
			location.href="main.jsp";
		</script>
</body>
</html>