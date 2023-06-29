	function mngEndTime(){
		//document.getElementById('endTime').setAttribute("value","");
		var openTime=ggEnrollFrm.openTime.value;
		console.log("openTime: "+openTime);
		document.getElementById("endTime").setAttribute("min", openTime);
	};
	
	
	
	document.querySelector("#endTime").addEventListener('focusout',(e)=>{
		ggEnrollFrm.endTime.value="";
		var endTime=ggEnrollFrm.endTime.value;
		document.getElementById("sendTime").setAttribute("min", endTime);
	});
	

	function ggEnrollFrmSubmit(){
		console.log("오픈타임: "+ggEnrollFrm.openTime.value);
		
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
		}
		
		if(open<today){
			alert("오픈 일시는 지금 이후여야합니다!");
			return;
		}
	}
