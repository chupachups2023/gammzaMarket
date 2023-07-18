<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/css/adminpage/qna.css">
<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param value="1:1문의" name="title" />
</jsp:include>

<div id="qnaBoard">
	<h1 align="center">문의 사항</h1>

	<br/>	

	<table class="qTable">
		<thead>
			<tr>
				<th width="100px">NO</th>
				<th width="450px">제목</th>
				<th width="200px">작성자</th>
				<th width="150px">날짜</th>
			</tr>
		</thead>
		<tbody>
			<c:forEach items="${questionList}" var="qna" varStatus="s">
				<tr>
					<td>${pi.totalRecord - ((pi.nowPage-1)*pi.numPerPage)-s.index}</td>
					<td class="Qtitle"><a href="${pageContext.request.contextPath}/adminpage/questionAnswer.do?nowPage=${pi.nowPage}&qnaNo=${qna.qnaNo}">[${qna.qnaCatName}] ${qna.qnaTitle}</a></td>
					<td>${qna.qnaWriter}</td>
					<td>${qna.createAt}</td>
				</tr>
			</c:forEach>
		</tbody>
	</table>
  <br/>
	
	<nav id="pagingNav">
		<ul class="qnaPaging">
			<c:if test="${pi.nowPage ne 1}">
				<li>
					<a href="${pageContext.request.contextPath}/adminpage/questionList.do?nowPage=${pi.nowPage-1}">이전</a>
				</li>
			</c:if>
			<c:forEach var="p" begin="${pi.startPage }" end="${pi.endPage }">
				<c:choose>
					<c:when test="${p eq pi.nowPage }">
						<li>
							<a id="selectedPage" href="${pageContext.request.contextPath}/adminpage/questionList.do?nowPage=${p}">[${p}]</a>
						</li>
					</c:when>
					<c:otherwise>
						<li>
							<a href="${pageContext.request.contextPath}/adminpage/questionList.do?nowPage=${p}">[${p}]</a>
						</li>
					</c:otherwise>
				</c:choose>
			</c:forEach>
			<c:if test="${pi.nowPage ne pi.totalPage }">
				<li><a href="${pageContext.request.contextPath}/adminpage/questionList.do?nowPage=${pi.nowPage+1}">다음</a></li>
			</c:if>
		</ul>
	</nav>
</div>

<jsp:include page="/WEB-INF/views/common/footer.jsp" />