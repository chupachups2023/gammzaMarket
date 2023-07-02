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
		<h1 align="center">문의 답변</h1>
		<br>
		<br>

		<form method="post" action="${pageContext.request.contextPath}/mypage/myQuestionUpdate.do">
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
						<td colspan="2"><textarea id="myQC" class="textbox">${qna.qnaContent}</textarea></td>
						<td></td>
					</tr>

					<c:choose>
						<c:when test="${empty qAns.qnaNo}">
							<tr style="height: 250px">
								<th>답변 내용</th>
								<td colspan="2"><textarea name="qAnswer" class="textbox" readonly></textarea></td>
								<td></td>
							</tr>
						</c:when>
						<c:otherwise>
							<tr style="height: 250px">
								<th>답변 내용</th>
								<td colspan="2">
									<textarea class="textbox" readonly>${qAns.qnaContent }</textarea>
								</td>
								<td></td>
							</tr>
						</c:otherwise>
					</c:choose>
				</tbody>
			</table>
			
			 <br>
			<div class="qnaBtnBox">
				<button class="qnaBtn" id="updateQ" type="submit">수정</button>
				<button class="qnaBtn" type="button"
					onclick="location.href='${pageContext.request.contextPath}/mypage/myQuestionList.do?nowPage=${nowPage}'">목록</button>
			</div>
			<input type="hidden" name="qnaNo" value="${qna.qnaNo }">
			<input type="hidden" name="nowPage" value="${nowPage }">
		</form>
	</div>
<jsp:include page="/WEB-INF/views/common/footer.jsp" />

<script>
	$(document).ready(function() {
		if(${qAns.qnaNo} != null) {
			$("#myQC").attr("readonly", true);
			$("#updateQ").attr("disabled", true);
		}
	})
</script>