<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=44e2b21ec219944c6d834fff124a603d&libraries=services,clusterer"></script>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/gonggu/ggWrite.css?<%=System.currentTimeMillis() %>">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/gonggu/ggWriteRequest.css?<%=System.currentTimeMillis() %>">
<script type="text/javascript" src="http://code.jquery.com/jquery-latest.min.js"></script>	

<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param value="공구 요청하기" name="title"/>
</jsp:include>
    <div class="request-title">
        <h1>공구 요청 작성글</h1>
    </div>

    <div class="request-container-out">
        <form action="${pageContext.request.contextPath}/ggRequest/ggRequestFrm.req" method="post" name="ggRequestFrm"  class="request-container" enctype="multipart/form-data" >
		<div>
			<input type="hidden" name="requestWriter" value="${loginMember.userId }">
	           <div class="write-category">
	               <input class="write-stuff" type="text" placeholder="공구 요청할 물건" name="requestName">
	               <select name="categoryNo">
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
	
	           <div class="write-price">
	               <span>예상 가격</span>
	               <input type="text" name="price" placeholder="선택사항입니다">P
	           </div>
	           <div class="request-count">
	               <span>예시 링크</span>
	               <input type="text" name="link">
	           </div>
		</div>
	              <!-- 요청 공구 사진 -->
		<div>
			<div class="req-subtitle">요청 공구 사진</div>
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
	        <div>
	            <div class="req-subtitle">선호 지역 위치</div>
				<div id="map" class="ggWrite_map"></div>
			</div>
			<div>
		        <input type="hidden" name="latitude" id="lat">
		        <input type="hidden" name="longitude" id="lon">
		        <input type="hidden" name="sidoNm" id="sidoNm">
		        <input type="hidden" name="sggNm" id="sggNm">
		        <input type="hidden" name="admNm" id="admNm">
		        <input type="hidden" name="legNm" id="legNm">
			</div>
		</form>
		<div class="ggStart-btn"><input type="button" value="공구 요청하기" onclick="ggRequestFrmSubmit();"></div>
	</div>
<script src="${pageContext.request.contextPath}/resources/js/gonggu/ggWriteMap.js?<%=System.currentTimeMillis() %>"></script>
<script>

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

function ggRequestFrmSubmit(){
	let check = /^[0-9]+$/
	if(ggRequestFrm.requestName.value=="" || ggRequestFrm.requestName.value==null){
		alert("어떤걸 공구하시나요?");
		return;
	}else if(ggRequestFrm.categoryNo.value=="0"){
		alert("카테고리를 선택해주세요");
		return;
	}else if(ggRequestFrm.upPhoto1.value=="" && ggRequestFrm.upPhoto2.value=="" && ggRequestFrm.upPhoto3.value=="" ){
		alert("사진은 하나 이상 들어가야합니다!");
		return;
	}else{
		ggRequestFrm.submit();
	}
}
</script>
<jsp:include page="/WEB-INF/views/common/footer.jsp" />