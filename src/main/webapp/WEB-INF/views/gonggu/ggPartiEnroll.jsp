<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/gonggu/ggPartiEnroll.css?<%=System.currentTimeMillis() %>">
<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param value="${gonggu.gongguName }에 참여하기" name="title"/>
</jsp:include>

	<!-- 공구 참여하기 -->
    <div class="partic-title">
        <h1 title="${gonggu.gongguName }">
        	<c:choose>
				<c:when test="${fn:length(gonggu.gongguName) gt 20}">
					<div class="ggTitle" >${fn:substring(gonggu.gongguName, 0, 20)}⋯ 참여 폼</div>
				</c:when>
				<c:otherwise>
					<div class="ggTitle">${gonggu.gongguName} 참여 폼</div>
				</c:otherwise>
			</c:choose>
		</h1>
    </div>
    <div class="partic-container">

        <form action="${pageContext.request.contextPath}/gonggu/partiEnroll.pa" method="post" name="partiEnrollFrm">
            <table>
                <tbody>
                    <tr>
                        <td class="partic-tb-top">공구품 정보</td>
                        <td>
                            <c:choose>
								<c:when test="${fn:length(gonggu.gongguName) gt 20}">
									<div class="ggTitle title-size" title="${gonggu.gongguName }">${fn:substring(gonggu.gongguName, 0, 20)}⋯</div>
								</c:when>
								<c:otherwise>
									<div class="ggTitle title-size" title="${gonggu.gongguName }">${gonggu.gongguName}</div>
								</c:otherwise>
							</c:choose>
                        </td>
                        <td>
                            <img src="${pageContext.request.contextPath}/resources/upload/${gonggu.photo1 }" alt="이미지 없음" style="width: 75px; height: auto;">
                        </td>
                    </tr>
                    <tr>
                        <td colspan="">수량</td>
                        <td>
                        <c:choose>
                        	<c:when test="${gonggu.type eq 0 }">
                            <div class="qttcont">
								<button type="button" onclick="minus();" class="numbtn">-</button>
								<input type="text" name="num" min="1" readonly value="1" id="qttnum">
								<button type="button" onclick="plus();" class="numbtn">+</button>
							</div>
                        	</c:when>
                        	<c:otherwise>
                        		<input type="text" name="num" min="1" readonly value="1" id="qttnum">
                        	</c:otherwise>
                        </c:choose>
                        </td>
                    </tr>
                    <tr class="partic-point">
                        <td>소모 포인트</td>
                        <td colspan="2">
                            <input type="text" class="Parti-td" readonly id="needPoint" value="<fmt:formatNumber type="number" maxFractionDigits="3" value="${gonggu.price}" />"> 포인트
                            <input type="hidden" id="hidden-price" value="${gonggu.price}">
                        </td>
                        
                    </tr>
                    <tr class="partic-point">
                        <td>보유 포인트</td>
                        <td colspan="2">
                            <input type="text" class="Parti-td" readonly value="<fmt:formatNumber type="number" maxFractionDigits="3" value="${loginMember.point}" />"> 포인트
                        </td>
                    </tr>
                    <tr class="partic-point">
                        <td>남는 포인트</td>
                        <td colspan="2">
                            <input type="text" class="Parti-td" readonly id="leftPoint"> 포인트
                        </td>
                    </tr>
                    <tr class="partic-point">
                        <td>부족한 포인트</td>
                        <td>
                            <input type="text" class="Parti-td" readonly id="lackPoint" > 포인트
                        </td>
                        <td><a href="${pageContext.request.contextPath}/member/pointPurchase.do" class="button btn">충전하러 가기</a>
                        </td>
                    </tr>
                    <tr>
                        <td>모집마감시간</td><fmt:parseDate value="${gonggu.endTime}" var="endTime" pattern="yyyy-MM-dd HH:mm"/>
                        <td colspan="2"><fmt:formatDate value="${endTime}" pattern="YYYY년 MM월 dd일 HH시 mm분"/></td>
                    </tr>
                    <tr>
                        <td>교환장소/시간</td><fmt:parseDate value="${gonggu.sendTime}" var="sendTime" pattern="yyyy-MM-dd HH:mm"/>
                        <td colspan="2">${location.sidoNm } ${location.sggNm } ${location.legNm } <br><small><fmt:formatDate value="${sendTime}" pattern="YYYY년 MM월 dd일 HH시 mm분"/> 예정</small> </td>
                    </tr>
                    <tr>
                        <td class="partic-tb-bottom">#유의사항</td>
                        <td colspan="2">조건 확인</td>
                    </tr>
                </tbody>
            </table>
            <input type="hidden" name="gongguNo" value="${gonggu.gongguNo }">
            <input type="hidden" name="locationCode" value="${gonggu.locationNo }">
            <input type="hidden" name="partiMember" value="${loginMember.userId }">
            <div class="partic-btn"><input type="button" value="참여하기" class="button" onclick="partiEnrollSubmit()"></div>
            <!-- 모달창: 유의사항 동의 - 참여하기 -->
        </form>
    </div>
	<input type="hidden" value="${gonggu.price }" id="price">
	<input type="hidden" value="${gonggu.num }" id="amount">
	<input type="hidden" value="${loginMember.point }" id="memberPoint">
<script>
function partiEnrollSubmit(){
	let spendPoint=$("#hidden-price").attr("value");
	let currPoint="${loginMember.point}"*1;
	if(currPoint<spendPoint){
		alert("포인트가 부족합니다.");
		return;
	}else{
		if(confirm("공구에 참여하시겠습니까?")){
			partiEnrollFrm.submit();
		}else{
			return;
		}
	}
}

$(function(){
	let memberPoint=document.getElementById("memberPoint").value;
	let price=document.getElementById("price").value;
	let leftPoint=(memberPoint-price).toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
	if(memberPoint-price>0){
		$("#leftPoint").attr("value",leftPoint);
	}else{
		$("#lackPoint").attr("value",leftPoint);
	}
})
function plus(){
	let amount=document.getElementById("amount").value;
	let atprice=document.getElementById("price").value;
	let qttnum=$("#qttnum").attr("value")*1;
	let partiCount="${partiCount}";
	console.log(partiCount)
	let available=amount-partiCount;
	if($("#qttnum").attr("value")*1+1>available){
		alert("최대 구매 가능 수량은 "+available+"개입니다.");
	}else{
		$("#qttnum").attr("value",qttnum+1);
		$("#hidden-price").attr("value", $("#qttnum").attr("value")*atprice);
		let plusPoint=$("#hidden-price").attr("value")
		
		let leftPoint=document.getElementById("memberPoint").value-plusPoint;
		let Cprice=leftPoint.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
		
		if(leftPoint>=0){
			$("#leftPoint").attr("value",Cprice);
			$("#lackPoint").attr("value",0);
		}else{
			$("#lackPoint").attr("value",Cprice);
			$("#leftPoint").attr("value",0);
		}
		let Vprice=$("#hidden-price").attr("value").replace(/\B(?=(\d{3})+(?!\d))/g, ",");
		$("#needPoint").attr("value",Vprice);
	}
	
	
}
function minus(){
	let amount=document.getElementById("amount").value;
	let atprice=document.getElementById("price").value*1;
	let qttnum=$("#qttnum").attr("value")*1;
	if(qttnum=='1'){
		return;
	}else{ 
		$("#qttnum").attr("value",qttnum-1);
		$("#hidden-price").attr("value", $("#qttnum").attr("value")*atprice);
		let minusPoint=$("#hidden-price").attr("value")
		
		let leftPoint=document.getElementById("memberPoint").value*1-minusPoint*1;
		let Cprice=leftPoint.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
		
		if(leftPoint>=0){
			$("#leftPoint").attr("value",Cprice);
			$("#lackPoint").attr("value",0);
		}else{
			$("#lackPoint").attr("value",Cprice);
			$("#leftPoint").attr("value",0);
		}
		
		let Vprice=$("#hidden-price").attr("value").replace(/\B(?=(\d{3})+(?!\d))/g, ",");
		$("#needPoint").attr("value",Vprice);
	 } 
}
</script>






<jsp:include page="/WEB-INF/views/common/footer.jsp" />