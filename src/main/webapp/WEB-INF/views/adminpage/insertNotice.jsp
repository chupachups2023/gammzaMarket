<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<style>
	.table {
		border: 1px; soild;
		width: 50%;
		align: center;
		margin: 0 auto;
		background-color: #f2f2f2
	}
.table-group-drivider {
	align: center;
}
#noticeContent {
	 width: 100%
}
.page-item {
	width: 70px;
	height: 30px;
	text-align: center;
	margin-right: 10px;
	font-size: 16px;
	border: none;
	border-radius: 4px;
	background-color: #4caf50;
	color: white;
	cursor: pointer;
}
.bigbox {
	background-color: #f2f2f2;
	padding: 10px;
	margin: 0 auto;
}
</style>

<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param value="제목" name="title" />
</jsp:include>

<div id="title" align="center">
	<h1>공지사항 작성</h1>
</div>
<br><br>
<div class="bigbox">
<br>
<form
	action="${pageContext.request.contextPath}/adminpage/insertNotice.do"
	method="post">
	<table class="table">
		<tbody class="table-group-divider" align="center">
			<tr>
				<th>제목</th>
				<th><input type="text" style="width: 100%" id="noticeTitle"
					name="noticeTitle" value="${ notice.noticeTitle }" required></th>
			</tr>
			<tr>
				<td><br><br></td>
			</tr>
			<tr>
				<td><input  name="noticeWriter" type="hidden" id="noticeWriter"
					value="${ notice.noticeWriter }" readonly></td>
				<td><input name="noticeCreate" type="hidden" id="noticeCreate"
					value="${ notice.noticeCreate }" readonly></td>
			</tr>
			<tr>
				<td colspan="2"><textarea name="noticeContent"
						id="noticeContent" cols="75" rows="10"
						placeholder="공지사항 내용을 작성해주세요." required style="resize: none"></textarea></td>
			</tr>
		</tbody>
	</table>
	<br><br>
	<table>
		<tr>
			<td align="center"><button type="submit" class="page-item">작성하기</button>
				<button class="page-item" onclick="history.back(-2)">취소</button></td>
		</tr>
	</table>
</form>
</div>
<jsp:include page="/WEB-INF/views/common/footer.jsp" />
