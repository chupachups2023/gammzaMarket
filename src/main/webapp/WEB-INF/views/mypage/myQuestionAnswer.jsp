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

		<form method="post" action="${pageContext.request.contextPath}/mypage/myQuestionUpdate.do">
			<table class="ansTable">
				<thead>
					<tr>
						<th width="100px">문의 번호</th>
						<th width="400px">제목</th>
						<th width="200px">작성자</th>
						<th width="100px">날짜</th>
					</tr>
				</thead>
				<tbody>
					<tr style="height: 40px">
						<th width="100px">${qna.qnaNo}</th>
						<td width="400px">${qna.qnaTitle}</td>
						<td width="200px">${qna.qnaWriter}</td>
						<td width="100px">${qna.createAt}</td>
					</tr>
					<tr style="height: 250px">
						<th>문의 내용</th>
						<td colspan="2"><textarea id="myQC" style="resize: none; height: 200px; width:400px;"
								>${qna.qnaContent}</textarea></td>
						<td></td>
					</tr>

					<c:choose>
						<c:when test="${empty qAns.qnaNo}">
							<tr style="height: 250px">
								<th>답변 내용</th>
								<td colspan="2"><textarea name="qAnswer"
										style="resize: none; height: 200px; width:400px;" readonly></textarea></td>
								<td></td>
							</tr>
						</c:when>
						<c:otherwise>
							<tr style="height: 250px">
								<th>답변 내용</th>
								<td colspan="2">
									<textarea style="resize: none; height: 200px; width:400px;" readonly>${qAns.qnaContent }</textarea>
								</td>
								<td></td>
							</tr>
						</c:otherwise>
					</c:choose>
				</tbody>
			</table>
			
			 <br>
			<div class="replyBtnBox">
				<button class="replyBtn" id="updateQ" type="submit">수정</button>
				<button class="replyBtn" type="button" onclick="#">삭제</button>
				<button class="replyBtn" type="button"
					onclick="location.href='${pageContext.request.contextPath}/mypage/myQuestionList.do?nowPage=${nowPage}'">목록</button>
			</div>
			<input type="hidden" name="qnaNo" value="${qna.qnaNo }">
			<input type="hidden" name="nowPage" value="${nowPage }">
		</form>
	</div>
<jsp:include page="/WEB-INF/views/common/footer.jsp" />

<script>
	$(document).ready(function() {
		if(${qAns.qnaNo} == null) {
			$("#myQC").attr("readonly", true);
			$("#updateQ").attr("disabled", true);
		}
	})
</script>