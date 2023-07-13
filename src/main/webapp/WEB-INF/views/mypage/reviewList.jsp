<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param value="마이 리뷰게시판" name="title"/>
</jsp:include>

<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/mypage/reviewList.css">


<div class="allGGList">
    <div id="reviewCategory">
        <button class="btn reviewBtn readerR" onclick="">총대로 받은 리뷰</button>&emsp;&emsp;
        <button class="btn reviewBtn particR" onclick="">참가자로 받은 리뷰</button>
    </div>

    <br><br><br>
<<<<<<< Updated upstream
        
        <table class="allGGListTable">
            <tr class="allGGt">
                <td width="10%">번호</td>
=======
                <table class="allGGListTable" id="partiReview">
                <c:if test="${empty partiReview }">
                <tr>
                	<td colspan="5">공구에 참여해서 받은 리뷰가 아직 없습니다.</td>
                </tr>
                </c:if>
        <c:forEach items="${partiReview }" var="plist" varStatus="i">
            <tr class="allGGt" >
                <td width="10%">${plist.reviewNo }</td>
>>>>>>> Stashed changes
                <td width="20%">
                	공구글 제목<br>
                	총대 아이디
                </td>
                <td width="40%">
                	<button class="btn btn-reviewDetail" type="button" onclick="reviewDetailModal();">리뷰 내용</button>
                </td>
                <td width="20%">점수: ⭐⭐⭐⭐⭐</td>
                <td width="10%">게시날짜</td>
            </tr>
            <tr class="allGGt">
                <td width="10%">번호</td>
                <td width="20%">
                	공구글 제목<br>
                	총대 아이디
                </td>
                <td width="40%">
                	<button class="btn btn-reviewDetail" type="button" onclick="reviewDetailModal();">리뷰 내용</button>
                </td>
                <td width="20%">점수: ⭐⭐⭐⭐⭐</td>
                <td width="10%">게시날짜</td>
            </tr>
            <tr class="allGGt">
                <td width="10%">번호</td>
                <td width="20%">
                	공구글 제목<br>
                	총대 아이디
                </td>
                <td width="40%">
                	<button class="btn btn-reviewDetail" type="button" onclick="reviewDetailModal();">리뷰 내용</button>
                </td>
                <td width="20%">점수: ⭐⭐⭐⭐⭐</td>
                <td width="10%">게시날짜</td>
            </tr>
        </table>
        


<<<<<<< Updated upstream
        <%-- 

        <table class="allGGListTable">
            <c:forEach >
                <tr class="allGGt">
                    <td width="10%">번호</td>
                    <td width="20%">
                        공구글 제목<br>
                        총대 아이디
                    </td>
                    <td width="40%">
                        <button class="btn btn-reviewDetail" type="button" onclick="reviewDetailModal();">리뷰 내용</button>
                    </td>
                    <td width="20%">점수: </td>
                    <td width="10%">게시날짜</td>
                    
                </tr>

            </c:forEach>
=======
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
                	<div class="gongguName" onclick="location.href='${pageContext.request.contextPath}/gonggu/ggRead.go?gongguNo=${list.gongguNo }'">${fn:substring(lList.gongguName, 0, 10)}⋯</div>
                </c:if>
                <c:if test="${fn:length(lList.gongguName) le 10}">
                	<div class="gongguName" onclick="location.href='${pageContext.request.contextPath}/gonggu/ggRead.go?gongguNo=${list.gongguNo }'">${fn:substring(lList.gongguName, 0, 10)}</div>
                </c:if>
                	${lList.reviewWriter }
                </td>
                
                <td width="35%">
                	<div class="reviewContent" onclick="reviewDetailModal(${lList.reviewNo});"><pre>${lList.reviewContent }</pre></div>
                </td>
                <td width="20%"><div class="reviewRate">점수:
                <c:forEach begin="1" end="${lList.rate }">
					<span class="star">★</span>
                </c:forEach>
                <c:forEach begin="${lList.rate+1 }" end="5">
					<span class="emptystar">★</span>
                </c:forEach></div></td>
                <fmt:parseDate value="${lList.reviewDate }" var="reviewDate" pattern="yyyy-MM-dd"/>
                <td width="15%"><small><fmt:formatDate value="${reviewDate }" pattern="yyyy년 MM월 dd일"/></small></td>
            </tr>
        </c:forEach>
>>>>>>> Stashed changes
        </table>

         --%>

</div>




		<!-- 리뷰보기 모달창 -->
	
	<div class="modalR" id="reviewDetailModal">
	  <div class="modalR-dialog">
	    <div class="modalR-content">
	      <div class="modalR-header" style="text-align:center;">
	        <h4 class="modalR-title">리뷰보기</h4>
	      </div>
	      <div class="modalR-body">
				<table class="reviewModal">
					<tr height="50px">
						<td width="50%">
							&emsp;<b>공구물건 : </b> <br>
							&emsp;<b>리뷰 작성자 : </b>
						</td>
						<td width="50%">&emsp;<b>점수 : </b></td>
					</tr>	
					<tr>
						<td colspan="2">&emsp;리뷰내용</td>
					</tr>			
				</table>
	      </div>
	      <div class="modalR-footer">
	        <br><button type="button" class="btn-close" onclick="javascrip:mClose();">닫기</button><br><br>
	      </div>
	    </div>
	  </div>
	</div>

<script>
 	function reviewDetailModal(){
 		$('.modalR').addClass('show');
 		$('.modalR-dialog').addClass('show');
 	};
 	function mClose(){
 		$('.modalR').removeClass('show');
 		$('.modalR-dialog').removeClass('show');
 	};
</script>



<jsp:include page="/WEB-INF/views/common/footer.jsp" />