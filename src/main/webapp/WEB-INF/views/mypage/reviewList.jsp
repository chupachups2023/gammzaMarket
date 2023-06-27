<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param value="마이 리뷰게시판" name="title"/>
</jsp:include>


<style>
	/* 마이페이지 리뷰게시판 */
    .allGGList {
        width: 1500px;
        margin: 30px auto;
    }
    /* 리뷰 카테고리박스 */
    .reviewCategory {
        text-align: center;
    }
    /* 리뷰카테고리버튼 */
    .reviewBtn{
        display: inline-block;
        height: 50px;
        width: 300px;

        background: rgba(94, 177, 98, 0.75);
        border: none;
        border-radius: 15px;
        color: aliceblue;
        font-size: large;
        font-weight: bold;
    }
    .readerR {
        margin-left: 30%;
    }
    
    /*리뷰 테이블*/
    .allGGListTable{
        border-top: 1px solid;
        border-collapse: collapse;
        width: 1100px;
        text-align: center;
        margin:auto;
    }

    .allGGListTable td{
        vertical-align: middle;
        border-bottom: 1px solid;
        height: 100px;}
    
    
    .btn-reviewDetail{
    	border:none;
    	background:none
    }
    
	/* 마이페이지 리뷰상세보기 모달 */
    .modalR {
    	position: fixed;
    	left: 0;top: 0;
		background: rgba(0, 0, 0, 0.52);
		width: 100%;height: 100vh;
		display: none
		}
    .modalR-dialog {
    	position:absolute;
    	top:50%;
    	left:50%;
    	width:500px;
    	height:400px;
    	transform: translate(-50%,-50%);
    	border-radius: 10px;
    	display:none;
    	background-color:white;
    }
    .modalR.show{
    	display:block;
    }
    .modalR-dialog.show{
    	display:block;
    }
    .modalR-body{
    	margin:auto;
    }
    .reviewModal{
        border: 1px solid;
        border-collapse: collapse;
        width: 400px;
        height: 250px;
        margin:auto;
    }
    .reviewModal td {
    	border:1px solid;
    }
    .btn-close {
        display: inline-block;
        width: 50px;
        height: 20px;
        margin-left:225px;

        background: rgba(94, 177, 98, 0.75);
        border: none;
        border-radius: 5px;
        color: aliceblue;
        font-weight: bold;
    }
    

</style>

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
        

        <!-- 
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
            <c:forEach>
        </table>

         -->
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