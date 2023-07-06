<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=44e2b21ec219944c6d834fff124a603d&libraries=services,clusterer"></script>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/gonggu/ggWrite.css?<%=System.currentTimeMillis()  %>">
<script type="text/javascript" src="http://code.jquery.com/jquery-latest.min.js"></script>	
<!-- <script type="text/javascript">
	
</script> -->

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
        <form action="${pageContext.request.contextPath}/gonggu/ggEnrollFrm.go?roomOwner=${loginMember.userId}" method="post" enctype="multipart/form-data" name="ggEnrollFrm">
            <div class="write-category">
                <input class="write-stuff" type="text" placeholder="공구할 물건" name="gongguName">
                <select name="category">
                    <option value="0">카테고리</option>
                    <option value="1">의류</option>
                    <option value="2">화장품/미용</option>
                    <option value="3">식품/농산물</option>
                    <option value="4">가구/인테리어</option>
                    <option value="5">배달음식</option>
                    <option value="6">유아동</option>
                    <option value="7">생활용품</option>
                    <option value="8">반려동물용품</option>
                </select>
            </div>
            <div>
                <div class="write-price">
                    <span>개당</span><input type="number" name="price" id="">P
                </div>
                <div class="ggWrite-mid-flex">
                <div>
                <div class="write-count">
                    공구 수량 <select name="type" >
                        <option value="0">수량 기준</option>
                        <option value="1">인원 기준</option>
                    </select>
                    <input type="text" name="num">명/개
                </div>
	                <!-- 사진 파일 첨부 -->
	                <div class="ggWrite_fileupload_out">
					    <div class="ggWirte_upload_icon" onclick="openFileUpload('1');">
					        <img src="https://cdn-icons-png.flaticon.com/512/1237/1237946.png" class="ggWrite_plus">
					        <div class="ggWrite_file">
					            <img src="" alt="" id="preview-image1" class="preview-image">
					            <input type="file" accept=".jpg, .png, jpeg" class="hidden" id="hiddenFile1" name="upPhoto1">
					        </div>
					    </div>
					
					    <div class="ggWirte_upload_icon" onclick="openFileUpload('2');">
					        <img src="https://cdn-icons-png.flaticon.com/512/1237/1237946.png" class="ggWrite_plus">
					        <div class="ggWrite_file">
					            <img src="" alt="" id="preview-image2" class="preview-image">
					            <input type="file" accept=".jpg, .png, jpeg" class="hidden" id="hiddenFile2" name="upPhoto2">
					        </div>
					    </div>
					    
					    <div class="ggWirte_upload_icon" onclick="openFileUpload('3');">
					        <img src="https://cdn-icons-png.flaticon.com/512/1237/1237946.png" class="ggWrite_plus">
					        <div class="ggWrite_file">
					            <img src="" alt="" id="preview-image3" class="preview-image">
					            <input type="file" accept=".jpg, .png, jpeg" class="hidden" id="hiddenFile3" name="upPhoto3">
					        </div>
					    </div>
					</div>
				</div>
	            <div class="ggWrite-null">
					<div class="ggWrite-content">
						<pre><textarea name="content" placeholder="공구 예정자들에게 전달할 내용이 있나요?" class="ggWrite-textarea"></textarea></pre>
					</div>
					<div class="ggWrite-link">
						구매 예정 링크: <input name="link">
					</div>
				</div>
			</div>
            <!-- date/time -->
            <div class="write-info2">
                <div class="write-date">
                    <table class="write-tb">
                        <tr>
                            <td rowspan="2">공구 오픈 날짜</td>
                            <td><input type="datetime-local" name="openTime" id="openTime"></td>
                        </tr>
                        <tr>
                            <td><input type="checkbox" id="sysdate" value="sysdate" ><label for="sysdate">바로 시작하기</label></td>
                        </tr>
                        <tr>
                            <td class="gg-date">공구 마감 날짜</td>
                            <td><input type="datetime-local" name="endTime" id="endTime"></td>
                        </tr>
                        <tr>
                            <td class="gg-date">물건 나눌 날짜</td>
                            <td><input type="datetime-local" name="sendTime" id="sendTime"></td>
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
            <input type="hidden" name="sidoNm" id="sidoNm">
            <input type="hidden" name="sggNm" id="sggNm">
            <input type="hidden" name="admNm" id="admNm">
            <input type="hidden" name="legNm" id="legNm">
            <input type="hidden" name="gongguWriter" value="${loginMember.userId }">
            <div class="ggStart-btn"><input type="button" value="공구 시작" onclick="ggEnrollFrmSubmit();"></div>
        </form>
    </div>
	<script src="${pageContext.request.contextPath}/resources/js/gonggu/ggWriteMap.js?<%=System.currentTimeMillis() %>"></script>
<script>


	
	var now_utc = Date.now();
	var timeOff = new Date().getTimezoneOffset()*60000;
	var today = new Date(now_utc-timeOff).toISOString().substring(0, 16);
	
	document.getElementById("openTime").setAttribute("min", today);
	document.getElementById("endTime").setAttribute("min", today);
	
	function openFileUpload(num) {
        
	    document.getElementById("hiddenFile"+num).click();

	    function readImage(input) {
	        // 인풋 태그에 파일이 있는 경우
	        if (input.files && input.files[0]) {
	            // 이미지 파일인지 검사 (생략)
	            // FileReader 인스턴스 생성
	            const reader = new FileReader()
	            // 이미지가 로드가 된 경우
	            reader.onload = e => {
	                const previewImage = document.getElementById("preview-image"+num);
	                previewImage.src = e.target.result;
	                previewImage.style.backgroundColor="white";
	            }
	            // reader가 이미지 읽도록 하기
	            reader.readAsDataURL(input.files[0]);
	        }
	    }
	    // input file에 change 이벤트 부여
	    const inputImage = document.getElementById("hiddenFile"+num);
	    inputImage.addEventListener("change", e => {
	        readImage(e.target)
	    });
	}
	
	
</script>


<script src="${pageContext.request.contextPath}/resources/js/gonggu/ggWrite.js"></script>
<jsp:include page="/WEB-INF/views/common/footer.jsp" />