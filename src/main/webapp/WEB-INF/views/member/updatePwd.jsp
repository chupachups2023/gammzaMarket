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
									<li><a href="${pageContext.request.contextPath}/member/findPwd.me"  class="tab-on">비밀번호 찾기</a></li>
									<li><a href="${pageContext.request.contextPath}/member/findId.me">새로운 비밀번호 설정</a></li>
							</ul>
					</nav>
			</div>
			<form action="${pageContext.request.contextPath}/" method="post">
				<div class="find-content2">
						<div class="find-id2">
								<ul>
										<li><input type="password" name=""  id="" placeholder="새로운 비밀번호를 입력해 주세요"></li>
								</ul>
								<ul>
										<li><input type="password" name="" id="" placeholder="한번 더 입력해 주세요"></li>
								</ul>
								<ul>
										<li><input type="button" value="찾기" onclick=""></li>
								</ul>
						</div>
				</div>
			</form>
		</div>

















<jsp:include page="/WEB-INF/views/common/footer.jsp" />