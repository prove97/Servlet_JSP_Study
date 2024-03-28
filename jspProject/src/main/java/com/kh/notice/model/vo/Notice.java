package com.kh.notice.model.vo;

import java.sql.Date;

public class Notice {
	private int noticeNo; // 공지사항 번호
	private String noticeTitle; //공지사항 제목
	private String noticeContent; // 공지사항 내용
	private String userId; //작성자 회원번호
	private int count; //조회수
	private Date createDate; //작성일
	private String status; //상태값(Y/N)
	
	public Notice() {
		super();
	}
	
	

	public Notice(int noticeNo, String noticeTitle, String userId, int count, Date createDate) {
		super();
		this.noticeNo = noticeNo;
		this.noticeTitle = noticeTitle;
		this.userId = userId;
		this.count = count;
		this.createDate = createDate;
	}



	public Notice(int noticeNo, String noticeTitle, String noticeContent, String userId, int count, Date createDate,
			String status) {
		super();
		this.noticeNo = noticeNo;
		this.noticeTitle = noticeTitle;
		this.noticeContent = noticeContent;
		this.userId = userId;
		this.count = count;
		this.createDate = createDate;
		this.status = status;
	}


	public int getNoticeNo() {
		return noticeNo;
	}

	public void setNoticeNo(int noticeNo) {
		this.noticeNo = noticeNo;
	}

	public String getNoticeTitle() {
		return noticeTitle;
	}

	public void setNoticeTitle(String noticeTitle) {
		this.noticeTitle = noticeTitle;
	}

	public String getNoticeContent() {
		return noticeContent;
	}

	public void setNoticeContent(String noticeContent) {
		this.noticeContent = noticeContent;
	}

	public String getUserId() {
		return userId;
	}

	public void setUserId(String userId) {
		this.userId = userId;
	}

	public int getCount() {
		return count;
	}

	public void setCount(int count) {
		this.count = count;
	}

	public Date getCreateDate() {
		return createDate;
	}

	public void setCreateDate(Date createDate) {
		this.createDate = createDate;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}






	@Override
	public String toString() {
		return "Notice [noticeNo=" + noticeNo + ", noticeTitle=" + noticeTitle + ", noticeContent=" + noticeContent
				+ ", userId=" + userId + ", count=" + count + ", createDate=" + createDate + ", status=" + status + "]";
	}



	
	
	
	
	
}
