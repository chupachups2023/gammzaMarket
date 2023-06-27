<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param value="포인트결제" name="title"/>
</jsp:include>
<style>
	/* 포인트결제창 */
    .pointPurchaseSec {
		width: 1000px;
		margin: 30px auto;
	}
    .pointPurchaseSec>h1 {
        text-align: center;
        font-size:30px;
    }
    #pointPurchaseBox {
      border-radius: 10px;
      border: 2px solid rgba(176, 164, 122, 1);
      overflow: hidden;
    }
	/* 충전 포인트 선택칸 */
    .pointbox{
        width: 24.8%;
        height: 50px;
        border: 1px solid ;
        display: inline-block;
    }
    .pointPurchaseTable {
		border-collapse: collapse;
      	width: 1000px;
	
    }
    .pointPurchaseTable tbody td{
		border: 1px solid rgba(176, 164, 122, 1);
    	font-size: 20px;
		text-align: right;
		font-weight: bold;
		width: 25%;
    }
	.pointPurchaseTable tbody div {
		padding: 10px 20px;
	}
	.pointPurchaseTable tbody div:hover {
		background-color: rgb(184, 182, 182);
		color: white;
	}
	.pointPurchaseTable tbody div.clicking {
		background-color: rgb(184, 182, 182);
		color: white;
	}
    .pointG{
		font-size: 25px;
		color: #fce38c;
		text-align: left;
    }
	
	/* 약관박스 */
    #clause{
		border: 1px solid;
		width: 500px;
		padding: 15px;
		display: inline-block;
	}
	
	/* 결제버튼 */
	#purchaseBtn {
		border: none;
		border-radius: 5px;
		width: 80px;
		font-size: 25px;
		background-color: rgb(242, 210, 163);
		margin-left:90%;
	}
    
</style>	

<div class="pointPurchaseSec">
    <h1>포인트 결제</h1>
    <hr>
	<br><br>
	<form>
		<div id="pointPurchaseBox">	
			<table class="pointPurchaseTable">
				<thead>
					<tr>
						<td colspan="4">
							잔여 포인트 : 340p<br>
							충전 후 포인트 : 10,340p
						</td>
					</tr>
				</thead>
				<tbody>
					<tr>
						<td>
							<div>
								<h3 class="pointG">10,000p</h3>
								10,000<br>
								won
							</div>
						</td>
						<td>
							<div>
								<h3 class="pointG">30,000p</h3>
								30,000<br>
								won
							</div>
						</td>
						<td>
							<div>
								<h3 class="pointG">50,000p</h3>
								50,000<br>
								won
							</div>
						</td>
						<td>
							<div>
								<h3 class="pointG">100,000p</h3>
								100,000<br>
								won
							</div>
						</td>
					</tr>
				</tbody>
				<tfoot>
					<tr>
						<td style="text-align: right;">
							결제가능 수단&emsp;&emsp;
						</td>
						<td colspan="3">
								<input type="radio" name="purchaseSelect" value="카카오페이">카카오페이
								<input type="radio" name="purchaseSelect" value="카카오페이">네이버페이
								<input type="radio" name="purchaseSelect" value="카카오페이">계좌이체<br>
								<input type="radio" name="purchaseSelect" value="카카오페이">토스뱅크
								<input type="radio" name="purchaseSelect" value="카카오페이">휴대폰 결제
								<input type="radio" name="purchaseSelect" value="카카오페이">신용/체크 카드 결제
							
						</td>
					</tr>
				</tfoot>
			</table>
		</div>
		<div>
			if문으로 선택한 포인트와 결제수단으로 결제창 뜨는 div 공간
			<!-- 
			<div id="pay">

			</div> 
			-->


		</div>
		<br><br><br><br>
		<div>
			<div id="clause">
				<textarea id="clauseContent" cols="68" rows="7">약관내용
				</textarea>
				<input type="checkbox" required> 약관을 다 읽었으며 동의하고 결제합니다
			</div>
			<button id="purchaseBtn" type="submit">결제</button>
		</div>
	</form>
</div>
<jsp:include page="/WEB-INF/views/common/footer.jsp" />

<scrip>
	

</scrip>