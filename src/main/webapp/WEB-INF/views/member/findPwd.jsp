<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/member/findIdPwd.css">

<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param value="회원가입" name="title"/>
</jsp:include>


	<!-- 아이디/비밀번호 찾기 -->
    <div class="find-container">
			<div class="find-content">
					<nav class="tab-type1">
							<ul class="find-id">
									<li><a href="${pageContext.request.contextPath}/member/findId.me">아이디 찾기</a></li>
									<li><a href="${pageContext.request.contextPath}/member/findPwd.me"  class="tab-on">비밀번호 찾기</a></li>
							</ul>
					</nav>
			</div>
			<form action="${pageContext.request.contextPath}/member/authPwd.me" method="post">
				<div class="find-content2">
						<div class="find-id2">
								<ul>
										<li><input type="text" name="userId" id="userId" class="find-input" placeholder="아이디를 입력해 주세요" required=""></li>
								</ul>
								<ul>
										<li><input type="email" name="email" id="email" class="find-input" placeholder="이메일 주소를 입력해 주세요" required="/^[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*\.[a-zA-Z]{2,3}$/i"></li>
								</ul>
								<ul>
										<li><input class="find-btn" type="submit" id="pwdCheck" value="찾기"></li>
								</ul>
						</div>
				</div>
			</form>
		</div>

<jsp:include page="/WEB-INF/views/common/footer.jsp" />