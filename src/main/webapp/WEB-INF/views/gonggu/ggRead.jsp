<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/gonggu/ggRead.css?<%=System.currentTimeMillis() %>" type="text/css" />
<script	src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.3/jquery.min.js"></script>
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=44e2b21ec219944c6d834fff124a603d&libraries=services,clusterer"></script>

<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param value="${gonggu.gongguName }" name="title" />
</jsp:include>


<div class="ggRead-section">
    <div class="ggRead-head">
        <div class="ggRead-title">
            <div class="ggRead-writer ggRead-writer-none">${gonggu.gongguWriter }</div>
            <div class="ggRead-name">${gonggu.gongguName }</div>
            <div class="ggRead-writer" onclick="location.href='${pageContext.request.contextPath}/member/userPf.bo?userPr=${gonggu.gongguWriter}'">${gonggu.gongguWriter }</div>
        </div>
    </div>
    <hr class="ggRead-hr">
    <div class="ggRead-body">
        <div class="ggRead-leftside">
            <div class="ggRead-slider-wrap">
                <div class="ggRead-slider-img">
                    <div class="ggRead-slider-inner">
                    	<c:if test="${not empty gonggu.photo1 }">
	                        <div class="ggRead-img-slider"><img src="${pageContext.request.contextPath}/resources/upload/${gonggu.photo1 }"></div>
                    	</c:if>
                    	<c:if test="${not empty gonggu.photo2 }">
	                        <div class="ggRead-img-slider"><img src="${pageContext.request.contextPath}/resources/upload/${gonggu.photo2 }"></div>
                    	</c:if>
                    	<c:if test="${not empty gonggu.photo3 }">
	                        <div class="ggRead-img-slider"><img src="${pageContext.request.contextPath}/resources/upload/${gonggu.photo3 }"></div>
                    	</c:if>
                    </div>
                </div>
                <div class="ggRead-slider-dot">
                </div>
            </div>
            <c:choose>
            	<c:when test="${empty gonggu.content }">
            		<div class="ggRead-content-empty"></div>
            	</c:when>
            	<c:otherwise>
		            <div class="ggRead-content">
		                <pre>${gonggu.content }</pre>
		            </div>
            	</c:otherwise>
            </c:choose>
        </div>
        <div class="ggRead-detail">
            <div class="ggRead-price">개당 <fmt:formatNumber type="number" maxFractionDigits="3" value="${gonggu.price}" /> 포인트</div>
                <c:choose>
                	<c:when test="${gonggu.type eq 0 }">
			            <div class="ggRead-num">
			                <div>${gonggu.num}개 나눠요<span>/</span></div>
					        <div class="ggRead-on"> 지금 <span>${gonggu.num - partiNum}개</span> 남았어요</div>
			            </div>
                	</c:when>
                	<c:otherwise>
			            <div class="ggRead-num">
			                <div>${gonggu.num}명과 나눠요<span>/</span></div>
					        <div class="ggRead-on"> 지금 <span>${gonggu.num - partiNum}명</span> 남았어요</div>
			            </div>
                	</c:otherwise>
                </c:choose>
            <input type="hidden" id="endtime" value="${gonggu.endTime }">
            <fmt:parseDate value="${gonggu.endTime }" var="endTime" pattern="yyyy-MM-dd HH:mm"/>
            <div class="ggRead-endtime"><fmt:formatDate value="${endTime }" pattern="yyyy년 MM월 dd일 HH시 mm분"/>까지 기다려요</div>
            <div class="ggRead-lefttime" id="left-time"></div>
            <c:choose>
            	<c:when test="${empty gonggu.link }">
		            <div><a class="ggRead-link-empty"> </a></div>
            	</c:when>
            	<c:otherwise>
		            <div><a href="${gonggu.link}" target="_blank" class="ggRead-link">물건의 자세한 정보는 여기서 볼 수 있어요</a></div>
            	</c:otherwise>
            </c:choose>
            <div class="ggRead-map">
            	<fmt:parseDate value="${gonggu.sendTime }" var="sendTime" pattern="yyyy-MM-dd"/>
                <div><fmt:formatDate value="${sendTime }" pattern="yyyy년 MM월 dd일"/>에 여기서 나눠드려요</div>
                <div class="ggRead-mapp" id="map"></div>
            </div>
        </div>
    </div>
    <div class="ggRead-btn">
        <div class="ggRead-title-right"  id="zzim">
            <c:choose>
        		<c:when test="${gonggu.pullupAt eq gonggu.createAt}">
        			<fmt:parseDate value="${gonggu.createAt }" var="createAt" pattern="yyyy-MM-dd"/>
		            <div class="ggRead-date">작성 <fmt:formatDate value="${createAt }" pattern="yyyy년 MM월 dd일"/></div>
        		</c:when>
        		<c:otherwise>
        			<fmt:parseDate value="${gonggu.pullupAt }" var="pullupAt" pattern="yyyy-MM-dd"/>
		            <div class="ggRead-date">끌올 <fmt:formatDate value="${pullupAt }" pattern="yyyy년 MM월 dd일"/></div>
        		</c:otherwise>
        	</c:choose>
            <div id="emptyzzim"><img src="https://cdn-icons-png.flaticon.com/512/1077/1077086.png" alt="emptyzzim" onclick="addZzim();" ></div>
            <div id="fullzzim"><img src="https://cdn-icons-png.flaticon.com/512/138/138533.png" alt="fullzzim" onclick="deleteZzim();"></div>
            <div><img src="https://cdn-icons-png.flaticon.com/512/2089/2089736.png" alt="share" onclick="clip();"></div>
        </div>
        <c:choose>
        	<c:when test="${gonggu.gongguWriter eq loginMember.userId}">
       		<div class="ggRead-button">
	            <a href="${pageContext.request.contextPath}/gonggu/update.go?gongguNo=${gonggu.gongguNo}" class="button">공구 수정</a>
	            <a href="${pageContext.request.contextPath}/gonggu/gongguEnd.go?gongguNo=${gonggu.gongguNo}" class="button">공구 마감</a>
	            <a href="javascript:deleteGonggu();" class="button">공구삭제</a>
	            <a href="${pageContext.request.contextPath}/chatRoom/myChatList.bo?roomOwner=${loginMember.userId}" class="button">채팅하기</a>
	            <a href="javascript:pullUpGonggu();" class="button">끌올하기</a>
	            <a href="${pageContext.request.contextPath}/gonggu/checkPartis.pa?gongguNo=${gonggu.gongguNo}" class="button">참여자확인</a>
        	</div>
        	</c:when>
        	<c:when test="${loginMember.userId eq 'admin'}">
       		<div class="ggRead-button">
	            <a href="${pageContext.request.contextPath}/gonggu/update.go?gongguNo=${gonggu.gongguNo}" class="button">공구 수정</a>
	            <a href="${pageContext.request.contextPath}/gonggu/gongguEnd.go?gongguNo=${gonggu.gongguNo}" class="button">공구 마감</a>
	            <a href="javascript:deleteGonggu();" class="button">공구삭제</a>
	            <a href="${pageContext.request.contextPath}/gonggu/checkPartis.pa?gongguNo=${gonggu.gongguNo}" class="button">참여자확인</a>
        	</div>
        	</c:when>
        	<c:when test="${empty loginMember }">
	        <div class="ggRead-button">
	            <a onclick="alert('공구에 참여하려면 먼저 로그인 하세요')" class="button">참여신청</a>
	        </div>
        	</c:when>
        	<c:otherwise>
	        <div class="ggRead-button">
	            <a href="${pageContext.request.contextPath}/gonggu/partiEnroll.pa?gongguNo=${gonggu.gongguNo}" class="button">참여신청</a>
	        </div>
        	</c:otherwise>
        </c:choose>
        <div>
        <c:choose>
        	<c:when test="${empty loginMember.userId}">
        		<div class="ggRead-report"><a id="pzlogin">신고</a></div>
        	</c:when>
        	<c:when test="${gonggu.gongguWriter eq loginMember.userId}">
        		<div class="ggRead-report"><a id="report-none">신고</a></div>
        	</c:when>
        	<c:otherwise>
            	<div class="ggRead-report"><a id="open-report">신고</a></div>
            </c:otherwise>
        </c:choose>
            <div class="ggRead-info">
                <div>관심 수 <span id="zzimCount">
                <c:choose>
                	<c:when test="${ empty zzimCount }">0</c:when>
                	<c:otherwise>${zzimCount }</c:otherwise>
                </c:choose></span> · </div>
                <div>조회 수 <span>${gonggu.count }</span></div>
                <input type="hidden" value="${gonggu.longitude }" id="longitude">
                <input type="hidden" value="${gonggu.latitude }" id="latitude">
            </div>
        </div>
    </div>
</div>

<!-- 신고 모달창 -->
<div class="modal-report" id="report" tabindex="-1">
    <form action="${pageContext.request.contextPath}/report/insertReport.do" method="post" id="reportFrm">

        <div class="report-bg" onclick="closeModal();"></div>
        <div class="report-content" id="report">
            <h2>신고하기</h2>
            <ul class="report-top">
                <li class="report-info">신고글: <input type="text" class="report-gongguName report-info" value="${gonggu.gongguName}" readonly></li>
                <li class="report-info">신고자: <input type="text" id="reportWriter" name="reportWriter" value="${loginMember.userId}"></li>
                <li class="report-info"><span><textarea id="reportContent" rows="20px" cols="90px" name="reportContent" placeholder="신고내용을 적어주세요"></textarea></span></li>
                <li class="report-input modal-footer"><input type="button" class="report-btn button" value="신고하기" id="report-modal"></li>
            </ul>
            <br>
            <button type="button" id="close-report" onclick="closeModal();">취소</button>
        </div>
        <input type="hidden" id="gongguNo" name="gongguNo" value="${gonggu.gongguNo}" />
    </form>
</div>

<script src="${pageContext.request.contextPath}/resources/js/gonggu/ggRead_Partic.js?<%=System.currentTimeMillis() %>"></script>
<script>

let zzimNo="${zzim.zzimNo}";
if(zzimNo==null || zzimNo==""){
	$("#emptyzzim").css("display","block");
}else{
	$("#fullzzim").css("display","block");
}

const longitude= document.getElementById('longitude').value;
const latitude= document.getElementById('latitude').value;

 $.ajax({
	type:"get",
	url:"https://dapi.kakao.com/v2/local/geo/coord2address.json?x="+longitude+"&y="+latitude+"&input_coord=WGS84",
	beforeSend: function (header) {
		header.setRequestHeader("Authorization","KakaoAK ");
    },
    success:function(result){
    	var container = document.getElementById('map'); //지도를 담을 영역의 DOM 레퍼런스
    	var options = { //지도를 생성할 때 필요한 기본 옵션
    		center: new kakao.maps.LatLng(latitude, longitude), //지도의 중심좌표.
    		level: 3 //지도의 레벨(확대, 축소 정도);
    		
    	};
    	var map = new kakao.maps.Map(container, options); //지도 생성 및 객체 리턴
    	
    	// 마커가 표시될 위치입니다 
    	var markerPosition  = new kakao.maps.LatLng(latitude, longitude); 

    	// 마커를 생성합니다
    	var marker = new kakao.maps.Marker({
    	    position: markerPosition
    	});

    	// 마커가 지도 위에 표시되도록 설정합니다
    	marker.setMap(map);
    },
    error:function(){
    	console.log("실패");
    }
});

  
const report = document.getElementById("report");
const openReportBtn = document.getElementById("open-report");
const closeReportBtn = document.getElementById("close-report");
const reportModalBtn = document.getElementById("report-modal");
const pzlogin = document.getElementById("pzlogin");
const mappppp=document.getElementById('map');

// 모달창 열기
openReportBtn.addEventListener("click", () => {
	report.style.display = "block";
	document.body.style.overflow = "hidden";
	
});
// 모달창 닫기
function closeModal() {
	report.style.display = "none";
	document.body.style.overflow = "auto"; 
}
// 모달창 닫기
reportModalBtn.addEventListener("click", () => {
	closeModal();
	reportFrm.submit();
});
pzlogin.addEventListener("click", () => {
	alert("로그인 후 이용가능합니다");
	location.href="${pageContext.request.contextPath}/";
});

function deleteGonggu(){
	if(confirm("정말로 ${gonggu.gongguName} 공구를 삭제하시겠습니까?")){
		let onPartiNum="${onPartiNum}"*1;
		if(onPartiNum>0){
			alert("공구에 참여중인 회원이 있습니다.")
			return
		}else{
			location.href="${pageContext.request.contextPath}/gonggu/deleteGonggu.go?gongguNo=${gonggu.gongguNo}";
		}
	}else{
		return
	}
}
function pullUpGonggu(){
	if(confirm("${gonggu.gongguName} 공구를 끌올하시겠습니까?")){
		location.href="${pageContext.request.contextPath}/gonggu/pullUpGonggu.go?gongguNo=${gonggu.gongguNo}";
	}else{
		return
	}
}
function addZzim(){
	let zzimC=document.getElementById("zzimCount");
	const gongguNo="${gonggu.gongguNo}";
	const userId="${loginMember.userId}";
	if(userId == "" || userId == null){
		alert("찜에 담으려면 먼저 로그인 하세요");
		return
	}else{
		$.ajax({
	       	type:"get",
	       	url:"${pageContext.request.contextPath}/mypage/addZzim.zz",
	       	data:{'gongguNo':gongguNo},
	       	success:function(result){
	       		zzimNo=result;
	       		$("#emptyzzim").css("display","none");
	       		$("#fullzzim").css("display","block");
	       		zzimC.innerHTML=zzimC.innerHTML*1+1;
	       	},
	       	error:function(){
	       		console.log("찜추가 에러");
	       	}
		});
	}
}
function deleteZzim(){
	let zzimC=document.getElementById("zzimCount");
	const gongguNo="${gonggu.gongguNo}";
	$.ajax({
       	type:"get",
       	url:"${pageContext.request.contextPath}/mypage/deleteZzim.zz",
       	data:{'zzimNo':zzimNo},
       	success:function(data){
       		$("#fullzzim").css("display","none");
       		$("#emptyzzim").css("display","block");
       		zzimC.innerHTML=zzimC.innerHTML-1;
       	},
    	error:function(){
       		console.log("찜삭제 에러");
       	}
	});
}
function clip(){

    var url = '';    // <a>태그에서 호출한 함수인 clip 생성
    var textarea = document.createElement("textarea");  
    //url 변수 생성 후, textarea라는 변수에 textarea의 요소를 생성
    
    document.body.appendChild(textarea); //</body> 바로 위에 textarea를 추가(임시 공간이라 위치는 상관 없음)
    url = window.document.location.href;  //url에는 현재 주소값을 넣어줌
    textarea.value = url;  // textarea 값에 url를 넣어줌
    textarea.select();  //textarea를 설정
    document.execCommand("copy");   // 복사
    document.body.removeChild(textarea); //extarea 요소를 없애줌
    
    alert("주소가 복사되었습니다.")  // 알림창
}
</script>
<input type="hidden" id="text">
<jsp:include page="/WEB-INF/views/common/footer.jsp" />
