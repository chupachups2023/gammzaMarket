<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/mypage/chatting.css?<%=System.currentTimeMillis() %>">

<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param value="채팅" name="title"/>
</jsp:include>

<main class="body">
	<div class="css-143d18r">
		<div class="css-1plme8k">
			<nav class="css-dcpzrh">
				<div class="css-fycla4">
					<div>${loginMember.userId}</div>
				</div>
				<div class="css-iyc8t">
					<label class="unread-label common-bg-hover">
						<span class="unread-description">안읽은 메시지만 보기</span>
						<input class="checkbox" type="checkbox">
					</label>
				</div>
				<ul tabindex="0" role="list" aria-label="내 채널 리스트" class="css-8lfz6g">
					<c:forEach items="${chatRoomList}" var="chatRoom">
				<%-- <c:if test="${parti.status eq 1 or chatRoom.roomOwner eq loginMember.userId}"> </c:if>--%>
					<li class="css-v2yhcd">
						<a class="selected css-y6c1l4" id="roomNo" onclick="msgList(${chatRoom.roomNo});" href="#">
							<div class="preview-title-wrap">
								<span class="preview-nickname" id="roomOwner">${chatRoom.roomOwner}</span>
							<div class="sub-text">
								<span id="gongguNo">${chatRoom.gongguNo }</span>
								<span id="lastChat">${chatRoom.lastChat}</span>
							</div>
							</div>
								<img src="${pageContext.request.contextPath}/resources/upload/${list.photo1}" alt="이미지 없음" width="50px">
						</a>
						<div class="common-bg-hover only-hover css-q6qzi5">
							<span class="option-controller">
								<svg width="36" height="36" viewBox="0 0 1024 1024" version="1.1" xmlns="http://www.w3.org/2000/svg"></svg>
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
								<span>${ chatRoom.roomOwner }</span>
								<span class="temperature">37.8°C</span>
							</div>
						</div>

							<div class="more-button-wrapper common-bg-hover">
								<svg width="4" height="16" viewBox="0 0 4 16" fill="none" xmlns="http://www.w3.org/2000/svg">
								</svg>
						</div>
					</div>
						<div heigh="100%">
							<jsp:include page="/WEB-INF/views/mypage/chatDetail.jsp" />
						</div>
			</div>
		</section>
	</div>
</main>

<jsp:include page="/WEB-INF/views/common/footer.jsp" />
<script>
	function msgList(roomNo) {
		location.href = '${pageContext.request.contextPath}/mypage/msgList.do?roomNo=' + roomNo;
	}
</script>
<!-- 
<c:forEach items="${msgList}" var="chatMsg" varStatus ="status">
	<li>
		<a href="${pageContext.request.contextPath}${result.view_url}">
			<span class="cate"><c:out value="${chatMsg.chatWriter}"/></span>
			<div class="txt">
				<strong><c:out value="${chatMsg.chatContent}" escapeXml = "false" /></strong>
				<span class="date"><c:out value="${chatMsg.sendDate}" /></span>
			</div> 
		</a>
	</li>
</c:forEach> 

<script>	
	document.querySelect("#msgList"),addEventListener('click', (e) => {
		$.ajax{(
			url : "chatMsg/msgList.do",
			type : "post",
			dateType : "json",
			data: {param : "${msgList}", num : thisIndex},
			traditional : true,
			success : function(result) {
				console.log(result);
				${"#msgList"}.html(result);
			},
			error :function(jqXHR, textStatus, errorThrown) {
				alert("오류가 발생했습니다.");
			}
		
		
		
		)}		
	})
</script>
 -->