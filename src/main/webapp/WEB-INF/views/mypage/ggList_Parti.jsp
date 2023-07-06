<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/mypage/ggPartic_List.css?<%=System.currentTimeMillis() %>">

<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param value="${loginMember.userId }님이 참여한 공구" name="title"/>
</jsp:include>


<<<<<<< Updated upstream
<div id="container">
<input type="checkbox"> 마감 공구 제외하고 보기
<input type="radio"> 마감 순으로 정렬
<input type="radio"> 신청 순으로 정렬
=======
	<div id="container">
>>>>>>> Stashed changes
		<table class="table" align="center" >
		<c:forEach items="${partiList}" var="list" varStatus="j">
			<tr>
				<th><img src="${pageContext.request.contextPath }/resources/upload/${list.photo1}" width="100px"></img></th>
				<th>
					<c:choose>
						<c:when test="${fn:length(list.gongguName) gt 25}">
							<a href="${pageContext.request.contextPath }/gonggu/ggRead.go?gongguNo=${list.gongguNo}" class="ggTitle" >${fn:substring(list.gongguName, 0, 25)}⋯ </a>
						</c:when>
						<c:otherwise>
							<a href="${pageContext.request.contextPath }/gonggu/ggRead.go?gongguNo=${list.gongguNo}" class="ggTitle">${list.gongguName} </a>
						</c:otherwise>
					</c:choose>
				</th>
				<th><fmt:formatNumber type="number" maxFractionDigits="3" value="${list.price }" />P</th>
			<c:choose>
			<c:when test="${list.status eq 0 and list.endStatus eq 0}">
				<th><div>마감된 공구입니다</div></th>
				<th><button class="non"></button></th>
			</c:when>
			<c:when test="${list.status eq 0 and list.endStatus eq 1}">
				<th><div>신청 확인 중</div></th>
				<th><button class="non"></button></th>
			</c:when>
			<c:when test="${list.status eq 1 and list.endStatus eq 1}">
				<th><div>공구 진행 중</div></th>
				<th><button class="bon" onclick='receive("${list.gongguName}",${list.gongguNo });'>물건 받기 완료</button></th>
			</c:when>
			<c:otherwise>
				<th><div>공구 완료</div></th>
				<th><button class="bon">리뷰쓰기</button></th>
			</c:otherwise>
			</c:choose>
				<fmt:parseDate value="${list.createAt }" var="createAt" pattern="yyyy-MM-dd"/>
				<th><fmt:formatDate value="${createAt }" pattern="yyyy.MM.dd."/></th>
			</tr>
		</c:forEach>
		</table>
	</div>
<script>
	function receive(gongguName,gongguNo){
		if(	confirm(gongguName+"을(를) 수령하셨나요?") ){
			location.href="${pageContext.request.contextPath }/gonggu/partiStatusUpdate.pa?gongguNo="+gongguNo;
		}else{
			return
		}
		
	}
</script>
<jsp:include page="/WEB-INF/views/common/footer.jsp" />