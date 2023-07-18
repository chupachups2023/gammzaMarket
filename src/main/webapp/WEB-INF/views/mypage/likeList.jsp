<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/css/mypage/likeList.css">

<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param value="찜리스트" name="title"/>
</jsp:include>

<style>
	#selectedPage{
		color: red;
	}
</style>
<div class="mypage-likeListSec">
    <h1>찜한 공구💚</h1>
	<br><br>
	<h4 align="right">
		<input type="checkbox" id="chkAll">전체선택&ensp; |&ensp;
		<a href="javascript:delSelZ();">선택한 찜 삭제</a>&ensp;
	</h4>
    <hr>
	<div class="likeList">
		<form name="delZFrm" method="post" action="deleteZzim.do">
			<c:forEach items="${myLikelist}" var="zzim">
				<div class="onelineThreebox">
					<input class="checklike" type="checkbox" name="delZzim" value="${zzim.zzimNo }">
					<div onclick="location.href='${pageContext.request.contextPath}/gonggu/ggRead.go?gongguNo=${zzim.gongguNo}'">
						<div class="onelineThreeImg">
							<img src="${pageContext.request.contextPath}/resources/upload/${zzim.photo1}">
						</div>
						<div class="onelineThreeTitle">
							<div class="ggTitle">${fn:substring(zzim.gongguName, 0, 10)}...</div>
							<div><b>${zzim.price} point</b></div>
							<div><small>${zzim.locationName}</small></div>
						</div>
					</div>
				</div>
			</c:forEach>
		</form>
	</div>
	
	<br>
	<nav id="pagingNav">
		<ul class="qnaPaging">
			<c:if test="${pi.totalRecord eq 0 }">
				<h1 style="color:gray;">찜한 공구가 없습니다</h1>
			</c:if>
			<c:if test="${pi.nowPage ne 1}">
				<li>
					<a href="${pageContext.request.contextPath}/mypage/likeList.do?nowPage=${pi.nowPage-1}">이전</a>
				</li>
			</c:if>
			<c:forEach var="p" begin="${pi.startPage }" end="${pi.endPage }">
				<c:choose>
					<c:when test="${p eq pi.nowPage }">
						<li>
							<a id="selectedPage" href="${pageContext.request.contextPath}/mypage/likeList.do?nowPage=${p}">[${p}]</a>
						</li>
					</c:when>
					<c:otherwise>
						<li>
							<a href="${pageContext.request.contextPath}/mypage/likeList.do?nowPage=${p}">[${p}]</a>
						</li>
					</c:otherwise>
				</c:choose>
			</c:forEach>
			<c:if test="${pi.nowPage ne pi.totalPage && pi.totalPage ne 0}">
				<li><a href="${pageContext.request.contextPath}/mypage/likeList.do?nowPage=${pi.nowPage+1}">다음</a></li>
			</c:if>
		</ul>
	</nav>

</div>


<script>
	const chkAll = document.querySelector("#chkAll");
	chkAll.addEventListener("change", () => {
		const chkList = document.getElementsByName("delZzim");
		for (delZzim of chkList)
			delZzim.checked = chkAll.checked;
	});
	
	function delSelZ() {
		let chkList = $("input[name=delZzim]");
		if(chkList.is(":checked")){
			delZFrm.submit();
		}else{
			alert("선택된 공구가 없습니다");
		}
	}
	
</script>
<jsp:include page="/WEB-INF/views/common/footer.jsp" />