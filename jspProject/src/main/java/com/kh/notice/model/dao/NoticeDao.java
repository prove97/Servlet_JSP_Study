package com.kh.notice.model.dao;

import java.io.FileInputStream;
import java.io.IOException;
import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Properties;

import com.kh.notice.model.vo.Notice;
import static com.kh.common.JDBCTemplate.close;

public class NoticeDao {
	private Properties prop = new Properties();

	public NoticeDao() {
		String filePath = NoticeDao.class.getResource("/db/sql/notice-mapper.xml").getPath();
		
		try {
			prop.loadFromXML(new FileInputStream(filePath));			
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
	
	public ArrayList<Notice> selectNoticeList(Connection conn){
		//select -> ResultSet(여러행) -> ArrayList<Notice>
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		ArrayList<Notice> list = new ArrayList<>();
		
		String sql = prop.getProperty("selectNoticeList");
		
		try {
			pstmt = conn.prepareStatement(sql);
			rset = pstmt.executeQuery();
			
			// rest.next() => 다음객체에 값이 있는지 없는지 알 수 있음 / 다음 객체가 비어있을 때까지 반복
			while(rset.next()) {
				System.out.println("가져옴");
				int noticeNo = rset.getInt("notice_no");
				String noticeTitle = rset.getString("notice_title");
				String userId = rset.getString("user_id");
				int count = rset.getInt("count");
				Date createDate = rset.getDate("create_date");
				list.add(new Notice(noticeNo, noticeTitle, userId, count, createDate));
			}
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			close(rset);
			close(pstmt);
		}
		
		return list;
		
	}

}
