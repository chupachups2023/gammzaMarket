<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<script	src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.3/jquery.min.js"></script>

<c:forEach items="${msgList}" var="chatMsg">
	<div>
		${chatMsg.roomNo}
		<c:choose>
			<c:when test="${chatWriter eq loginMember.userId}">
				<div align="right">${chatMsg.chatContent}</div>			
			</c:when>
			<c:otherwise>
				<div>${chatMsg.chatContent}</div>
			</c:otherwise>
		</c:choose>
		${chatMsg.chatWriter}
	</div>
</c:forEach>