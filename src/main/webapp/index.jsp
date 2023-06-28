<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<<<<<<< Updated upstream
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
=======
<%-- <jsp:forward page="/WEB-INF/views/home.jsp"/> --%>
>>>>>>> Stashed changes
<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param value="감자마켓" name="title"/>
</jsp:include>
<a href="${pageContext.request.contextPath}/notice/noticeList.bo">관리자 공지사항</a>
<jsp:include page="/WEB-INF/views/common/footer.jsp" />
	<%-- <jsp:forward page="WEB-INF/views/home.jsp"/> --%>
</body>
</html>

<%-- <jsp:forward page="/WEB-INF/views/home.jsp"/> --%>
