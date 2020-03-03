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
		String bbsTitle = request.getParameter("bbsTitle");
		String bbsContent = request.getParameter("bbsContent");
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
			if(bbsTitle == null || bbsContent == null
					|| bbsTitle == "" || bbsContent == "") {
			%>
				<script>
					alert("모두 입력하세요!");
					history.back();
				</script>
				
			<%
			System.out.println("NULL 오류!");
		} else {
			BBSDAO dao = new BBSDAO();
			System.out.println("--------update 하기전 get-------------");
				System.out.println("bbsTitle : "+ bbs.getBbsTitle());
				System.out.println("bbsUserID : "+ userID);
				System.out.println("bbsTitle : "+ bbs.getBbsContent());
				
			int result = dao.update(bbsID, bbsTitle, bbsContent);
			
			System.out.println("--------update 한 후 get-------------");
				System.out.println("bbsTitle : "+ bbs.getBbsTitle());
				System.out.println("bbsUserID : "+ userID);
				System.out.println("bbsTitle : "+ bbs.getBbsContent());
			
				if(result == -1){
			%>
				<script>
					alert("수정에 실패했습니다."); //DB userID가 기본키 중복되면 같은 아이디라는 뜻
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
					System.out.println("아이디 : "+ userID + " 글수정성공");
					}
				%>
		<%
			}
		}
		%>

</body>
</html>