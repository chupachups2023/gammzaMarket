<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!-- <script	src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.3/jquery.min.js"></script> -->
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/css/member/memberEnroll.css?<%=System.currentTimeMillis() %>">
<script src="${pageContext.request.contextPath}/resources/js/memeber/insertMember.js?<%=System.currentTimeMillis() %>"></script>

<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param value="회원추가" name="title" />
</jsp:include>

<div class="enroll-title">
	<h1>회원추가</h1>
</div>
<div class="enroll-container">
	<form action="${pageContext.request.contextPath}/member/memberEnroll.me" method="post" name="enrollfrm">
		<div class="container1">
			<div class="container2">
				<table class="enroll-section">
					<tr>
						<td scope="col" class="add"><input name="userId" id="userId" placeholder="아이디 입력"></td>
					</tr>
					<tr>
						<td scope="col" class="add" colspan="2"><input
							type="password" name="userPwd" id="userPwd" placeholder="비밀번호 입력">
							<!-- 영문, 숫자, 특수문자 포함 8~20자리 --></td>
					</tr>
					<tr>
						<td scope="col" class="add" colspan="2"><input
							type="password" name="userPwdChk" id="userPwdChk"
							placeholder="비밀번호 다시 입력"></td>
					</tr>
					<tr>
						<td><span style="font-size: 12px;"><em>*아이디는
									4~12자의 영문 소문자와 숫자만 사용 가능</em></span><br> <span
							style="font-size: 12px;"><em>*비밀번호는 영문, 숫자, 특수문자 포함
									8~20자리로 입력</em></span><br></td>
					</tr>

					<tr>
						<td scope="col" class="add" colspan="2"><span
							class="guide ok">멋진 아이디네요!</span> <span class="guide error">사용할
								수 없는 아이디입니다.</span></td>
					</tr>


				</table>
			</div>
			<div class="container3">
				<table class="enroll-section">
					<tr>
						<td scope="col" class="add"><input name="name" id="name"
							placeholder="이름 입력"></td>
					</tr>
					<tr>
						<td scope="col" class="add"><input name="phone" id="phone"
							placeholder="휴대폰번호 입력 (ex. 010-1234-5678)"></td>
					</tr>
					<tr>
						<td scope="col" class="add"><input name="email" id="email"
							placeholder="이메일 입력 (ex. example@example.com)"></td>
					</tr>
					<tr>
						<td scope="col" class="add"><input name="birthday"
							id="birthday" placeholder="생년월일 8자리 입력 (ex. 2023-01-01)">
						</td>
					</tr>
				</table>
			</div>
			<div class="table1">
				<button type="button" class="bo" onclick="validation_Ad();">회원추가</button>
				&emsp;
				<button type="reset" class="bo">초기화</button>
				&emsp;
				<button type="button" class="bo" onclick="location.href='${pageContext.request.contextPath}/member/memberList.do'">뒤로가기</button>
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
	        url: "${pageContext.request.contextPath}/member/checkId.me",
	        data: {userId: userId.value},
	        method: "get",
	        dataType: "json",
	        success(result) {
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
	
	function insertMember(){
	    var uid = document.getElementById("userId");
	    var pw = document.getElementById("userPwd");
	    var pwc = document.getElementById("userPwdChk");
	    var uname = document.getElementById("name");
	    var phone = document.getElementById("phone");
	    var email = document.getElementById("email");
	    var birthday = document.getElementById("birthday");
	     $.ajax({
	         url: "${pageContext.request.contextPath}/member/insertMember_Ad.do",
	         type: "post",
	         data: {
	             userId : uid.value,
	             userPwd : pw.value,
	             name : uname.value,
	             phone : phone.value,
	             email : email.value,
	             birthday:birthday.value
	         },
	         success: function(result) {
	             if(result > 0){ 
	                 alert("회원이 추가되었습니다.");
	                 enrollfrm.reset();
	              }else {
	                 alert("회원추가 실패");
	             } 
	         },
	         error: function() {
	             console.log("통신실패");
	         }
	     }); 
	}
</script>

<jsp:include page="/WEB-INF/views/common/footer.jsp" />