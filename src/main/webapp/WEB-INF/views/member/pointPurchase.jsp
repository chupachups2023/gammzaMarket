<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param value="포인트결제" name="title"/>
</jsp:include>
<script type="text/javascript" src="https://cdn.iamport.kr/js/iamport.payment-1.2.0.js"></script>
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
	.pointSel {
		padding: 50px 20px;
	}
	.pointSel:hover {
		background-color: rgb(184, 182, 182);
		color: white;
	}
	.clicking {
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

	#payBox {
	}
    
</style>	

<script>

</script>

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
							잔여 포인트 : ${member.point} p<br>
							충전 후 포인트 : ${member.point} p
						</td>
					</tr>
				</thead>
				<tbody>
					<tr>
						<td>
							<a href="javascript:">
							<div class="pointSel">
								<h3 class="pointG">10,000p</h3>
								10,000 원
								<input type="hidden" class="price" value="10000">
							</div>
							</a>
						</td>
						<td>
							<div class="pointSel">
								<h3 class="pointG">30,000p</h3>
								30,000 원
								<input type="hidden" class="price" value="30000">
							</div>
						</td>
						<td>
							<div class="pointSel">
								<h3 class="pointG">50,000p</h3>
								50,000 원
								<input type="hidden" class="price" value="50000">
							</div>
						</td>
						<td>
							<div class="pointSel" >
								<h3 class="pointG">100,000p</h3>
								100,000 원
								<input type="hidden" class="price" value="100000">
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
								<input type="radio" name="purchaseSelect" class="pg" value="kakaopay">카카오페이<br>
								<input type="radio" name="purchaseSelect" class="pg" value="네이버페이">네이버페이<br>
								<input type="radio" name="purchaseSelect" class="pg" value="계좌이체">계좌이체<br>
								<input type="radio" name="purchaseSelect" class="pg" value="휴대폰">휴대폰 결제<br>
								<input type="radio" name="purchaseSelect" class="pg" value="html5_inicis">신용/체크 카드 결제
							
						</td>
					</tr>
				</tfoot>
			</table>
		</div>
		<div>
			
			<div id="payBox">
				결제수단 : <input id="selectedPg">
				결제가격 : <input id="pointPrice">
				
				이대로 포인트 충전하시겠습니까?
			</div> 

		</div>
		<br><br><br><br>
		<div>
			<div id="clause">
				<textarea id="clauseContent" cols="60" rows="7">약관내용
				</textarea>
				<input type="checkbox" required> 약관을 다 읽었으며 동의하고 결제합니다
			</div>
			<button id="test" type="button">되나?</button>
			<button id="purchaseBtn" type="button" onclick="requestPay();">결제</button>
		</div>
	</form>
</div>
<jsp:include page="/WEB-INF/views/common/footer.jsp" />

<script>
	/* 포인트 선택 */
	$('.pointSel').click(function(){
  		$('.pointSel').removeClass('clicking');
  		$(this).addClass('clicking');
  		const price1 = $(this).children('input').val();
  		$('#pointPrice').val(price1);
	});
	
	/* 결제방식 선택 */
	$(':radio').click(function() {
		$('#test').attr("onclick", 'requestPay();');
	});

	/* 카카오페이 */
	const IMP = window.IMP; 
	IMP.init("imp36052417"); 
	
	function requestPay() {
	    IMP.request_pay({
	        pg : $(".pg").val(),		//결제하는 pg종류
	        pay_method : 'card',
	        merchant_uid: '12322',		//  상점에서 관리하는 주문 번호(겹치지않는 번호로)
	        name : '결제테스트 10,000p',			
	        amount : $('#pointPrice').val(),
	        buyer_email : '${member.email}',
	        buyer_name : '${member.name}',
	        buyer_tel : '${member.phone}',
	        buyer_addr : '${member.address}',
	        buyer_postcode : '${member.zipcode}'
	    }, function (rsp) {
	    	if(rsp.success) {     //결제성공시
				$.ajax({
					url:'/updatePoint',
					type:'post',
					data: {"purchased":10000, }
				}); 
			}else {
				alert("결제실패원인: " + rsp.error_msg);
			}
	    });
	}
	
	
	
	function orderNum() {
		
	}
	
	
</script>
