<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/member/findIdPwd.css">
<%-- <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/member/default.css"> --%>

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
			<!-- <ul class="login-top">
					<li class="login-input"><input type="text" placeholder="아이디 입력"></li>
					<li class="login-input"><input type="submit" class="login-btn" value="로그인" style="background-color: #CBB376; border: 1px solid #F3D774;"></li>
			</ul> -->
			<form action="">
				<div class="find-content2">
						<div class="find-id2">
								<ul>
										<li><input type="text" name="userId" placeholder="아이디를 입력해 주세요"></li>
								</ul>
								<ul>
										<li><input type="text" name="phone" placeholder="휴대폰 번호를 입력해 주세요"></li>
								</ul>
								<ul>
										<li><input type="button" value="찾기"></li>
								</ul>
						</div>
				</div>
			</form>
		</div>




















   
   <script type="text/javascript">
		document.querySelector("#userId").addEventListener("keyup", (e) => {
			const ok = document.querySelector(".ok");
			const error = document.querySelector(".error");
			const userId = e.target;
			
			if (userId.value.length < 4) {
				ok.style.display = "none";
				error.style.display = "none";
				return;
			}
			
			
			$.ajax({
				url: "${pageContext.request.contextPath}/member/checkId.do",
				data: {userId: userId.value},
				method: "get",
				dataType: "json",
				success(result) {
					console.log(result);
					const {userId, available} = result; // unpacking 
					
					if (available) {
						ok.style.display = "inline";
						error.style.display = "none";
					} else {
						ok.style.display = "none";
						error.style.display = "inline";
					}
				},
				error: console.log
			});
		});
	
	</script>

<jsp:include page="/WEB-INF/views/common/footer.jsp" />