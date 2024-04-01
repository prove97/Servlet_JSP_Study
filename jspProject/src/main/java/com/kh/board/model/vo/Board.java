package com.kh.board.model.vo;

import java.sql.Date;

public class Board {
	private int boardNo;
	private int boardType;
	private int categoryNo; // 작성기능 사용시 => 카테고리 번호 | 조회 카테고리명
	private String boardTitle;
	private String boardContent;
	private String boardWriter; // 작성기능시 회원번호 | 조회기능 회원아이디
	private int count;
	private String createDate;
	private String status;
	
	public Board(int boardNo, int boardType, int categoryNo, String boardTitle, String boardContent, String boardWriter,
			int count, String createDate, String status) {
		super();
		this.boardNo = boardNo;
		this.boardType = boardType;
		this.categoryNo = categoryNo;
		this.boardTitle = boardTitle;
		this.boardContent = boardContent;
		this.boardWriter = boardWriter;
		this.count = count;
		this.createDate = createDate;
		this.status = status;
	}
	
	public int getBoardNo() {
		return boardNo;
	}
	
	public void setBoardNo(int boardNo) {
		this.boardNo = boardNo;
	}
	
	public int getBoardType() {
		return boardType;
	}
	
	public void setBoardType(int boardType) {
		this.boardType = boardType;
	}
	
	public int getCategoryNo() {
		return categoryNo;
	}
	
	public void setCategoryNo(int categoryNo) {
		this.categoryNo = categoryNo;
	}
	
	public String getBoardTitle() {
		return boardTitle;
	}
	
	public void setBoardTitle(String boardTitle) {
		this.boardTitle = boardTitle;
	}
	
	public String getBoardContent() {
		return boardContent;
	}
	
	public void setBoardContent(String boardContent) {
		this.boardContent = boardContent;
	}
	
	public String getBoardWriter() {
		return boardWriter;
	}
	
	public void setBoardWriter(String boardWriter) {
		this.boardWriter = boardWriter;
	}
	
	public int getCount() {
		return count;
	}

	public void setCount(int count) {
		this.count = count;
	}
	
	public String getCreateDate() {
		return createDate;
	}
	
	public void setCreateDate(String createDate) {
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
		return "Board [boardNo=" + boardNo + ", boardType=" + boardType + ", categoryNo=" + categoryNo + ", boardTitle="
				+ boardTitle + ", boardContent=" + boardContent + ", boardWriter=" + boardWriter + ", count=" + count
				+ ", createDate=" + createDate + ", status=" + status + "]";
	}
	
	

	
}
