<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param value="관리자 메인화면" name="title"/>
</jsp:include>
<style>
	/* 관리자 메인화면 */
    .adminMain {
		width: 1000px;
		margin: 30px auto;
	}
    .adminMain>h1 {
        text-align: center;
        font-size:30px;
    }
    
    
    /* 관리자 메인화면 아이콘틀 */
    .bigbox{
        width: 800px;
        height: 800px;
        margin-top: 50px;
        margin-left: 180px;
    }
    
    
    /* 관리자 메인화면 아이콘+색(오렌지, 그린) */
    .adminpageBox{
        position: relative;
        width: 300px;
        height: 300px;
        border-radius: 10px;
        display: inline-block;
        margin: 10px;
        cursor: pointer;
    }
    .adminpageBoxHalf{
        position: relative;
        width: 300px;
        height: 137px;
        border-radius: 10px;
        display: inline-block;
        margin: 10px 0 10px 10px;
        cursor: pointer;
    }
    .orange{
        background: #F3CF9F;
    }
    .green{
        background: #95D08B;
    }
    .adminpageBox>div{
        position: absolute;
        top:100px;
        left:50px;
        width: 200px;
        height: 100px;
        background: rgba(255, 255, 255, 0.32);
        border-radius: 20px;
        text-align: center;
        vertical-align: middle;
        font-size: 40px;
        font-weight: bold;
        line-height: 100px;
    }
    .adminpageBoxHalf>div{
        position: absolute;
        top:25px;
        left:50px;
        width: 200px;
        height: 90px;
        background: rgba(255, 255, 255, 0.32);
        border-radius: 20px;
        text-align: center;
        vertical-align: middle;
        font-size: 35px;
        font-weight: bold;
        line-height: 90px;
    }
    .halfbox{
        display: inline-block;
        width:300px;
    }

</style>

<div class="adminMain">
    <h1>관리자 페이지</h1>
    <hr>
    <div class="bigbox">
        <div class="adminpageBox green" onclick="location.href='${pageContext.request.contextPath}/adminpage/noticeList.bo'">
            <div>공지사항</div>
        </div>
        <div class="adminpageBox orange" onclick="location.href='${pageContext.request.contextPath}/adminpage/allGGList.do'">
            <div>전체공구</div>
        </div>
        <div class="adminpageBox orange" onclick="location.href='#'">
            <div class="menuBig">회원정보</div>
        </div>
        <div class="halfbox">
            <div class="adminpageBoxHalf green" onclick="location.href='${pageContext.request.contextPath}/report/reportList.bo'">
                <div>신고목록</div>
            </div>
            <div class="adminpageBoxHalf green" onclick="location.href='${pageContext.request.contextPath}/adminpage/questionList.do'">
                <div>1:1 문의</div>
            </div>
        </div>
    </div>

</div>


<jsp:include page="/WEB-INF/views/common/footer.jsp" />