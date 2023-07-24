<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/css/adminpage/notice.css">
<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param value="공지사항" name="title" />
</jsp:include>

<style>
#navPage {
	display: flex;
	justify-content: center;
	margin-top: 30px;
}

.page-item {
	width: 50px;
	height: 20px;
	text-align: center;
	margin-right: 10px;
	padding: 10px 20px;
	font-size: 16px;
	border: none;
	border-radius: 4px;
	background-color: #4caf50;
	color: white;
	cursor: pointer;
}

.page-item a {
	color: white;
	text-decoration: none;
}

.page-item:hover {
	background-color: #45a049;
}

.page-item.active {
	background-color: #45a049;
}

.pagination {
	margin-top: 20px;
	width: 300px;
	display: flex;
	justify-content: center;
}

.col {
	text-align: center;
	border-top: groove;
}

#col-t {
	font-size: large;
	font-weight: bolder;
	height: 50px;
}

.table {
	width: 100%;
	text-align: center;
}

.bigtable {
	height: 400px;
	width: 100%;
	margin: 0 auto;
	display: flex;
	align-items: center;
	justify-content: space-around;
	border: 1px solid black;
	border-radius: 30px
}

.notice {
	width: 80%;
	margin: 0 auto;
}

#title {
	margin-top: 30px;
	text-align: center;
}

button {
	margin-top: 30px;
}
element.style {
    width: 32px;
}
.writeNotice {
	width: 70px;
	height: 30px;
	border: none;
	border-radius: 4px;
	background-color: #4caf50;
	color: white;
	cursor: pointer;
}
</style>

<div id="title">
	<h1>공지사항</h1>
</div>
<div class="notice">
	<table class="bigtable">
		<tr>
			<td>
				<table class="table">
					<tbody class="notice">
						<tr>
							<th class="col" width="60px">NO</th>
							<th class="col" width="600px" height="50px">제목</th>
							<th class="col" width="400px">작성일</th>
							<th class="col" width="140px">조회수</th>
						</tr>
						<c:forEach items="${noticeList}" var="notice">
							<tr>
								<td class="col">${notice.noticeNo}</td>
								<td class="col" id="col-t"><a
									href="${pageContext.request.contextPath}/adminpage/noticeDetail.bo?noticeNo=${notice.noticeNo}&nowPage=${pi.nowPage}">${notice.noticeTitle}</a></td>
								<td class="col">${notice.noticeCreate}</td>
								<td class="col">${notice.count}</td>
								</tr>
						</c:forEach>
					</tbody>
				</table>
			</td>
		</tr>
	</table>
</div>
<nav id="navPage">
	<ul class="pagination">
		<c:if test="${ pi.nowPage ne 1 }">
			<li class="page"><a class="page-item" tabindex="-1"
				aria-disabled="false"
				href="${pageContext.request.contextPath}/adminpage/noticeList.bo?nowPage=${ pi.nowPage - 1 }">이전</a></li>
		</c:if>
		<c:forEach var="p" begin="${pi.startPage}" end="${pi.endPage }">
			<c:choose>
				<c:when test="${p eq pi.nowPage }">
					<a class="page-link" href="${pageContext.request.contextPath}/adminpage/noticeList.bo?nowPage=${ p }">
						<li class="page-item active">${ p }</li>
					</a>
				</c:when>
				<c:otherwise>
					<a class="page-link" href="${pageContext.request.contextPath}/adminpage/noticeList.bo?nowPage=${ p }">
						<li class="page-item">${ p }</li>
					</a>
				</c:otherwise>
			</c:choose>
		</c:forEach>
		<c:if test="${ pi.nowPage ne pi.totalPage }">
			<li class="page"><a class="page-item"
				href="${pageContext.request.contextPath}/adminpage/noticeList.bo?nowPage=${ pi.nowPage + 1 }">다음</a></li>
		</c:if>
	</ul>
</nav>
<div align="center">
	<c:if test="${loginMember.userId eq 'admin'}">
		<button class="writeNotice" onclick="location.href='${pageContext.request.contextPath}/adminpage/insertNotice.do'">글 작성</button>
	</c:if>
</div>

<jsp:include page="/WEB-INF/views/common/footer.jsp" />
