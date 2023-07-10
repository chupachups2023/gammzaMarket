<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/common/home.css?<%=System.currentTimeMillis() %>">
<jsp:include page="/WEB-INF/views/common/mainHeader.jsp" >
	<jsp:param value="main" name="title"/>
</jsp:include>
	<div class="mainSearchSec">
		<h2>어떤 공구를 찾으세요?</h2>
		<form action="" method="get">
			<div class="header-searchbox">
				<img src="${pageContext.request.contextPath}/resources/img/header/search.png" alt="" class="header-searchicon" onclick="fn_srchGgLst()">
				<input type="text" class="mainHeader-search" name="gongguName" id="gongguName" value="${gonggu}"> 
			</div>
		</form>
	</div>
	
 	<div class="main-listSec">
 	
<div class="list-column">
        <c:forEach begin="0" end="${fn:length(homeList)/4 }" varStatus="i">
            <div class="list-row">
                <c:forEach begin="${i.index*4}" end="${(i.index+1)*4 - 1}" items="${homeList}" var="list" varStatus="j">
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
                                <fmt:formatNumber type="number" maxFractionDigits="3" value="${list.price}" />
                            </b>
                        </div>
                        <div class="gghover">
                            <small>동네</small>
                        </div>
                    </div>
                </c:forEach>
            </div>
        </c:forEach>
    </div>
        
        
        
        <div class="moreBtnBox"><button type="button" class="moreBtn button">더보기</button></div>
	</div>
	
<!-- 	<script>
		$(function(){
			$(".main-listSec  .list-goods").hide();
			$(".main-listSec  .list-goods").slice(0, 8).css({display:inline-block;}); 
			$("#load").click(function(e){
				e.preventDefault();
				$(".main-listSec .list-goods:hidden").slice(0, 8).fadeIn(200).css({display:inline-block;}); // 클릭시 more 갯수 지저정
				if($(".main-listSec .list-goods:hidden").length == 0){ // 컨텐츠 남아있는지 확인
					$('#load').fadeOut(100); // 컨텐츠 없을 시 버튼 사라짐
				}
			});
		});
	</script> -->
	
	<script>
        function fn_srchGgLst() {
            var gongguName = document.getElementById('gongguName').value;
            
            var url = '${pageContext.request.contextPath}/gonggu/ggSearch.go?gongguName=' + encodeURIComponent(gongguName);
            location.href = url;
        }
    </script>
	
	 
	 <a href="${pageContext.request.contextPath}/adminpage/questionList.do">문의</a>
	 
	 
<jsp:include page="/WEB-INF/views/common/footer.jsp" />

