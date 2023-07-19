<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<% 
	String nowPage = request.getParameter("nowPage");	
%>

<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param value="${ notice.noticeTitle }" name="title" />
</jsp:include>
<style>
#title {
	margin-top: 30px;
	text-align: center;
}

.table {
	margin-top: 30px;
	width: 55%;
	margin: 0 auto;
}

.table-group-divider tr:nth-child(even) {
	background-color: #f2f2f2;
}

.table-group-divider tr:nth-child(odd) {
	background-color: #ffffff;
}

.table th,.table td {
	padding: 10px;
	text-align: center;
}

.button-container {
	margin-top: 30px;
	text-align: center;
}

.button-container input[type="button"] {
	margin-right: 10px;
	padding: 10px 20px;
	font-size: 16px;
	border: none;
	border-radius: 4px;
	background-color: #4caf50;
	color: white;
	cursor: pointer;
}

.button-container input[type="button"]:hover {
	background-color: #45a049;
}
</style>
</head>

<body>
	<div id="title">
		<h1>공지사항 상세보기</h1>
	</div>

	<table class="table">
		<thead>
			<tr>
				<th scope="col">제목</th>
				<th scope="col">날짜</th>
			</tr>
		</thead>
		<tbody class="table-group-divider">
			<tr>
				<th scope="col">${ notice.noticeTitle }</th>
				<th scope="col">${ notice.noticeCreate }</th>
			</tr>
			<tr>
				<td colspan="2">${ notice.noticeContent }${pi.nowPage }</td>
			</tr>
		</tbody>
	</table>

	<div class="button-container">
		<input type="button"
			onclick="location.href='${pageContext.request.contextPath}/adminpage/noticeList.bo?nowPage=${pi.nowPage}'"
			value="목록">
		<c:if test="${loginMember.userId eq 'admin'}">
			<input type="button" onclick='updateNotice(${notice.noticeNo});'
				value="수정">
			<input type="button" onclick='deleteNotice(${notice.noticeNo});'
				value="삭제">
		</c:if>
	</div>

	<jsp:include page="/WEB-INF/views/common/footer.jsp" />

	<script type="text/javascript">
		function updateNotice(noticeNo) {
			location.href = '${ pageContext.request.contextPath }/adminpage/updateNotice.do?noticeNo='
					+ noticeNo;
		}

		function deleteNotice(noticeNo) {
			location.href = '${ pageContext.request.contextPath }/adminpage/deleteNotice.do?noticeNo='
					+ noticeNo;
		}
	</script>
