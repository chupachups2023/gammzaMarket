<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/mypage/ggPartic_List.css">

<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param value="내가 참여한 공구" name="title"/>
</jsp:include>


<div id="container">
		<table class="table" align="center" width="950px">
			<tr>
				<th><img src="${pageContext.request.contextPath }/resources/img/chatting/Rectangle 3.png" width="100px"></img></th>
				<th>판매글 제목</th>
				<th>10,000원</th>
				<th><button class="don">리뷰쓰기</button></th>
				<th>2023.06.11</th>
			</tr>
			<tr>
				<th><img src="${pageContext.request.contextPath }/resources/img/chatting/Rectangle 3.png"  width="100px"></img></th>
				<th>판매글 제목</th>
				<th>10,000원</th>
				<th><button class="bon">공구완료</button></th>
				<th>2023.06.11</th>
			</tr>
			<tr>
				<th><img src="${pageContext.request.contextPath }/resources/img/chatting/Rectangle 3.png" width="100px"></img></th>
				<th>판매글 제목</th>
				<th>10,000원</th>
				<th><button class="bon">공구완료</button></th>
				<th>2023.06.11</th>
			</tr>
			<tr>
				<th><img src="${pageContext.request.contextPath }/resources/img/chatting/Rectangle 3.png"  width="100px"></img></th>
				<th>판매글 제목</th>
				<th>10,000원</th>
				<th><button class="bon">공구완료</button></th>
				<th>2023.06.11</th>
			</tr>
			<tr>
				<th><img src="${pageContext.request.contextPath }/resources/img/chatting/Rectangle 3.png"  width="100px"></img></th>
				<th>판매글 제목</th>
				<th>10,000원</th>
				<th><button class="bon">공구완료</button></th>
				<th>2023.06.11</th>
			</tr>
		</table>
	</div>

<jsp:include page="/WEB-INF/views/common/footer.jsp" />