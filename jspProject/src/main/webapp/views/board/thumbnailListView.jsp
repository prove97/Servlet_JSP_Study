<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.util.ArrayList, com.kh.board.model.vo.Board"%>
<%
    ArrayList<Board> list = (ArrayList<Board>)request.getAttribute("list");
%>
    <!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
    .outer{
        background: black;
        color: white;
        height: auto;
        margin: auto;
        margin-top: 50px;
    }

    .list-area{
        max-width: 850px;
        margin: auto;
    }

    .thumbnail{
        display: inline-block;
        border: 1px solid white;
        padding: 12px;
        margin: 14px;
        width: 226px;
    }

    .thumbnail:hover{
        cursor: pointer;
        opacity: 0.7;
    }

    .thumbnail p > span{
        display: inline-block;
        width: 220px;
        text-overflow: ellipsis;
        white-space: nowrap;
        overflow: hidden;
    }

</style>
</head>
<body>
    <%@ include file="../common/menubar.jsp"%>

    <div class="outer">
        <br>
        <h2 align="center">사진게시판</h2>
        <br>
        
        <% if(loginUser != null){%>
            <!-- 현재 로그인한 사용자가 관리자일 때-->
            <div align="right" style="width: 850px; margin:auto; margin-bottom: 4px;">
                <a href="<%=contextPath %>/enrollForm.th" class="btn btn-sm btn-secondary">글쓰기</a>
            </div>
        <%}%>    

        <div class="list-area">
        	<%for(Board b : list) { %>
            <div class="thumbnail" align="center">
                <input type="hidden" value="<%=b.getBoardNo()%>">
                <img src="<%=contextPath %>/<%=b.getTitleImg() %>" alt="썸네일" width="200px" height="150px">
                <p>
                    <span>No. <%=b.getBoardNo() %> <%=b.getBoardTitle() %></span><br>
                    조회수 : <%=b.getCount() %>
                </p>
            </div>
            <%} %>
        </div>


    </div>
    
    <script>
    	$(function(){
    		$(".thumbnail").click(function(){
    			location.href = "<%=contextPath%>/detail.th?bno=" + $(this).children().eq(0).val();
            })
    	})
    </script>
</body>
</html>