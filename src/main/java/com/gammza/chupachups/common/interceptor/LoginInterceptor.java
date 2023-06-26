package com.gammza.chupachups.common.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.web.servlet.FlashMap;
import org.springframework.web.servlet.FlashMapManager;
import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.support.RequestContextUtils;

import com.gammza.chupachups.member.model.vo.Member;

public class LoginInterceptor implements HandlerInterceptor{
	
	/*
	  	- Interceptor(HandlerInterceptor)
	  해당 controller가 실행되기 전, 실행된 후에 낚아채서 실행할 내용을 작성
	  보통 로그인 유무 판단, 회원 권한 체크
	  preHandle(전처리): Dispatcherservlet이 컨트롤러를 호출하기 전에 낚아 채는 영역
	  postHandle(후처리): 컨트롤러 요청 처리 후 Dispatcherservlet으로 뷰 정보가 리턴되는 순간 낚아채는 영역
	 */
	
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception{
		//true 리턴시 => 기존 요청 흐름대로 해당 controller를 실행
		//false 리턴시 => controller 실행되지 않음
		HttpSession session=request.getSession();
		Member loginUser=(Member)session.getAttribute("loginUser");
		if(loginUser == null) {
			FlashMap flashMap=new FlashMap(); //한번 쓰고 버림
			flashMap.put("msg", "로그인 후 접근 가능한 페이지입니다.");
			FlashMapManager manager=RequestContextUtils.getFlashMapManager(request);
			manager.saveOutputFlashMap(flashMap,request,response);
			response.sendRedirect(request.getContextPath()+"/");
			return false;
		}else {
			return true;
		}
	}
}
