<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/member/pointPurchase.css?<%=System.currentTimeMillis() %>">
<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param value="포인트결제" name="title" />
</jsp:include>
<script type="text/javascript"
	src="https://cdn.iamport.kr/js/iamport.payment-1.2.0.js"></script>

<div class="pointPurchaseSec">
	<h1>포인트 결제</h1>
	<br> <br>
	<button id="CheckPaymentBtn" onclick="location.href='${pageContext.request.contextPath}/member/checkPayment.do'">결제내역보기</button>
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
							<div class="purchaseMethod">
								<div><input type="radio" name="purchaseSelect" class="pg" value="kakaopay" id="kakaopay"><label for="kakaopay"><span>카카오페이</span></label></div>
								<div><input type="radio" name="purchaseSelect" class="pg" value="danal" id="danal"><label for="danal"><span>핸드폰 소액결제</span></label></div> 
								<div><input type="radio" name="purchaseSelect" class="pg" value="html5_inicis" id="html5_inicis"><label for="html5_inicis"><span>신용/체크 카드</span></label></div>
							</div>
						</td>
					</tr>
				</tfoot>
			</table>
		</div>
		<div>
			<br>
			<div id="payBox">
				결제수단 : <input id="viewPg" readonly><br> 
				결제가격 : <input id="viewPrice" readonly><br> <br>
				&emsp;&emsp;&emsp;▶기타 포인트 결정: <input id="viewPriceEtc"><button type="button" id="priceBtn">결정</button><br><br>
				이대로 진행하시려면 결제를 눌러주세요.<br>
			</div>

		</div>
		<br> <br> <br> <br>
		<div class="form-bottom">
			<div id="clause">
				<div id="clauseContent" >

<p><b>제 1 조 (정의)</b></p>
<pre>본 장에서 사용하는 용어의 정의는 다음과 같습니다.

‘선불전자지급수단’이라 함은 당근머니 등과 같이 회사가 발행 당시 미리 회원에게 
공지한 전자금융거래법 상 선불전자지급수단을 말합니다.
‘충전’이라 함은 선불전자지급수단의 일정액을 확보하기 위해 회사가 지정한 지불
수단을 통해 선불전자지급수단을 구매하거나, 회사 또는 회사가 지정한 제3자의 서
비스 등(이하 ‘서비스 등’이라 합니다)에서의 활동을 통해 선불전자지급수단을 적
립 받는 것을 말합니다.
‘회원’이라 함은 본 약관에 동의하고 판매자로부터 재화 등을 구매하고 선불전자지
급수단을 결제수단으로 하여 그 대가를 지급하는 자를 말합니다.
‘판매자’라 함은 선불전자지급수단에 의한 거래에 있어서 회원에게 재화 등을 판매
하는 자를 말합니다.

</pre>

<p><b>제 2 조 (접근매체의 관리)</b></p>
<pre>회사는 회원으로부터 접근매체의 분실 또는 도난 등의 통지를 받기 전에 발생
하는 선불전자지급수단에 저장된 금액에 대한 손해에 대하여는 책임지지 않습니다.
제2장 결제대행서비스 제18조 제1항 내지 제4항은 본 장에 준용합니다.

</pre>

<p><b>제 3 조 (선불전자지급수단의 충전)</b></p>
<pre>회원은 계좌출금 , 기타 회사가 정하는 지불수단으로 선불전자지급수단을 구매
하거나, 서비스 등에서의 활동으로 회사 또는 회사의 제휴사로부터 적립 받아 선불전
자지급수단을 충전할 수 있습니다.
회사가 지정한 지불 수단을 통한 선불전자지급수단 구매는 제1항에서 규정하는 지불 
수단별로 지정된 금액으로 충전을 할 수 있으며, 지불 수단에 따라 자체 제한금액이 
있을 수 있습니다.

</pre>

<p><b>제 4 조 (선불전자지급수단의 이용)</b></p>
<pre>회원은 회사가 정한 기한 및 이용방법에 따라 선불전자지급수단을 이용할 수 있
으며, 회사는 그 구체적인 사항을 본 약관 또는 선불전자지급수단 관련 서비스 페이지
를 통해 공지합니다.
회원은 서비스 등에서 재화 등을 구매할 때 선불전자지급수단을 지불 수단으로 사용
할 수 있습니다.
선불전자지급수단은 재화 등의 구매완료 시점에 즉시 차감됩니다.
회원이 선불전자지급수단을 사용하는 경우 서비스 등에서 적립 받은 무상의 선불전자
지급수단(이하 ‘적립선불’이라고 합니다), 회원이 구매한 선불전자지급수단(이하 ‘구
매선불’이라고 합니다)의 순서로 차감합니다.
회원이 선불전자지급수단을 사용한 재화 등의 구매를 취소하는 경우 회사는 재화 등 
구매시 사용한 선불전자지급수단을 재충전하는 것을 원칙으로 합니다.

</pre>

<p><b>제 5 조 (선불전자지급수단의 유효기간)</b></p>
<pre>개별 선불전자지급수단을 마지막으로 이용한 날로부터 10 년이 경과하는 동안 
해당 선불전자지급수단을 한번도 적립하거나 사용하지 않은 경우 회원이 충전한 해당 
선불전자지급수단은 자동소멸됩니다.
회사는 전항에 따른 선불전자지급수단의 자동소멸 전에 회원에게 소멸예정 사실을 전
자우편 등의 방법으로 통지합니다.
본 약관에 대한 동의를 철회하는 경우 적립선불은 소멸되어 환급이 불가능합니다.

</pre>

				</div>
				<div class="clauseCkh-box"><input type="checkbox" id="clauseCkh" required><label for="clauseCkh">약관을 다 읽었으며 동의하고 결제합니다.</label></div> 
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
	
 	$('#priceBtn').click(function(){
  		$('.pointSel').removeClass('clicking');
  		var price1 = $('#viewPriceEtc').val();
  		$('#pointPrice').val(price1);
  		const price2 = price1.replace(/\B(?=(\d{3})+(?!\d))/g, ",") + " 원";
  		$('#viewPrice').val(price2);
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
