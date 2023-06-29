<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param value="제목" name="title"/>
</jsp:include>

<div id="title">
  <h1>공지사항 작성</h1>
</div>
    <form action="${pageContext.request.contextPath}/adminpage/insertNotice.do" method="post" >
        <table class="table">
            <tbody class="table-group-divider">
            <tr>
            <th>제목</th>
                    <th scope="row"><input type="text" id="noticeTitle" name="noticeTitle" value="${ notice.noticeTitle }"></th>
                    </tr>
             <tr>
             <td><input name="noticeWriter" id="noticeWriter" value="admin" readonly></td>
            </tr>
                <tr>
                    <td colspan="3"><textarea name="noticeContent" id="noticeContent" cols="75" rows="10" placeholder="공지사항 내용을 작성해주세요." style="resize:none"></textarea></td>
                </tr>
            </tbody>
        </table>
        <table align="left">
            <tr><td><button type="submit">작성하기</button>
            <button onclick="history.back()">취소</button></td></tr>
        </table>
    </form>

<jsp:include page="/WEB-INF/views/common/footer.jsp" />
