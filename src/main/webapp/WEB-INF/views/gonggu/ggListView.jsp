<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/gonggu/ggListView.css?<%=System.currentTimeMillis() %>">
<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param value="공구게시판" name="title"/>
</jsp:include>
<div class="currAdd"><span class="location-title">현재 접속 동네: </span><span id="address"></span></div>
<div class="GGlistSec">
<c:if test="${empty loginMember }">
	<div class="loginWarning" id="loginWarning">
		<div><img alt="close" src="https://cdn-icons-png.flaticon.com/512/2961/2961937.png" onclick="closeWarning();"></div>
		<div>로그인하지 않고 사용할 경우 정확한 주변의 공구를 가져오지 못할 수 있습니다.</div>
	</div>
</c:if>
	<div class="sortByPart">
		<div>
		   	<a onclick="sortByWhat('PULLUP_AT');" class="GGlist-a" id="pullup">최신순</a>&emsp;<a onclick="sortByWhat('END_TIME');" class="GGlist-a" id="end">마감 임박순</a>
		   	<input type="hidden" id="sortByHidden" value="${sortByHidden }">
	   	</div>
	   	<div><input type="checkbox" id="withEnd"   <c:if test="${endStatus eq 0 }">checked</c:if>  ><label for="withEnd">마감 공구도 보기</label></div>
   	</div>
	<div class="likeList">
	<c:choose>
		<c:when test="${empty ggListView }">
			<div class="emptyggList"><div>현재 위치에서 조회되는 공구가 없습니다.</div></div>
		</c:when>
		<c:otherwise>
	       	<c:forEach items="${ggListView}" var="list" varStatus="j">
				<div class="onelineThreebox" onclick="location.href='${pageContext.request.contextPath}/gonggu/ggRead.go?gongguNo=${list.gongguNo }'">
					<div class="onelineThreeImg">
						<img src="${pageContext.request.contextPath}/resources/upload/${list.photo1}" alt="이미지 없음">
					</div>
					<div class="onelineThreeTitle">
						<c:choose>
							<c:when test="${fn:length(list.gongguName) gt 17}">
								<div class="ggTitle">${fn:substring(list.gongguName, 0, 17)}⋯</div>
							</c:when>
							<c:otherwise>
								<div class="ggTitle">${list.gongguName}</div>
							</c:otherwise>
						</c:choose>
						<c:choose>
							<c:when test="${list.endStatus eq 0 }">
							<div class="when-ggEnd">
								<div class="ggEnd-tag"><b>마감공구</b></div>
								<div  style="font-size: 20px;">
								    <b><fmt:formatNumber type="number" maxFractionDigits="3" value="${list.price}" /> P</b>
								</div>
							</div>
							</c:when>
							<c:otherwise>
								<div style="font-size: 20px;">
								    <b><fmt:formatNumber type="number" maxFractionDigits="3" value="${list.price}" /> P</b>
								</div>
							</c:otherwise>
						</c:choose>
						<div><small>${list.locationName}</small></div>
					</div>
				</div>	
			</c:forEach>
		</c:otherwise>
	</c:choose>
	</div>
</div>
<script>
	function closeWarning(){
		$('#loginWarning').css('display', 'none');
	}
	
    const latitude = "${location.latitude}";
    const longitude = "${location.longitude}";
    
	$.ajax({
    	type:"get",
    	url:"https://dapi.kakao.com/v2/local/geo/coord2address.json?x="+longitude+"&y="+latitude+"&input_coord=WGS84",
    	beforeSend: function (header) {
    		header.setRequestHeader("Authorization","KakaoAK ");
        },
        success:function(result){
        	var address=result.documents[0].address.address_name;
        	let arr=address.split(" ");
        	add=arr[0]+" "+arr[1]+" "+arr[2];
        	document.getElementById("address").innerHTML=add;
        	
        }
	});
	function sortByWhat(what){
		let sortby=what;
		let keywordd="${keyword}";
		let category="${category}";
		if($("#withEnd").prop('checked')){
			if(keywordd != ""){
				location.href="${pageContext.request.contextPath}/gonggu/ggSearch.go?latitude="+latitude+"&longitude="+longitude+"&sort="+sortby+"&end=0&gongguName="+keywordd;
			}else{
				if(category != ""){
					location.href="${pageContext.request.contextPath}/gonggu/categoryList.go?category=" + category+"&latitude="+latitude+"&longitude="+longitude+"&sort="+sortby+"&end=0";
				}else{
					location.href="${pageContext.request.contextPath}/gonggu/ggListView.go?latitude="+latitude+"&longitude="+longitude+"&sort="+sortby+"&end=0";
				}
			}
		}else{
			if(keywordd != ""){
				location.href="${pageContext.request.contextPath}/gonggu/ggSearch.go?latitude="+latitude+"&longitude="+longitude+"&sort="+sortby+"&gongguName="+keywordd;
			}else{
				if(category != ""){
					location.href="${pageContext.request.contextPath}/gonggu/categoryList.go?category=" + category+"&latitude="+latitude+"&longitude="+longitude+"&sort="+sortby;
				}else{
					location.href="${pageContext.request.contextPath}/gonggu/ggListView.go?latitude="+latitude+"&longitude="+longitude+"&sort="+sortby;
				}
			}
		}
	}
	$(function(){
		sortbyy=document.getElementById("sortByHidden").value;
		let keywordd="${keyword}";
		let category="${category}";
		if(sortbyy=="PULLUP_AT"){
			$("#pullup").css("font-weight","bold");
		}else{
			$("#end").css("font-weight","bold");
		}
		
		$("#withEnd").on('click', function() {
			if ( $(this).prop('checked') ) {
				if(keywordd != ""){
					location.href="${pageContext.request.contextPath}/gonggu/ggSearch.go?latitude="+latitude+"&longitude="+longitude+"&sort="+sortbyy+"&end=0&gongguName="+keywordd
				}else{
					if(category != ""){
						location.href="${pageContext.request.contextPath}/gonggu/categoryList.go?category=" + category+"&latitude="+latitude+"&longitude="+longitude+"&sort="+sortbyy+"&end=0"
					}else{
						location.href="${pageContext.request.contextPath}/gonggu/ggListView.go?latitude="+latitude+"&longitude="+longitude+"&sort="+sortbyy+"&end=0"
					}
				}
			} else {
				if(keywordd != ""){
					location.href="${pageContext.request.contextPath}/gonggu/ggSearch.go?latitude="+latitude+"&longitude="+longitude+"&sort="+sortbyy+"&gongguName="+keywordd
				}else{
					if(category != ""){
						location.href="${pageContext.request.contextPath}/gonggu/categoryList.go?category=" + category+"&latitude="+latitude+"&longitude="+longitude+"&sort="+sortbyy
					}else{
						location.href="${pageContext.request.contextPath}/gonggu/ggListView.go?latitude="+latitude+"&longitude="+longitude+"&sort="+sortbyy
					}
				}
			}
		});
	})
</script>



<jsp:include page="/WEB-INF/views/common/footer.jsp" />
