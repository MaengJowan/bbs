<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="bbs.BBSDAO" %>
<% request.setCharacterEncoding("utf-8"); %>
<jsp:useBean id="bbs" class="bbs.BBS" scope="page"/>
<jsp:setProperty name="bbs" property="bbsTitle"/>
<jsp:setProperty name="bbs" property="bbsContent"/>

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
			System.out.println("아이디 : "+ userID + "가 글쓰기를 시도합니다.");
		}
		if (userID == null){
	%>
		<script>
			alert("로그인을 하세요");
			location.href="login.jsp";
		</script>
	<%	
		}
		else { 
			if(bbs.getBbsTitle() == null || bbs.getBbsContent() == null) {
		
	%>
				<script>
					alert("모두 입력하세요!");
					history.back();
				</script>
				
			<%
			System.out.println("NULL 오류!");
		} else {
			BBSDAO dao = new BBSDAO();
			System.out.println("--------write 하기전 get-------------");
				System.out.println("bbsTitle : "+ bbs.getBbsTitle());
				System.out.println("bbsUserID : "+ userID);
				System.out.println("bbsTitle : "+ bbs.getBbsContent());
				
			int result = dao.write(bbs.getBbsTitle(), userID, bbs.getBbsContent());
			
			System.out.println("--------write 한 후 get-------------");
				System.out.println("bbsTitle : "+ bbs.getBbsTitle());
				System.out.println("bbsUserID : "+ userID);
				System.out.println("bbsTitle : "+ bbs.getBbsContent());
			
				if(result == -1){
			%>
				<script>
					alert("글쓰기에 실패했습니다."); //DB userID가 기본키 중복되면 같은 아이디라는 뜻
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
					System.out.println("아이디 : "+ userID + " 글쓰기성공");
					}
				%>
		<%
			}
		}
		%>

</body>
</html>