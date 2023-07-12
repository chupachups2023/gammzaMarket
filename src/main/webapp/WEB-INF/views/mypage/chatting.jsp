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
	property: overflow-y, values: auto hidden visible scroll
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
					<div>${loginMember.userId}</div>
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
						<li class="css-v2yhcd"><a class="selected css-y6c1l4"
							id="roomNo" onclick="'msgList(${chatRoom.roomNo}?userId='${loginMember.userId});" href="#">
								<div class="preview-title-wrap">
									<span class="preview-nickname" id="roomOwner">${chatRoom.roomOwner}</span>
									<div class="sub-text">
										<span id="gongguNo">${chatRoom.gongguNo }</span> <span
											id="lastChat">${chatRoom.lastChat}</span>
									</div>
								</div> <img
								src="${pageContext.request.contextPath}/resources/upload/${list.photo1}"
								alt="이미지 없음" width="50px">
						</a>
							<div class="common-bg-hover only-hover css-q6qzi5">
								<span class="option-controller"> <svg width="36"
										height="36" viewBox="0 0 1024 1024" version="1.1"
										xmlns="http://www.w3.org/2000/svg"></svg>
								</span>
							</div></li>
					</c:forEach>
				</ul>
			</nav>
		</div>
		<section class="css-am8mw7">
			<div class="chat-normal-room" id="msgList">
				<div class="css-1c3oejv">
					<div class="chat-header-profile">
						<div class="main-title">
							<span>${ chatRoom.roomOwner }</span> <span class="temperature">37.8°C</span>
						</div>
					</div>

					<div class="more-button-wrapper common-bg-hover">
						<svg width="4" height="16" viewBox="0 0 4 16" fill="none"
							xmlns="http://www.w3.org/2000/svg">
								</svg>
					</div>
				</div>
		
				<div id="result" style="height: 300px" width="900px">
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
/* const msgListWrapper = function() {
    const msgList = function(roomNo) {
        // 메시지 목록 처리 코드
    };

    setInterval(function() {
        msgList(roomNo);
    }, 1000);
};
 */
/* msgListWrapper(); // msgListWrapper 함수를 호출하여 setInterval을 시작합니다.
 */
	function msgList(roomValue) {
		 $.ajax({
			url:"${pageContext.request.contextPath}/chatRoom/msgList.do",
			data:{
				roomNo : roomValue,
			},
			success:function(list) {
				console
				const msgList = list.MsgList;
				let result = "";
			for(let i in msgList) {
				let mList = msgList[i];
					result += "<div id='msgList'>"
						   + "<div class='chat-msg'>"
						   + "<div>" + mList.chatWriter + "</div>"
						   + "<div>" + mList.chatContent + "</div>"
						   + "</div>"
						   + "</div>";
				} 
				$("#result").html(result);
			},
			error:function() {
				console.log("리스트 조회 실패");
			}
		});
 	}
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
					msgList(); // 메시지 전송 후 목록을 다시 가져올 수 있도록 호출
				}
			},
			error : function() {
				console.log("메시지 전송 실패");
			}
		});
	} 

</script>
