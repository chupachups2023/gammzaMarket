<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/css/gonggu/ggRead.css">

<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param value="제목" name="title" />
</jsp:include>

<div class="ggRead-section">
    <div class="ggRead-head">
        <div class="ggRead-title">
            <div class="ggRead-writer ggRead-writer-none">${gonggu.gongguWriter }</div>
            <div class="ggRead-name">${gonggu.gongguName }</div>
            <div class="ggRead-writer" onclick="">${gonggu.gongguWriter }</div>
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
		                ${gonggu.content }
		            </div>
            	</c:otherwise>
            </c:choose>
        </div>
        <div class="ggRead-detail">
            <div class="ggRead-price">개당 <fmt:formatNumber type="number" maxFractionDigits="3" value="${gonggu.price}" /> 포인트</div>
            <div class="ggRead-num">
                <div>${gonggu.num}개 나눠요<span>/</span></div>
                <div class="ggRead-on"> 아직 <span>${gonggu.num - 1}개</span> 남았어요</div>
            </div>
            <fmt:parseDate value="${gonggu.endTime }" var="endTime" pattern="yyyy-MM-dd HH:mm"/>
            <div class="ggRead-endtime"><fmt:formatDate value="${endTime }" pattern="yyyy년 MM월 dd일 HH시 mm분"/>까지 기다려요</div>
            <div class="ggRead-lefttime">2일 23시간 15분 22초 남았어요</div>
            <c:choose>
            	<c:when test="${empty gonggu.link }">
		            <div><a class="ggRead-link-empty"> </a></div>
            	</c:when>
            	<c:otherwise>
		            <div><a href='${gonggu.link}"' target="_blank" class="ggRead-link">물건의 자세한 정보는 여기서 볼 수 있어요</a></div>
            	</c:otherwise>
            </c:choose>
            <div class="ggRead-map">
                <div>여기서 나눠드려요</div>
                <img src="${pageContext.request.contextPath}/resources/upload/image.png" class="ggRead-mapp">
            </div>
        </div>
    </div>
    <div class="ggRead-btn">
        <div class="ggRead-title-right">
            <c:choose>
        		<c:when test="${gonggu.pullupAt eq gonggu.createAt}">
        			<fmt:parseDate value="${gonggu.createAt }" var="createAt" pattern="yyyy-MM-dd"/>
		            <div class="ggRead-date">작성 <fmt:formatDate value="${createAt }" pattern="yyyy년 MM월 dd일"/></div>
        		</c:when>
        		<c:otherwise>
        			<fmt:parseDate value="${gonggu.pullupAt }" var="pullupAt" pattern="yyyy-MM-dd"/>
		            <div class="ggRead-date">작성 <fmt:formatDate value="${pullupAt }" pattern="yyyy년 MM월 dd일"/></div>
        		</c:otherwise>
        	</c:choose>
            <div><img src="https://cdn-icons-png.flaticon.com/512/138/138533.png" alt="zzim" id="zzim"></div>
            <div><img src="https://cdn-icons-png.flaticon.com/512/2089/2089736.png" alt="share"></div>
        </div>
        <div class="ggRead-button">
            <a href="" class="button">참여신청</a>
            <a href="" class="button">채팅하기</a>
        </div>
        <div>
            <div class="ggRead-report"><a href="#">신고</a></div>
            <div class="ggRead-info">
                <div>관심 수 <span>5</span> · </div>
                <div>조회 수 <span>${gonggu.count }</span></div>
            </div>
        </div>
    </div>
</div>
<%-- 
<div class="report" tabindex="-1" id="report">
	<div class="modal-dialog">

		<div class="modal-header">
			<h5 class="modal-title">신고하기</h5>
		</div>
		<form action="${pageContext.request.contextPath}/report/report.do" method="post" id="reportFrm">
			<div class="modal-login">
				<div class="modal-bg"></div>
				<div class="modal-content">
					<h2>신고하기</h2>
					<ul class="login-top">
						<li class="login-info"><input type="text"
							value="${gonggu.gongguWriter}"></li>
						<li class="login-info"><textarea rows="" cols="" name=""
								placeholder="신고내용을 적어주세요"></textarea></li>
						<li class="report-input modal-footer"><input type="button"
							class="report-btn" value="신고하기" id="report-modal"></li>
					</ul>
					<br>
					<button type="button" id="close-modal">취소</button>
				</div>
			</div>
		</form>
	</div>
</div> --%>
<script
	src="${pageContext.request.contextPath}/resources/js/gonggu/ggRead_Partic.js"></script>

<!-- 신고 모달창 -->
<script>
const report = document.getElementById("report");
const openReportBtn = document.getElementById("open-modal");
const closeReportBtn = document.getElementById("close-modal");
const reportModalBtn = document.getElementById("report-modal");
// 모달창 열기
openReportBtn.addEventListener("click", () => {
	report.style.display = "block";
	document.body.style.overflow = "hidden";
});
// 모달창 닫기
closeReportBtn.addEventListener("click", () => {
	report.style.display = "none";
	document.body.style.overflow = "auto"; 
});
// 모달창 닫기
reportModalBtn.addEventListener("click", () => {
	report.style.display = "none";
	document.body.style.overflow = "auto";
	reportFrm.submit();
});
</script>

<jsp:include page="/WEB-INF/views/common/footer.jsp" />