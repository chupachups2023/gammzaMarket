<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/mypage/ggPartic_List.css?<%=System.currentTimeMillis() %>">
<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param value="${gonggu.gongguName } 신청자 리스트" name="title"/>
</jsp:include>
<style>
	#container{
		display:flex;
		flex-direction: column;
		align-items: center;
	}
	
	#container>.long-btn{
		width:200px;
		font-size:16px;
	}
	.userId_bold{
		font-weight:bold;
	}
	.writeReview:hover{
		text-decoration:underline;
		cursor:pointer;
	}
</style>
	<h1 align="center">
		<c:choose>
			<c:when test="${fn:length(gonggu.gongguName) gt 25}">
				<a href="${pageContext.request.contextPath }/gonggu/ggRead.go?gongguNo=${gonggu.gongguNo}">${fn:substring(gonggu.gongguName, 0, 25)}⋯ 신청자 리스트</a>
			</c:when>
			<c:otherwise>
				<a href="${pageContext.request.contextPath }/gonggu/ggRead.go?gongguNo=${gonggu.gongguNo}" >${gonggu.gongguName} 신청자 리스트</a>
			</c:otherwise>
		</c:choose>
	</h1>
	<div id="container">
		<table class="table" align="center" id="partiTable" >
			<tr>
				<td colspan="7" class="sortByWhat">
					<a onclick="sortByWhat('regAt');" id="regAt">최신순</a>&emsp;<a onclick="sortByWhat('temperature');" id="temperature">온도순</a>
		   			<input type="hidden" id="sortByHidden" value="${sort }">
				</td>
			</tr>
			<c:if test="${empty partiList }">
				<tr>
					<th colspan="7" height="100px">아직 신청자가 없습니다.</th>
				</tr>
			</c:if>
		<c:forEach items="${partiList}" var="list" varStatus="j">
			<tr>
			<c:choose>
				<c:when test="${list.status > 0 }">
					<th height="50px"> <input name="gongguMem" type="checkbox" value="${j.index}" disabled checked> </th>
				</c:when>
				<c:otherwise>
					<th height="50px"> <input type="checkbox" value="${j.index}" name="gongguMem"> </th>
				</c:otherwise>
			</c:choose>
				<th>${j.count }</th>
				<th class="userId_bold"><a href="${pageContext.request.contextPath}/member/userPf.bo?userPr=${list.userId}">${list.userId }</a></th>
				<th>${list.num }개(인분)</th>
				<th>${list.temperature }도</th>
				<th>
					<c:choose>
						<c:when test="${list.status eq 0 }">
							참여 대기
						</c:when>
						<c:when test="${list.status eq 1 }">
							참여 중
						</c:when>
						<c:otherwise>
							수령 완료
							<div class="writeReview" onclick="reviewWriteCheck('${list.userId}');"><small>참가자 리뷰쓰기</small></div>
						</c:otherwise>
					</c:choose>
				</th>
				
				<th class="dateTd">
					<fmt:parseDate value="${list.regAt }" var="regAt" pattern="yyyy-MM-dd HH:mm"/>
					<fmt:formatDate value="${regAt }" pattern="yyyy년 MM월 dd일 HH시 mm분"/> 신청
				</th>
			</tr>
		</c:forEach>
		</table>
		<button class="long-btn button" onclick="addMember();">공구 참여자로 추가하기</button>
	</div>
	
		<!-- 리뷰보기 모달창 -->
	
	<div class="modalR" id="reviewDetailModal">
	<div class="modal-bg" onclick="mClose()"></div>
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
						<td colspan="2"><pre><textarea name="reviewContent" class="reviewContent"></textarea></pre></td>
					</tr>
				</table>
					<input type="hidden" name="gongguNo" id="ggNo" value="${gonggu.gongguNo}">
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
	function reviewWriteCheck(id){
		let userId=id;
		$.ajax({
			url:"${pageContext.request.contextPath }/review/reviewWriteCheck.re",
			data:{"userId":userId, "gongguNo":${gonggu.gongguNo}},
			success:function(result){
				const parti=result.parti;
				const check=result.result*1;
				if(check>0){
					alert("이미 작성을 완료하였습니다.")
				}else{
					reviewDetailModal(parti.gongguNo,parti.partiMember);
					document.getElementById("receiver").value=parti.partiMember;
					document.getElementById("ggName").innerHTML=parti.gongguName;
					document.getElementById("ggNo").value=parti.gongguNo;
				}
			},
			error:function(){
				console.log("에러!!!!")
			}
			
		})
	}
	function addMember(){
		
		var rowData = [];
		var tdArr = [];
		var checkbox = $("input[name=gongguMem]:checked");
		
		totalNum=0;
		let arr=[];
		checkbox.each(function(i) {
			let tr = checkbox.parent().parent().eq(i);
			let td = tr.children();
			let num = td.eq(3).text().split('개')[0];
			let id = td.eq(2).text();
			totalNum+=num*1;
			arr.push(id);
		});
		const maxNum="${gonggu.num}";
		if(totalNum>(maxNum*1)){
			alert("최대 선택 가능 수량 또는 인원은 "+maxNum+"개(명)입니다");
		}else{
			if(confirm("참여자를 추가하시겠습니까?")){
				let strr='?gongguNo=${gonggu.gongguNo}&';
				for(let i=0;i<arr.length;i++){
					strr+="id="+arr[i]+"&";
				}
				location.href="${pageContext.request.contextPath }/gonggu/partiMemSelect.pa"+strr;
				alert("참여자 선택이 완료되었습니다.")
			}else{
				return;
			}
		}
	};


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
 	$(function(){
 		let sort=$("#sortByHidden").val();
 		if(sort=="temperature"){
 			$("#temperature").css("font-weight","bold");
 		}else{
 			$("#regAt").css("font-weight","bold");
 		}
 	})
 	function sortByWhat(what){
		let sortby=what;
		location.href="${pageContext.request.contextPath}/gonggu/checkPartis.pa?gongguNo=${gonggu.gongguNo}&sort="+sortby;
	}
</script>

<jsp:include page="/WEB-INF/views/common/footer.jsp" />