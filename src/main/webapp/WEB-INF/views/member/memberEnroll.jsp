<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/member/memberEnroll.css?<%=System.currentTimeMillis() %>">

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
					</tr>
					<tr>
						<td scope="col" class="add" colspan="2">
							<input type="password" name="userPwd" id="userPwd" placeholder="비밀번호 입력">
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
			<div class="container3">
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
							<button type="button" class="bo-small" id="emlChk" >이메일 인증하기</button>
						</td>
					</tr>
					<tr>
						<td scope="col" class="add">
							<input type="email" name="emailAuth" id="emailAuth" placeholder="인증번호 6자리를 입력해주세요" required>
						</td>
					</tr>
					<tr>
						<td class="btn-cont">
							<button type="button" class="bo-small" id="emlChk2" >인증</button>
							<input type="hidden" id="emailAuthKey" name="emailAuthKey">
						</td>
					</tr>
					<tr>
						<td scope="col" class="add">
							<input name="birthday" id="birthday" placeholder="생년월일 8자리 입력 (ex. 2023-01-01)">
						</td>
					</tr>
				</table>
			</div>
			<div class="table1">
				<button type="button" class="bo" onclick="validation();">회원가입</button>&emsp;
				<button type="reset" class="bo">초기화</button>
			</div>
		</div>
	</form>
</div>

<!-- 이용 약관 모달창 -->
<div class="modal2" tabindex="-1" id="modal2">
	<div class="modal-dialog">
		<form action="${pageContext.request.contextPath}/member/ex" method="post" id="exFrm" name="exFrm">
			<div class="modal-login">
				<div class="modal-bg" onclick="agreeModalClose();"></div>
				<div class="agree-container1">
					<div class="agree-content">
						<div class="align-both">
							<h3>서비스 이용약관</h3>
							<div><input type="checkbox" id="chk2_1" name="chk"><label for="chk2_1">동의합니다.</label></div>
						</div>
						<div class="agree-container2">
							<div class="agree">
								<h4>제1조 (목적)</h4>
								이 약관은 감자마켓이 제공하는 서비스를 이용함에 있어 감자마켓과 이용자의 권리 및 의무와 이용에 관한 제반사항을 규정하는 것을 목적으로 합니다.<br>
								<h4>제2조 (용어의 정의)</h4>
								이 약관에서 사용하는 용어의 정의는 다음과 같습니다.<br>
								1. "감자마켓 서비스"란 이용자가 회사의 서비스를 이용할 수 있도록 회사가 제공하는 공동구매 및 지역생활 정보 공유를 위한 웹/앱 플랫폼 서비스 일체를 의미합니다.<br>
							</div>
						</div>
					
						<div class="align-both">
							<h3>개인정보 수집 및 이용에 관한 안내</h3>
							<div><input type="checkbox" id="chk2_2" name="chk"><label for="chk2_2">동의합니다.</label></div>
						</div>
						<div class="agree-container2">
							<div class="agree">
								<h4>제9조 (취득한 개인정보의 보호)</h4>
								1. 판매자는 판매 서비스의 이용에 따라 취득한 이용자 등 타인의 개인정보를 상품의 배송 또는 전달을 위한 목적 이외의 용도로 사용하거나 제3자에게 제공하는 등 외부에 유출할 수 없으며, 관련 법령 등에 따라 철저히 보호하여야 합니다.<br>
								2. 감자마켓은 배송 등의 목적으로 판매자에게 공개되어 있는 이용자의 개인정보를 감자마켓의 정책에 따라 상당 기간이 경과한 후 비공개 조치할 수 있습니다.<br>
								3. 판매자가 본 조를 위반하여 이용자와 분쟁이 발생하는 경우 자신의 노력과 비용으로 감자마켓을 면책시켜야 하며, 민/형사 상 일체의 법적 책임을 부담하여야 합니다.<br>
							</div>
						</div>
						<div class="agree-total">
							<div class="chk3"><input type="checkbox" id="chk-all" name="chk" onclick="selectAll(this)"><label for="chk-all">전체 동의합니다.</label></div>
							<button type="button" class="bo login-btn" onclick="agreeModal();" id="agree-modal">정보 입력하기</button>
						</div>
						<a id="close-modal2" class="modal-closeBtn" onclick="agreeModalClose();">닫기</a>
					</div>
				</div>
			</div>
		</form>
	</div>
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






	$("#modal2").ready(function() {
		$("#modal2").show();
	});

	function agreeModalClose() {
		$('.modal2').hide();
	};
	
	function agreeModal() {
		if (!$("input:checked[id='chk2_1']").is(":checked")) {
			alert("약관 동의가 필요합니다.");
			return false;
		}
		if (!$("input:checked[id='chk2_2']").is(":checked")) {
			alert("약관 동의가 필요합니다.");
			return false;
		}
		
		$('.modal2').hide();
		
	};

	// 약관 체크박스 전체 선택 or 전체 해제 
	function selectAll(selectAll) {
		var checkboxes = document.getElementsByName('chk');
		checkboxes.forEach((checkbox) => {
			checkbox.checked = selectAll.checked;
		})
	}

	// 개별 체크박스 모두 선택하면, 전체 선택도 체크되게   
	$(".agree-content").on('click', 'input:not(#chk-all)', function () {
		var isChecked = true;
		$(".agree-content input:not(#chk-all)").each(function() {
			isChecked =  isChecked && $(this).is(":checked");
		})
		$("#chk-all").prop("checked", isChecked)
	});

	
	const modal2 = document.getElementById("modal2");
	const openModalBtn2 = document.getElementById("open-modal2");
	const closeModalBtn2 = document.getElementById("close-modal2");
	const agreeModalBtn = document.getElementById("agree-modal");

	openModalBtn2.addEventListener("click", () => {
		modal2.style.display = "block";
		document.body.style.overflow = "hidden"; 
	});
	
	function agreeModalClose(){
		modal2.style.display = "none";
		document.body.style.overflow = "auto"; 
	}
		agreeModalBtn.addEventListener("click", () => {
			agreeModalClose();
		});
	
</script>

<script type="text/javascript">

	function validation() {
		var uid = document.getElementById("userId");
		var pw = document.getElementById("userPwd");
		var pwc = document.getElementById("userPwdChk");
		var uname = document.getElementById("name");
		var phone = document.getElementById("phone");
		var email = document.getElementById("email");
		var authKey = document.getElementById("emailAuthKey");
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
		
		// 인증번호 
		var authCfm = /^[0-9]{1,6}$/;
		
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
		} else if (!phoneCfm.test(phone.value)) {
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
		
		// 인증번호 입력 
		if (emailAuth.value == "") {
			alert("이메일 인증 후 인증번호 6자리를 입력해 주세요");
			emailAuth.focus();
			return false;
		}
		
		// 인증번호 확인
		if($('#emailAuth').val() != authKey.value) {
			alert("인증번호가 일치하지 않습니다.");
			emailAuth.focus();
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
		document.enrollfrm.submit();
	}
	
	var code = ""; 		/*	인증번호 저장할 곳	 */
	$('#emlChk').click(function() {
		var email = $('#email').val();   /* 입력한 이메일 */
		/* console.log('완성된 이메일 : ' + email);	 */	/* 이메일 오는지 확인 */
		var emailAuth = $('.emailAuth')		/* 인증번호 입력 */
		
		 var regExp = /\w+([-+.]\w+)*@\w+([-.]\w+)*\.[a-zA-Z]{2,4}$/;
		 
		  if(!regExp.test(email)){
		    alert("이메일 주소를 입력하세요!");
		    return false;
		  }
			$.ajax({
				type: 'GET',
				url: '${pageContext.request.contextPath}/member/mailCheck.me?email=' + email,	/* url을 통해 데이터를 보낼 수 있도록 GET방식, url명을 "mailCheck"로 지정 */
				success: function(data) {
					/* console.log("인증번호 : " + data); */
					$('input[name=emailAuthKey]').attr('value', data);
					emailAuth.attr('disabled', false);		/* 데이터가 성공적으로 들어오면 인증번호 입력란이 활성화되도록 */
					code = data;
					alert('인증번호가 전송되었습니다.')
					return true;
				},
			});
		});
		
	$('#emlChk2').click(function() {
		var inputCode = $('#emailAuth').val();
		var checkResult = $("#emailAuth");
		var authKey = document.getElementById("emailAuthKey");
		
		if($('#emailAuth').val() != authKey.value) {
			alert("인증번호가 일치하지 않습니다.");
			return false;
		} else if($('#emailAuth').val() == authKey.value) {
			alert("인증번호가 일치합니다.");
			return true;
		}
	});
</script>
   
<jsp:include page="/WEB-INF/views/common/footer.jsp" />