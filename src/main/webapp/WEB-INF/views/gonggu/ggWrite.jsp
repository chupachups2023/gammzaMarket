<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=44e2b21ec219944c6d834fff124a603d&libraries=services,clusterer"></script>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/common/ggWrite.css">

<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param value="공구 글 작성하기" name="title"/>
</jsp:include>

<!-- 
*제목 수정하기
*내용 들어갈 곳
*공구 글 작성 
-->


  <!--   <h1>공구 글 작성</h1>
    <hr>  -->
    <div class="write-container">
        <form action="${pageContext.request.contextPath}/gonggu/ggEnrollFrm.go" method="post" enctype="multipart/form-data" name="ggEnrollFrm">
            <div class="write-category">
                <input class="write-stuff" type="text" placeholder="공구할 물건" name="gongguName">
                <select name="category" id="">
                    <option value="1">카테고리</option>
                    <option value="2">의류</option>
                    <option value="3">화장품/미용</option>
                    <option value="4">식품/농산물</option>
                    <option value="5">가구/인테리어</option>
                    <option value="6">배달음식</option>
                    <option value="7">유아동</option>
                    <option value="8">생활용품</option>
                    <option value="9">반려동물용품</option>
                </select>
            </div>
            <div>
                <div class="write-price">
                    <span>개당</span><input type="number" name="price" id="">￦
                </div>
                <div class="write-count">
                    공구 수량 <select name="" id="">
                        <option value="0">수량 기준</option>
                        <option value="1">인원 기준</option>
                    </select>
                    <input type="text" name="num">명/개
                </div>
                
                <!-- 사진 파일 첨부 -->
                <div>
                    <input type="file" name="photo1">
                    <input type="file" name="photo2">
                    <input type="file" name="photo3">
                </div>
            </div>

            <!-- date/time -->
            <div class="write-info2">
                <div class="write-date">
                    <table class="write-tb">
                        <tr>
                            <td>물건 나눌 날짜</td>
                            <td><input type="date" name="sendDate" ></td>
                        </tr>
                        <tr>
                            <td>물건 나눌 시간</td>
                            <td><input type="time" name="sendTime"></td>
                        </tr>
                        <tr></tr>
                        <tr>
                            <td>공구 마감 날짜</td>
                            <td><input type="date" name="endDate" ></td>
                        </tr>
                        <tr>
                            <td>공구 마감 시간</td>
                            <td><input type="time" name="endTime"></td>
                        </tr>
                        <tr>
                            <td>공구 오픈 날짜</td>
                            <td><input type="date" name="openDate" ></td>
                        </tr>
                        <tr>
                            <td>공구 오픈 시간</td>
                            <td><input type="time" name="openTime"></td>
                        </tr>
                        <tr>
                            <td></td>
                            <td><input type="checkbox" id="chk2" name="openTime" value="sysdate"><label for="chk2">바로 시작하기</label></td>
                        </tr>
                    </table>
                </div>
                <div class="wirte-map">
                    <span>물건 나눌 장소</span>
                    <div id="map" class="ggWrite_map"></div>
                </div>
            </div>
            <input type="hidden" name="latitude" id="lat">
            <input type="hidden" name="longitude" id="lon">
            <div class="ggStart-btn"><input type="submit" value="공구 시작"></div>
        </form>
    </div>
<script>
function time(){
	const time=document.getElementById("time").value;
	console.log(time)
}
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

            	//카카오맵 클릭 이벤트 추가
            	kakao.maps.event.addListener(map, 'click', (mouseEvent) => {
            		//클릭한 위도, 경도 정보 불러오기
            		const latlng = mouseEvent.latLng;
            		
            		document.getElementById('lon').value=latlng.La;
            		document.getElementById('lat').value=latlng.Ma;
            		
            		//마커 위치를 클릭한 위치로 이동
            		marker.setPosition(latlng);
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

</script>

<jsp:include page="/WEB-INF/views/common/footer.jsp" />