<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/mypage/ggList_Leader.css?<%=System.currentTimeMillis() %>">

<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param value="${loginMember.userId }님이 연 공구" name="title"/>
</jsp:include>

<div id="container">
<h1 align="center" class="ggList_title">내가 연 공구</h1>
	<table class="table" align="center" >
		<tr>
			<td colspan="3"  class="sort-type" >
			<small>
				<input type="radio" name="sort" id="recent" value="recent" <c:if test="${sort eq 'recent' }">checked</c:if> ><label for="recent"> 등록 순으로 정렬</label>
				<input type="radio" name="sort" id="endTime" value="endTime" <c:if test="${sort eq 'endTime' }">checked</c:if> ><label for="endTime" > 마감 순으로 정렬</label>
				<input type="hidden" name="hiddenSort" value="${sort }" id="hiddenSort">
			</small>
			</td>
			<td colspan="3"  class="sort-type align-right">
			<small>
				<input type="checkbox" name="end" id="end" <c:if test="${endStatus eq 1 }">checked</c:if> ><label for="end"> 마감 공구 제외하고 보기</label>
				<input type="hidden" name="hiddenEnd" value="${endStatus }" id="hiddenEnd">
			</small>
			</td>
		</tr>
		<c:if test="${empty leadList }">
        <tr>
        	<th colspan="6" height="100px">아직 공구를 연 적이 없어요</th>
        </tr>
        </c:if>
		<c:forEach items="${leadList}" var="list" varStatus="j">
			<tr>
				<th><img src="${pageContext.request.contextPath }/resources/upload/${list.photo1}" width="100px"></img></th>
				<th width="40%">
					<c:choose>
						<c:when test="${fn:length(list.gongguName) gt 25}">
							<a href="${pageContext.request.contextPath }/gonggu/ggRead.go?gongguNo=${list.gongguNo}" class="ggTitle" >${fn:substring(list.gongguName, 0, 25)}⋯ </a>
						</c:when>
						<c:otherwise>
							<a href="${pageContext.request.contextPath }/gonggu/ggRead.go?gongguNo=${list.gongguNo}" class="ggTitle">${list.gongguName} </a>
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
				<th width="15%"><a href="${pageContext.request.contextPath}/gonggu/checkPartis.pa?gongguNo=${list.gongguNo}">참여자 보기</a></th>
				<fmt:parseDate value="${list.endTime }" var="endTime" pattern="yyyy-MM-dd"/>
				<th width="15%"><fmt:formatDate value="${endTime }" pattern="yyyy.MM.dd."/></th>
			</tr>
		</c:forEach>
		</table>
	</div>

<script>
	$(function(){
		let hiddenSort=document.getElementById("hiddenSort").value;
		let hiddenEnd=document.getElementById("hiddenEnd").value;
		
		$("#recent").on('click', function() {
			if(hiddenSort == "recent"){
				return;
			}else{
				location.href="${pageContext.request.contextPath}/gonggu/ggLeadList.pa?sort=recent&end="+hiddenEnd;
			}
		})
		
		$("#endTime").on('click', function() {
			if(hiddenSort == "endTime"){
				return;
			}else{
				location.href="${pageContext.request.contextPath}/gonggu/ggLeadList.pa?sort=endTime&end="+hiddenEnd;
			}
		})
	})
	$(function(){
		
		$("#end").on('click', function() {
			let hiddenSort=document.getElementById("hiddenSort").value;
			if ( $(this).prop('checked') ) {
				location.href="${pageContext.request.contextPath}/gonggu/ggLeadList.pa?sort="+hiddenSort+"&end=1"
			} else {
				location.href="${pageContext.request.contextPath}/gonggu/ggLeadList.pa?sort="+hiddenSort
			}
		});
	})
</script>

<jsp:include page="/WEB-INF/views/common/footer.jsp" />