<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param value="1:1문의" name="title" />
</jsp:include>
<style>

	#qnaBoard {
		width:1100px;
		text-align: center;
		margin: auto;
	}
  	.qTable {
		text-align: center;
		border-collapse: collapse;
		width: 900px;
		margin: auto;
	}
	.qTable a {
		text-decoration:none; 
		color:black; 
		cursor:pointer;
	}
	.qTable tr, td{
		
	}
	thead {
		border-bottom: 3px solid;
	}
  #qnaWriteBtn {
  	width: 70px;
  	height: 30px;
    margin-left: 90%;
    border: none;
    background-color: gray;
    color: white;
    border-radius: 5px;
  }
  .qnaPaging {
	list-style-type: none;
  }
  .qnaPaging a{
	text-decoration: none;
	color: black;
  }
  .qnaPaging li {
	display: inline;
  }
  #pagingNav {

  }
</style>
<div id="qnaBoard">
	<h1 id="title">문의 사항</h1>

	<br/>	

	<table class="qTable">
		<thead>
			<tr>
				<th width="5%">NO</th>
				<th width="55%">제목</th>
				<th width="20%">작성자</th>
				<th width="20%">날짜</th>
			</tr>
		</thead>
		
		<tbody>
			<c:forEach items="${questionList}" var="qna">
				<tr>
					<th>${qna.qnaNo}</th>
					<td><a href="${pageContext.request.contextPath}/adminpage/questionAnswer.do?qnaNo=${qna.qnaNo}">${qna.qnaTitle}</a></td>
					<td>${qna.qnaWriter}</td>
					<td>${qna.createAt}</td>
				</tr>
			</c:forEach>
		</tbody>
	</table>
  <br/>
	
	<nav id="pagingNav">
		<ul class="qnaPaging">
			<c:if test="${pi.nowPage ne 1}">
				<li class="page-item disabled"><a class="page-link"
					href="${pageContext.request.contextPath}/qna/questionList.do?nowPage=${p}"
					tabindex="-1" aria-disabled="false">이전</a></li>
			</c:if>
			<c:forEach var="p" begin="${pi.startPage }" end="${pi.endPage }">
				<c:choose>
					<c:when test="${p eq pi.nowPage }">
						<li class="page-item active"><a class="page-link"
							href="${pageContext.request.contextPath}/qna/questionList.do?nowPage=${pi.nowPage-1}">${p}</a></li>
					</c:when>
					<c:otherwise>
						<li class="page-item"><a class="page-link"
							href="${pageContext.request.contextPath}/qna/questionList.do?nowPage=${p}">${p}</a></li>
					</c:otherwise>
				</c:choose>
			</c:forEach>
			<c:if test="${pi.nowPage ne pi.totalPage }">
				<li class="page-item"><a class="page-link"
					href="${pageContext.request.contextPath}/qna/questionList.do?nowPage=${pi.nowPage+1}">다음</a></li>
			</c:if>
		</ul>
	</nav>
<!-- 
	<button type="button" id="qnaWriteBtn">글쓰기</button>
	 -->

</div>
<script>
/* 	document.querySelector("#qnaWriteBtn").addEventListener('click', (e) => {
		location.href='${pageContext.request.contextPath}/qna/QnaForm.do';
	}); */
</script>
<jsp:include page="/WEB-INF/views/common/footer.jsp" />