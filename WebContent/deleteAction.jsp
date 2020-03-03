<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="bbs.BBSDAO" %>
<%@ page import="bbs.BBS" %>
<%@ page import="java.io.PrintWriter" %>
<% request.setCharacterEncoding("utf-8"); %>
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
			System.out.println("아이디 : "+ userID + "가 글수정를 시도합니다.");
		}
		if (userID == null){
	%>
		<script>
			alert("로그인을 하세요");
			location.href="login.jsp";
		</script>
	<%	
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
		if (!userID.equals(bbs.getUserID())){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('권한이 없습니다.')");
			script.println("location.href='bbs.jsp'");
			script.println("</script>");
		}  else { 
			BBSDAO dao = new BBSDAO();	
			int result = dao.delete(bbsID);
				if(result == -1){
			%>
				<script>
					alert("삭제에 실패했습니다."); //DB userID가 기본키 중복되면 같은 아이디라는 뜻
												// DB오류 = 중복 아이디
					history.back();
				</script>
			<%
				} else {
				%>
				<script>
					location.href="bbs.jsp";
				</script>
			<%
				System.out.println("아이디 : "+ userID + " 글삭제성공");
				}
			}
			%>

</body>
</html>