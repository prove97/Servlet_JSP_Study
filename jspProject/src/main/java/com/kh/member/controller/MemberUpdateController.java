package com.kh.member.controller;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.kh.member.model.vo.Member;
import com.kh.member.service.MemberService;

/**
 * Servlet implementation class MemberUpdateController
 */
@WebServlet("/update.me")
public class MemberUpdateController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public MemberUpdateController() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		//1) 인코딩
		request.setCharacterEncoding("UTF-8");
		
		//2) 요청시 전달값 추출해서 변수 및 객체 저장
		String userId = request.getParameter("userId"); //"qwer"
		String userName = request.getParameter("userName"); //"홍길동"
		String phone = request.getParameter("phone"); //"010-1111-4444" || ""
		String email = request.getParameter("email"); // qqq@naver.com || ""
		String address = request.getParameter("address"); //서울 관악구 || ""
		String[] interestArr = request.getParameterValues("interest"); //["등산", "영화",...] || null

		//String[] ==> String
		String interest = "";
		if(interestArr != null) {
			interest = String.join(",", interestArr);			
		}
		
		Member m = new Member(userId, userName, phone, email, address, interest);
		
		
		//3) sql요청 => service => dao => sql실행
		 Member updateMem = new MemberService().updateMember(m);
		
		//4) 결과값에 따른 페이지 반환
		if(updateMem != null) { //회원가입 성공
			HttpSession session = request.getSession();
			session.setAttribute("loginUser", updateMem);
			session.setAttribute("alertMsg", "성공적으로 수정하였습니다.");
			
			// url 재요청 => 마이페이지 재요청(/kh/myPage.me)
			response.sendRedirect(request.getContextPath() + "/myPage.me");
			
		} else { //정보변경 실패
			//에러문구가 보여지는 에러페이지
			request.setAttribute("errorMsg", "정보변경에 실패하였습니다.");			
			request.getRequestDispatcher("views/common/errorPage.jsp").forward(request, response);
		}
		
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
