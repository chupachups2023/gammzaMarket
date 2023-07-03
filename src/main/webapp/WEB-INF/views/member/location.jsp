<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/member/location.css?<%=System.currentTimeMillis() %>">
<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param value="장소인증" name="title"/>
</jsp:include>

<form method="post" action="${pageContext.request.contextPath}/location/EnrollLocation.lo">
  <div class="location-body">
        <div class="location-map" id="map"></div>
        <div>
            <div>
                <div class="location-title">현재 접속 동네</div>
                <div class="location-cont">
                	<input name="sidoNm" id="sidoNm" readonly class="location-curr">
		            <input name="sggNm"  id="sggNm" readonly class="location-curr">
		            <input name="admNm"  type="hidden" id="admNm" >
		            <input name="legNm"  id="legNm" readonly class="location-curr">
				</div>
            </div>
            <div class="location-part">
                <div class="location-title">우리 동네 근처 옆동네</div>
                <div class="location-cont">당산동, 당산동4가, 당산동5가, 당산동6가, 합정동, 여의동, 양평동, 영등포동</div>
            </div>
            <input type="hidden" id="lon" name="longitude" >
            <input type="hidden" id="lat" name="latitude" >
            
            <div class="location-btn">
                <input type="submit" value="장소 인증하기" class="button">
            </div>
        </div>
    </div>
</form>
<script>

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
        	var address=result.documents[0].address.address_name;
        	geoCoe(address);
        	
        	var container = document.getElementById('map'); //지도를 담을 영역의 DOM 레퍼런스
        	var options = { //지도를 생성할 때 필요한 기본 옵션
        		center: new kakao.maps.LatLng(latitude, longitude), //지도의 중심좌표.
        		level: 4 //지도의 레벨(확대, 축소 정도);
        		
        	};
        	var map = new kakao.maps.Map(container, options); //지도 생성 및 객체 리턴
       	    map.setZoomable(false);
       	 	map.setDraggable(false);
        	
        	//현재 위치로 일단 마커 지정
        	var markerPosition  = new kakao.maps.LatLng(latitude,longitude ); 
        	var marker = new kakao.maps.Marker({
        	    position: markerPosition
        	});
        	marker.setMap(map);
        	    // 마우스 휠로 지도 확대,축소 가능여부를 설정합니다
    		
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
		        		header.setRequestHeader("Authorization","KakaoAK 840539f3651afe19f12cc19a1dc9e0ab");
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
</script> 


<jsp:include page="/WEB-INF/views/common/footer.jsp" />