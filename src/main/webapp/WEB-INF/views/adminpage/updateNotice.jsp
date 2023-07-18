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
	width: 80px;
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
.nTitle {
	text-align: center;
}
</style>
<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param value="제목" name="title" />
</jsp:include>
<!-- 
*관리자 공지사항 글 수정
 -->
	<div id="title">
		<h1 align="center">공지사항 수정</h1>
	</div>
	<div class="bigbox">
	<form action="${pageContext.request.contextPath}/adminpage/updateNotice.do" method="post">
		<table class="table">
			<thead>
				<tr>
					<th scope="col" align="center">제목</th>
					<th scope="col">날짜</th>
				</tr>
			</thead>
			<tbody class="table-group-divider">
				<tr>
					<th scope="col" align="center"><input type="text" class="nTitle" id="noticeTitle" style="border:0 solid black; background-color: #f2f2f2;" name="noticeTitle" value="${ notice.noticeTitle }" required></th>
					<th scope="col">${ notice.noticeCreate }</th>
				</tr>
				<tr>
					<td colspan="2"><input type="hidden" id="noticeWriter" name="noticeWriter" style="border:0 solid black; background-color: #f2f2f2;" value="admin" readonly></td>
				</tr>
				<tr>
					<td colspan="2"> <textarea id="noticeContent" name="noticeContent" cols="75" rows="10" required>${ notice.noticeContent }</textarea></td>
				</tr>
			</tbody>
		</table>
		<br><br>
		<table>
			<tr>
				<td align="center">
					<input type="submit" class="page-item" value="수정 완료">
					<input type="button" class="page-item" onclick='history.back()' value="취소">
				</td>
			</tr>
		</table>
		<input type="hidden" name="noticeNo" value="${notice.noticeNo}">
	</form>
	</div>
	<jsp:include page="/WEB-INF/views/common/footer.jsp" />