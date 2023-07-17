<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/member/memberInfo.css?<%=System.currentTimeMillis() %>">

<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param value="나의 회원정보" name="title"/>
</jsp:include>

<h1 id="title">나의 회원정보</h1>
<form name="updateFrm" method="post" action="${pageContext.request.contextPath }/member/memberUpdate.me">
<div id="MemInfoContainer">
	<table id="memInfoTable"> 
		<tr>
			<th>아이디 : </th>
			<td>
				<input name="userId" class="infoInput readonlyCursor" id="userId" value="${member.userId}" readonly>
			</td>
		</tr>
		<tr>
			<th>현재 비밀번호 : </th>
			<td>
				<input class="infoInput" type="password" placeholder="탈퇴/정보 수정시 입력해주세요" id="insertPwd" name="userPwd" required>
			</td>
		</tr>
		<tr>
			<th>새 비밀번호 : </th>
			<td>
				<input class="infoInput" type="password" placeholder="새 비밀번호 변경시 작성해주세요"  id="newPwd" name="newPwd">
			</td>
		</tr>
	</table>
</div>
<div id="MemInfoContainer">
	<table id="memInfoTable">
		<tr>
			<th>이름 : </th>
			<td>
				<input class="infoInput readonlyCursor" name="name" value="${member.name}" readonly>
			</td>
		</tr>
		<tr>
			<th>휴대폰 : </th>
			<td>
				<input class="infoInput" name="phone" value="${member.phone}">
			</td>
		</tr>
		<tr>
			<th>이메일 : </th>
			<td>
				<input class="infoInput" name="email" value="${member.email}">
			</td>
		</tr>
		<tr>
			<th>생년월일 : </th>
			<td>
				<input class="infoInput" id="birthday" name="birthday">
			</td>
		</tr>
	</table>
</div>

<div id="infoBtn">
	<button type="button" class="bo" onclick="updateMember();">회원정보 수정</button>&emsp;
	<button type="button" class="bo" onclick="location.href='${pageContext.request.contextPath}/mypage/mypageMain.me'">뒤로가기</button>&emsp;
	<button type="button" class="bo" onclick="deleteUser();">탈퇴하기</button>
</div>
</form>
<script>
	$(function(){
		 let birthday = new Date('${member.birthday}');
		const year = birthday.getFullYear();
		const month = ('0' + (birthday.getMonth() + 1)).slice(-2);
		const day = ('0' + birthday.getDate()).slice(-2);
		birthday = [year, month, day].join('-');
		$("#birthday").val(birthday); 
	})
	
	function updateMember() {
		const insertPwd = $("#insertPwd").val();
		if(insertPwd == null || insertPwd == ""){
			alert("본인확인을 위해 현재 비밀번호를 입력해주세요.");
			return false;
		}
		
		//비밀번호 대조
		$.ajax({
			url : "checkPwd.do",
			type : "post",
			data : {'insertPwd' : insertPwd},
			success : function(result) {
							if(result == "false"){
								alert("비밀번호가 맞지 않습니다. 다시 입력해주세요.");
							}else {
								updateFrm.submit();
							}
					},
			error:function() {
				console.log("ajax통신실패");
				}
		});
	}
	
	function deleteUser(){
		if(confirm("탈퇴 전 환불요청 완료하시고 진행중인 모든 공구를 마치셨는지 확인후 신청해주십시오.")){
			const insertPwd = $("#insertPwd").val();
			if(insertPwd == null || insertPwd == ""){
				alert("본인확인을 위해 현재 비밀번호를 입력해주세요.");
				return false;
			}
			
			//비밀번호 대조
			$.ajax({
				url : "checkPwd.do",
				type : "post",
				data : {'insertPwd' : insertPwd},
				success : function(result) {
								if(result == "false"){
									alert("비밀번호가 맞지 않습니다. 다시 입력해주세요.");
								}else {
									location.href="${pageContext.request.contextPath}/member/changeStatus.do";
								}
						},
				error:function() {
					console.log("ajax통신실패");
					}
			});
		};
	}
	
</script>

<jsp:include page="/WEB-INF/views/common/footer.jsp" />