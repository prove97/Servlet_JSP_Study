<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="com.kh.board.model.vo.Board, com.kh.board.model.vo.Attachment"%>
<!-- Attachment 객체는 common 폴더에 넣는걸 추천 -->    
<%
	Board b = (Board)request.getAttribute("board");
	//글번호, 카테고리명, 제목, 내용, 작성자, 작성일
	
	Attachment at = (Attachment)request.getAttribute("attachment");
	//없을 수도 있다. null
	//있다면 파일번호, 원본명, 수정명, 저장경로
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
    .outer {
        background: black;
        color: white;
        width: 1000px;
        height: 500px;
        margin: auto;
        margin-top: 50px;
    }

    .outer table {
        border: 1px solid white;
        border-collapse: collapse;
    }

    .outer > table tr, .outer > table td{
        border: 1px solid white;
    }

</style>
</head>
<body>
    <%@ include file="../common/menubar.jsp"%>
    <div class="outer">
        <br>
        <h2 align="center">일반게시판 상세보기</h2>
        <br>

        <table id="detail.area" border="1", align="center">
            <tr>
                <th width="70">카테고리</th>
                <td width="70"><%=b.getCategory() %></td>
                <th width="70">제목</th>
                <td width="350"><%=b.getBoardTitle() %></td>
            </tr>
            <tr>
                <th>작성자</th>
                <td><%=b.getBoardWriter() %></td>
                <th>작성일</th>
                <td><%=b.getCreateDate() %></td>                
            </tr>
            <tr>
                <th>내용</th>
                <td colspan="3">
                    <p style="height: 200px;"><%=b.getBoardContent() %></p>
                </td>
            </tr>
            <tr>
                <th>첨부파일</th>
                <td colspan="3">
                <%if(at == null){ %>
                    <!-- case1 첨주파일이 없을때 -->
                	첨부파일이 없습니다.
                <%} else{%> 
                    <!--case2첨부파일 있을 때 8001/kh/resources/board_upfile/-->
                     <a download="<%=at.getOriginName() %>" href="<%=contextPath%>/<%=at.getFilePath() + at.getChangeName()%>"><%=at.getOriginName() %></a>
                <%} %>
                </td>
            </tr>
        </table>
        <br>

        <div align="center">
            <a href="<%=contextPath %>/list.bo?cpage=1" class="btn btn-sm btn-secondary">목록가기</a>
            <%if(loginUser != null && loginUser.getUserId().equals(b.getBoardWriter())) { %>
	            <a href="<%=contextPath %>/updateForm.bo?bno=<%=b.getBoardNo() %>" class="btn btn-sm btn-warning">수정하기</a>
	            <a href="<%=contextPath %>/delete.bo?bno=<%=b.getBoardNo() %>" class="btn btn-sm btn-danger">삭제하기</a>
            <%} %>
        </div>
    </div>
</body>
</html>