package board;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

public class BoardDAO {
	private Connection conn;
	private ResultSet rs;
	
	public BoardDAO() {
		try {
			String dbURL = "jdbc:mariadb://localhost:3306/SecureCoding";
			String dbID = "root";
			String dbPass = "ycdc2021!";
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
		String sql = "SELECT board_idx FROM board ORDER BY board_idx DESC";
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
	
	public int write(String title, String userID, String content, String uploadFile) {
		String sql = "INSERT INTO board VALUES (?, ?, ?, ?, ?, ?, ?)";
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
			pstmt.setString(7, uploadFile);
			return pstmt.executeUpdate();
		} catch(Exception e) {
			e.printStackTrace();
		}
		return -1;    // 데이터베이스 오류
	}
	
	public ArrayList<Board> getList(int pageNumber) {
		String sql = "SELECT * FROM board WHERE board_idx < ? AND available = 1 ORDER BY board_idx DESC LIMIT 10";
		ArrayList<Board> list = new ArrayList<Board>();
		try {
			PreparedStatement pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, getNext() - (pageNumber - 1)*10);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				Board board = new Board();
				board.setBoard_idx(rs.getInt(1));
				board.setTitle(rs.getString(2));
				board.setUserID(rs.getString(3));
				board.setBoard_date(rs.getString(4));
				board.setContent(rs.getString(5));
				board.setAvailable(rs.getInt(6));
				board.setUploadFile(rs.getString(7));
				list.add(board);
			}
		} catch(Exception e) {
			e.printStackTrace();
		}
		return list;
	}
	
	public boolean nextPage(int pageNumber) {
		String SQL = "SELECT * FROM board WHERE board_idx < ? AND available = 1";
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
	
	public Board getBoard(int board_idx) {
		String sql = "SELECT * FROM board WHERE board_idx = ?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, board_idx);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				Board board = new Board();
				board.setBoard_idx(rs.getInt(1));
				board.setTitle(rs.getString(2));
				board.setUserID(rs.getString(3));
				board.setBoard_date(rs.getString(4));
				board.setContent(rs.getString(5));
				board.setAvailable(rs.getInt(6));
				board.setUploadFile(rs.getString(7));
				return board;
			}
		} catch(Exception e) {
			e.printStackTrace();
		}
		return null;
	}
	
	public int update(int board_idx, String title, String content, String uploadFile) {
		String SQL = "UPDATE board SET title = ?, content = ?, uploadFile = ? WHERE board_idx = ?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, title);
			pstmt.setString(2, content);
			pstmt.setString(3, uploadFile);
			pstmt.setInt(4, board_idx);
			
			return pstmt.executeUpdate();
		} catch(Exception e) {
			e.printStackTrace();
		}
		return -1;	// 데이터베이스 오류
	}
	
	public int delete(int board_idx) {
		String SQL = "DELETE FROM board WHERE board_idx = ?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, board_idx);
			return pstmt.executeUpdate();
		} catch(Exception e) {
			e.printStackTrace();
		}
		return -1;	// 데이터베이스 오류
	}
	
	public ArrayList<Board> getList2(int pageNumber, String search) {
		String SQL = "SELECT * FROM board WHERE board_idx < ? AND available = 1 AND userID = ? ORDER BY board_idx DESC LIMIT 10";
		ArrayList<Board> list = new ArrayList<Board>();
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, getNext() - (pageNumber-1)*10);
			pstmt.setString(2, search);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				Board board = new Board();
				board.setBoard_idx(rs.getInt(1));
				board.setTitle(rs.getString(2));
				board.setUserID(rs.getString(3));
				board.setBoard_date(rs.getString(4));
				board.setContent(rs.getString(5));
				board.setAvailable(rs.getInt(6));
				board.setUploadFile(rs.getString(7));
				list.add(board);
			}
		} catch(Exception e) {
			e.printStackTrace();
		}
		return list;
	}
	
	public ArrayList<Board> getSearch(String searchField, String searchText) {
		ArrayList<Board> list = new ArrayList<Board>();
		String sql = "SELECT * FROM board WHERE " + searchField.trim();
		try {
			if(searchText != null && !searchText.equals("")) {
				sql += " LIKE '%" + searchText.trim() + "%' ORDER BY board_idx DESC LIMIT 10";
			}
			PreparedStatement pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				Board board = new Board();
				board.setBoard_idx(rs.getInt(1));
				board.setTitle(rs.getString(2));
				board.setUserID(rs.getString(3));
				board.setBoard_date(rs.getString(4));
				board.setContent(rs.getString(5));
				board.setAvailable(rs.getInt(6));
				board.setUploadFile(rs.getString(7));
				list.add(board);
			}
		} catch(Exception e) {
			e.printStackTrace();
		}
		return list;
	}
	public ArrayList<Board> getMyWriting(String userID) {
		ArrayList<Board> list = new ArrayList<Board>();
		
		String sql = "SELECT * FROM board WHERE userID = ? ORDER BY board_idx DESC LIMIT 10";
		try {
			PreparedStatement pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, userID);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				Board board = new Board();
				board.setBoard_idx(rs.getInt(1));
				board.setTitle(rs.getString(2));
				board.setUserID(rs.getString(3));
				board.setBoard_date(rs.getString(4));
				board.setContent(rs.getString(5));
				board.setAvailable(rs.getInt(6));
				board.setUploadFile(rs.getString(7));
				list.add(board);
			}
		} catch(Exception e) {
			e.printStackTrace();
		}
		return list;
	}
}
