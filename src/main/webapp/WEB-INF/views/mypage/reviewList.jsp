<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param value="제목" name="title"/>
</jsp:include>
<<<<<<< Updated upstream

*제목 수정하기
*내용 들어갈 곳
*내가 받은 리뷰 리스트
=======
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/mypage/reviewList.css">

<div class="allGGList">
    <div id="reviewCategory">
        <button class="btn reviewBtn readerR" onclick="">총대로 받은 리뷰</button>&emsp;&emsp;
        <button class="btn reviewBtn particR" onclick="">참가자로 받은 리뷰</button>
    </div>

    <br><br><br>
        
        <table class="allGGListTable">
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
>>>>>>> Stashed changes


<jsp:include page="/WEB-INF/views/common/footer.jsp" />