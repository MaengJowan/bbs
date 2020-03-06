package bbs;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

public class BBSDAO {
	private Connection con;

	private ResultSet rs;
	
	public BBSDAO() {
		try {
			
			String url = "jdbc:mysql://localhost/qleksqnddj33?characterEncoding=UTF-8&serverTimezone=UTC";	
			String id =  "qleksqnddj33";
			String pw =  "z617166@";
			
			Class.forName("com.mysql.jdbc.Driver");
			
			con = DriverManager.getConnection(url, id, pw);
			
		}catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}
	}
	
	public String getDate() {
		String query="SELECT NOW()";
		
		try {
			PreparedStatement pstmt = con.prepareStatement(query);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				return rs.getString(1);
			}
		} catch(Exception e) {
			e.printStackTrace();
		}
		return "";
	}
	
	public int getNext() {
		String query="SELECT bbsID FROM BBS order by bbsID DESC";
		
		try {
			PreparedStatement pstmt = con.prepareStatement(query);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				return rs.getInt(1) + 1;
			}
			return 1; //첫 번째 게시물인 경우
		} catch(Exception e) {
			e.printStackTrace();
		}
		return -1; //db 오류

	}
	
	public int write(String bbsTitle, String userID, String bbsContent) {
		String query="INSERT INTO BBS VALUES (?, ?, ?, ?, ?, ?)";
		
		try {
			PreparedStatement pstmt = con.prepareStatement(query);
			pstmt.setInt(1, getNext());
			pstmt.setString(2, bbsTitle);
			pstmt.setString(3, userID);
			pstmt.setString(4, getDate());
			pstmt.setString(5, bbsContent);
			pstmt.setInt(6, 1);
			
			System.out.println("글번호 : " + getNext());
			System.out.println("글제목 : " + bbsTitle);
			System.out.println("글쓴이 : " + userID);
			System.out.println("글날짜 : " + getDate());
			System.out.println("글내용 : " + bbsContent);
			
			return pstmt.executeUpdate(); //성공인경우 0이상인 것을 반환
		} catch(Exception e) {
			e.printStackTrace();
		}
		return -1; //db 오류
	}
	
	public ArrayList<BBS> getList(int pageNumber){
		String query="SELECT * FROM BBS WHERE bbsID < ? AND bbsAvailable = 1 order by bbsID desc limit 10";
		ArrayList<BBS> list = new ArrayList<BBS>();
		try {
			PreparedStatement pstmt = con.prepareStatement(query);
			pstmt.setInt(1, getNext() - (pageNumber - 1) * 10); //게시글이 5개 일 때, getNext() = 5, pageNUmber = 1
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				BBS bbs = new BBS();
				bbs.setBbsID(rs.getInt(1));
				bbs.setBbsTitle(rs.getString(2));
				bbs.setUserID(rs.getString(3));
				bbs.setBbsDate(rs.getString(4));
				bbs.setBbsContent(rs.getString(5));
				bbs.setBbsAvailable(rs.getInt(6));
				
				list.add(bbs);
			}
		} catch(Exception e) {
			e.printStackTrace();
		}
		return list; //db 오류
	}
	
	public boolean nextPage(int pageNumber) {
		String query="SELECT * FROM BBS WHERE bbsID < ? AND bbsAvailable = 1";
		try {
			PreparedStatement pstmt = con.prepareStatement(query);
			pstmt.setInt(1, getNext() - (pageNumber - 1) * 10); //게시글이 5개 일 때, getNext() = 5, pageNUmber = 1
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				return true;
			}
		} catch(Exception e) {
			e.printStackTrace();
		}
		return false; //다음 페이지 게시글 없음
	}
	
	public BBS getBbs(int bbsID) {
		String query="SELECT * FROM BBS WHERE bbsId = ?";
		
		try {
			PreparedStatement pstmt = con.prepareStatement(query);
			pstmt.setInt(1, bbsID);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				BBS bbs = new BBS();
				bbs.setBbsID(rs.getInt(1));
				bbs.setBbsTitle(rs.getString(2));
				bbs.setUserID(rs.getString(3));
				bbs.setBbsDate(rs.getString(4));
				bbs.setBbsContent(rs.getString(5));
				bbs.setBbsAvailable(rs.getInt(6));
				
				return bbs;
			}
		} catch(Exception e) {
			e.printStackTrace();
		}
		return null; //db 오류
	}
	
	public int update(int bbsID, String bbsTitle, String bbsContent) {
			String query="UPDATE BBS SET bbsTitle = ?, bbsContent = ? WHERE bbsID = ?";
		
		try {
			PreparedStatement pstmt = con.prepareStatement(query);
			pstmt.setString(1, bbsTitle);
			pstmt.setString(2, bbsContent);
			pstmt.setInt(3, bbsID);			
			
			return pstmt.executeUpdate(); //성공인경우 0이상인 것을 반환
			
		} catch(Exception e) {
			e.printStackTrace();
		}
		return -1; //db 오류
	}
	
	public int delete(int bbsID) {
String query="UPDATE BBS SET bbsAvailable = 0 WHERE bbsID = ?";
		
		try {
			PreparedStatement pstmt = con.prepareStatement(query);
			pstmt.setInt(1, bbsID);			
			
			return pstmt.executeUpdate(); //성공인경우 0이상인 것을 반환
			
		} catch(Exception e) {
			e.printStackTrace();
		}
		return -1; //db 오류
	}
	
}
