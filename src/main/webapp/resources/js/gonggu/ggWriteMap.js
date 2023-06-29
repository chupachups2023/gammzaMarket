	function success(position) {
	    const latitude = position.coords.latitude;   // 위도(37.xxxx)
	    const longitude = position.coords.longitude; // 경도
	    
		
	  //kakao REST API에 get 요청을 보낸다.
        //파라미터 x,y에 lon,lat을 넣어주고 API_KEY를 Authorization헤더에 넣어준다.
        
        $.ajax({
        	type:"get",
        	url:"https://dapi.kakao.com/v2/local/geo/coord2address.json?x="+longitude+"&y="+latitude+"&input_coord=WGS84",
        	beforeSend: function (header) {
        		header.setRequestHeader("Authorization","KakaoAK 840539f3651afe19f12cc19a1dc9e0ab");
            },
            success:function(result){
            	var container = document.getElementById('map'); //지도를 담을 영역의 DOM 레퍼런스
            	var options = { //지도를 생성할 때 필요한 기본 옵션
            		center: new kakao.maps.LatLng(latitude, longitude), //지도의 중심좌표.
            		level: 3 //지도의 레벨(확대, 축소 정도)
            		
            	};
            	
            	var map = new kakao.maps.Map(container, options); //지도 생성 및 객체 리턴
            	
            	//마커 초기화(초기화 시 지도에 미리 지정 가능 : 카카오맵 API 문서 참조)
            	const marker = new kakao.maps.Marker();
        		
            	document.getElementById('lon').value=latitude;
        		document.getElementById('lat').value=longitude;

            	//카카오맵 클릭 이벤트 추가
            	kakao.maps.event.addListener(map, 'click', (mouseEvent) => {
            		//클릭한 위도, 경도 정보 불러오기
            		const latlng = mouseEvent.latLng;
            		
            		document.getElementById('lon').value=latlng.La;
            		document.getElementById('lat').value=latlng.Ma;
            		
            		//마커 위치를 클릭한 위치로 이동
            		marker.setPosition(latlng);
            		console.log(latlng);
            		marker.setMap(map);
            		
            	});
            },
            error:function(){
            	console.log("실패");
            }
        })
	}

	function getUserLocation() {
	    if (!navigator.geolocation) {
	        alert("위치 정보가 지원되지 않습니다.");
	    }else{
		    navigator.geolocation.getCurrentPosition(success);
	    }
	}
	
	getUserLocation();