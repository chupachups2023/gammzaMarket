<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/member/memberEnroll.css">

<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param value="회원가입" name="title"/>
</jsp:include>

<hr>
   <div>
       <form action="${pageContext.request.contextPath}/member/memberEnroll.me" method="post" name="enrollfrm">
           <div class="container">
               <table>
                   <tr>
                       <th scope="col" id="add">
                           <input name="userId" placeholder="아이디 입력" id="userId" required>
                           <span class="guide ok">아이디 사용가능</span>
                           <span class="guide error">아이디 사용불가</span>
                       </th>
                   </tr>
                   <tr>
                       <th scope="col" id="add">
                           <input type="password" placeholder="비밀번호 입력" name="userPwd" required>
                       </th>
                   </tr>
                   <tr>
                       <th scope="col" id="add">
                           <input type="password" placeholder="비밀번호 확인" name="pwdCheck" required>
                       </th>
                   </tr>
               </table>
           </div>
           <div class="container">
               <table>
                   <tr>
                       <th>
                           <input type="checkbox" class="checkbox-round" style="margin-top: 20px;"/><span>이메일 인증</span><br><br>
                           <input name="" placeholder="입력해주세요" required>
                           <button type="submit" class="header-login btn">인증</button>
                       </th>
                   </tr>
               </table>
           </div>
           <div class="container">
               <table>
                   <tr>
                       <td scope="col" id="add" align="center">
                           <input name="birthday" placeholder="생년월일 입력" style="margin-top: 25px;" required>
                       </td>
                   </tr>
                   <tr>
                       <td scope="col" id="add" align="center">
                           <input type="detailAddress" name="address" placeholder="주소 입력">
                       </td>
                   </tr>
               </table>
           </div>
           <div id="lo">
               <table>
                   <input type="checkbox" class="checkbox-square" /><span>이용약관에 동의하시겠습니까?</span>
               </table>
           </div>
           <div id="table">
               <button type="submit" class="bo">회원가입</button>&emsp;
               <button type="reset" class="bo">초기화</button>
           </div>
       </form>
   </div>

<jsp:include page="/WEB-INF/views/common/footer.jsp" />