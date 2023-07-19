<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/member/findIdPwd.css">

<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param value="회원가입" name="title"/>
</jsp:include>

	<!-- 새로운 비밀번호 설정 -->
    <div class="find-container">
			<div class="find-content">
					<nav class="tab-type1">
							<ul class="find-id">
									<li><a href="#" class="tab-on">새로운 비밀번호 설정</a></li>
							</ul>
					</nav>
			</div>
			<form action="${pageContext.request.contextPath}/member/updatePwd.me" method="post">
				<div class="find-content2">
						<div class="find-id2">
								<ul>
										<li><input type="password" name="userPwdNew"  id="userPwdNew" class="find-input" placeholder="새로운 비밀번호 입력"></li>
								</ul>
								<ul>
										<li><input type="password" id="userPwdNewChk" class="find-input" placeholder="새로운 비밀번호 확인"></li>
								</ul>
								<ul>
										<li><input type="submit" id="pwdCheck" class="find-btn" value="변경"></li>
								</ul>
						</div>
				</div>
			</form>
		</div>

<jsp:include page="/WEB-INF/views/common/footer.jsp" />