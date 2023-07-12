<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/member/memberInfo.css?<%=System.currentTimeMillis() %>">

<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param value="제목" name="title"/>
</jsp:include>

<div id="container">
	<table> 
		<tr>
			<th scope="col" >
				아이디 : <input name="userId" placeholder="user01" id="userId" required><br>
			</th>
		</tr>
		<tr>
			<th scope="col">
				<input type="password" placeholder="*****" name="userPwd" required>
			</th>
		</tr>
		<tr>
			<th scope="col">
				<input type="password" placeholder="*****" name="pwdCheck" required>
			</th>
		</tr>
	</table>    
</div>
<div id="container">
	<table>
		<tr>
			<td scope="col" align="center">
				<input name="birthday" placeholder="1999-09-09" required>
			</td>
		</tr>
		<tr>
			<td scope="col" align="center">
				<input type="detailAddress" name="address" placeholder="서울 영등포구 선유동2로 57 이레빌딩">
			</td>
		</tr><br>
	</table>
</div>
<div id="table">
	<button type="submit" class="bo">회원정보 수정</button>&emsp;
	<button type="previous" class="bo">뒤로가기</button>&emsp;
	<button type="quit" class="bo">탈퇴하기</button>
</div>


<jsp:include page="/WEB-INF/views/common/footer.jsp" />