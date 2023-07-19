<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/member/findIdPwd.css">

<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param value="회원가입" name="title"/>
</jsp:include>

	<!-- 비밀번호 찾기(인증번호 입력 -->
    <div class="find-container">
			<div class="find-content">
					<nav class="tab-type1">
							<ul class="find-id">
									<li><a href="#"  class="tab-on">비밀번호 찾기</a></li>
							</ul>
					</nav>
			</div>
			<form action="${pageContext.request.contextPath}/member/setPwd.me" method="post">
				<input type="hidden" name="num" value="${num}"> 
				<!-- 생성한 랜덤값과 사용자가 입력한 값이 동일한지 확인 -->
				<div class="find-content2">
						<div class="find-id2">
								<ul>
										<li><input type="text" name="emailAuth" class="find-input" placeholder="인증번호를 입력해 주세요"></li>
								</ul>
								<ul>
										<li><input type="submit" id="pwdCheck" class="find-btn" value="확인"></li>
								</ul>
						</div>
				</div>
			</form>
		</div>
		
<jsp:include page="/WEB-INF/views/common/footer.jsp" />