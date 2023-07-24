
	function success(position) {
	    /*const latitude = position.latitude;   // 위도(37.xxxx)
	    const longitude = position.longitude; // 경도*/
	    const latitude = position.coords.latitude;   // 위도(37.xxxx)
	    const longitude = position.coords.longitude; // 경도
		
	  	//kakao REST API에 get 요청을 보낸다.
        //파라미터 x,y에 lon,lat을 넣어주고 API_KEY를 Authorization헤더에 넣어준다.
        
        $.ajax({
        	type:"get",
        	url:"https://dapi.kakao.com/v2/local/geo/coord2address.json?x="+longitude+"&y="+latitude+"&input_coord=WGS84",
        	beforeSend: function (header) {
        		header.setRequestHeader("Authorization","KakaoAK ");
            },
            success:function(result){
            	var address=result.documents[0].address.address_name;
            	geoCoe(address);
            	
            	var container = document.getElementById('map'); //지도를 담을 영역의 DOM 레퍼런스
            	var options = { //지도를 생성할 때 필요한 기본 옵션
            		center: new kakao.maps.LatLng(latitude, longitude), //지도의 중심좌표.
            		level: 3 //지도의 레벨(확대, 축소 정도);
            		
            	};
            	var map = new kakao.maps.Map(container, options); //지도 생성 및 객체 리턴
            	
            	//마커 초기화(초기화 시 지도에 미리 지정 가능 : 카카오맵 API 문서 참조)
            	const marker = new kakao.maps.Marker();
        		
            	document.getElementById('lon').value=longitude;
        		document.getElementById('lat').value=latitude;
            	
            	//카카오맵 클릭 이벤트 추가
            	kakao.maps.event.addListener(map, 'click', (mouseEvent) => {
            		//클릭한 위도, 경도 정보 불러오기
            		const latlng = mouseEvent.latLng;
            		
            		document.getElementById('lon').value=latlng.La;
            		document.getElementById('lat').value=latlng.Ma;
            		
            		//마커 위치를 클릭한 위치로 이동
            		marker.setPosition(latlng);
            		marker.setMap(map);
            		
            		$.ajax({
			        	type:"get",
			        	url:"https://dapi.kakao.com/v2/local/geo/coord2address.json?x="+latlng.La+"&y="+latlng.Ma+"&input_coord=WGS84",
			        	beforeSend: function (header) {
			        		header.setRequestHeader("Authorization","KakaoAK ");
			            },
			            success:function(clickresult){
			            	var clickaddress=clickresult.documents[0].address.address_name;
				            console.log(clickaddress);
			            	geoCoe(clickaddress);
			            },
			            error:function(){
			            	console.log("실패");
			            }
					});
            		
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
	
	//지도 토큰 받아오기
	var accessToken = 'none';
	var errCnt=0;
	getAccessToken();
	function getAccessToken(){
		jQuery.ajax({
			type:'GET',
			url: 'https://sgisapi.kostat.go.kr/OpenAPI3/auth/authentication.json',
			data:{
			consumer_key : 'd063e685682f42c998cc',
			consumer_secret : '26cef6c7c4f64fe4bea7'
			},
			success:function(data){
				errCnt = 0;																									
				accessToken = data.result.accessToken;
				getUserLocation(); 
				/*position={"latitude":37.533921602961506, "longitude":126.89677032759451 }*/
         		success(position);
				
			},
			error:function(data) {
			}
		});
	};
	
	function geoCoe(address){
     	address = encodeURIComponent(address);
     	var pagenum = '0';
     	var resultcount = '1';
     	$.ajax({
     		type:'GET',
     		url: 'https://sgisapi.kostat.go.kr/OpenAPI3/addr/geocode.json',
     		data:{
     			accessToken : accessToken,
     			address : address,
     			pagenum : pagenum,
     			resultcount : resultcount,
     		},
     		success:function(data){
     			switch (parseInt(data.errCd)){
     					case 0:
		     			var resultdata = data.result.resultdata[0];
     					document.getElementById('sidoNm').value=resultdata.sido_nm
     					document.getElementById('sggNm').value=resultdata.sgg_nm
     					document.getElementById('admNm').value=resultdata.adm_nm
     					document.getElementById('legNm').value=resultdata.leg_nm
     					
     					break;
     					case -401:
                         	errCnt ++;
     						getAccessToken();
     						console.log(errCnt);
     						
     						//window.location.reload()
     					break;																					
     					case -100:																					
     					break;																					
     			}
     		},																														
     		error:function(data) {
     		}																														
     	});																		
   }
   
   
