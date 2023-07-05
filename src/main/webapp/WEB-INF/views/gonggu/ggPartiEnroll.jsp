<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/gonggu/ggPartiEnroll.css">
<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param value="${gonggu.gongguName }에 참여하기" name="title"/>
</jsp:include>

	<!-- 공구 참여하기 -->
    <div class="partic-title">
        <h1>공구 물건 이름: 참여폼</h1>
        <hr>
    </div>
    <div class="partic-container">

        <form action="" method="">
            <table>
                <tbody>
                    <tr>
                        <td class="partic-tb-top">공구품 정보</td>
                        <td>
                            공구 게시물 제목
                        </td>
                        <td>
                            <img src="sample1.png" alt="공구품이미지" style="width: 75px; height: auto;">
                        </td>
                    </tr>
                    <tr>
                        <td colspan="">수량</td>
                        <td>
                            <button type="button" class="partic-minus" onclick="">-</button>
                            <input type="text" class="partic-qty" value="1" name="" style="text-align: center;"> <!-- name 속성: 수량 DB 연동 -->
                            <button type="button" class="partic-plus" onclick="">+</button>
                        </td>
                    </tr>
                    <tr class="partic-point">
                        <td>소모 포인트</td>
                        <td>
                            <input type="text" style="border: none; border-bottom: 1px solid #000000;">
                        </td>
                        <td>포인트</td>
                    </tr>
                    <tr class="partic-point">
                        <td>보유 포인트</td>
                        <td>
                            <input type="text" style="border: none; border-bottom: 1px solid #000000;">
                        </td>
                        <td>포인트</td>
                    </tr>
                    <tr class="partic-point">
                        <td>남는 포인트</td>
                        <td>
                            <input type="text" style="border: none; border-bottom: 1px solid #000000;">
                        </td>
                        <td>포인트</td>
                    </tr>
                    <tr class="partic-point">
                        <td>부족한 포인트</td>
                        <td>
                            <input type="text" style="border: none; border-bottom: 1px solid #000000;">
                        </td>
                        <td>포인트</td>
                    </tr>
                    <tr>
                        <td>모집마감시간</td>
                        <td>2023년 6월 10일 12시 00분</td>
                    </tr>
                    <tr>
                        <td>교환장소/시간</td>
                        <td>주소.. / 2023.06.11 15시 예정</td>
                    </tr>
                    <tr>
                        <td class="partic-tb-bottom">#유의사항</td>
                        <td>조건 확인</td>
                    </tr>
                </tbody>
            </table>
            <div class="partic-btn"><input type="button" value="참여하기"></div>
            <!-- 모달창: 유의사항 동의 - 참여하기 -->
        </form>
    </div>






<jsp:include page="/WEB-INF/views/common/footer.jsp" />