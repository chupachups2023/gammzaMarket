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
*신고 리스트
 -->
 
<div id="title">
	<h1>신고 목록</h1>
</div>
    <table class="table">
        <thead>
          <tr>
            <th scope="col">NO</th>
            <th scope="col">신고 사유</th>
            <th scope="col">신고자</th>
            <th scope="col">날짜</th>
          </tr>
        </thead>
        <tbody class="table-group-divider">
          <tr>
            <th scope="row">1</th>
            <td>신고신고신고신고신고</td>
            <td>신고자신고자신고자</td>
            <td>날짜</td>
          </tr>
          <tr>
            <th scope="row">2</th>
            <td>신고신고신고신고신고</td>
            <td>신고자신고자신고자</td>
            <td>날짜</td>
          </tr>
          <tr>
            <th scope="row">3</th>
            <td>신고신고신고신고신고</td>
            <td>신고자신고자신고자</td>
            <td>날짜</td>
          </tr>
          <tr>
            <td colspan="4" align="center">[이전]...[1][2][3]...[다음]</td>
        </tr>
        </tbody>
      </table>

<jsp:include page="/WEB-INF/views/common/footer.jsp" />