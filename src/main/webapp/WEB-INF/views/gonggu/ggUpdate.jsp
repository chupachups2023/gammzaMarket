<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/gonggu/ggUpdate.css?<%=System.currentTimeMillis() %>">

<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param value="공구 글 수정하기" name="title"/>
</jsp:include>
    <div class="write-container">
        <form action="${pageContext.request.contextPath}/gonggu/ggUpdate.go" method="post" enctype="multipart/form-data" name="ggUpdateFrm">
            <div class="write-category">
                <input class="write-stuff" type="text" placeholder="공구할 물건" name="gongguName" value="${gonggu.gongguName }">
                <select name="category">
                    <option value="0" id="cate0">카테고리</option>
                    <option value="1" id="cate1">의류</option>
                    <option value="2" id="cate2">화장품/미용</option>
                    <option value="3" id="cate3">식품/농산물</option>
                    <option value="4" id="cate4">가구/인테리어</option>
                    <option value="5" id="cate5">배달음식</option>
                    <option value="6" id="cate6">유아동</option>
                    <option value="7" id="cate7">생활용품</option>
                    <option value="8" id="cate8">반려동물용품</option>
                </select>
            </div>
                <div class="write-price">
                    <span>개당(인당)가격</span><input type="number" name="price" value="${gonggu.price}">P
                </div>
			<div class="ggWrite-mid-flex">
                <div>
	                <div class="write-count-out">
		                <div class="write-count">
		                    공구 수량 <select name="type" >
		                        <option value="0" id="type0">수량 기준</option>
		                        <option value="1" id="type1">인원 기준</option>
		                    </select>
		                    <input type="number" name="num" value="${gonggu.num }">명/개
		                </div>
		                <small class="write-count-small">* 나를 제외한 인원 또는 수량으로 입력해주세요</small>
	               </div>
	                <!-- 사진 파일 첨부 -->
	                <div class="ggWrite_fileupload_out">
					    <div class="ggWirte_upload_icon" onclick="openFileUpload('1');">
					        <img src="https://cdn-icons-png.flaticon.com/512/1237/1237946.png" class="ggWrite_plus">
					        <div class="ggWrite_file">
					        <c:choose>
					        	<c:when test="${not empty gonggu.photo1 }">
						            <img src="${pageContext.request.contextPath}/resources/upload/${gonggu.photo1}" id="preview-image1" alt="" class="preview-image">
					        	</c:when>
					        	<c:otherwise>
						            <img src="" alt="" id="preview-image1" class="preview-image">
					        	</c:otherwise>
					        </c:choose>
					            <input type="file" accept=".jpg, .png, jpeg" class="hidden" id="hiddenFile1" name="upPhoto1">
					        </div>
					    </div>
					
					    <div class="ggWirte_upload_icon" onclick="openFileUpload('2');">
					        <img src="https://cdn-icons-png.flaticon.com/512/1237/1237946.png" class="ggWrite_plus">
					        <div class="ggWrite_file">
					        <c:choose>
					        	<c:when test="${not empty gonggu.photo2 }">
						            <img src="${pageContext.request.contextPath}/resources/upload/${gonggu.photo2}" id="preview-image2" alt="" class="preview-image">
					        	</c:when>
					        	<c:otherwise>
						            <img src="" alt="" id="preview-image2" class="preview-image">
					        	</c:otherwise>
					        </c:choose>
					            <input type="file" accept=".jpg, .png, jpeg" class="hidden" id="hiddenFile2" name="upPhoto2">
					        </div>
					    </div>
					    
					    <div class="ggWirte_upload_icon" onclick="openFileUpload('3');">
					        <img src="https://cdn-icons-png.flaticon.com/512/1237/1237946.png" class="ggWrite_plus">
					        <div class="ggWrite_file">
					        <c:choose>
					        	<c:when test="${not empty gonggu.photo3}">
						            <img src="${pageContext.request.contextPath}/resources/upload/${gonggu.photo3}" id="preview-image3" alt="" class="preview-image">
					        	</c:when>
					        	<c:otherwise>
						            <img src="" alt="" id="preview-image3" class="preview-image">
					        	</c:otherwise>
					        </c:choose>
					            <input type="file" accept=".jpg, .png, jpeg" class="hidden" id="hiddenFile3" name="upPhoto3">
					        </div>
					    </div>
					</div>
				</div>
	            <div class="ggWrite-null">
					<div class="ggWrite-content">
						<pre><textarea name="content" placeholder="공구 예정자들에게 전달할 내용이 있나요?" class="ggWrite-textarea">${gonggu.content }</textarea></pre>
					</div>
					<div class="ggWrite-link">
						구매 예정 링크: <input name="link" value="${gonggu.link}">
					</div>
				</div>
			</div>
            <!-- date/time -->
            <div class="write-info2">
                <div class="write-date">
                    <table class="write-tb">
                        <tr>
                            <td rowspan="2">공구 오픈 날짜</td>
                            <td><input type="datetime-local" name="openTime" id="openTime" value="${gonggu.openTime }"></td>
                        </tr>
                        <tr>
                            <td><input type="checkbox" id="sysdate" value="sysdate" ><label for="sysdate">바로 시작하기</label></td>
                        </tr>
                        <tr>
                            <td class="gg-date">공구 마감 날짜</td>
                            <td><input type="datetime-local" name="endTime" id="endTime" value="${gonggu.endTime }"></td>
                        </tr>
                        <tr>
                            <td class="gg-date">물건 나눌 날짜</td>
                            <td><input type="datetime-local" name="sendTime" id="sendTime" value="${gonggu.sendTime }"></td>
                        </tr>
                    </table>
                </div>
                <div class="wirte-map">
                    <span>물건 나눌 장소</span>
                    <div id="map" class="ggWrite_map"></div>
                </div>
            </div>
            <input type="hidden" name="latitude" id="lat" value="${gonggu.latitude }">
            <input type="hidden" name="longitude" id="lon" value="${gonggu.longitude }">
            <input type="hidden" name="sidoNm" id="sidoNm" value="${location.sidoNm }">
            <input type="hidden" name="sggNm" id="sggNm" value="${location.sggNm }">
            <input type="hidden" name="admNm" id="admNm" value="${location.admNm }">
            <input type="hidden" name="legNm" id="legNm" value="${location.legNm }">
            <input type="hidden" name="gongguNo" value="${gonggu.gongguNo }">
            <div class="ggStart-btn"><input type="button" value="공구 수정" onclick="ggUpdateFrmSubmit();"></div>
        </form>
    </div>
	<script src="${pageContext.request.contextPath}/resources/js/gonggu/ggUpdateMap.js?<%=System.currentTimeMillis() %>"></script>
	<script>
	let gongguCate="${gonggu.category}";
	let gongguType="${gonggu.type}";
	if(gongguCate != ""){
		document.getElementById("cate"+gongguCate).setAttribute("selected","true");
		document.getElementById("type"+gongguType).setAttribute("selected","true");
	}
	
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
	            // FileReader 인스턴스 생성
	            const reader = new FileReader()
	            // 이미지가 로드가 된 경우
	            reader.onload = e => {
	                const previewImage = document.getElementById("preview-image"+num);
	                const oldPhoto = document.getElementById("Pvalue"+num);
	                previewImage.src = e.target.result;
	                oldPhoto.src= " " ;
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


<script src="${pageContext.request.contextPath}/resources/js/gonggu/ggUpdate.js?<%=System.currentTimeMillis() %>"></script>
<jsp:include page="/WEB-INF/views/common/footer.jsp" />