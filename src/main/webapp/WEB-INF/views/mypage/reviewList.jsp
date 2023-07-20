<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param value="${loginMember.userId }님의 리뷰" name="title"/>
</jsp:include>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/mypage/reviewList.css?<%=System.currentTimeMillis() %>">
<style>
	.emptystar{
		opacity:0.15;
		font-size:17px;
	}
	.star{
		color:RGB(252, 213, 63);
		font-size:17px;
	}
	.reviewRate span{
		margin-right:-5px;
	}
</style>

<div class="allGGList">
    <div class="reviewCategory">
        <button class="btn reviewBtn readerR" onclick="showLeader();">총대로 받은 리뷰</button>&emsp;&emsp;
        <button class="btn reviewBtn particR" onclick="showParti();">참가자로 받은 리뷰</button>
    </div>

    <br><br><br>
    <table class="allGGListTable" id="leaderReview">
        <c:if test="${empty leaderReview }">
        <tr>
        	<td colspan="5">공구를 열어서 받은 리뷰가 아직 없습니다.</td>
        </tr>
        </c:if>
        <c:forEach items="${leaderReview }" var="lList">
            <tr class="allGGt" >
                <td width="10%">${lList.reviewNo }</td>
                <td width="20%">
	                <c:if test="${fn:length(lList.gongguName) gt 10}">
	                	<a class="gongguName" href="${pageContext.request.contextPath}/gonggu/ggRead.go?gongguNo=${lList.gongguNo }">${fn:substring(lList.gongguName, 0, 10)}⋯</a>
	                </c:if>
	                <c:if test="${fn:length(lList.gongguName) le 10}">
	                	<a class="gongguName" href="${pageContext.request.contextPath}/gonggu/ggRead.go?gongguNo=${lList.gongguNo }">${fn:substring(lList.gongguName, 0, 10)}</a>
	                </c:if>
                	<br>작성자: <a href="${pageContext.request.contextPath}/member/userPf.bo?userPl=${lList.reviewWriter}">${lList.reviewWriter}</a>
                </td>
                <td width="35%">
                	<div class="reviewContent" onclick="reviewDetailModal(${lList.reviewNo});">
                		<c:choose>
                			<c:when test="${fn:length(lList.reviewContent) gt 25}">
                				${fn:substring(lList.reviewContent, 0, 25)}⋯
                			</c:when>
                			<c:otherwise>
			                	${lList.reviewContent }
                			</c:otherwise>
                		</c:choose>
                	</div>
                </td>
                <td width="20%"><div class="reviewRate">점수:
	                <c:forEach begin="1" end="${lList.rate }">
						<span class="star">★</span>
	                </c:forEach>
	                <c:forEach begin="${lList.rate+1 }" end="5">
						<span class="emptystar">★</span>
	                </c:forEach></div>
                </td>
                <fmt:parseDate value="${lList.reviewDate }" var="reviewDate" pattern="yyyy-MM-dd"/>
                <td width="15%"><small><fmt:formatDate value="${reviewDate }" pattern="yyyy년 MM월 dd일"/></small></td>
            </tr>
		</c:forEach>
	</table>
    
    
   <table class="allGGListTable" id="partiReview">
        <c:if test="${empty partiReview }">
            <tr>
            	<td colspan="5">공구에 참여해서 받은 리뷰가 아직 없습니다.</td>
            </tr>
        </c:if>
        <c:forEach items="${partiReview }" var="plist" varStatus="i">
            <tr class="allGGt" >
                <td width="10%">${plist.reviewNo }</td>
                <td width="20%">
	                <c:if test="${fn:length(plist.gongguName) gt 10}">
	                	<a class="gongguName" href="${pageContext.request.contextPath}/gonggu/ggRead.go?gongguNo=${plist.gongguNo }">${fn:substring(plist.gongguName, 0, 10)}⋯</a>
	                </c:if>
	                <c:if test="${fn:length(plist.gongguName) le 10}">
	                	<a class="gongguName" href="${pageContext.request.contextPath}/gonggu/ggRead.go?gongguNo=${plist.gongguNo }">${fn:substring(plist.gongguName, 0, 10)}</a>
	                </c:if>
                	<br>작성자: <a href="${pageContext.request.contextPath}/member/userPf.bo?userPp=${plist.reviewWriter}">
                	${plist.reviewWriter }</a>
                </td>
                <td width="35%">
                	<div class="reviewContent" onclick="reviewDetailModal(${plist.reviewNo});">
                		<c:choose>
                			<c:when test="${fn:length(plist.reviewContent) gt 25}">
                				${fn:substring(plist.reviewContent, 0, 25)}⋯
                			</c:when>
                			<c:otherwise>
			                	${plist.reviewContent }
                			</c:otherwise>
                		</c:choose>
                	</div>
                </td>
                <td width="20%"><div class="reviewRate">점수: 
	                <c:forEach begin="1" end="${plist.rate }">
						<span class="star">★</span>
	                </c:forEach>
	                <c:forEach begin="${plist.rate+1 }" end="5">
						<span class="emptystar">★</span>
	                </c:forEach>
					</div>
				</td>
                	<fmt:parseDate value="${plist.reviewDate }" var="reviewDate" pattern="yyyy-MM-dd"/>
                <td width="15%"><small><fmt:formatDate value="${reviewDate }" pattern="yyyy년 MM월 dd일"/></small></td>
            </tr>
        </c:forEach>
   </table>

</div>




		<!-- 리뷰보기 모달창 -->
	
	<div class="modalR" id="reviewDetailModal">
		<div class="modal-bg" onclick="mClose()"></div>
		<div class="modalR-dialog">
			<div class="modalR-content">
				<div class="modalR-header" style="text-align:center;"><h4 class="modalR-title">리뷰보기</h4></div>
				<div class="modalR-body">
					<table class="reviewModal">
						<tr height="30px">
							<td width="50%" colspan="2">
								<b>공구물건 : </b> <span id="reviewGongguName"></span><br>
							</td>
						</tr>	
						<tr height="30px">
							<td><b>리뷰 작성자 : </b> <span id="reviewWriter"></span></td>
							<td width="50%"><b>점수 : </b><span id="rate"></span></td>
						</tr>
						<tr>
							<td colspan="2"><span id="reviewContent"></span><br></td>
						</tr>			
					</table>
				</div>
				<div class="modalR-footer">
		        	<button type="button" class="button" onclick="javascrip:mClose();">닫기</button>
				</div>
			</div>
		</div>
	</div>

<script>
$("#partiReview").css("display", "none");

function showLeader(){
	$("#partiReview").css("display", "none");
	$("#leaderReview").css("display", "table");
}
function showParti(){
	$("#partiReview").css("display", "table");
	$("#leaderReview").css("display", "none");
}

 	function reviewDetailModal(reviewNo){
 		$('.modalR').addClass('show');
 		$('.modalR-dialog').addClass('show');
 		
 		$.ajax({
 			type:"get",
 			url:"${pageContext.request.contextPath}/review/getReview.re",
 			data:{"reviewNo" : reviewNo},
 			success:function(re){
 				review=re.review;
 				document.getElementById("reviewGongguName").innerHTML=review.gongguName;
 				document.getElementById("reviewWriter").innerHTML=review.reviewWriter;
 				document.getElementById("reviewContent").innerHTML=review.reviewContent;
 				let star='';
 				for(let i=1;i<=review.rate*1;i++){
 					star+="<span class='star'>★</span>";
 				}
 				for(let i=review.rate*1+1;i<=5;i++){
 					star+="<span class='emptystar'>★</span>";
 				}
 				document.getElementById("rate").innerHTML=star;
 			}
 			
 		})
 	};
 	function mClose(){
 		$('.modalR').removeClass('show');
 		$('.modalR-dialog').removeClass('show');
 	};
 	
</script>



<jsp:include page="/WEB-INF/views/common/footer.jsp" />