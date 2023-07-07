<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param value="결제결과" name="title"/>
</jsp:include>

결제되셨습니다!

결제한 포인트 : ${pointOrderNum}<br>
결제 후 포인트 :<%--  ${member.point } --%> <br>




<jsp:include page="/WEB-INF/views/common/footer.jsp" />