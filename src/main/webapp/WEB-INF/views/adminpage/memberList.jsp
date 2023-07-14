<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param value="관리자-회원관리게시판" name="title"/>
</jsp:include>
<style>
	#MemberManagementBoard{
		width:1200px;
		margin: 50px auto;
	}
	
	.mTable {
		margin: auto;
		border-collapse: collapse;
		text-align: center;
		width: ;
	}
	
	.mTable a {
		text-decoration: none;
		color: black;
		cursor: pointer;
	}
	
	.mTable th, tr, td {
		text-align: center;
		height: 30px;
	}
	
	thead {
		border-bottom: 3px solid;
		width: 100%;
	}
	
	tbody>tr {
		width: 100%;
		border-bottom: 1px solid;
	}
	
	.Mtitle thead {
		font-size:20px;
	}
	
	#memInsertBtn {
		width: 70px;
		height: 30px;
		border: none;
		background-color: gray;
		color: white;
		border-radius: 5px;
		margin-left: 1000px;
	}
	#chageStatusBtn {
		width: 70px;
		height: 25px;
		background-color: white;
		border-radius: 5px;
	}
	
	.qnaPaging {
		list-style-type: none;
	}
	
	.qnaPaging a {
		text-decoration: none;
		color: black;
	}
	
	.qnaPaging li {
		display: inline;
	}
	
	#pagingNav {
		text-align: center;
	}

	#selectedPage{
		color: red;
		font-weight: bolder;
	}
</style>


<div id="MemberManagementBoard">
	<h1 align="center">회원관리</h1>

	<br/>	

	<table class="mTable">
		<thead>
			<tr>
				<th width="50px">NO</th>
				<th width="200px">회원아이디</th>
				<th width="200px">평점</th>
				<th width="150px">가입날짜</th>
				<th width="150px">가입상태</th>
				<th width="150px">탈퇴</th>
			</tr>
		</thead>
		<tbody>
			<c:forEach items="${memberList}" var="member" varStatus="s">
				<tr>
					<td>${pi.totalRecord - ((pi.nowPage-1)*pi.numPerPage)-s.index}</td>
					<td class="title"><a href="${pageContext.request.contextPath}/member/memberInfo_Ad.do?nowPage=${pi.nowPage}&userId=${member.userId}">${member.userId}</a></td>
					<td>${member.temperature}</td>
					<td>${member.createAt2}</td>
					<td>${member.status2}</td>
					<td><button id="chageStatusBtn" onclick="location.href='${pageContext.request.contextPath}/member/changeStatus_Ad.do?userId=${member.userId}&nowPage=${pi.nowPage }'">탈퇴</button></td>
				</tr>
			</c:forEach>
		</tbody>
	</table>
  	<br/>
	
	<nav id="pagingNav">
		<ul class="qnaPaging">
			<c:if test="${pi.nowPage ne 1}">
				<li>
					<a href="${pageContext.request.contextPath}/member/memberList.do?nowPage=${pi.nowPage-1}">이전</a>
				</li>
			</c:if>
			<c:forEach var="p" begin="${pi.startPage }" end="${pi.endPage }">
				<c:choose>
					<c:when test="${p eq pi.nowPage }">
						<li>
							<a href="${pageContext.request.contextPath}/member/memberList.do?nowPage=${p}" id="selectedPage">[${p}]</a>
						</li>
					</c:when>
					<c:otherwise>
						<li>
							<a href="${pageContext.request.contextPath}/member/memberList.do?nowPage=${p}">[${p}]</a>
						</li>
					</c:otherwise>
				</c:choose>
			</c:forEach>
			<c:if test="${pi.nowPage ne pi.totalPage }">
				<li><a href="${pageContext.request.contextPath}/member/memberList.do?nowPage=${pi.nowPage+1}">다음</a></li>
			</c:if>
		</ul>
	</nav>
	<div id="memberSearchBox">
		<selcet><option></option></selcet>
		<input id="memSearch"><button>검색</button>
		<button id="memInsertBtn">회원추가</button>
	</div>
</div>	



<jsp:include page="/WEB-INF/views/common/footer.jsp" />