<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/common/footer.css?<%=System.currentTimeMillis() %>">
		</section>
		<hr class="footer-hr">
		<a href="#top"><img src="https://cdn-icons-png.flaticon.com/512/3426/3426636.png" class="footer-totop" id="totop"></a>
		<footer>
			<p>&lt;Copyright 2023. <strong>감자마켓</strong>. All rights reserved&gt;</p>
<pre>대표 김용현, 황도연
사업자번호 375-87-00088
직업정보제공사업 신고번호 2016-서울서초-0051
주소 서울특별시 구로구 디지털로 30길 28, 609호 (당근서비스)
전화 1544-9796고객문의 cs@daangnservice.com</pre>
	
		</footer>
		<script>
$(document).ready(function(){

	// 일단 버튼을 숨긴다
	$("#totop").hide();

	// 스크롤이 되면 버튼이 나타난다. 
	$(function () {
	   $(window).scroll(function () {
	        if ($(this).scrollTop() > 100) {
	              $('#totop').fadeIn();
	         } else {
	              $('#back-top').fadeOut();
	         }
		});
	
	});

});
</script>
[출처] 스크롤하면 나타나는 버튼 / 맨 위로(Top)이동|작성자 NMD

		
	</body>
</html>