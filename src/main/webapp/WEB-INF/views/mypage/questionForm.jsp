<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/css/adminpage/qna.css">
<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param value="1:1문의 상세보기" name="title" />
</jsp:include>

<body>
	<div id="qnaAns">
		<h1>1대1 답변</h1>
		<br>
		<br>

		<form method="post" action="${pageContext.request.contextPath}/mypage/updateQuestion.do">
			<table class="ansTable">
				<thead>
					<tr>
						<th width="400px">제목</th>
						<th width="200px">카테고리</th>
					</tr>
				</thead>
				<tbody>
					<tr style="height: 40px">
						<td width="400px"><input name="qnaTitle"></td>
						<td width="200px"><input name="qnaCategory"></td>
					</tr>
					<tr style="height: 250px">
						<th>문의 내용</th>
						<td colspan="2"><textarea name="qnaContent" style="resize: none; height: 200px; width:400px;"
								></textarea></td>
						<td></td>
					</tr>
				</tbody>
			</table>
			
			 <br>
			<div class="replyBtnBox">
				<button class="replyBtn" type="submit">작성</button>
				<button class="replyBtn" type="reset">취소</button>
				<button class="replyBtn" type="button"
					onclick="location.href='${pageContext.request.contextPath}/mypage/myQuestionList.do?nowPage=${nowPage}'">목록</button>
			</div>
			<input type="hidden" name="userId" value="${loginMember.userId}">
			<input type="hidden" name="nowPage" value="${nowPage }">
			<input type="hidden" name="nowPage" value="${nowPage }">
			<input type="hidden" name="nowPage" value="${nowPage }">
		</form>
	</div>
<jsp:include page="/WEB-INF/views/common/footer.jsp" />
