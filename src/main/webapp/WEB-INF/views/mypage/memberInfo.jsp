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
    height: 500px;
}    
  
#memInfoTable th {
    padding: 7px 7px 7px 30px;
	text-align: justify;
	width:35%;
}
#memInfoTable td {
    padding: 7px;
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
#infoBtn {
    text-align: center;
    margin: auto;
    margin-top: 20px;
}
.bo {
    width: 120px; 
    height: 30px; 
    background: rgba(94, 177, 98, 0.75); 
    color: white; 
    border-radius: 30px;
    border: none;
}
.bo-small {
    width: 220px; 
    height: 30px; 
    background: rgba(94, 177, 98, 0.75); 
    color: white; 
    border-radius: 0 10px 10px 10px;
    border: none;
    font-size: 13px;
    font-weight: bold;
    cursor: pointer;
}

</style>
<h1 id="title">나의 회원정보</h1>
<div id="MemInfoContainer">
	<table id="memInfoTable"> 
		<tr>
			<th>아이디 : </th>
			<td>
				<input name="userId" class="infoInput" id="userId" value="${member.userId}" readonly><br>
			</td>
		</tr>
		<tr>
			<th>현재 비밀번호 : </th>
			<td>
				<input class="infoInput" type="password" placeholder="정보 수정시 입력해주세요" name="userPwd" required>
			</td>
		</tr>
		<tr>
			<th>새 비밀번호 : </th>
			<td>
				<input class="infoInput" type="password" placeholder="새 비밀번호 변경시 작성해주세요" name="rePwd">
			</td>
		</tr>
		<tr><td colspan="2"><br></td></tr>
		<tr>
			<th>이름 : </th>
			<td>
				<input class="infoInput" name="name" value="${member.name}" readonly>
			</td>
		</tr>
		<tr>
			<th>휴대폰 : </th>
			<td>
				<input class="infoInput" name="birthday" value="${member.phone}">
			</td>
		</tr>
		<tr>
			<th>이메일 : </th>
			<td>
				<input class="infoInput" name="birthday" value="${member.email}">
			</td>
		</tr>
		<tr>
			<th>생년월일 : </th>
			<td>
				<input class="infoInput" id="birthday" name="birthday">
			</td>
		</tr>
		
		<br>
	</table>
</div>
<div id="infoBtn">
	<button type="submit" class="bo">회원정보 수정</button>&emsp;
	<button type="previous" class="bo">뒤로가기</button>&emsp;
	<button type="quit" class="bo">탈퇴하기</button>
</div>
<script>
	$(function(){
		let birthday = ${member.birthday};
		const year = birthday.slice(4);
		console.log(year);
		const month = ('0' + (birthday.getMonth() + 1)).slice(-2);
		const day = ('0' + birthday.getDate()).slice(-2);
		birthday = `${year}년 ${month}월 ${day}일`;
		$("#birthday").val(birthday);
		console.log();
	})
</script>

<jsp:include page="/WEB-INF/views/common/footer.jsp" />