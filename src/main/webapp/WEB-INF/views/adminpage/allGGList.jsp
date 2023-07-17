<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/adminpage/allGGList.css?<%=System.currentTimeMillis() %>">

<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param value="제목" name="title"/>
</jsp:include>

<div id="container">
	<table class="table" align="center" >
		<tr>
			<td colspan="2"  class="sort-type" >
			<small>
				<input type="checkbox" name="onlyOn" id="onlyOn" ><label for="onlyOn"> 마감 공구 제외하고 보기</label>
			</small>
			</td>
			<td colspan="4"  class="sort-type align-right">
			<small>
				<input type="radio" name="admin-sort" id="regAt" value="2" checked="checked"><label for="regAt"> 최근 오픈 순으로 정렬</label>&emsp;
				<input type="radio" name="admin-sort" id="endTime" value="0"><label for="endTime"> 마감 임박 순으로 정렬</label> 
			</small>
			</td>
		</tr>
		<c:forEach items="${allList}" var="list" varStatus="j">
			<tr>
				<th><img src="${pageContext.request.contextPath }/resources/upload/${list.photo1}" width="100px"></img></th>
				<th width="40%">
					<c:choose>
						<c:when test="${fn:length(list.gongguName) gt 25}">
							<a href="${pageContext.request.contextPath }//gonggu/ggRead.go?gongguNo=${list.gongguNo}" class="ggTitle" >${fn:substring(list.gongguName, 0, 25)}⋯ </a>
						</c:when>
						<c:otherwise>
							<a href="${pageContext.request.contextPath }//gonggu/ggRead.go?gongguNo=${list.gongguNo}" class="ggTitle">${list.gongguName} </a>
						</c:otherwise>
					</c:choose>
				</th>
				<th width="15%">
					<c:choose>
						<c:when test="${list.endStatus eq 1}">
							진행 중 공구
						</c:when>
						<c:otherwise>
							마감 공구
						</c:otherwise>
					</c:choose>
				</th>
				<th width="15%"><fmt:formatNumber type="number" maxFractionDigits="3" value="${list.price }" />P</th>
				<th width="15%"><a href="${pageContext.request.contextPath}/gonggu/deleteGonggu.go?gongguNo=${list.gongguNo}">삭제</a></th>
				<fmt:parseDate value="${list.endTime }" var="endTime" pattern="yyyy-MM-dd"/>
				<th width="15%"><fmt:formatDate value="${endTime }" pattern="yyyy.MM.dd."/></th>
			</tr>
		</c:forEach>
	</table>
</div>


<jsp:include page="/WEB-INF/views/common/footer.jsp" />