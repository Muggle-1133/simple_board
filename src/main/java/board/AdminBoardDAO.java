package board;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

public class AdminBoardDAO {
	private Connection conn;
	private ResultSet rs;
	
	public AdminBoardDAO() {
		try {
			String dbURL = "jdbc:mariadb://localhost:3306/SecureCoding";
			String dbID = "you're id";
			String dbPass = "you're password";
			Class.forName("org.mariadb.jdbc.Driver");
			conn = DriverManager.getConnection(dbURL, dbID, dbPass);
		} catch(Exception e) {
			e.printStackTrace();
		}
	}
	public String getDate() {
		String sql = "SELECT NOW()";
		try {
			PreparedStatement pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				return rs.getString(1);
			}
		} catch(Exception e) {
			e.printStackTrace();
		}
		return ""; // 데이터베이스 오류
	}
	public int getNext() {
		String sql = "SELECT board_idx FROM admin_board ORDER BY board_idx DESC";
		try {
			PreparedStatement pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				return rs.getInt(1) + 1;
			}
			return 1;   // 첫번째 게시글인 경우
		} catch(Exception e) {
			e.printStackTrace();
		}
		return -1;    // 데이터베이스 오류
	}
	public int write(String title, String userID, String content) {
		String sql = "INSERT INTO admin_board VALUES (?, ?, ?, ?, ?, ?)";
		// 시큐어 코딩
		title = title.replaceAll(" ", "&nbsp;").replaceAll(">", "&gt;").replaceAll("\n", "<br>").replaceAll("<", "&lt;");
		content = content.replaceAll(" ", "&nbsp;").replaceAll(">", "&gt;").replaceAll("\n", "<br>").replaceAll("<", "&lt;");
		try {
			PreparedStatement pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, getNext());
			pstmt.setString(2, title);
			pstmt.setString(3, userID);
			pstmt.setString(4, getDate());
			pstmt.setString(5, content);
			pstmt.setInt(6, 1);
			return pstmt.executeUpdate();
		} catch(Exception e) {
			e.printStackTrace();
		}
		return -1;    // 데이터베이스 오류
	}
	public ArrayList<AdminBoard> getList(int pageNumber) {
		String sql = "SELECT * FROM admin_board WHERE board_idx < ? AND available = 1 ORDER BY board_idx DESC LIMIT 10";
		ArrayList<AdminBoard> list = new ArrayList<AdminBoard>();
		try {
			PreparedStatement pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, getNext() - (pageNumber - 1)*10);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				AdminBoard board = new AdminBoard();
				board.setBoard_idx(rs.getInt(1));
				board.setTitle(rs.getString(2));
				board.setUserID(rs.getString(3));
				board.setWriting_date(rs.getString(4));
				board.setContent(rs.getString(5));
				board.setAvailable(rs.getInt(6));
				list.add(board);
			}
		} catch(Exception e) {
			e.printStackTrace();
		}
		return list;
	}
	
	public boolean nextPage(int pageNumber) {
		String SQL = "SELECT * FROM admin_board WHERE board_idx < ? AND available = 1";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, getNext() - (pageNumber-1)*10);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				return true;
			}
		} catch(Exception e) {
			e.printStackTrace();
		}
		return false;
	}
	
	public AdminBoard getBoard(int board_idx) {
		String sql = "SELECT * FROM admin_board WHERE board_idx = ?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, board_idx);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				AdminBoard board = new AdminBoard();
				board.setBoard_idx(rs.getInt(1));
				board.setTitle(rs.getString(2));
				board.setUserID(rs.getString(3));
				board.setWriting_date(rs.getString(4));
				board.setContent(rs.getString(5));
				board.setAvailable(rs.getInt(6));
				return board;
			}
		} catch(Exception e) {
			e.printStackTrace();
		}
		return null;
	}
	
	public int update(int board_idx, String title, String content) {
		String SQL = "UPDATE admin_board SET title = ?, content = ? WHERE board_idx = ?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, title);
			pstmt.setString(2, content);
			pstmt.setInt(3, board_idx);
			return pstmt.executeUpdate();
		} catch(Exception e) {
			e.printStackTrace();
		}
		return -1;	// 데이터베이스 오류
	}
	
	public int delete(int board_idx) {
		String SQL = "DELETE FROM admin_board WHERE board_idx = ?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, board_idx);
			return pstmt.executeUpdate();
		} catch(Exception e) {
			e.printStackTrace();
		}
		return -1;	// 데이터베이스 오류
	}
	
	public ArrayList<AdminBoard> getList2(int pageNumber, String search) {
		String SQL = "SELECT * FROM admin_board WHERE board_idx < ? AND available = 1 AND userID = ? ORDER BY board_idx DESC LIMIT 10";
		ArrayList<AdminBoard> list = new ArrayList<AdminBoard>();
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, getNext() - (pageNumber-1)*10);
			pstmt.setString(2, search);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				AdminBoard board = new AdminBoard();
				board.setBoard_idx(rs.getInt(1));
				board.setTitle(rs.getString(2));
				board.setUserID(rs.getString(3));
				board.setWriting_date(rs.getString(4));
				board.setContent(rs.getString(5));
				board.setAvailable(rs.getInt(6));
				list.add(board);
			}
		} catch(Exception e) {
			e.printStackTrace();
		}
		return list;
	}
}
