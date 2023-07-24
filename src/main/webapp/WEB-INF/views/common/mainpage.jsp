<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/common/mainpage.css?<%=System.currentTimeMillis() %>">
<jsp:include page="/WEB-INF/views/common/mainHeader.jsp" >
	<jsp:param value="감자마켓💚" name="title"/>
</jsp:include>
	<div class="mainSearchSec">
		<h2>어떤 공구를 찾으세요?</h2>
		<div class="header-searchbox">
			<img src="${pageContext.request.contextPath}/resources/img/header/search.png" alt="" class="header-searchicon" onclick="fn_srchGgLst()">
			<input type="text" class="mainHeader-search" name="gongguName" id="gongguName" value="${keyword}" onkeyup="if(window.event.keyCode==13){fn_srchGgLst()}"> 
		</div>
		<div>파는 사이트 아니고 같이 사는 사이트입니다^^</div>
	</div>
	
 	<div class="main-listSec">
        <div class="list-row">
			<c:forEach items="${mainList}" var="list" varStatus="i">
				<div class="list-goods" onclick="location.href='${pageContext.request.contextPath}/gonggu/ggRead.go?gongguNo=${list.gongguNo }'">
					<div class="ggImg gghover">
					    <img src="${pageContext.request.contextPath}/resources/upload/${list.photo1}" alt="이미지 없음">
					</div>
					<c:choose>
						<c:when test="${fn:length(list.gongguName) gt 10}">
							<div class="ggTitle gghover">${fn:substring(list.gongguName, 0, 10)}...</div>
						</c:when>
						<c:otherwise>
							<div class="ggTitle gghover">${list.gongguName}</div>
						</c:otherwise>
					</c:choose>
					<div class="gghover">
					    <b>
						<fmt:formatNumber type="number" maxFractionDigits="3" value="${list.price}" /> P
					    </b>
					</div>
					<div class="gghover">
					    <small>${list.locationName}</small>
					</div>
				</div>
			</c:forEach>
			
		</div>
		<div class="moreList-row"></div>
		<div class="moreBtnBox">
			<button type="button" class="moreBtn button" onclick="moreList();">더보기</button>
		</div>
	</div>
	<script>
		/* 더보기 버튼 방법1 */
/* 		let page = 8;	//한번에 보여줄 상품 개수
		$(function(){
			$(".list-goods").hide();
			$(".list-goods").slice(0, page).show();
		});
		
		function moreList(){
			if($(".list-goods:hidden").length >= page){			//보여지지 않은 상품 개수가 보여주고자하는 개수와 같거나 많은지
				$(".list-goods:hidden").slice(0, page).fadeIn(200); // 클릭시 more 갯수 미정
				if($(".list-goods:hidden").length == 0){ 		// 컨텐츠 남아있는지 확인
					$('.moreBtn').fadeOut(100); 				// 컨텐츠 없을 시 버튼 사라짐
				}
			}else{
				$(".list-goods:hidden").slice(0, $(".list-goods:hidden").length).fadeIn();
				$('.moreBtn').fadeOut(100);
			}
		} */
		
		/* 더보기 버튼 방법2 */
		let page =1;
 		function moreList(){
 			console.log(page);
 			page++;
 			console.log(page);
			$.ajax({
				url:'${pageContext.request.contextPath}/gonggu/mainList.go',
				type:'post',
				dataType:'json',
				data:{page:page},
				success:function(data){
					console.log(data.result);
					const itemArr = data.result;
					let value = "";
					console.log(data.result[0]);
					for(let i in itemArr){
						value += `<div class="list-goods" onclick="location.href='${pageContext.request.contextPath}/gonggu/ggRead.go?gongguNo=`
							+ itemArr[i].gongguNo +`'">`
							+ '<div class="ggImg gghover">'
							+ '<img src="${pageContext.request.contextPath}/resources/upload/' +itemArr[i].photo1+'" alt="이미지 없음">' 
							+ '</div>' + '<div class="ggTitle gghover">';
						if(itemArr[i].gongguName.length > 10){ 
							value += itemArr[i].gongguName.substring(0, 10)+'...</div>';
						}else {
							value += itemArr[i].gongguName+'</div>';
						}
						value += '<div class="gghover"><b>'+Number(itemArr[i].price).toLocaleString()+' P</b></div>'
				 		+'<div class="gghover"><small>' + itemArr[i].locationName +'</small></div></div>';
					}
					const moreList = document.querySelector(".moreList-row");
					moreList.innerHTML += value;
					if(itemArr.length<8){
						$(".moreBtnBox").remove();
					}
				},
				error:function(){
					console.log("실패");
				}
			});
		} 
		
		
		function fn_srchGgLst() {
			var gongguName = document.getElementById('gongguName').value;
			
			var url = '${pageContext.request.contextPath}/gonggu/ggSearch.go?gongguName=' + encodeURIComponent(gongguName);
			
			 if (!navigator.geolocation) {
		        alert("위치 정보가 지원되지 않습니다.");
		    }else{
				function success(position) {
				    /* const latitude = position.latitude;   
				    const longitude = position.longitude; */
 				    const latitude = position.coords.latitude;   
				    const longitude = position.coords.longitude;
				    
				    location.href=url+"&longitude="+longitude+"&latitude="+latitude;
				};
		    	navigator.geolocation.getCurrentPosition(success);
				/* position={"latitude":37.533921602961506, "longitude":126.89677032759451 } */
		        success(position);
		    }
		}
    </script>
	
<jsp:include page="/WEB-INF/views/common/footer.jsp" />

