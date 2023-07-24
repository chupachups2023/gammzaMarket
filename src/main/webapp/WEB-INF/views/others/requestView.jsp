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
					<input type="radio" name="request-sort" id="recent" value="recent" checked="checked"><label for="recent"> 최신순 정렬</label>&emsp;
					<input type="radio" name="request-sort" id="member" value="member"><label for="member"> 참가자수 정렬</label> &emsp;
					<input type="radio" name="request-sort" id="count" value="count"><label for="count"> 조회수 정렬</label> 
					<input type="hidden" id="hiddenSort" value="${hiddenSort }">
				</small>
			</td>
		</tr>
		<c:forEach items="${requestList}" var="list" varStatus="j">
			<tr>
				<th><div class="request-fore">abcd</div></th>
				<th><div class="request-img"><img src="${pageContext.request.contextPath }/resources/upload/${list.photo1}"/></div></th>
				<th>
					<c:choose>
						<c:when test="${fn:length(list.requestName) gt 35}">
							<a href="${pageContext.request.contextPath }/ggRequest/requestRead.req?requestNo=${list.requestNo}" class="ggTitle" >${fn:substring(list.requestName, 0, 35)}⋯ </a>
						</c:when>
						<c:otherwise>
							<a href="${pageContext.request.contextPath }/ggRequest/requestRead.req?requestNo=${list.requestNo}" class="ggTitle">${list.requestName} </a>
						</c:otherwise>
					</c:choose>
				</th>
				<th class="reqNum"><div>${list.num }명이<br>원해요</div></th>
				<fmt:parseDate value="${list.recentDate }" var="recentDate" pattern="yyyy-MM-dd"/>
				<th class="recentDate"><fmt:formatDate value="${recentDate }" pattern="yyyy년 MM월 dd일"/>에<br><small>요청 인원이 추가됐어요</small></th>
				<th class="viewCount">${list.count }명이<br>봤어요</th>
			</tr>
		</c:forEach>
		</table>
	</div>
	<div class="writeRequestBtn" onclick="location.href='${pageContext.request.contextPath }/ggRequest/writeRequest.req'"><img alt="글쓰기" src="https://cdn-icons-png.flaticon.com/512/148/148764.png"><div>글쓰기</div></div>

<script>
let latitude='';
let longitude='';
const currSort=document.getElementById("hiddenSort").value;

	
$(":radio[name='request-sort'][value='" + currSort + "']").attr('checked', true);
    
	$("input:radio[name=request-sort]").on('click', function() {
		let requestSort=$("input:radio[name=request-sort]:checked").val();
		if ( requestSort == currSort ){
			return;
		}else{
			if(requestSort == "recent"){
				location.href="${pageContext.request.contextPath}/ggRequest/requestView.req?latitude="+latitude+"&longitude="+longitude+"&sort=recent"
			}else if(requestSort =="member"){
				location.href="${pageContext.request.contextPath}/ggRequest/requestView.req?latitude="+latitude+"&longitude="+longitude+"&sort=member"
			}else{
				location.href="${pageContext.request.contextPath}/ggRequest/requestView.req?latitude="+latitude+"&longitude="+longitude+"&sort=count"
			}
		}
	});
	
function success(position) {
    latitude = position.coords.latitude;   // 위도(37.xxxx)
    longitude = position.coords.longitude;
}

navigator.geolocation.getCurrentPosition(success);

</script>
<jsp:include page="/WEB-INF/views/common/footer.jsp" />