<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!-- <script	src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.3/jquery.min.js"></script> -->
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/member/memberEnroll.css">

<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param value="회원가입" name="title"/>
</jsp:include>

<div class="enroll-title">
    <h1>회원가입</h1>
</div>
<div class="enroll-container">
			<form action="${pageContext.request.contextPath}/member/memberEnroll.me" method="post" name="enrollfrm">
					<div class="container1">
						<div class="container2">
								<table class="enroll-section">
										<tr>
												<td scope="col" class="add">
													 <input name="userId" id="userId" placeholder="아이디 입력">
												</td>
												<!-- <td>
														<input type="button" class="bo-small" id="checkId" onclick="checkIdFunc();" value="중복확인">
														<input type="hidden" name="idDuplication" value="idUnCheck"> 중복확인 버튼을 눌렀을 때 값이 바뀌도록
												</td> -->
									 </tr>
									 <tr>
											 <td scope="col" class="add" colspan="2">
													 <input type="password" name="userPwd" id="userPwd" placeholder="비밀번호 입력">
													 <!-- 영문, 숫자, 특수문자 포함 8~20자리 -->
											 </td>
									 </tr>
									 <tr>
											 <td scope="col" class="add" colspan="2">
													 <input type="password" name="userPwdChk" id="userPwdChk" placeholder="비밀번호 다시 입력">
											 </td>
									 </tr>
									 <tr>
											<td>
												<span style="font-size: 12px;"><em>*아이디는 4~12자의 영문 소문자와 숫자만 사용 가능</em></span><br>
												<span style="font-size: 12px;"><em>*비밀번호는 영문, 숫자, 특수문자 포함 8~20자리로 입력</em></span><br>
											</td>
										</tr>
											
										<tr>
										<td scope="col" class="add" colspan="2">
												<span class="guide ok">멋진 아이디네요!</span>
												<span class="guide error">사용할 수 없는 아이디입니다.</span>
										</td>
										</tr>
									 

							 </table>
										 </div>
										 <div class="container2">
							 <table class="enroll-section">
								<tr>
										<td scope="col" class="add">
												<input name="name" id="name" placeholder="이름 입력">
										</td>
								</tr>
								<tr>
										<td scope="col" class="add">
												<input name="phone" id="phone" placeholder="휴대폰번호 입력 (ex. 010-1234-5678)">
										</td>
								</tr>
								<tr>
										<td scope="col" class="add">
												<input name="email" id="email" placeholder="이메일 입력 (ex. example@example.com)">
										</td>
								</tr>
										<tr>
											<td class="btn-cont">
												<button type="button" class="bo-small">이메일 인증하기</button>
											</td>
										</tr>
									 <tr>
											 <td scope="col" class="add">
													 <input name="birthday" id="birthday" placeholder="생년월일 8자리 입력 (ex. 2023-01-01)">
											 </td>
									 </tr>
							 </table>
										 </div>
										 <div class="lo">
							 <table>
									 <input type="checkbox" class="checkbox-square" /><span>이용약관에 동의하시겠습니까?</span>
							 </table>
										 </div>
										 <div class="table1">
							 <button type="button" class="bo" onclick="validation();">회원가입</button>&emsp;
							 <button type="reset" class="bo">초기화</button>
										 </div>
					</div>
				 </form>
		
</div>


	<!-- 우편번호, 주소 삭제 -->
       <!-- <div class="container2">
           <table class="enroll-section2"> -->
               <!-- <tr>
                   <td scope="col" class="add">
                       <input type="detailAddress" name="address" placeholder="우편번호 입력">
                   </td>
               </tr> -->
            <!-- <tr>
                <td scope="col" class="add">
                    <input name="zipcode" id="postcode" class="" placeholder="우편번호" readonly>
                </td>
                <td>
                    <button class="bo-small" onclick="findAddr();" type="button" style="background-color: rgba(94, 177, 98, 0.75);">우편번호 찾기</button>
                </td>
            </tr>
            <tr>
                <td scope="col" class="add">
                    <input name="address" id="address" class="" placeholder="주소" readonly><br> 우편번호 찾고 주소 클릭 시 자동 입력됨
                </td>
            </tr>
            <tr>
                <td scope="col" class="add">
                    <input name="detailAddress" id="addressdetail" class="" placeholder="상세주소 입력">
                </td>
            </tr> -->
               <!-- <tr>
                <td scope="col" class="add">
                    <input name="" type="detailAddress" placeholder="주소 입력" id="">
                </td>
            </tr> -->
           <!-- </table>
       </div> -->


<!-- <script type="text/javascript">
		
	    // ID 중복체크 
		function checkIdFunc() {
			var userId = $('#userId').val();
			console.log("사용자 아이디 입력 값: " + userId);
			
		    var uid = document.getElementById("userId");
			
			if (uid.value == "") {
			alert("아이디를 입력하세요");
			uid.focus();
			return false;
		}
		
			$.ajax({
				type: "post",
				url: "${pageContext.request.contextPath}/member/checkId.do",
				data: { userId : userId },
				dataType: 'json',
	            /* contentType : "application/json; charset=utf-8", */
	            success: function(cnt) {
	            	if (cnt == 0) {
	            		$('id_ok').css("display", "inline-block");
	            		$('.id_already').css("display", "none");
	            	} else {
	            		$('.id_already').css("display", "inline-block");
	            		$('.id_ok').css("display", "none");
	            		alert("아이디를 다시 입력해 주세요");
	            		$('#userId').val('');
	            	}
	            },
	            error: function() {
	            	alert("통신 오류");
	            }
	        });
	    }
	    
	
</script> -->

<script type="text/javascript">
		document.querySelector("#userId").addEventListener("keyup", (e) => {
			const ok = document.querySelector(".ok");
			const error = document.querySelector(".error");
			const userId = e.target;
			
			// var userId = $('#userId').val();
			
			/*
			console.log("사용자 아이디 입력 값: " + userId);
			
		    var uid = document.getElementById("userId");
		    var idCfm = /^[a-z0-9]{4,12}$/;
		    
		    
			if (uid.value == "") {
			alert("아이디를 입력하세요");
			uid.focus();
			return false;
		}
			
			// 아이디 대소문자 확인 
			if (!idCfm.test(uid.value)) {
				alert("아이디는 4~12자의 영문 소문자와 숫자만 사용 가능합니다");
				uid.focus();
				return false;
			}
			*/
			
			/*
			  - 한글 입력 시
			  - 4~12글자 제한 
			
			*/
			
			
			
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

<script type="text/javascript">

	/* function inputIdChk() {
		enrollfrm.idDuplication.value = "idUnCheck";
		console.log(enrollfrm.idDuplication.value);
		
	}
	
	function inputIdChk(id) {
		enrollfrm.idDuplication.value = "idCheck";
		console.log(enrollfrm.idDuplication.value);
	}  */

	function validation() {
		var uid = document.getElementById("userId");
		var pw = document.getElementById("userPwd");
		var pwc = document.getElementById("userPwdChk");
		var uname = document.getElementById("name");
		var phone = document.getElementById("phone");
		
		// 자동으로 하이픈 넣기 
		// phone = phone.replace(/^(\d{2,3})(\d{3,4})(\d{4})$/, `$1-$2-$3`);
		
		var email = document.getElementById("email");
		var birthday = document.getElementById("birthday");
		
		// 정규표현식
		// 아이디 
		var idCfm = /^[a-z0-9]{4,12}$/;
		
		// 비밀번호 
		var pwdCfm = /^(?=.*[a-zA-Z])(?=.*[0-9])(?=.*[!@#$%^&*.])[a-zA-Z0-9!@#$%^&*.]{8,20}$/;
		
		// 이름 
		var nameCfm = /^[가-힣a-zA-Z0-9]{2,15}$/;
		
		// 휴대폰번호
		var phoneCfm = /^01([0|1|6|7|8|9])-?([0-9]{3,4})-?([0-9]{4})$/;
		
		// 이메일 
		var emailCfm = /^[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*\.[a-zA-Z]{2,3}$/i;
		
		// 생년월일
		var birthdayCfm = /^(19[0-9][0-9]|20\d{2})-(0[0-9]|1[0-2])-(0[1-9]|[1-2][0-9]|3[0-1])$/;
		
		
		
		// 아이디 확인
		if (uid.value == "") {
			alert("아이디를 입력하세요");
			uid.focus();
			return false;
		}
		
		// 아이디 대소문자 확인 
		if (!idCfm.test(uid.value)) {
			alert("아이디는 4~12자의 영문 소문자와 숫자만 사용 가능합니다");
			uid.focus();
			return false;
		}
		
		// ID 중복확인 작업중 
		
		// 비밀번호 확인 
		if (pw.value == "") {
			alert("비밀번호를 입력하세요");
			pw.focus();
			return false;
		}
		
		// 비밀번호와 아이디 비교 
		else if (pw.value == uid.value) {
			alert("아이디와 동일한 비밀번호를 사용할 수 없습니다");
			pw.focus();
			return false;
		}
		
		// 비밀번호 일치 확인 
		if (pw.value != pwc.value) {
			alert("비밀번호가 일치하지 않습니다");
			cpw.focus();
			return false;
		}
		
		// 비밀번호 영문, 숫자, 특수문자 포함 8~20자리
		if (!pwdCfm.test(pw.value)) {
			alert("비밀번호는 8~20자리의 영문, 숫자, 특수문자를 최소 1개씩 포함해야 합니다");
			pw.focus();
			return false;
		}
		
		// 이름 확인 
		if (uname.value == "") {
			alert("이름을 입력하세요");
			uname.focus();
			return false;
		} else if (!nameCfm.test(uname.value)) {
			alert("이름은 2글자 이상으로 설정해 주세요");
			uname.focus();
			return false;
		}
		
		// 휴대폰번호
		if (phone.value == "") {
			alert("휴대폰번호를 입력하세요");
			phone.focus();
			return false;
		} else if (!phoneCfm.test(phone)) {
			alert("휴대폰번호가 올바르지 않습니다");
			phone.focus();
			return false;
		}
		
		
		
		// 이메일 주소 확인 
		if (email.value == "") {
			alert("이메일 주소를 입력하세요");
			email.focus();
			return false;
		} else if (!emailCfm.test(email.value)) {
			alert("잘못된 이메일 형식입니다");
			email.focus();
			return false;
		}
		
		// 생년월일 
		if (birthday.value == "") {
			alert("생년월일을 입력하세요");
			birthday.focus();
			return false;
		} else if (!birthdayCfm.test(birthday.value)) {
			alert("생년월일 형식이 올바르지 않습니다");
			birthday.focus();
			return false;
		}
		
		/*
		if (enrollfrm.idDuplication.value != "idCheck") {
		    alert("아이디 중복 확인이 필요합니다");
		    return;
		  }
		*/
		
		
		
		
		/* 
			- 입력 텍스트 font-size 조절 예정
		*/
		
		
		document.enrollfrm.submit();
		
	}




</script>




<!-- <script>
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
				url: "/member/checkId.do",
				data: {userId: userId},
				method: "post",
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
	
	</script> -->


   
<jsp:include page="/WEB-INF/views/common/footer.jsp" />