<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/css/mypage/chatting.css?<%=System.currentTimeMillis() %>">
<style>
.chat-msg {
	margin: 20 40 40 40;
	property: overflow-y, values: auto hidden visible scroll;
}

.c-List {
	overflow-y: auto;
	overflow-x: hidden;
	visibility: visible;
	scroll-behavior: smooth;
}

.msgBox {
	border: 0px solid;
	height: 5%;
	width: auto;
	background-color: bisque;
	border-radius: 7px;
}

.body {
	height: 700px;
}
</style>
<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param value="채팅" name="title" />
</jsp:include>

<main class="body">
	<div class="css-143d18r">
		<div class="css-1plme8k">
			<nav class="css-dcpzrh">
				<div class="css-fycla4">
					<div>${loginMember.userId}</div><div class="css-1c3oejv"><div class="main-title"><span class="temperature">${loginMember.temperature}°C</span></div></div>
				</div>
				<div class="css-iyc8t">
					<label class="unread-label common-bg-hover"> <span
						class="unread-description">안읽은 메시지만 보기</span> <input
						class="checkbox" type="checkbox">
					</label>
				</div>
				<ul tabindex="0" role="list" aria-label="내 채널 리스트"
					class="css-8lfz6g">
					<c:forEach items="${chatRoomList}" var="chatRoom">
						<%-- <c:if test="${parti.status eq 1 or chatRoom.roomOwner eq loginMember.userId}"> </c:if>--%>
						<li class="css-v2yhcd">
							<div class="selected css-y6c1l4 chatRoomItem" id="${chatRoom.roomNo}" data-room-no="${chatRoom.roomNo}" data-user-id="${loginMember.userId}">
								<c:forEach items="${mainList}" var="list" varStatus="i">
									<c:if test="${chatRoom.gongguNo eq list.gongguNo }">
								<input type="hidden" class="${chatRoom.roomNo}_roomNo" id="roomNo" value="${chatRoom.roomNo}"> 
								<input type="hidden" id="userId" value="${loginMember.userId}">
								<div class="preview-title-wrap">
									<span class="preview-nickname" id="roomOwner">${chatRoom.roomOwner}</span>
										<div class="gongguName">${list.gongguName}</div>	
									<div class="sub-text">
										<span id="gongguNo">${chatRoom.gongguNo}</span>
										<span id="lastChat">${chatRoom.lastChat}</span>
									</div>
								</div>									
										&emsp;&emsp;&emsp;<img
											src="${pageContext.request.contextPath}/resources/upload/${list.photo1}"
											alt="이미지 없음" width="50px">
									</c:if>
								</c:forEach>
							</div>

							<div class="common-bg-hover only-hover css-q6qzi5">
								<span class="option-controller"> <svg width="36"
										height="36" viewBox="0 0 1024 1024" version="1.1"
										xmlns="http://www.w3.org/2000/svg"></svg>
								</span>
							</div>
						</li>
					</c:forEach>
				</ul>
			</nav>
		</div>
		<section class="css-am8mw7">
			<div class="chat-normal-room" id="msgList">
				<div class="css-1c3oejv">
					<div class="chat-header-profile">
						<div class="main-title">
							<span>${ chatRoom.roomOwner }</span> <span class="temperature">${leader.temperature}°C</span>
						</div>
					</div>

					<div class="more-button-wrapper common-bg-hover">
						<svg width="4" height="16" viewBox="0 0 4 16" fill="none"
							xmlns="http://www.w3.org/2000/svg">
								</svg>
					</div>
				</div>

				<div id="result" style="height: 500px" width="900px" class="c-List">
					<input type="hidden" id="chatWriter" value="${loginMember.userId}">
					<input type="hidden" class="${chatRoom.roomNo}_roomNo" id="roomNo"
						value="${chatRoom.roomNo}">
					<%-- <jsp:include page="/WEB-INF/views/mypage/chatDetail.jsp" /> --%>
				</div>
				<div>				 
					<textarea placeholder="메시지를 입력해주세요" id="chatContent"
						class="css-10fmtiz"></textarea>
					<button class="disable css-1useanf" onclick="insertMsg();"
						aria-disabled="true">전송</button>
				</div>
			</div>
		</section>
	</div>
</main>

<jsp:include page="/WEB-INF/views/common/footer.jsp" />
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<script type="text/javascript">
	var currentRoomNo = null;

	$(document).ready(function() {
		$(".chatRoomItem").click(function() {
			var roomNo = $(this).data("room-no");
			var userId = $(this).data("user-id");
			currentRoomNo = roomNo;
			$("#chatRoomOwner").text(userId);
			msgList(roomNo);
		});

		setInterval(function() {
			if (currentRoomNo) {
				msgList(currentRoomNo);
			}
		}, 1000);
	});
	function msgList(roomNo) {
		var userId = $("#userId").val();
		$.ajax({
			url : "${pageContext.request.contextPath}/chatRoom/msgList.do",
			data : {
				roomNo : roomNo
			},
			success : function(list) {
				const msgList = list.MsgList;
				let result = "";
				for ( let i in msgList) {
					let mList = msgList[i];
					if (userId == mList.chatWriter) {
						result += "<div id='msgList'>"
								+ "<div class='chat-msg' id='chat-msg'>"
								+ "<div align='right' id='chatWriter'>"
								+ "<table class='msgBox'>" + "<tr>"
								+ "<td align='right' width='90%' height='10%'>"
								+ mList.chatContent + "</td>" + "</tr>"
								+ "</table>" + "</div>" + "</div>" + "</div>";
					} else {
						result += "<div id='msgList'>"
								+ "<div class='chat-msg' id='chat-msg'>"
								+ "<div>" + mList.chatWriter + "</div>"
								+ "<table class='msgBox'>" + "<tr>" + "<td>"
								+ "<div width='80%'>" + mList.chatContent
								+ "</div>" + "</td>" + "</tr>" + "</table>"
								+ "</div>" + "</div>";
					}
				}
				$("#result").html(result);
			},
			error : function() {
				console.log("리스트 조회 실패");
			}
		});
	}
	$(function() {
		$(".selected").click(function() {
			scrollToBottom();
		});
	});

	function insertMsg() {
		var chatContent = $("#chatContent").val();
		var chatWriter = $("#userId").val();
		var roomNo = $("#roomNo").val();
		$.ajax({
			url : "${pageContext.request.contextPath}/mypage/insertMsg.do",
			method : "POST",
			data : {
				chatContent : chatContent,
				chatWriter : chatWriter,
				roomNo : roomNo
			},
			success : function(result) {
				if (result > 0) {
					console.log("메시지 전송 성공!");
					$("#chatContent").val("");
					msgList(roomNo);
				} else {
					console.log("메시지 전송 성공!");
					$("#chatContent").val("");
					msgList(roomNo);
				}
				scrollToBottom();
			},
			error : function() {
				console.log("메시지 전송 실패");
				console.log(roomNo);
			}
		});
	}
	function scrollToBottom() {
		var element = document.getElementById("result");
		element.scrollTop = element.scrollHeight;
	}

	window.addEventListener("load", function() {
		scrollToBottom();
	});
</script>
