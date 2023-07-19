	<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/adminpage/admin.css?<%=System.currentTimeMillis() %>">
<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param value="관리자 메인화면" name="title"/>
</jsp:include>

<div class="adminMain">
    <h1>관리자 페이지</h1>
    <hr>
    <div class="bigbox">
        <div class="adminpageBox green" onclick="location.href='${pageContext.request.contextPath}/adminpage/noticeList.bo?nowPage=${nowPage}'">
            <div>공지사항</div>
        </div>
        <div class="adminpageBox orange" onclick="location.href='${pageContext.request.contextPath}/adminpage/allGGList.do'">
            <div>전체공구</div>
        </div>
        <div class="adminpageBox orange" onclick="location.href='${pageContext.request.contextPath}/member/memberList.do'">
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