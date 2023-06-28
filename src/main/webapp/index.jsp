<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<jsp:forward page="/WEB-INF/views/home.jsp"/>
<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param value="감자마켓" name="title"/>
</jsp:include>

<a href="${pageContext.request.contextPath}/gonggu/ggEnd.re" class="button">마감공구로</a>	
테스트 아무거나.. 
테스트 17:40

<jsp:include page="/WEB-INF/views/common/footer.jsp" />

