<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<style>
.chat-msg {
	margin: 20 40 40 40;
	property: overflow-y, values: auto hidden visible scroll
}
</style>
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.3/jquery.min.js">
	
</script>

<div id="msgList">
<c:forEach items="${MsgList}" var="chatMsg">
	<div class="chat-msg">
		<c:choose>
			<c:when test="${chatMsg.chatWriter eq loginMember.userId}">
				<div align="right" id="insertMsg">${chatMsg.chatContent}</div>
			</c:when>
			<c:otherwise>
				<div>${chatMsg.chatWriter}</div>
				<div>${chatMsg.chatContent}</div>
			</c:otherwise>
		</c:choose>
	</div>
</c:forEach>
</div>
<div>
	<textarea placeholder="메시지를 입력해주세요" id="chatContent"
		class="css-10fmtiz"></textarea>
	<button class="disable css-1useanf" onclick="insertMsg();"
		aria-disabled="true">전송</button>
</div>
<script>
/* setInterval(function () {
    location.reload();
}, 1000); */
/* 	$(function() {
		setInterval("#msgLisg", 1000);
	});

	function insertMsg() {
		$.ajax({
			url : "/mypage/insertMsg.do",
			data : {
				chatContent : $("#chatContent").val(),
				chatWriter : "${loginMember.userId}"
			},
			dataType : "post",
			success : function(result) {
				if (result > 0) {
					$("#chatContent").val("");
					selectMsgList(); // 메시지 전송 후 목록을 다시 가져올 수 있도록 호출
				}
			},
			error : function() {
				console.log("메시지 전송 실패");
			}
		});
	} */
</script>