<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/mypage/ggPartic_List.css?<%=System.currentTimeMillis() %>">

<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param value="${loginMember.userId }님이 참여한 공구" name="title"/>
</jsp:include>


<div id="container">
		<table class="table" align="center" >
		<tr>
			<td colspan="3"  class="sort-type" >
			<small>
				<input type="checkbox" name="onlyOn" id="onlyOn"><label for="onlyOn"> 마감 공구 제외하고 보기</label>
			</small>
			</td>
			<td colspan="3"  class="sort-type align-right">
			<small>
				<input type="radio" name="parti-sort" id="regAt" value="2" checked="checked"><label for="regAt"> 신청 순으로 정렬</label>
				<input type="radio" name="parti-sort" id="endTime" value="0"><label for="endTime"> 마감 순으로 정렬</label> 
			</small>
			</td>
		</tr>
		<c:if test="${empty partiList }">
        <tr>
        	<th colspan="6" height="100px">아직 공구에 참여한 적이 없어요</th>
        </tr>
        </c:if>
		<c:forEach items="${partiList}" var="list" varStatus="j">
			<tr>
				<th><img src="${pageContext.request.contextPath }/resources/upload/${list.photo1}" width="100px"></img></th>
				<th>
					<c:choose>
						<c:when test="${fn:length(list.gongguName) gt 25}">
							<a href="${pageContext.request.contextPath }/gonggu/ggRead.go?gongguNo=${list.gongguNo}" class="ggTitle" >${fn:substring(list.gongguName, 0, 25)}⋯ </a>
						</c:when>
						<c:otherwise>
							<a href="${pageContext.request.contextPath }/gonggu/ggRead.go?gongguNo=${list.gongguNo}" class="ggTitle">${list.gongguName} </a>
						</c:otherwise>
					</c:choose>
				</th>
				<th><fmt:formatNumber type="number" maxFractionDigits="3" value="${list.price }" />P</th>
			<c:choose>
			<c:when test="${list.status eq 0 and list.endStatus eq 0}">
				<th><div>마감된 공구입니다</div></th>
				<th><button class="non"></button></th>
			</c:when>
			<c:when test="${list.status eq 0 and list.endStatus eq 1}">
				<th><div>신청 확인 중</div></th>
				<th><button class="non"></button></th>
			</c:when>
			<c:when test="${list.status eq 1}">
				<th><div>공구 진행 중</div></th>
				<th><button class="bon" onclick='receive("${list.gongguName}",${list.gongguNo });'>물건 받기 완료</button></th>
			</c:when>
			<c:otherwise>
				<th><div>공구 완료</div></th>
				<th><button class="bon" onclick="reviewWriteCheck('${list.gongguWriter}','${list.gongguNo }');">리뷰쓰기</button></th>
			</c:otherwise>
			</c:choose>
				<fmt:parseDate value="${list.createAt }" var="createAt" pattern="yyyy-MM-dd"/>
				<th><fmt:formatDate value="${createAt }" pattern="yyyy.MM.dd."/></th>
			</tr>
		</c:forEach>
		</table>
	</div>
	
			<!-- 리뷰보기 모달창 -->
	
	<div class="modalR" id="reviewDetailModal">
	  <div class="modalR-dialog">
	    <div class="modalR-content">
	    <form name="writeReviewFrm">
	      <div class="modalR-header" style="text-align:center;">
	        <h4 class="modalR-title">리뷰쓰기</h4>
	      </div>
	      <div class="modalR-body">
				<table class="reviewModal">
					<tr height="30px">
						<td width="50%" colspan="2">
							<b>공구물건 : </b> <span id="ggName"></span><br>
						</td>
					</tr>	
					<tr height="30px">
						<td class="receiverId"><b>리뷰 받는 사람 : </b><input name="receiverId"  id="receiver"></td>
						<td width="24%"><b>점수 : </b>
							<span class="star">
								<input type="range" oninput="drawStar(this)" value="100" step="1" min="1" max="1000">
	        					★★★★★
								<span>★★★★★</span>
							</span>
							<input type="hidden" name="rate" id="rate" value="5">
						</td>
					</tr>
					<tr>
						<td colspan="2" ><pre class="reviewContentPre"><textarea name="reviewContent" class="reviewContent"></textarea></pre><br></td>
					</tr>
				</table>
					<input type="hidden" name="gongguNo" id="ggNo">
	      </div>
	      <div class="modalR-footer">
		        <button type="button" class="button" onclick="javascrip:reviewSubmit();">작성완료</button>
		        <button type="button" class="button" onclick="javascrip:mClose();">닫기</button>
	      </div>
	      </form>
	    </div>
	  </div>
	</div>
	
	
<script>
	function receive(gongguName,gongguNo){
		if(	confirm(gongguName+"을(를) 수령하셨나요?") ){
			location.href="${pageContext.request.contextPath }/gonggu/partiStatusUpdate.pa?gongguNo="+gongguNo;
		}else{
			return
		}
	}
	function reviewWriteCheck(id,ggNo){
		let userId=id;
		let gongguNo=ggNo;
		$.ajax({
			url:"${pageContext.request.contextPath }/review/reviewWriteCheck.re",
			data:{"userId":userId, "gongguNo":gongguNo},
			success:function(result){
				const check=result.result*1;
				const gonggu=result.gonggu;
				if(check>0){
					alert("이미 작성을 완료하였습니다.")
				}else{
					document.getElementById("receiver").value=gonggu.gongguWriter;
					document.getElementById("ggName").innerHTML=gonggu.gongguName;
					document.getElementById("ggNo").value=gonggu.gongguNo;
					
					reviewDetailModal(gonggu.gongguNo,gonggu.gongguWriter);
				}
			},
			error:function(){
				console.log("에러!!!!")
			}
			
		})
	}
	
 	function reviewDetailModal(){
 		$('.modalR').addClass('show');
 		$('.modalR-dialog').addClass('show');
 	};
 	function mClose(){
 		$('.modalR').removeClass('show');
 		$('.modalR-dialog').removeClass('show');
 	};
 	let drawStar = (target) => {
 		let val=Math.ceil(target.value/200);
 		let wid=val * 20+"%";
 	    document.querySelector(".star span").style.width = wid;
 	    $("#rate").attr("value",val);
 	  }
 	function reviewSubmit(){
 		let receiverId=writeReviewFrm.receiverId.value
 		let rate=writeReviewFrm.rate.value
 		let reviewContent=writeReviewFrm.reviewContent.value
 		let gongguNo=writeReviewFrm.gongguNo.value
 		
 		if(reviewContent==""){
 			alert("내용을 입력해주세요")
 			return
 		}else{
 			$.ajax({
 				type:"post",
 				url: "${pageContext.request.contextPath }/review/writeReview.re",
 				data: {"receiverId":receiverId,
 					   "rate":rate,
 					   "reviewContent":reviewContent,
 					   "gongguNo":gongguNo
 					  },
 				success:function(result0){
 					const result=result0.result
 					
 					mClose();
 				}
 			})
 		}
 	}
	
</script>
<jsp:include page="/WEB-INF/views/common/footer.jsp" />