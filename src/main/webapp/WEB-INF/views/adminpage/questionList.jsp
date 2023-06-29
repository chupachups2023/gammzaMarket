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
	    width: 1100px;
	    margin: auto;
	}
  	.qTable {
	  	margin: auto;
		width:900px;
		border-collapse: collapse;
		text-align:center;
	}
	.qTable a {
		text-decoration:none; 
		color:black; 
		cursor:pointer;
	}
	.qTable th,tr, td{
		text-align: center;
		height:30px;
	}
	thead {
		border-bottom: 3px solid;
		width:100%;
	}
	tbody {width:100%}
	.Qtitle {
		width:450px;
		text-align: left;
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
	text-align:center;
  }
</style>
<div id="qnaBoard">
	<h1 id="title">문의 사항</h1>

	<br/>	

	<table class="qTable">
		<thead>
			<tr>
				<th width="100px">NO</th>
				<th width="450px">제목</th>
				<th width="200px">작성자</th>
				<th width="150px">날짜</th>
			</tr>
		</thead>
		<tbody>
			<c:forEach items="${questionList}" var="qna" varStatus="s">
				<tr>
					<td width="100px">${pi.totalRecord - ((pi.nowPage-1)*pi.numPerPage)-s.index}</td>
					<td class="Qtitle"><a href="${pageContext.request.contextPath}/adminpage/questionAnswer.do?nowPage=${pi.nowPage}&qnaNo=${qna.qnaNo}">${qna.qnaTitle}</a></td>
					<td width="200px">${qna.qnaWriter}</td>
					<td width="150px">${qna.createAt}</td>
				</tr>
			</c:forEach>
		</tbody>
	</table>
  <br/>
	
	<nav id="pagingNav">
		<ul class="qnaPaging">
			<c:if test="${pi.nowPage ne 1}">
				<li>
					<a href="${pageContext.request.contextPath}/adminpage/questionList.do?nowPage=${pi.nowPage-1}"
					tabindex="-1" aria-disabled="false">이전</a>
				</li>
			</c:if>
			<c:forEach var="p" begin="${pi.startPage }" end="${pi.endPage }">
				<c:choose>
					<c:when test="${p eq pi.nowPage }">
						<li>
							<a href="${pageContext.request.contextPath}/adminpage/questionList.do?nowPage=${p}">${p}</a>
						</li>
					</c:when>
					<c:otherwise>
						<li>
							<a href="${pageContext.request.contextPath}/adminpage/questionList.do?nowPage=${p}">${p}</a>
						</li>
					</c:otherwise>
				</c:choose>
			</c:forEach>
			<c:if test="${pi.nowPage ne pi.totalPage }">
				<li><a href="${pageContext.request.contextPath}/adminpage/questionList.do?nowPage=${pi.nowPage+1}">다음</a></li>
			</c:if>
		</ul>
	</nav>
</div>

<jsp:include page="/WEB-INF/views/common/footer.jsp" />