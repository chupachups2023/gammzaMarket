
	
	document.querySelector("#openTime").addEventListener('focusout',(e)=>{
		ggUpdateFrm.endTime.value="";
		ggUpdateFrm.sendTime.value="";
		var openTime=ggUpdateFrm.openTime.value;
		document.getElementById("endTime").setAttribute("min", openTime);
	});
	
	
	document.querySelector("#endTime").addEventListener('focusout',(e)=>{
		ggUpdateFrm.sendTime.value="";
		var endTime=ggUpdateFrm.endTime.value;
		document.getElementById("sendTime").setAttribute("min", endTime);
	});
	

	function ggUpdateFrmSubmit(){
		if(ggUpdateFrm.gongguName.value=="" || ggUpdateFrm.gongguName.value==null){
			alert("어떤걸 공구하시나요?");
			return;
		}else if(ggUpdateFrm.category.value=="0"){
			alert("카테고리를 선택해주세요");
			return;
		}else if(ggUpdateFrm.price.value=="" || ggUpdateFrm.price.value==null){
			alert("공구할 물건의 가격을 적어주세요");
			return;
		}else if(ggUpdateFrm.num.value=="" || ggUpdateFrm.num.value==null){
			alert("몇 명과 또는 몇 개를 공구할지 적어주세요");
			return;
		}else if(ggUpdateFrm.num.value<1){
			alert("공구 수량 또는 인원은 1 이상이어야 합니다");
			return;
		}else if(ggUpdateFrm.upPhoto1.value==null && ggUpdateFrm.upPhoto2.value==null && ggUpdateFrm.upPhoto3.value==null&&ggUpdateFrm.upPhoto1.value=="" && ggUpdateFrm.upPhoto2.value==""&&ggUpdateFrm.upPhoto3.value==""){
			alert("사진은 하나 이상 들어가야합니다!");
			return;
		}else if(ggUpdateFrm.openTime.value=="" && ggUpdateFrm.openTime.value==null&&ggUpdateFrm.sysdate.value=="" && ggUpdateFrm.sysdate.value==null){
			alert("공구 오픈 예정 일시를 입력해주세요");
			return;
		}else if(ggUpdateFrm.endTime.value==""||ggUpdateFrm.endTime.value==null){
			alert("공구 마감 예정 일시를 입력해주세요");
			return;
		}else if(ggUpdateFrm.sendTime.value=="" || ggUpdateFrm.sendTime.value==null){
			alert("물건을 언제 나눌지 입력해주세요");
			return;
		}else{
			ggUpdateFrm.submit();
		}
	}
	
	
	document.querySelector("#sysdate").addEventListener('change',(e)=>{
	
		if ($("#sysdate").is(':checked')) {
			$("#openTime").attr("name", "");
			$("#sysdate").attr("name", "openTime");
		} else {
			$("#openTime").attr("name", "openTime");
			$("#sysdate").attr("name", "");
		}
	
	});
