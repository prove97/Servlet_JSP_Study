package com.kh.board.service;

import static com.kh.common.JDBCTemplate.close;
import static com.kh.common.JDBCTemplate.commit;
import static com.kh.common.JDBCTemplate.getConnection;
import static com.kh.common.JDBCTemplate.rollback;

import java.sql.Connection;
import java.util.ArrayList;

import com.kh.board.model.dao.BoardDao;
import com.kh.board.model.vo.Attachment;
import com.kh.board.model.vo.Board;
import com.kh.board.model.vo.Category;
import com.kh.common.vo.PageInfo;

public class BoardService {
	public int selectListCount() {
		Connection conn = getConnection();
		
		int listCount = new BoardDao().selectListCount(conn);
		
		close(conn);
		
		return listCount;
		
	}
	
	public ArrayList<Board> selectList(PageInfo pi){
		Connection conn = getConnection();
		
		ArrayList<Board> list = new BoardDao().selectList(conn, pi);
		
		close(conn);
		return list;
	}
	
	public Board increaseCount(int boardNo) {
		Connection conn = getConnection();
		
		BoardDao bDao = new BoardDao();
		int result = new BoardDao().increaseCount(conn, boardNo);
		
		Board b = null;
		
		if(result > 0) {
			commit(conn);
			//정보조회
			b = bDao.selectBoard(conn, boardNo);
			
		} else {
			rollback(conn);
		}
		
		close(conn);
		
		return b;		
	}
	
	public ArrayList<Category> selectCategoryList(){
		Connection conn = getConnection();
		
		ArrayList<Category> list = new BoardDao().selectCategoryList(conn);
		
		close(conn);
		
		return list;
		
	}
	
	public int insertBoard(Board b, Attachment at) {
		Connection conn = getConnection();
		BoardDao bDao = new BoardDao();
		
		int result1 = new BoardDao().insertBoard(conn, b);
		int result2 = 1;
		
		if(at != null) {
			result2 = bDao.insertAttachment(conn, at);
		}
		
		if(result1 > 0 && result2 > 0) { //성공
			commit(conn);
		} else {
			rollback(conn);
		}
		
		close(conn);
		
		return result1 * result2;
		
	}
	
	public Attachment selectAttachment(int boardNo) {
		Connection conn = getConnection();
		
		Attachment at = new BoardDao().selectAttachment(conn, boardNo);
		

		close(conn);
		
		return at;
		
	}
	
	public Board selectBoard(int boardNo) {
		Connection conn = getConnection();
		
		Board b= new BoardDao().selectBoard(conn, boardNo);
		
		close(conn);
		return b;
	}
	
	public int updateBoard(Board b, Attachment at) {
		Connection conn = getConnection();
		
		BoardDao bDao = new BoardDao();
		int result1 = bDao.updateBoard(conn, b);
		int result2 = 1;
		
		if(at != null) { //새로운 첨부파일이 있을 때
			if(at.getFileNo() != 0) { //기존첨부파일이 있었을 경우 update
				result2 = bDao.updateAttachment(conn, at);
			} else { //기존첨부파일이 없으므로 insert
				result2 = bDao.insertNewAttachment(conn, at);
			}
			
		}
		
		if(result1 > 0 && result2 > 0) {
			commit(conn);
		} else {
			rollback(conn);
		}
		
		close(conn);
		return result1 * result2;
	}
}
