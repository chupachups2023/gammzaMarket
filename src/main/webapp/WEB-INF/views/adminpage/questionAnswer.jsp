<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param value="1:1문의 상세보기" name="title" />
</jsp:include>
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/css/adminpage/qna.css">

<body>
	<div id="qnaAns">
		<h1 align="center">1대1 답변</h1>
		<br>
		<br>

		<form method="post" action="${pageContext.request.contextPath}/adminpage/QAnswerInsert.do">
			<table class="ansTable">
				<thead>
					<tr>
						<th class="td1">문의 번호</th>
						<th class="td2">제목</th>
						<th class="td3">작성자</th>
						<th class="td4">날짜</th>
					</tr>
				</thead>
				<tbody>
					<tr style="height: 40px">
						<th class="td1">${qna.qnaNo}</th>
						<td class="td2">${qna.qnaTitle}</td>
						<td class="td3">${qna.qnaWriter}</td>
						<td class="td4">${qna.createAt}</td>
					</tr>
					<tr style="height: 250px">
						<th>문의 내용</th>
						<td colspan="2">&emsp;<textarea class="textbox" readonly>${qna.qnaContent}</textarea></td>
						<td></td>
					</tr>

					<c:choose>
						<c:when test="${empty qAns.qnaNo}">
							<tr style="height: 250px">
								<th>답변 내용</th>
								<td colspan="2">&emsp;<textarea class="textbox" name="qAnswer" required></textarea></td>
								<td></td>
							</tr>
						</c:when>
						<c:otherwise>
							<tr style="height: 250px">
								<th>답변 내용</th>
								<td colspan="2">&emsp;<textarea class="textbox" readonly>${qAns.qnaContent }</textarea>
								</td>
								<td></td>
							</tr>
						</c:otherwise>
					</c:choose>
				</tbody>
			</table>
			
			 <br>
			<div class="replyBtnBox">
				<c:choose>
					<c:when test="${empty qAns.qnaNo}">
						<button class="replyBtn" type="submit">작성</button>
						<button class="replyBtn" type="reset">취소</button>
						<button class="replyBtn" type="button"
							onclick="location.href='${pageContext.request.contextPath}/adminpage/questionList.do?nowPage=${nowPage}'">목록</button>
					</c:when>
					<c:otherwise>
						<button class="replyBtn" type="button"
							onclick="location.href='#'">수정</button>
						<button class="replyBtn" type="button" onclick="#">삭제</button>
						<button class="replyBtn" type="button"
							onclick="location.href='${pageContext.request.contextPath}/adminpage/questionList.do?nowPage=${nowPage}'">목록</button>
					</c:otherwise>
				</c:choose>
			</div>
			<input type="hidden" name="nowPage" value="${nowPage }">
			<input type="hidden" name="qnaNo" value="${qna.qnaNo}">
			<input type="hidden" name="qnaTitle" value="${qna.qnaTitle}">
			<input type="hidden" name="qnaCategory" value="${qna.qnaCategory}">
			<input type="hidden" name="ref" value="${qna.ref}">
		</form>
	</div>
<jsp:include page="/WEB-INF/views/common/footer.jsp" />