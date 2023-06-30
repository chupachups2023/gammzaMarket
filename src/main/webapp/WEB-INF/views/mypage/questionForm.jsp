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
	<div id="questionForm">
		<h1 align="center">1대1 답변</h1>
		<br>
		<form method="post" action="${pageContext.request.contextPath}/mypage/updateQuestion.do">
			<table id="myQuestionT">
				<tr class="myQtr">
					<th class="myQtd1">문의제목</th>
					<td class="myQtd2"><input name="qnaTitle" style="width:400px;" required></td>
				</tr>
				<tr class="myQtr">
					<th class="myQtd1"> 문의 카테고리</th>
					<td class="myQtd2">
						<select name="qnaCategory" id="cate1" required>
							<option selected>*선택해주세요</option>
							<option value="1">포인트</option>
							<option value="2">공구총대</option>
							<option value="3">공구참여</option>
							<option value="4">공구요청</option>
						</select>
					</td>
				</tr>
				<tr id="myQtrB">
					<th class="myQtd1">문의 내용</th>
					<td class="myQtd2"><textarea class="myQTextbox" required></textarea></td>
				</tr>
			</table>
			
			 <br>
			<div class="replyBtnBox">
				<button class="replyBtn" type="submit">작성</button>
				<button class="replyBtn" type="reset">취소</button>
				<button class="replyBtn" type="button"
					onclick="location.href='${pageContext.request.contextPath}/mypage/myQuestionList.do'">목록</button>
			</div>
			<input type="hidden" name="nowPage" value="${nowPage }">
			<input type="hidden" name="nowPage" value="${nowPage }">
			<input type="hidden" name="nowPage" value="${nowPage }">
		</form>
	</div>
<jsp:include page="/WEB-INF/views/common/footer.jsp" />
