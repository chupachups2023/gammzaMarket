<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/others/gongguRequest.css?<%=System.currentTimeMillis() %>">
<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param value="이런 공구가 있었으면.." name="title"/>
</jsp:include>

<div id="container">
		<table class="table" align="center" >
		<tr>
			<td colspan="3"  class="sort-type" >
			</td>
			<td colspan="3"  class="sort-type align-right">
				<small>
					<input type="radio" name="parti-sort" id="regAt" value="2" checked="checked"><label for="regAt"> 신청 순으로 정렬</label>
					<input type="radio" name="parti-sort" id="endTime" value="0"><label for="endTime"> 마감 순으로 정렬</label> 
				</small>
			</td>
		</tr>
		<c:forEach items="${requestList}" var="list" varStatus="j">
			<tr>
				<th><div class="request-fore">abcd</div></th>
				<th><div class="request-img"><img src="${pageContext.request.contextPath }/resources/upload/${list.photo1}" width="150px"></img></div></th>
				<th>
					<c:choose>
						<c:when test="${fn:length(list.requestName) gt 25}">
							<a href="${pageContext.request.contextPath }/request/requestRead.req?gongguNo=${list.requestNo}" class="ggTitle" >${fn:substring(list.requestName, 0, 25)}⋯ </a>
						</c:when>
						<c:otherwise>
							<a href="${pageContext.request.contextPath }/request/requestRead.req?gongguNo=${list.requestNo}" class="ggTitle">${list.requestName} </a>
						</c:otherwise>
					</c:choose>
				</th>
				<th></th>
				<th></th>
				<th></th>
			</tr>
		</c:forEach>
		</table>
	</div>


<jsp:include page="/WEB-INF/views/common/footer.jsp" />