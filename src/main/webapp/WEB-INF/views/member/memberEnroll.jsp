<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<script	src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.3/jquery.min.js"></script>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/member/memberEnroll.css">

<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param value="회원가입" name="title"/>
</jsp:include>

    <div class="enroll-title">
        <h1>회원가입</h1>
    </div>
    <div class="enroll-container">
        <form action="${pageContext.request.contextPath}/member/memberEnroll.me" method="post" name="enrollfrm">
            <div class="container">
                <table class="enroll-section">
                    <tr>
                       <td scope="col" class="add" align="center">
                           <input name="userId" placeholder="아이디 입력" id="userId">
                           <!-- <span class="guide ok">아이디 사용가능</span>
                           <span class="guide error">아이디 사용불가</span> -->
                       </td>
                   </tr>
                   <tr>
                       <td scope="col" class="add">
                           <input type="password" placeholder="비밀번호 입력" name="userPwd">
                       </td>
                   </tr>
                   <tr>
                       <td scope="col" class="add">
                           <input type="password" placeholder="비밀번호 확인" name="pwdCheck">
                       </td>
                   </tr>
               </table>
           </div>
           <div class="container">
               <table>
                   <tr>
                       <td>
                           <input type="checkbox" class="checkbox-round"/>이메일 인증
                           <input name="email" placeholder="입력해주세요">
                           <button type="submit" class="header-login btn">인증</button>
                       </td>
                   </tr>
               </table>
           </div>
           <div class="container">
               <table>
                   <tr>
                       <td scope="col" class="add">
                           <input name="birthday" placeholder="생년월일 입력" style="margin-top: 25px;">
                       </td>
                   </tr>
                   <tr>
                       <td scope="col" class="add">
                           <input type="detailAddress" name="address" placeholder="주소 입력">
                       </td>
                   </tr>
               </table>
           </div>
           <div class="lo">
               <table>
                   <input type="checkbox" class="checkbox-square" /><span>이용약관에 동의하시겠습니까?</span>
               </table>
           </div>
           <div class="table1">
               <button type="submit" class="bo">회원가입</button>&emsp;
               <button type="reset" class="bo">초기화</button>
           </div>
       </form>
   </div>
   
   <script type="text/javascript">
		document.querySelector("#userId").addEventListener("keyup", (e) => {
			const ok = document.querySelector(".ok");
			const error = document.querySelector(".error");
			const userId = e.target;
			
			if (userId.value.length < 4) {
				ok.style.display = "none";
				error.style.display = "none";
				return;
			}
			
			
			$.ajax({
				url: "${pageContext.request.contextPath}/member/checkId.do",
				data: {userId: userId.value},
				method: "get",
				dataType: "json",
				success(result) {
					console.log(result);
					const {userId, available} = result; // unpacking 
					
					if (available) {
						ok.style.display = "inline";
						error.style.display = "none";
					} else {
						ok.style.display = "none";
						error.style.display = "inline";
					}
				},
				error: console.log
			});
		});
	
	</script>

<jsp:include page="/WEB-INF/views/common/footer.jsp" />