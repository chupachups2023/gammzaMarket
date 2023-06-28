<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/member/location.css">
<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param value="장소인증" name="title"/>
</jsp:include>

  <div class="location-body">
        <div class="location-map map" id="map"></div>
        <div>
            <div>
                <div class="location-title">현재 접속 동네</div>
                <div class="location-cont">서울시 영등포구 당산 제2동</div>
            </div>
            <div class="location-part">
                <div class="location-title">우리 동네 근처 옆동네</div>
                <div class="location-cont">당산동, 당산동4가, 당산동5가, 당산동6가, 합정동, 여의동, 양평동, 영등포동</div>
            </div>
            <div class="location-btn">
                <a href="#" class="button">장소 인증하기</a>
            </div>
        </div>
    </div>

<script>
	function success(position) {
	    const latitude = position.coords.latitude;   // 위도
	    const longitude = position.coords.longitude; // 경도
	    
	    console.log(position.coords);
	    
	  //kakao REST API에 get 요청을 보낸다.
	    //파라미터 x,y에 lon,lat을 넣어주고 API_KEY를 Authorization헤더에 넣어준다.
	    
	    $.ajax({
	    	type:"get",
	    	url:"https://dapi.kakao.com/v2/local/geo/coord2address.json?x="+longitude+"&y="+latitude+"&input_coord=WGS84",
	    	beforeSend: function (header) {
	    		header.setRequestHeader("Authorization","KakaoAK 840539f3651afe19f12cc19a1dc9e0ab");
	        },
	        success:function(result){
	        	console.log(result.documents);
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

	var container = document.getElementById('map'); //지도를 담을 영역의 DOM 레퍼런스
	var options = { //지도를 생성할 때 필요한 기본 옵션
		center: new kakao.maps.LatLng(37.5392375, 126.9003409), //지도의 중심좌표.
		level: 3 //지도의 레벨(확대, 축소 정도)
		
	};

	var map = new kakao.maps.Map(container, options); //지도 생성 및 객체 리턴
	
	//마커 초기화(초기화 시 지도에 미리 지정 가능 : 카카오맵 API 문서 참조)
	const marker = new kakao.maps.Marker();
	
	//카카오맵 클릭 이벤트 추가
	kakao.maps.event.addListener(map, 'click', (mouseEvent) => {
		//클릭한 위도, 경도 정보 불러오기
		const latlng = mouseEvent.latLng;
		//마커 위치를 클릭한 위치로 이동
		marker.setPosition(latlng);
		marker.setMap(map);
		
	});
</script>
<jsp:include page="/WEB-INF/views/common/footer.jsp" />