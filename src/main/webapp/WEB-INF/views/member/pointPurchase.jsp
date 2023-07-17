<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/member/pointPurchase.css">
<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param value="포인트결제" name="title" />
</jsp:include>
<script type="text/javascript"
	src="https://cdn.iamport.kr/js/iamport.payment-1.2.0.js"></script>
<style>

</style>


<div class="pointPurchaseSec">
	<h1>포인트 결제</h1>
	<hr>
	<br> <br>
	<form>
		<div id="pointPurchaseBox">
			<table class="pointPurchaseTable">
				<thead>
					<tr>
						<td colspan="4">&emsp;잔여 포인트 : ${loginMember.point} p<br>
							&emsp;충전 후 포인트 : <b id="afterP">${loginMember.point} p</b>
						</td>
					</tr>
				</thead>
				<tbody>
					<tr>
						<td>
							<div class="pointSel">
								<h3 class="pointG">10,000p</h3>
								<h4>10,000 원</h4>
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
							<div class="pointSel">
								<h3 class="pointG">100,000p</h3>
								<h4>100,000 원</h4>
								<input type="hidden" class="price" value="100000">
							</div>
						</td>
					</tr>
				</tbody>
				<tfoot>
					<tr>
						<td style="text-align: right;">결제가능 수단&emsp;&emsp;</td>
						<td colspan="3">
							<input type="radio" name="purchaseSelect" class="pg" value="kakaopay"> <span>카카오페이</span><br>
							<input type="radio" name="purchaseSelect" class="pg" value="danal"> <span>핸드폰 소액결제</span><br> 
							<input type="radio" name="purchaseSelect" class="pg" value="html5_inicis"> <span>신용/체크 카드</span></td>
					</tr>
				</tfoot>
			</table>
		</div>
		<div>
			<br>
			<div id="payBox">
				결제수단 : <input id="viewPg"><br> 
				결제가격 : <input	id="viewPrice"><br> <br>
				이대로 진행하시려면 결제를 눌러주세요.<br>
			</div>

		</div>
		<br> <br> <br> <br>
		<div>
			<div id="clause">
				<textarea id="clauseContent" cols="60" rows="7" readonly>약관내용
				</textarea>
				<input type="checkbox" id="clauseCkh" required> 약관을 다 읽었으며
				동의하고 결제합니다
			</div>
			<button type="button" id="purchaseBtn" onclick="requestPay();">결제</button>
		</div>
	</form>
</div>


<input type="hidden" id="pointPrice">
<input type="hidden" id="orderName">
<jsp:include page="/WEB-INF/views/common/footer.jsp" />

<script>
	/* 포인트 선택 */
 	$('.pointSel').click(function(){
  		$('.pointSel').removeClass('clicking');
  		$(this).addClass('clicking');
  		var price1 = $(this).children('input').val();
  		$('#viewPrice').val($(this).children('h4').text());
  		$('#orderName').val($(this).children('h3').text());
  		$('#pointPrice').val(price1);
  		var afterP = 0;
  		afterP = Number(${loginMember.point})+Number(price1)+" p";
  		$('#afterP').text(afterP);
	});

	/* 결제방식 선택 */
	$(':radio').click(function() {
		$('#viewPg').val($(':radio:checked').next().text());
	}); 

	/* 결제 */
	const IMP = window.IMP; 
	IMP.init("imp36052417"); 
	
	function requestPay() {
		if($('#viewPg').val() == "" || $('#viewPrice').val() == ""){
			alert("포인트 종류와 결제수단을 선택해주세요");
			return;
		}
		if(!$('#clauseCkh').is(':checked')){
			alert("약관을 읽고 동의해주세요");
			return;
		}
		const pg = $(':radio:checked').val();
		const merchant_uid = orderNum();
		
		const name = $('#orderName').val()+"oint";
		const pointPrice = $('#pointPrice').val();
	    IMP.request_pay({
	        pg : pg,		//결제하는 pg종류
	        pay_method : 'card',
	        merchant_uid: merchant_uid,		//  상점에서 관리하는 주문 번호(겹치지않는 번호로)
	        name : name,	
	        amount : pointPrice,
	        buyer_email : '${loginMember.email}',
	        buyer_name : '${loginMember.name}',
	        buyer_tel : '${loginMember.phone}',
	    }, function (rsp) { 
	    	if(rsp.success){
	    		$.ajax({
	    			type: 'post',
	    			url : '${pageContext.request.contextPath}/member/verifyAmount/' + rsp.imp_uid,
	    			error:function(){alert("실패1");}
	    		}).done(function(data) {  
		    		if(pointPrice == data.response.amount){
		    			const paymentMethod = $('#viewPg').val();
		    			
		    			$.ajax({
							url:'updatePoint.do',
							type:'post',
                            data : {
    							pointOrderNum : rsp.merchant_uid,
    							pointName : rsp.name,
    							pointPrice : pointPrice,
    							paymentMethod : paymentMethod,
    							purchasedTime : new Date()
    		    			},
                            error: function(){
                            	alert("실패2");
                            }
						}); 
		    			
				    	alert(name + " 충전되셨습니다");
				    	document.location.href="${pageContext.request.contextPath}/mypage/mypageMain.me";
		    		}else {
		    			alert("결제실패");
		    		}
				});
	    	}else{
    			alert("결제실패 : " + rsp.error_msg );
    		};
		})
	}
	
	
	function orderNum() {
		const date = new Date();
		const year = date.getFullYear();
		const month = String(date.getMonth() + 1).padStart(2, "0");
		const day = String(date.getDate()).padStart(2, "0");
		
		let orderNum = "p" + $('#pointPrice').val() + "_" + year + month + day;
		orderNum += String(Math.floor(Math.random() * 10000 +1)).padStart(4, "0");

		let orderNum2;
		for(var i=0; ;i++){
			if(orderNum == orderNum2){
				break;
			}
			(function(i){
				$.ajax({
					url: 'checkUid.do',
					type: 'post',
					data: {pointOrderNum : orderNum},
					async: false,
					success : function(result) {
									if(result > 0){
										orderNum = "p" + $('#pointPrice').val() + "_" + year + month + day;
										orderNum += String(Math.floor(Math.random() * 10000 +1)).padStart(4, "0");
									}else{
										orderNum2 = orderNum;
									}
					},
					error:function(){console.log("오류");}
				});
			})(i);
		}
		return orderNum;
	}
	
</script>
