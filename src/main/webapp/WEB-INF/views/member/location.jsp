<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/member/location.css?<%=System.currentTimeMillis() %>">
<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param value="장소인증" name="title"/>
</jsp:include>

<form method="post" action="${pageContext.request.contextPath}/location/EnrollLocation.lo" name="loactionFrm">
  <div class="location-body">
        <div class="location-map" id="map"></div>
        <div class="location-part">
            <div>
                <div class="location-title">현재 접속 동네</div>
                <div class="location-cont">
                	<input name="sidoNm" id="sidoNm" readonly class="location-curr">
		            <input name="sggNm"  id="sggNm" readonly class="location-curr">
		            <input name="admNm"  type="hidden" id="admNm" >
		            <input name="legNm"  id="legNm" readonly class="location-curr">
				</div>
            </div>
            <div>
                <div class="location-title">현재 인증 동네</div>
                <div class="location-cont">
                <c:choose>
                	<c:when test="${empty loginMember }">
                	<div class="location-cont" >동네 인증은 로그인 후 가능합니다.</div>
                	</c:when>
                	<c:when test="${empty loginLocation }">
                	<div class="location-cont" >어서 동네 인증을 해주세요!</div>
                	</c:when>
                	<c:otherwise>
                	<div class="location-cont" >${loginLocation.sidoNm } ${loginLocation.sggNm } ${loginLocation.legNm }</div>
                	</c:otherwise>
                </c:choose>
				</div>
            </div>
            <div>
                <div class="location-title">우리 동네 근처 옆동네</div>
                <div class="location-cont" id="location-cont"></div>
            </div>
            <div class="location-btn">
                <input type="button" value="장소 인증하기" class="button" id="location-submit" onclick="locationSubmit();">
            </div>
        </div>
    </div>
	            <input type="hidden" id="lon" name="longitude" >
	            <input type="hidden" id="lat" name="latitude" >
</form>
<script>
function locationSubmit(){
	const userId="${loginMember.userId}";
	if(userId=="" || userId ==null){
		alert("장소를 인증하려면 먼저 로그인을 해야 합니다!")
	}else{
		loactionFrm.submit();
	}
}


function success(position) {
    /* const latitude = position.latitude;   // 위도(37.xxxx)
    const longitude = position.longitude; // 경도 */
     const latitude = position.coords.latitude;   // 위도(37.xxxx)
    const longitude = position.coords.longitude; // 경도 
    
    document.getElementById('lon').value=longitude;
	document.getElementById('lat').value=latitude;
    
    $.ajax({
    	type:"get",
    	url:"https://dapi.kakao.com/v2/local/geo/coord2address.json?x="+longitude+"&y="+latitude+"&input_coord=WGS84",
    	beforeSend: function (header) {
    		header.setRequestHeader("Authorization"," ");
        },
        success:function(result){
        	var address=result.documents[0].address.address_name;
        	geoCoe(address);
        	
        	var container = document.getElementById('map'); 
        	var options = { 
        		center: new kakao.maps.LatLng(latitude, longitude), 
        		level: 4 
        		
        	};
        	var map = new kakao.maps.Map(container, options); 
       	    map.setZoomable(false);
       	 	map.setDraggable(false);
        	
        	var markerPosition  = new kakao.maps.LatLng(latitude,longitude ); 
        	var marker = new kakao.maps.Marker({
        	    position: markerPosition
        	});
        	marker.setMap(map);
        	    
			getNearDong(latitude,longitude ); 
    		
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
		        	type:"post",
		        	url:"https://dapi.kakao.com/v2/local/geo/coord2address.json?x="+latlng.La+"&y="+latlng.Ma+"&input_coord=WGS84",
		        	beforeSend: function (header) {
		        		header.setRequestHeader("Authorization"," ");
		            },
		            success:function(clickresult){
		            	var clickaddress=clickresult.documents[0].address.address_name;
		            	geoCoe(clickaddress);
		            	
		            	getNearDong(latlng.Ma, latlng.La);
		            	
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

function getNearDong(lat, lon){
   	var places = new kakao.maps.services.Places();
   	
   	var callback = function(result, status) {
   	    if (status === kakao.maps.services.Status.OK) {
   	    	let addressForCon=[];
   	    	let placeName=[];
   	    	for(let i=0;i<result.length;i++){
   	    		addressForCon.push(result[i].address_name);
   	    		placeName.push(result[i].place_name);
   	    	}
		$.ajax({
   	        	type:"post",
   	        	url:"nearDong.lo",
   	        	traditional : true,
   	        	data:{'address':addressForCon, 'place':placeName},
   	        	dataType : 'json',
   	        	success:function(successResult){
   	        		const locationCont=document.getElementById("location-cont");
   	        		let nearDong='';
   	        		for(let k=0;k<successResult.returnValue.length-1;k++){
   	        			nearDong+=successResult.returnValue[k]+', ';
   	        		}
   	        		nearDong+=successResult.returnValue[successResult.returnValue.length-1];
   	        		locationCont.innerHTML=nearDong;
   	        	}
   	        });
    	}
    }

   	// 공공기관 코드 검색
   	places.keywordSearch('행정복지센터', callback, {
   	    
   	    location: new kakao.maps.LatLng(lat, lon),
   	    radius:4000,
   	    sort_by:"DISTANCE"
   	});
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
			/* position={"latitude":37.533921602961506, "longitude":126.89677032759451 } */
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
