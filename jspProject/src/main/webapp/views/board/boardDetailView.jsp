<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="com.kh.board.model.vo.Board"%>
    
<%
	Board b = (Board)request.getAttribute("board");
	//글번호, 카테고리명, 제목, 내용, 작성자, 작성일
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
                    <!--
                        case1 첨주파일이 없을때
                        첨부파일이 없습니다.
                    -->
                    <!--case2첨부파일 있을 때-->
                     <a download="첨부파일1" href="https://www.google.com/imgres?q=%EB%B9%B5%EB%B9%B5%EC%9D%B4&imgurl=https%3A%2F%2Fimage.zdnet.co.kr%2F2023%2F07%2F26%2Ff7981bfffc284d23d6335b1223bd554c.jpg&imgrefurl=https%3A%2F%2Fzdnet.co.kr%2Fview%2F%3Fno%3D20230726144649&docid=Y9uWdIes8zGAMM&tbnid=EE5KD1Eur52l8M&vet=12ahUKEwj0wYG2u6KFAxVZd2wGHbcRDGgQM3oECEcQAA..i&w=557&h=572&hcb=2&ved=2ahUKEwj0wYG2u6KFAxVZd2wGHbcRDGgQM3oECEcQAA">file20230401</a>
                </td>
            </tr>
        </table>
        <br>

        <div align="center">
            <a href="<%=contextPath %>/list.bo?cpage=1" class="btn btn-sm btn-secondary">목록가기</a>
            <%if(loginUser != null && loginUser.getUserId().equals(b.getBoardWriter())) { %>
	            <a href="" class="btn btn-sm btn-warning">수정</a>
	            <a href="" class="btn btn-sm btn-danger">삭제</a>
            <%} %>
        </div>
    </div>
</body>
</html>