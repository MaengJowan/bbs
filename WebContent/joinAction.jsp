<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="user.UserDAO" %>
<% request.setCharacterEncoding("utf-8"); %>
<jsp:useBean id="user" class="user.User" scope="page"/>
<jsp:setProperty name="user" property="userID"/>
<jsp:setProperty name="user" property="userPassword"/>
<jsp:setProperty name="user" property="userName"/>
<jsp:setProperty name="user" property="userGender"/>
<jsp:setProperty name="user" property="userEmail"/>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
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
		if(user.getUserID() == null || user.getUserPassword() == null || user.getUserName() == null ||
			user.getUserGender() == null || user.getUserEmail() == null) {
	%>
				<script>
					alert("모두 입력하세요!");
					history.back();
				</script>
				
			<%
			System.out.println("NULL 오류!");
		} else {
			UserDAO dao = new UserDAO();
			int result = dao.join(user);
			
				if(result == -1){
			%>
				<script>
					alert("이미 존재하는 아이디입니다."); //DB userID가 기본키 중복되면 같은 아이디라는 뜻
													// DB오류 = 중복 아이디
					history.back();
				</script>
			<%
				} else {
				%>
					<script>
						location.href="login.jsp";
					</script>
				<%
					System.out.println("회원가입성공");
					}
				%>
		<%
		}
		%>

</body>
</html>