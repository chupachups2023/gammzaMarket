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
<%@ include file="findPwdModal.jsp" %>


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
										<li><input type="text" name="userId"  id="userId" placeholder="아이디를 입력해 주세요" required=""></li>
								</ul>
								<ul>
										<li><input type="email" name="email" id="email" placeholder="이메일 주소를 입력해 주세요" required="/^[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*\.[a-zA-Z]{2,3}$/i"></li>
										<!-- <input type="text" name="phone" id="phone" placeholder="휴대폰 번호를 입력해 주세요" required="/^01([0|1|6|7|8|9])-?([0-9]{3,4})-?([0-9]{4})$/"> -->
								</ul>
								<ul>
										<li><input type="submit" id="pwdCheck" value="찾기"></li>
										<!-- onclick="findPwdClick();" -->
								</ul>
						</div>
				</div>
			</form>
		</div>


	<!-- <script>
	// 비밀번호 찾기
	function findPwdClick(){
		var userId = $('#userId').val()
		var phone = $('#phone').val()
		
		$.ajax({
			url: "${pageContext.request.contextPath}/member/findPwd.me",
			type: "post",
			data: { "phone" : phone, "userId" : userId },
			success: function(data) {
				if (data == 0) {
					$('#idValue').text("회원 정보를 찾을 수 없습니다.");
					$('#userId').val('');
					$('#phone').val('');
				} else {
					$('#idValue').text(data);
					$('#userId').val('');
					$('#phone').val('');
					
				}
			},
			 error: function() {
				 alert("error");
			}
		});
	
	};

	const modal1 = document.getElementById("modal1")
	const btnModal1 = document.getElementById("findId")

	btnModal1.addEventListener("click", e => {
	    modal1.style.display = "flex"
	})

	    
	const closeBtn1 = modal1.querySelector(".close-area1")
	closeBtn1.addEventListener("click", e => {
	    modal1.style.display = "none"
	})

	modal1.addEventListener("click", e => {
	    const evTarget = e.target
	    if (evTarget.classList.contains("modal1-overlay")) {
	        modal1.style.display = "none"
	    }
	})
	
	</script> -->


   

<jsp:include page="/WEB-INF/views/common/footer.jsp" />