<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<link rel="stylesheet" 
href="${pageContext.request.contextPath}/resources/css/member/memberInfo.css?<%=System.currentTimeMillis() %>">

<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param value="관리자-회원관리게시판" name="title"/>
</jsp:include>

<div id="MemberManagementBoard">
	<h1 align="center">회원관리</h1>

	<br/>	

	<table class="mTable">
		<thead>
			<tr>
				<th width="50px">NO</th>
				<th width="200px">회원아이디</th>
				<th width="100px">평점</th>
				<th width="150px">가입날짜</th>
				<th width="150px">가입상태</th>
				<th width="150px">탈퇴</th>
			</tr>
		</thead>
		<tbody>
			<c:forEach items="${memberList}" var="member" varStatus="s">
				<tr>
					<td>${pi.totalRecord - ((pi.nowPage-1)*pi.numPerPage)-s.index}</td>
					<td class="title"><a href="${pageContext.request.contextPath}/member/memberInfo_Ad.me?nowPage=${pi.nowPage}&userId=${member.userId}">${member.userId}</a></td>
					<td>${member.temperature}</td>
					<td>${member.createAt2}</td>
					<td>${member.status2}</td>
					<td><button id="chageStatusBtn" onclick="location.href='${pageContext.request.contextPath}/member/changeStatus_Ad.do?userId=${member.userId}&nowPage=${pi.nowPage }'">탈퇴</button></td>
				</tr>
			</c:forEach>
		</tbody>
	</table>
  	<br/>
	
	<nav id="pagingNav">
		<ul class="qnaPaging">
			<c:if test="${pi.nowPage ne 1}">
				<li>
					<a href="${pageContext.request.contextPath}/member/memberList.do?nowPage=${pi.nowPage-1}">이전</a>
				</li>
			</c:if>
			<c:forEach var="p" begin="${pi.startPage }" end="${pi.endPage }">
				<c:choose>
					<c:when test="${p eq pi.nowPage }">
						<li>
							<a href="${pageContext.request.contextPath}/member/memberList.do?nowPage=${p}" id="selectedPage">[${p}]</a>
						</li>
					</c:when>
					<c:otherwise>
						<li>
							<a href="${pageContext.request.contextPath}/member/memberList.do?nowPage=${p}">[${p}]</a>
						</li>
					</c:otherwise>
				</c:choose>
			</c:forEach>
			<c:if test="${pi.nowPage ne pi.totalPage }">
				<li><a href="${pageContext.request.contextPath}/member/memberList.do?nowPage=${pi.nowPage+1}">다음</a></li>
			</c:if>
		</ul>
	</nav>
	<div id="memListBtnBox" align="right">
		<button id="pointRecordBtn" onclick="location.href='${pageContext.request.contextPath}/member/checkPayment_Ad.do'">충전목록</button>
		<button id="memInsertBtn" onclick="location.href='${pageContext.request.contextPath}/member/insertMember_Ad.do'">회원추가</button>
	</div>
</div>	


<jsp:include page="/WEB-INF/views/common/footer.jsp" />