package user;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class UserDAO {
	private Connection conn;
	private PreparedStatement pstmt;
	private ResultSet rs;
	
	public UserDAO() {
		try {
			String dbURL = "jdbc:mariadb://localhost:3306/SecureCoding";
			String dbID = "you're id";
			String dbPassword = "you're password";
			Class.forName("org.mariadb.jdbc.Driver");
			conn = DriverManager.getConnection(dbURL, dbID, dbPassword);
			
		}catch(Exception e){
			e.printStackTrace();
		}
	}
	
	public int login(String userID, String userPassword) {
		String sql = "SELECT userPassword FROM user WHERE userID = ?";
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, userID);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				if(rs.getString(1).equals(userPassword)) {
					return 1;	// 로그인 성공
				}
				else {
					return 0;	// 비밀번호 불일치
				}
			}
			return -1;	// 아이디가 없음
		} catch(Exception e) {
			e.printStackTrace();
		}
		return -2;	// 데이터베이스 오류
	}
	
	public int SignUp(User user) {
		String sql = "insert into user values(?, ?, ?)";
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, user.getUserID());
			pstmt.setString(2, user.getUserPassword());
			pstmt.setString(3, user.getUserEmail());
			return pstmt.executeUpdate();
		} catch(Exception e) {
			e.printStackTrace();
		}
		return -1;	// 데이터베이스 오류	
	}
	
	public int check_id(String userID) {
		String sql = "select * from user where userID = ?";
		int idCheck = 0;
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, userID);
			
			rs = pstmt.executeQuery();
			if(rs.next() || userID.equals("")) {
				idCheck = 0;	// 이미 존재하는 아이디, 사용 불가
			}
			else {
				idCheck = 1;	// 존재하지 않는 아이디, 사용 가능
			}
			
		} catch(Exception e) {
			e.printStackTrace();
		}
		
		return idCheck;
	}
	
	public int update(String userID, User user) {
		String sql = "update user set userPassword = ?, userEmail = ? where userID = ?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, user.getUserPassword());
			pstmt.setString(2, user.getUserEmail());
			pstmt.setString(3, userID);
			return pstmt.executeUpdate();
		} catch(Exception e) {
			e.printStackTrace();
		}
		return -1;	// 데이터베이스 오류
	}
}
