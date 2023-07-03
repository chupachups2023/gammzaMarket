<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/gonggu/ggListView.css?<%=System.currentTimeMillis() %>">
<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param value="공구게시판" name="title"/>
</jsp:include>

<div class="GGlistSec">
    <a href="" class="GGlist-a">최신순</a>&emsp;<a href="" class="GGlist-a">마감 임박순</a>
		<div class="likeList">
        	<c:forEach items="${ggListView}" var="list" varStatus="j">
				<div class="onelineThreebox" onclick="location.href='#';">
					<div class="onelineThreeImg">
						<img src="${pageContext.request.contextPath}/resources/upload/${list.photo1}" alt="이미지 없음">
					</div>
					<div class="onelineThreeTitle">
						<div class="ggTitle">${list.gongguName }</div>
						<div style="font-size: 20px;"><b><fmt:formatNumber type="number" maxFractionDigits="3" value="${list.price}" />P</b></div>
						<div><small>${list.locationName}</small></div>
					</div>
				</div>	
       		 </c:forEach>
		 </div>
</div>




<jsp:include page="/WEB-INF/views/common/footer.jsp" />