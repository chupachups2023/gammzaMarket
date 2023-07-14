<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/member/memberInfo.css?<%=System.currentTimeMillis() %>">

<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param value="제목" name="title"/>
</jsp:include>
<style>
#title {
    text-align: center;
}

#MemInfoContainer {
    width: 450px; 
    margin:auto; 
    margin-top: 20px;
    background-color: #F9F9F9; 
    border: 1px solid #E9D296; 
    border-radius: 30px;
	padding: 20px;
}    
  
#memInfoTable th {
    padding: 7px 7px 7px 30px;
	text-align: justify;
	width:35%;
}
#memInfoTable td {
    padding: 7px 0;
	text-align: justify;
	width:65%;
}
.infoInput {
    background-color: #f9f9f900; 
    width: 240px;
    border: none;
    border-bottom: 1px solid;  
	resize: none;
	font-size: 17px;
}
.readonlyCursor {
	cursor: default;
}
#infoBtn {
    text-align: center;
    margin: auto;
    margin-top: 20px;
}
.bo {
    width: 130px; 
    height: 30px; 
    background: rgba(94, 177, 98, 0.75); 
    color: white; 
    border-radius: 30px;
    border: none;
    font-size: 17px;
    font-weight: bold;
    cursor: pointer;
}

</style>
<h1 id="title">${member.name} 회원 정보 관리</h1>
<form name="updateFrm" method="post" action="${pageContext.request.contextPath }/member/memberUpdate_Ad.me">
	<div id="MemInfoContainer">
		<table id="memInfoTable"> 
			<tr>
				<th>아이디 : </th>
				<td>
					<input name="newUserId" class="infoInput" id="userId" value="${member.userId}">
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
					<input class="infoInput" name="name" value="${member.name}">
				</td>
			</tr>
			<c:if test="${!empty member.kakaoIdkey}">
				<tr>
					<th>카카오 아이디 : </th>
					<td>
						<input class="infoInput" name="kakaoIdkey" value="${member.kakaoIdkey}">
					</td>
				</tr>
			</c:if>
			<c:if test="${!empty member.naverIdkey}">
				<tr>
					<th>네이버 아이디 : </th>
					<td>
						<input class="infoInput" name="naverIdkey" value="${member.naverIdkey}">
					</td>
				</tr>
			</c:if>
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
			<tr>
				<th>온도 : </th>
				<td>
					<input class="infoInput" name="temperature" value="${member.temperature}">
				</td>
			</tr>
			<tr>
				<th>포인트 : </th>
				<td>
					<input class="infoInput" name="point" value="${member.point}">
				</td>
			</tr>
		</table>
	</div>
	<div id="infoBtn">
		<button type="submit" class="bo">회원정보 수정</button>&emsp;
		<button type="button" class="bo" onclick="location.href='${pageContext.request.contextPath}/member/memberList.do?nowPage=${nowPage}'">뒤로가기</button>&emsp;
		<button type="button" class="bo" onclick="${pageContext.request.contextPath}/member/changeStatus_Ad.do?userId=${member.userId}&nowPage=${nowPage}">탈퇴시키기</button>
	</div>
	<input type="hidden" name="userId" value="${member.userId}">
	<input type="hidden" name="userPwd" value="${member.userPwd}">
	<input type="hidden" name="nowPage" value="${nowPage}">
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
	
</script>

<jsp:include page="/WEB-INF/views/common/footer.jsp" />