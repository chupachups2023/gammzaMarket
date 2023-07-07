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
					<div class="nickname-area">${loginMember.userId}</div>
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
						<a class="selected css-y6c1l4" id="msgList" onclick="msgList(${chatRoom.roomNo});" href="">
							<div class="preview-title-wrap">
								<span class="preview-nickname">${chatRoom.roomOwner}</span>
							<div class="sub-text">
								<span>${chatRoom.gongguNo }</span>
								<span>${parti.status}</span>
								<span>${chatRoom.lastChat}</span>
							</div>
							</div>
								<img src="${pageContext.request.contextPath}/resources/img/chatting/Rectangle 3.png" class="preview-image" alt="" width="50px">
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
				<div class="css-voabwl">
					<div class="css-1c3oejv">
						<div class="chat-header-profile">
							<div class="main-title">
								<span>${ chatRoom.roomOwner }</span>
								<span class="temperature">37.8°C</span>
							</div>
						</div>
						<div class="css-1idbtsb">
							<div class="more-button-wrapper common-bg-hover">
								<svg width="4" height="16" viewBox="0 0 4 16" fill="none" xmlns="http://www.w3.org/2000/svg">
									<path fill-rule="evenodd" clip-rule="evenodd" d="M2.0002 3.19998C2.7152 3.19998 3.3002 2.61498 3.3002 1.89998C3.3002 1.18498 2.7152 0.599976 2.0002 0.599976C1.2852 0.599976 0.700195 1.18498 0.700195 1.89998C0.700195 2.61498 1.2852 3.19998 2.0002 3.19998Z" fill="currentColor">
										
									</path>
									<path fill-rule="evenodd" clip-rule="evenodd" d="M2.0002 6.70001C1.2852 6.70001 0.700195 7.28501 0.700195 8.00001C0.700195 8.71501 1.2852 9.30001 2.0002 9.30001C2.7152 9.30001 3.3002 8.71501 3.3002 8.00001C3.3002 7.28501 2.7152 6.70001 2.0002 6.70001Z" fill="currentColor">
										
									</path>
									<path fill-rule="evenodd" clip-rule="evenodd" d="M2.0002 12.8C1.2852 12.8 0.700195 13.385 0.700195 14.1C0.700195 14.815 1.2852 15.4 2.0002 15.4C2.7152 15.4 3.3002 14.815 3.3002 14.1C3.3002 13.385 2.7152 12.8 2.0002 12.8Z" fill="currentColor">
										
									</path>
								</svg>
							</div>
						</div>
					</div>
					<a href="" target="_blank" rel="noreferrer" class="css-16mjcje">
						<div class="reserved-wrapper common-bg-hover">
							<img class="article-image" src="${pageContext.request.contextPath}/resources/img/chatting/Rectangle 3.png" alt="">
							<div class="reserved-main">
								<div>물건 이름</div>
								<div class="reserved-price">10,000원</div>
							</div>
							<div>
								<span class="reserve-button ongoing">판매중</span>
							</div>
						</div>
					</a>
					<div tabindex="0" role="region" aria-label="메시지 리스트" class="css-13cllyv">
						<div class="css-13ec0kq">
							<div class="info">
								<div class="css-1o46l5b">
									<span>user01님은 당근페이 사용자예요. 채팅방에서 바로 송금할 수 있어요.</span>
								</div>
							</div>
						</div>
						<div class="day-divider">
							<div class="date-text">2023년 6월25일</div>
						</div>
						<div id="for-scroll-1" id="msg-area" class="for-containment right">
							<div class="for-containment   css-uc14ng">
								<div class="sender css-lty8rs">
									<span class="message-date">user01</span>
									<div class="message-date">오후 10:25</div>
								</div>
								<div class="message-wrapper">
									<div>
										<p class="message-box">안녕하세요!</p>
									</div>
									<button type="button" class="toolbox">
										<img src="/icons/more_horiz.svg" alt="more">
									</button>
								</div>
							</div>
						</div>
						<div id="for-scroll-2" class="for-containment left">
							<div class="  css-7rih9z">
								<div class="message-wrapper">
									<div>
										<p class="message-box">안녕하세요!</p>
									</div>
									<button type="button" class="toolbox">
										<img src="/icons/more_horiz.svg" alt="more">
									</button>
								</div>
								<div class="css-lty8rs">
									<span class="message-date">user02</span>
									<div class="message-date">오후 11:29</div>
								</div>
							</div>
						</div>
					</div>
				</div>
				<form class="css-1ckh9yi">
					<textarea placeholder="메시지를 입력해주세요" class="css-10fmtiz"></textarea>
					<div class="chatform-option-area">
						<div class="chatform-submenu">
							<label class="option-wrapper">
								<span class="option-tooltip">사진</span>
								<svg width="20" height="20" viewBox="0 0 20 20" fill="none" xmlns="http://www.w3.org/2000/svg">
									<rect width="20" height="20" rx="3"></rect>
									<path d="M6 9C7.10457 9 8 8.10457 8 7C8 5.89543 7.10457 5 6 5C4.89543 5 4 5.89543 4 7C4 8.10457 4.89543 9 6 9Z" fill="white">
										
									</path>
									<path d="M3 16L6.5 12L10 16" fill="white">
										
									</path>
									<path d="M7 16L12 10L17 16" fill="white">
										
									</path>
								</svg>
								<input type="file" multiple="" accept="image/png, image/jpeg, image/gif">
							</label>
							<label class="option-wrapper ">
								<span class="option-tooltip">자주 쓰는 문구</span>
								<svg width="20" height="20" viewBox="0 0 20 20" fill="none" xmlns="http://www.w3.org/2000/svg">
									<path fill-rule="evenodd" clip-rule="evenodd" d="M0 18C0 19.1046 0.895431 20 2 20H18C19.1046 20 20 19.1046 20 18V2C20 0.895431 19.1046 0 18 0H2C0.895431 0 0 0.895431 0 2V18ZM5 5.1C4.50294 5.1 4.1 5.50294 4.1 6C4.1 6.49706 4.50294 6.9 5 6.9H15C15.4971 6.9 15.9 6.49706 15.9 6C15.9 5.50294 15.4971 5.1 15 5.1H5ZM4.1 10C4.1 9.50294 4.50294 9.1 5 9.1H15C15.4971 9.1 15.9 9.50294 15.9 10C15.9 10.4971 15.4971 10.9 15 10.9H5C4.50294 10.9 4.1 10.4971 4.1 10ZM5 13.1C4.50294 13.1 4.1 13.5029 4.1 14C4.1 14.4971 4.50294 14.9 5 14.9H15C15.4971 14.9 15.9 14.4971 15.9 14C15.9 13.5029 15.4971 13.1 15 13.1H5Z">
										
									</path>
								</svg>
							</label>
							<label class="option-wrapper">
								<span class="option-tooltip">이모티콘</span>
								<div class="option-wrapper  css-1f5m7zv">
									<button class="sticker-button" type="button">sticker
										</svg>
									</button>
								</div>
							</label>
						</div>
						<button class="disable css-1useanf" id="send-msg" aria-disabled="true">전송</button>
					</div>
					<span class="text-length">0/1000</span>
				</form>
			</div>
		</section>
	</div>
</main>

<jsp:include page="/WEB-INF/views/common/footer.jsp" />
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