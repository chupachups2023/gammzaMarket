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
*문의사항
 -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-9ndCyUaIbzAi2FUVXJi0CjmCapSmO7SnpJef0486qhLnuZ2cdeRhO02iuK6FUUVM" crossorigin="anonymous">
<div id="title">
  <h1>문의 사항</h1>
</div>
    <table class="table">
        <thead>
          <tr>
            <th scope="col">NO</th>
            <th scope="col">제목</th>
            <th scope="col">작성자</th>
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
            <th scope="row">2</th>
            <td>문의문의문의문의</td>
            <td>작성자작성자</td>
            <td>날짜</td>
          </tr>
          <tr>
            <th scope="row">3</th>
            <td>문의문의문의문의</td>
            <td>작성자작성자</td>
            <td>날짜</td>
          </tr>
          <tr>
            <td colspan="4" align="center">[이전]...[1][2][3]...[다음]</td>
        </tr>
        </tbody>
      </table>

<jsp:include page="/WEB-INF/views/common/footer.jsp" />