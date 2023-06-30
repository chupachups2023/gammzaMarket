
	document.querySelector("#openTime").addEventListener('focusout',(e)=>{
		ggEnrollFrm.endTime.value="";
		ggEnrollFrm.sendTime.value="";
		var openTime=ggEnrollFrm.openTime.value;
		document.getElementById("endTime").setAttribute("min", openTime);
	});
	
	
	document.querySelector("#endTime").addEventListener('focusout',(e)=>{
		ggEnrollFrm.sendTime.value="";
		var endTime=ggEnrollFrm.endTime.value;
		document.getElementById("sendTime").setAttribute("min", endTime);
	});
	

	function ggEnrollFrmSubmit(){
		if(ggEnrollFrm.gongguName.value=="" || ggEnrollFrm.gongguName.value==null){
			alert("어떤걸 공구하시나요?");
			return;
		}else if(ggEnrollFrm.category.value=="0"){
			alert("카테고리를 선택해주세요");
			return;
		}else if(ggEnrollFrm.price.value=="" || ggEnrollFrm.price.value==null){
			alert("공구할 물건의 가격을 적어주세요");
			return;
		}else if(ggEnrollFrm.num.value=="" || ggEnrollFrm.num.value==null){
			alert("몇 명과 또는 몇 개를 공구할지 적어주세요");
			return;
		}else if(ggEnrollFrm.num.value<1){
			alert("공구는 함께! 공구 수량 또는 인원은 2 이상이어야 합니다");
			return;
		}else if(ggEnrollFrm.upPhoto1.value==null && ggEnrollFrm.upPhoto2.value==null && ggEnrollFrm.upPhoto3.value==null&&ggEnrollFrm.upPhoto1.value=="" && ggEnrollFrm.upPhoto2.value==""&&ggEnrollFrm.upPhoto3.value==""){
			alert("사진은 하나 이상 들어가야합니다!");
			return;
		}else if(ggEnrollFrm.openTime.value=="" && ggEnrollFrm.openTime.value==null&&ggEnrollFrm.sysdate.value=="" && ggEnrollFrm.sysdate.value==null){
			alert("공구 오픈 예정 일시를 입력해주세요");
			return;
		}else if(ggEnrollFrm.endTime.value==""||ggEnrollFrm.endTime.value==null){
			alert("공구 마감 예정 일시를 입력해주세요");
			return;
		}else if(ggEnrollFrm.sendTime.value=="" || ggEnrollFrm.sendTime.value==null){
			alert("물건을 언제 나눌지 입력해주세요");
			return;
		}else{
			ggEnrollFrm.submit();
		}
	}
	
	
	document.querySelector("#sysdate").addEventListener('change',(e)=>{
	
		if ($("#sysdate").is(':checked')) {
			$("#openTime").prop("disabled", true);
			$("#sysdate").attr("name", "openTime");
		} else {
			$("#openTime").prop("disabled", false);
			$("#sysdate").attr("name", "");
		}
	
	});
