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
	
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception{
		HttpSession session=request.getSession();
		Member loginMember =(Member) session.getAttribute("loginMember");
		if (loginMember == null) {
			FlashMap flashMap=new FlashMap(); //한번 쓰고 버림
			flashMap.put("msg", "로그인 후 접근 가능한 페이지입니다.");
			FlashMapManager manager=RequestContextUtils.getFlashMapManager(request);
			manager.saveOutputFlashMap(flashMap,request,response);
			response.sendRedirect(request.getContextPath()+"/");
			return false;
		} else {
			return true;
		}
	}
}
