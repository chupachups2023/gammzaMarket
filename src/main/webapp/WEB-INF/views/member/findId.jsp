<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/member/findIdPwd.css">

<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param value="회원가입" name="title"/>
</jsp:include>
<%@ include file="findIdModal.jsp" %>

	<!-- 아이디/비밀번호 찾기 -->
    <div class="find-container">
			<div class="find-content">
					<nav class="tab-type1">
							<ul class="find-id">
									<li><a href="${pageContext.request.contextPath}/member/findId.me" class="tab-on">아이디 찾기</a></li>
									<li><a href="${pageContext.request.contextPath}/member/findPwd.me" >비밀번호 찾기</a></li>
							</ul>
					</nav>
			</div>
			<form action="${pageContext.request.contextPath}/member/findId.me" method="post" name="findfrm">
				<div class="find-content2">
						<div class="find-id2">
								<ul>
										<li><input type="text" name="phone" id="phone" class="find-input" placeholder="휴대폰 번호를 입력해 주세요"></li>
								</ul>
								<ul>
										<li><input type="button" id="findId" value="찾기" class="find-btn" onclick="findIdClick();"></li>
								</ul>
						</div>
				</div>
			</form>
		</div>

		<script>
			// 아이디 찾기
			function findIdClick(){
				var phone = $('#phone').val()
				
				$.ajax({
					url: "${pageContext.request.contextPath}/member/findId.me",
					type: "post",
					data: { "phone" : phone },
					success: function(data) {
						if (data == 0) {
							$('#idValue').text("일치하는 아이디가 없습니다.");
							$('#phone').val('');
						} else {
							$('#idValue').text(data);
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
		</script>

   
<jsp:include page="/WEB-INF/views/common/footer.jsp" />