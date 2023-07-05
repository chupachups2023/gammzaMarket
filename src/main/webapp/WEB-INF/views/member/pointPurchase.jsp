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

	#payBox{
		display: none;
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
							잔여 포인트 : ${member.point} p<br>
							충전 후 포인트 : ${member.point} p
						</td>
					</tr>
				</thead>
				<tbody>
					<tr>
						<td>
							<div class="pointSel sel1">
								<h3 class="pointG">10,000p</h3>
								10,000 원
							</div>
						</td>
						<td>
							<div class="pointSel sel2">
								<h3 class="pointG">30,000p</h3>
								30,000 원
							</div>
						</td>
						<td>
							<div class="pointSel sel3">
								<h3 class="pointG">50,000p</h3>
								50,000 원
							</div>
						</td>
						<td>
							<div class="pointSel sel4" >
								<h3 class="pointG">100,000p</h3>
								100,000 원
							</div>
							
							
							<!-- onclick="selectedPoint('sel4', 100000);" -->
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
								<input type="radio" name="purchaseSelect" value="네이버페이">네이버페이
								<input type="radio" name="purchaseSelect" value="계좌이체">계좌이체<br>
								<input type="radio" name="purchaseSelect" value="토스뱅크">토스뱅크
								<input type="radio" name="purchaseSelect" value="휴대폰">휴대폰 결제
								<input type="radio" name="purchaseSelect" value="카드">신용/체크 카드 결제
							
						</td>
					</tr>
				</tfoot>
			</table>
		</div>
		<div>
			if문으로 선택한 포인트와 결제수단으로 결제창 뜨는 div 공간
			
			<div id="payBox">

			</div> 
			


		</div>
		<br><br><br><br>
		<div>
			<div id="clause">
				<textarea id="clauseContent" cols="60" rows="7">약관내용
				</textarea>
				<input type="checkbox" required> 약관을 다 읽었으며 동의하고 결제합니다
			</div>
			<button id="purchaseBtn" type="submit">결제</button>
		</div>
	</form>
</div>
<jsp:include page="/WEB-INF/views/common/footer.jsp" />

<script>
/*  	function selectedPoint(point, won) {
  		$('.pointSel').removeClass('clicking');
  		$(this).addClass('clicking');
 	} */
/* $(function(){
 	$('.pointSel').on("click", () => {
  		$('.pointSel').removeClass('clicking');
  		$(this).addClass('clicking');
	});
}) */

$(function(){
 	$('.pointSel').click(function(){
  		$('.pointSel').removeClass('clicking');
  		$('.sel1').addClass('clicking');
	});
})
	/* 결제 */
	var IMP = window.IMP;	//생략가능
	IMP.init("imp36052417"); //가맹점 식별 코드
	
	function kakaopay() {
		
	IMP.request_pay({
    pg : 'kakaopay',		//바꿀 수 있음
    pay_method : 'card', //생략 가능
    merchant_uid: "10000p", // 상점에서 관리하는 주문 번호
    name : '주문명:결제테스트',
    amount : 10000,
    buyer_email : ${member.email},
    buyer_name : ${member.name},
    buyer_tel : ${member.phone},
    buyer_addr : ${member.address},
    buyer_postcode : ${member.zipcode}
	}, function(rsp) { 
		if(rsp.success) {   //결제성공시
			$.ajax({
				type:'post',
				url:'/updatePoint',
				data: {"purchased":, }
			});
		}else {
			alert("결제실패원인: " + rsp.error_msg);
		}
	});
	}
 	
	// if(${qAns.qnaNo} != null) {
	// 	$("#myQC").attr("readonly", true);
	// 	$("#updateQ").attr("disabled", true).css("width", "200px").text("답변된 문의는 수정불가");
	// 	$("#myQTitle").attr("readonly", true);
	// }
	
	
	// const chkAll = document.querySelector("#chkAll");
	// chkAll.addEventListener("change", () => {
	// 	const chkList = document.getElementsByName("delZzim");
	// 	for (delZzim of chkList)
	// 		delZzim.checked = chkAll.checked;
	// });
	
	// function delSelZ() {
	// 	const chkList = document.getElementsByName("delZzim");
	// 	if(chkList.value != null) {
	// 		delZFrm.submit();
	// 	}else {
	// 		alert("선택된 찜이 없습니다");
	// 	}
	// }
</script>