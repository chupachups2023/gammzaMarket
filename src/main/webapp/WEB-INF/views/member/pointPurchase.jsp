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
		margin-left: 50px;
	}
	#viewPg, #viewPrice {
		border:none;
		font-size:20px;
		text-align:right;
		width:140px;
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
							&emsp;잔여 포인트 : ${member.point} p<br>
							&emsp;충전 후 포인트 : ${member.point} p
						</td>
					</tr>
				</thead>
				<tbody>
					<tr>
						<td>
							<div class="pointSel">
								<h3 class="pointG">10,000p</h3>
								<h4>10,000 원</h5>
								<input type="hidden" class="price" value="10000">
							</div>
						</td>
						<td>
							<div class="pointSel">
								<h3 class="pointG">30,000p</h3>
								<h4>30,000 원</h4>
								<input type="hidden" class="price" value="30000">
							</div>
						</td>
						<td>
							<div class="pointSel">
								<h3 class="pointG">50,000p</h3>
								<h4>50,000 원</h4>
								<input type="hidden" class="price" value="50000">
							</div>
						</td>
						<td>
							<div class="pointSel" >
								<h3 class="pointG">100,000p</h3>
								<h4>100,000 원</h4>
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
								<input type="radio" name="purchaseSelect" class="pg" value="kakaopay"><span>카카오페이</span><br>
								<input type="radio" name="purchaseSelect" class="pg" value="naverpay"><span>네이버페이</span><br>
								<input type="radio" name="purchaseSelect" class="pg" value="bank"><span>계좌이체</span><br>
								<input type="radio" name="purchaseSelect" class="pg" value="html5_inicis"><span>신용/체크 카드</span>
							
						</td>
					</tr>
				</tfoot>
			</table>
		</div>
		<div>
			<br>
			<div id="payBox">
				결제수단 : <input id="viewPg"><br>
				결제가격 : <input id="viewPrice"><br>
				<br>이대로 진행하시려면 결제를 눌러주세요.<br>
			</div> 

		</div>
		<br><br><br><br>
		<div>
			<div id="clause">
				<textarea id="clauseContent" cols="60" rows="7" readonly>약관내용
				</textarea>
				<input type="checkbox" id="clauseCkh" required> 약관을 다 읽었으며 동의하고 결제합니다
			</div>
			<button id="purchaseBtn" type="button" onclick="requestPay();">결제</button>
		</div>
	</form>
</div>


<input type="hidden" id="selectedPg">
<input type="hidden" id="pointPrice">
<input type="hidden" id="orderName">
<jsp:include page="/WEB-INF/views/common/footer.jsp" />

<script>
	/* 포인트 선택 */
	$('.pointSel').click(function(){
  		$('.pointSel').removeClass('clicking');
  		$(this).addClass('clicking');
  		const price1 = $(this).children('input').val();
  		$('#viewPrice').val($(this).children('h4').text());
  		$('#orderName').val($(this).children('h3').text());
  		$('#pointPrice').val(price1);
	});

	/* 결제방식 선택 */
	$(':radio').click(function() {
		const pg = $(':radio:checked').val();
		$('#viewPg').val($(':radio:checked').next().text());
		$('#selectedPg').val(pg);
		const payment = $('#payBox').text();
		
		if(pg != "bank") {
			$('#purchaseBtn').attr("onclick", 'requestPay('+'"'+pg+'"'+');');	//계좌이체 외 결제수단은 requestPay()에서 처리
		}else {
			$('#purchaseBtn').removeAttr("onclick");
			$('#purchaseBtn').attr("onclick", 'bank();');	//계좌이체는 모달창으로 띄우기//미완성
			
		}
	});

	/* 결제 */
	const IMP = window.IMP; 
	IMP.init("imp36052417"); 
	
	function requestPay(pg) {
		if(!$('#clauseCkh').is(':checked')){
			alert("약관을 읽고 동의해주세요");
			return;
		}
		if(pg == "bank") {
			
			
		}else{
			const pointPrice = $('#pointPrice').val();
		    IMP.request_pay({
		        pg : pg,		//결제하는 pg종류
		        pay_method : 'card',
		        merchant_uid: orderNum(),		//  상점에서 관리하는 주문 번호(겹치지않는 번호로)
		        name : $('#orderName').val()+'oint',			
		        amount : pointPrice,
		        buyer_email : '${member.email}',
		        buyer_name : '${member.name}',
		        buyer_tel : '${member.phone}'
	
		    }, function (rsp) {
		    	if(rsp.success) {     //결제성공시
					$.ajax({
						url:'/updatePoint.do',
						type:'post',
						data: {
							"pointOrderNum" : merchant_uid,
							"userId" : ${member.userId},
							"pointName" : name,
							"pointPrice": pointPrice,
							"paymentMethod" : $('#viewPrice').val(),
							"purchasedTime" : new Date()
						}
					}); 
				}else {
					alert("결제실패원인: " + rsp.error_msg);
				}
		    });
		}
	}
	
	/* 계좌이체 선택시 */	//미완성
	function bank() {
		
	}
	
	
	function orderNum() {
		const date = new Date();
		const year = date.getFullYear();
		const month = String(date.getMonth() + 1).padStart(2, "0");
		const day = String(date.getDate()).padStart(2, "0");
		
		let orderNum = "p" + $('#pointPrice').val() + "_" + year + month + day;
		orderNum += String(Math.floor(Math.random() * 10000 +1)).padStart(4, "0");
		return orderNum;
	}
	
</script>
