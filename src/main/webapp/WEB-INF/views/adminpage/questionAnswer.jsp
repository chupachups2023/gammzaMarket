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
*문의 답변
 -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-9ndCyUaIbzAi2FUVXJi0CjmCapSmO7SnpJef0486qhLnuZ2cdeRhO02iuK6FUUVM" crossorigin="anonymous">
</head>
<style>
    * {margin: 0 10%;}
</style>
<body>
<div id="title">
  <h1>1대1 답변</h1>
</div>
<form action="insertAnswer">
    <table class="table">
        <thead>
          <tr>
            <th scope="col" width="100px">NO</th>
            <th scope="col" width="400px">제목</th>
            <th scope="col" width="200px">작성자</th>
            <th scope="col">날짜</th>
          </tr>
        </thead>
        <tbody class="table-group-divider">
          <tr>
            <th scope="row">1</th>
            <td>문의문의문의문의</td>
            <td>작성자작성자</td>
            <td>날짜</td>
          </tr>
          <tr>
            <th scope="row">문의 내용 </th>
            <td colspan="3">문의문의문의문의문의문의문의</td><p/>
          </tr>
          <tr>
            <th scope="row">답변 내용</th>
            <td colspan="3"><textarea name="" id="" cols="65" rows="10" style="resize: none;"></textarea></td>
          </tr>
        </tbody>
      </table>
      <table align="right">
        <tr>
            <td><input type="submit" value="작성"></td>
            <td><input type="button" value="취소" onclick="href='#'"></td>
        </tr>
      </table>
</form>      

<jsp:include page="/WEB-INF/views/common/footer.jsp" />