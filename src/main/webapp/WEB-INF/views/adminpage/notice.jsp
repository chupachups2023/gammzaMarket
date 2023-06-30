<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param value="제목" name="title" />
</jsp:include>

<!-- 
*제목 수정하기
*내용 들어갈 곳
*관리자페이지 공지사항
 -->

<div id="title" align="center">
	<h1>공지사항</h1>
</div>
<table class="table">
	<thead>
		<tr>
			<th colspan="4"><hr id="line"></th>
		</tr>
		<tr align="center">
			<th scope="col">NO</th>
			<th scope="col">제목</th>
			<th scope="col">작성일</th>
			<th scope="col">조회수</th>
		</tr>
	</thead>
	<tbody class="table-group-divider">
		<c:forEach items="${noticeList}" var="notice">
			<tr>
				<td>${notice.noticeNo}</td>

				<td><a
					href="${pageContext.request.contextPath}/adminpage/noticeDetail.bo?noticeNo=${notice.noticeNo}&nowPage=${pi.nowPage}">${notice.noticeTitle}</a></td>
				<td>${notice.noticeCreate}</td>

				<td>${notice.count}</td>
			</tr>
		</c:forEach>
	</tbody>
</table>
<nav aria-label="Page navigation example">
	<ul class="pagination justify-content-center">
		<c:if test="${ pi.nowPage ne 1 }">
			<li class="page-item"><a class="page-link" tabindex="-1"
				aria-disabled="false"
				href="${pageContext.request.contextPath}/adminpage/noticeList.bo?nowPage=${ pi.nowPage - 1 }">[이전]</a>

			</li>
		</c:if>
		<c:forEach var="p" begin="${pi.startPage}" end="${pi.endPage }">
			<c:choose>
				<c:when test="${p eq pi.nowPage }">
					<li class="page-item active"><a class="page-link"
						href="${pageContext.request.contextPath}/adminpage/noticeList.bo?nowPage=${ p }">${ p }</a>
					<li>
				</c:when>
				<c:otherwise>
					<li class="page-item"><a class="page-link"
						href="${pageContext.request.contextPath}/adminpage/noticeList.bo?nowPage=${ p }">${ p }</a>

					</li>
				</c:otherwise>
			</c:choose>
		</c:forEach>
		<c:if test="${ pi.nowPage ne pi.totalPage }">

			<a class="page-link"
				href="${pageContext.request.contextPath}/adminpage/noticeList.bo?nowPage=${ pi.nowPage + 1 }">[다음]</a>

		</c:if>
	</ul>
</nav>
<div>
	<c:if test="${loginMember.userId eq 'admin'}">
		<button
			onclick="location.href='${pageContext.request.contextPath}/adminpage/insertNotice.do'">글
			작성</button>
	</c:if>
</div>
<%-- <input type="hidden" name="nowPage" id="nowPage" value="${pi.nowPage }"> --%>

<jsp:include page="/WEB-INF/views/common/footer.jsp" />