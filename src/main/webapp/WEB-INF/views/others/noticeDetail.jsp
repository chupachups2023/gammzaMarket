<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param value="제목" name="title"/>
</jsp:include>

*제목 수정하기
*내용 들어갈 곳
*공지사항 글 상세보기

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-9ndCyUaIbzAi2FUVXJi0CjmCapSmO7SnpJef0486qhLnuZ2cdeRhO02iuK6FUUVM" crossorigin="anonymous">
</head>
<style>
    * {margin: 0 10%;}
</style>
<body>
<div id="title">
  <h1>공지사항 상세보기</h1>
</div>
<form action="insertAnswer">
    <table class="table">
        <thead>
          <tr>
            <th scope="col" width="600px">제목</th>
            <th scope="col">날짜</th>
          </tr>
        </thead>
        <tbody class="table-group-divider">
          <tr>
            <th >${ noticeTitle }</th>
            <th >${ noticeCreate }</th>
          </tr>
          <tr>
            <td colspan="2">
            	${ noticeContent }
            </td>
          </tr>
        </tbody>
      </table>
      <table align="center">
        <tr>
            <td><input type="button" onclick='history.back()' value="목록"></td>
        </tr>
      </table>
</form>      

<jsp:include page="/WEB-INF/views/common/footer.jsp" />