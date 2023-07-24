<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/common/footer.css?<%=System.currentTimeMillis() %>">
<a href="#top"><img src="https://cdn-icons-png.flaticon.com/512/3426/3426636.png" class="footer-totop" id="totop"></a>
</section>
<footer>
	<hr class="footer-hr">
	<div class="footer-div">
		<p>
			대표 김용현, 황도연
		</p>
		<p><small>
			사업자번호 375-87-00088<br>
			직업정보제공사업 신고번호 2016-서울서초-0051
		</small></p>
		<p><small>
			주소 서울특별시 구로구 디지털로 30길 28, 609호 (감자서비스)<br>
			전화 1544-9796고객문의 cs@daangnservice.com
		</small></p>
	</div>
		<div class="copyright">&lt;Copyright 2023. <strong>감자마켓</strong>. All rights reserved&gt;</div>
<!-- wrapper-whole-section -->
</footer>
<style>
html,  body {
  height: 100%;
}
#wrapper-whole-section {
  min-height: calc(100% - 383px);
}

footer {
  height: 100px;
}
.footer-div{
	margin-top: 19px;
    display: flex;
    justify-content: space-around;
}
.footer-div>p{
	width:450px;;
    font-size: 12px;
}
.copyright{
	margin-top:25px;
	font-size: 13px;
}

</style>
	</body>
</html>