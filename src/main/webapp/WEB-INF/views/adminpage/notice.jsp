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
*관리자페이지 공지사항
 -->
  <style>
    * {margin: 0 10%}
  </style>
<div id="title">
  <h1>공지사항</h1>
</div>
    <table class="table" align="center">
        <thead>
          <tr>
            <th scope="col">NO</th>
            <th scope="col">제목</th>
            <th scope="col" width="20%">작성일</th>

          </tr>
        </thead>
        <tbody class="table-group-divider">
          <tr>
            <th scope="row">1</th>
            <td>[공지]공지공지공지공지</td>
            <td>날짜날짜날짜날짜</td>
          </tr>
          <tr>
            <th scope="row">2</th>
            <td>[공지]공지공지공지공지</td>
            <td>날짜날짜날짜날짜</td>
          </tr>
          <tr>
            <th scope="row">3</th>
            <td>[공지]공지공지공지공지</td>
            <td>날짜날짜날짜날짜</td>
          </tr>
        </tbody>
        
        <tr>
            <td colspan="3" align="center">[이전]...[1][2][3]...[다음]</td>
        </tr>        
      </table>
      <table align="right">
        <tr>
          <td> 
            <button onclick="href=''">글 작성</button>
          </td>
        </tr>
      </table>


<jsp:include page="/WEB-INF/views/common/footer.jsp" />