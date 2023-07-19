<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/member/pointPurchase.css">
<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param value="회원 포인트 충전 목록" name="title"/>
</jsp:include>
<div id="paymentRecordSec">
	<h1 align="center">회원 포인트 충전 목록</h1><br><br>
	<table class="pTable">
		<thead>
			<tr>
				<td width="20%">충전결제번호</td>
				<td width="15%">아이디</td>
				<td width="20%">충전한 포인트</td>
				<td width="15%">충전가격</td>
				<td width="15%">충전수단</td>
				<td width="20%">충전날짜</td>
			</tr>
		</thead>
		<tbody>
			<c:forEach items="${paymentList}" var="payment" varStatus="j">
				<tr>
					<th>${payment.pointOrderNum}</th>
					<th>${payment.userId}</th>
					<th>${payment.pointName}</th>
					<th>${payment.pointPrice }원</th>
					<th>${payment.paymentMethod }</th>
					<th>${payment.purchasedTime}</th>
				</tr>
			</c:forEach>
		</tbody>
	</table>
	<br>
	<nav id="pagingNav">
		<ul class="qnaPaging">
			<c:if test="${pi.nowPage ne 1}">
				<li>
					<a href="${pageContext.request.contextPath}/member/checkPayment_Ad.do?nowPage=${pi.nowPage-1}">이전</a>
				</li>
			</c:if>
			<c:forEach var="p" begin="${pi.startPage }" end="${pi.endPage }">
				<c:choose>
					<c:when test="${p eq pi.nowPage }">
						<li>
							<a href="${pageContext.request.contextPath}/member/checkPayment_Ad.do?nowPage=${p}" id="selectedPage">[${p}]</a>
						</li>
					</c:when>
					<c:otherwise>
						<li>
							<a href="${pageContext.request.contextPath}/member/checkPayment_Ad.do?nowPage=${p}">[${p}]</a>
						</li>
					</c:otherwise>
				</c:choose>
			</c:forEach>
			<c:if test="${pi.nowPage ne pi.totalPage }">
				<li><a href="${pageContext.request.contextPath}/member/checkPayment_Ad.do?nowPage=${pi.nowPage+1}">다음</a></li>
			</c:if>
		</ul>
	</nav>
</div>
<button id="PurBackBtn" onclick="location.href='${pageContext.request.contextPath}/member/memberList.do'">뒤로가기</button>
<jsp:include page="/WEB-INF/views/common/footer.jsp" />