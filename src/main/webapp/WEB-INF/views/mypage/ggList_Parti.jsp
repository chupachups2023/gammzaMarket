<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/mypage/ggPartic_List.css?<%=System.currentTimeMillis() %>">

<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param value="내가 참여한 공구" name="title"/>
</jsp:include>


<div id="container">
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
				<th><fmt:formatNumber type="number" maxFractionDigits="3" value="${list.price}" />P</th>
			<c:choose>
			<c:when test="${list.status eq 0 and list.endStatus eq 0}">
				<th><div>마감된 공구입니다</div></th>
				<th><button class="non"></button></th>
			</c:when>
			<c:when test="${list.status eq 0}">
				<th><div>신청 확인 중</div></th>
				<th><button class="non"></button></th>
			</c:when>
			<c:when test="${list.status eq 1}">
				<th><div>공구 진행 중</div></th>
				<th><button class="non"></button></th>
			</c:when>
			<%-- <c:when test="${list.endStatus eq 1}">
				<th><div>공구 진행 중</div></th>
				<th><button class="non"></button></th>
			</c:when> --%>
			<c:otherwise>
				<th><div>공구 마감</div></th>
				<th><button class="bon">리뷰쓰기</button></th>
			</c:otherwise>
			</c:choose>
				<fmt:parseDate value="${list.createAt }" var="createAt" pattern="yyyy-MM-dd"/>
				<th><fmt:formatDate value="${createAt }" pattern="yyyy.MM.dd."/></th>
			</tr>
		</c:forEach>
			<%-- <tr>
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
			</tr> --%>
		</table>
	</div>

<jsp:include page="/WEB-INF/views/common/footer.jsp" />