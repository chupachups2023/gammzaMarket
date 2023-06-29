<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param value="제목" name="title" />
</jsp:include>
<!-- 
*관리자 공지사항 글 수정
 -->
</head>
<body>
	<div id="title">
		<h1 align="center">공지사항 수정</h1>
	</div>
	<form action="${pageContext.request.contextPath}/adminpage/updateNotice.do" method="post">
		<table class="table">
			<thead>
				<tr>
					<th scope="col" width="600px">제목</th>
					<th scope="col">날짜</th>
				</tr>
			</thead>
			<tbody class="table-group-divider">
				<tr>
					<th scope="col" width="600px"><input type="text" id="noticeTitle" placeholder="${ notice.noticeTitle }"></th>
					<th scope="col">${ notice.noticeCreate }</th>
				</tr>
				<tr>
					<td colspan="2"> <input type="text" id="noticeContent" placeholder="${ notice.noticeContent }"></td>
				</tr>
			</tbody>
		</table>
		<table align="center">
			<tr>
				<td><input type="submit"
					 value="수정 완료"></td>
				<td><input type="button"
					onclick='history.back()' value="취소"></td>
			</tr>
		</table>
		<input type="hidden" name="notice.noticeNo" value="${notice.noticeNo}">
	</form>
	<jsp:include page="/WEB-INF/views/common/footer.jsp" />