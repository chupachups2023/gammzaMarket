<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param value="결제내역" name="title"/>
</jsp:include>
<style>
	#paymentRecordSec{
		width:1200px;
		margin: 0 auto;
	}
	.pTable{
	    border-collapse: collapse;
	    width:1000px;
		margin: 0 auto;
		text-align:center;
	}
	thead>tr {
		border-bottom: solid 3px #808080;
		font-weight:bold;
		font-size: 20px;
	}
	tbody tr{
	    border-bottom: solid 1px #808080;
	    height:30px;
	}
</style>
<div id="paymentRecordSec">
	<table class="pTable">
		<thead>
			<tr>
				<td width="25%">충전한 포인트</td>
				<td width="25%">충전가격</td>
				<td width="25%">충전수단</td>
				<td width="25%">충전날짜</td>
			</tr>
		</thead>
		<tbody>
			<c:forEach items="${paymentList}" var="payment" varStatus="j">
				<tr>
					<th>${payment.pointName}</th>
					<th>${payment.pointPrice }원</th>
					<th>${payment.paymentMethod }</th>
					<th>${payment.purchasedTime}</th>
				</tr>
			</c:forEach>
		</tbody>
	</table>
</div>

<script>
	
</script>
<jsp:include page="/WEB-INF/views/common/footer.jsp" />