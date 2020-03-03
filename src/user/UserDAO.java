package user;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class UserDAO {
	private Connection con;
	private PreparedStatement pstmt;
	private ResultSet rs;
	
	public UserDAO() {
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
	
	public int login (String userId, String userPw) {
		String query = "SELECT userPassword FROM USER WHERE userID = ?";
		
		try {
			pstmt = con.prepareStatement(query);
			pstmt.setString(1, userId);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				if(rs.getString(1).equals(userPw)) {
					System.out.println("로그인 성공!");
					return 1; //login success
				}
				else {
					System.out.println("비밀번호 오류!");
					return 0; //incorrect pw
				}
					
			} else {
				System.out.println("아이디가 없습니다");
				return -1; // no id
			}
		}catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		} 
		return -2; //db error;
	}
	
	public int join(User user) {
		String query="INSERT INTO USER VALUES(?, ?, ?, ?, ?)";
		
		try {
			pstmt = con.prepareStatement(query);
			pstmt.setString(1, user.getUserID());
			pstmt.setString(2, user.getUserPassword());
			pstmt.setString(3, user.getUserName());
			pstmt.setString(4, user.getUserGender());
			pstmt.setString(5, user.getUserEmail());
			
			return pstmt.executeUpdate();

		} catch(Exception e) {
			e.printStackTrace();
		} return -1;
	}
	
	
}
