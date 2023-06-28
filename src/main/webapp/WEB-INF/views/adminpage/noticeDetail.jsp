<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param value="제목" name="title"/>
</jsp:include>
<!-- 
*제목 수정하기
*내용 들어갈 곳
*관리자 공지사항 글 상세보기
 -->
</head>
<body>
<div id="title">
  <h1 align="center">공지사항 상세보기</h1>
</div>
    <table class="table">
        <thead>
          <tr>
            <th scope="col" width="600px">제목</th>
            <th scope="col">날짜</th>
          </tr>
        </thead>
        <tbody class="table-group-divider">
          <tr>
            <th scope="col" width="600px">${ notice.noticeTitle }</th>
            <th scope="col">${ notice.noticeCreate }</th>
          </tr>
          <tr>
            <td colspan="2">
            	${ notice.noticeContent }
            </td>
          </tr>
        </tbody>
      </table>
      <table align="center">
        <tr>
            <td><input type="button" onclick='history.back()' value="목록"></td>
            <td><input type="button" onclick='updateNotice(${notice.noticeNo});' value="수정"></td>
			<td><input type="button" onclick='deleteNotice(${notice.noticeNo});' value="삭제"></td>
        </tr>
      </table>
      
<jsp:include page="/WEB-INF/views/common/footer.jsp" />

<script type="text/javascript">
	function updateNotice(no) {
		location.href = '${ pageContext.request.contextPath }/adminpage/updateNotice.do?noticeNo='+noticeNo;
		
	}
	function deleteNotice(no) {
		location.href = '${ pageContext.request.contextPath }/adminpage/updateNotice.do?noticeNo='+noticeNo;
		
	}
</script>