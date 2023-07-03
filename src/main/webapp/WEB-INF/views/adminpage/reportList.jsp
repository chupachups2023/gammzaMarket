<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-9ndCyUaIbzAi2FUVXJi0CjmCapSmO7SnpJef0486qhLnuZ2cdeRhO02iuK6FUUVM"
	crossorigin="anonymous">
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"
	integrity="sha384-geWF76RCwLtnZ8qwWowPQNguL3RmwHVBC9FhGdlKrxdiJJigb/j/68SIy3Te4Bkz"
	crossorigin="anonymous"></script>
<c:choose>	
<c:when test="${loginMember.userId eq 'admin' }">
<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param value="제목" name="title" />
</jsp:include>
<!-- 
*제목 수정하기
*내용 들어갈 곳
*신고 리스트
 -->
 <br>
 	<div align="center" class="title">
		<h1>신고 목록</h1>
	</div>
<br><br>
<div class="accordion accordion-flush">
	<c:forEach items="${reportList}" var="report" varStatus="loop">
		<div class="accordion-item">
			<h2 class="accordion-header">
				<button class="accordion-button collapsed" type="button"
					data-bs-toggle="collapse" data-bs-target="#flush-collapse${loop.index}"
					aria-expanded="false" aria-controls="flush-collapse${loop.index}">
					신고 번호 : ${report.reportNo} 신고자 아이디 : ${report.reportWriter} 공구글 번호 : ${report.gongguNo} 작성일시 : ${report.createAt}
				</button>
			</h2>
			<div id="flush-collapse${loop.index}" class="accordion-collapse collapse"
				data-bs-parent=".accordion">
				<div class="accordion-body">
					<table class="table">
						<tbody class="report">
							<tr>
								<th class="col" width="100px">신고자아이디</th>
								<th class="col" width="200px">신고 글</th>
								<th class="col" width="70px">공구글번호</th>
								<th class="col" width="100px">작성일시</th>
							</tr>
							<tr>
								<td class="col" id="col-t">${report.reportWriter}</a></td>
								<td class="col">${report.reportContent}</td>            
								<td class="col" onclick="location.href='${pageContext.request.contextPath}/gonggu/ggRead.go?gongguNo=${report.gongguNo }'">${report.gongguNo}</td>
								<td class="col">${report.createAt}</td>
							</tr>
						</tbody>
					</table>
				</div>
			</div>
		</div>
	</c:forEach>
</div>
<jsp:include page="/WEB-INF/views/common/footer.jsp" />

</c:when>
<c:otherwise>
		<script type="text/javascript">
			alert("관리자만 이용가능합니다.");
			location.href="${pageContext.request.contextPath}";
		</script>
</c:otherwise>
</c:choose>
