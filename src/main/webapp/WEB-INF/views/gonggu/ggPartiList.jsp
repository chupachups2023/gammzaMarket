<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/mypage/ggPartic_List.css?<%=System.currentTimeMillis() %>">
<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param value="${gonggu.gongguName } 신청자 리스트" name="title"/>
</jsp:include>
<style>
	#container{
		display:flex;
		flex-direction: column;
		align-items: center;
	}
	
	#container>.long-btn{
		width:200px;
		font-size:16px;
	}
	.userId_bold{
		font-weight:bold;
	}
</style>
	<h1 align="center">
		<c:choose>
			<c:when test="${fn:length(gonggu.gongguName) gt 25}">
				<a href="${pageContext.request.contextPath }/gonggu/ggRead.go?gongguNo=${gonggu.gongguNo}">${fn:substring(gonggu.gongguName, 0, 25)}⋯ 신청자 리스트</a>
			</c:when>
			<c:otherwise>
				<a href="${pageContext.request.contextPath }/gonggu/ggRead.go?gongguNo=${gonggu.gongguNo}" >${gonggu.gongguName} 신청자 리스트</a>
			</c:otherwise>
		</c:choose>
	</h1>
	<div id="container">
		<table class="table" align="center" id="partiTable" >
		<c:forEach items="${partiList}" var="list" varStatus="j">
			<tr>
			<c:choose>
				<c:when test="${list.status > 0 }">
					<td height="50px"> <input type="checkbox" value="${j.index}" name="gongguMem" disabled checked> </td>
				</c:when>
				<c:otherwise>
					<td height="50px"> <input type="checkbox" value="${j.index}" name="gongguMem"> </td>
				</c:otherwise>
			</c:choose>
				<td>${j.count }</td>
				<td class="userId_bold">${list.userId }</td>
				<td>${list.num }개(인분)</td>
				<td>${list.temperature }도</td>
				<td>
					<c:choose>
						<c:when test="${list.status eq 0 }">
							참여 대기
						</c:when>
						<c:otherwise>
							참여 중
						</c:otherwise>
					</c:choose>
				</td>
				
				<td class="dateTd">
					<fmt:parseDate value="${list.regAt }" var="regAt" pattern="yyyy-MM-dd HH:mm"/>
					<fmt:formatDate value="${regAt }" pattern="yyyy년 MM월 dd일 HH시 mm분"/> 신청
				</td>
			</tr>
		</c:forEach>
		</table>
		<button class="long-btn button" onclick="addMember();">공구 참여자로 추가하기</button>
	</div>
<script>
	
	function addMember(){
		
		var rowData = [];
		var tdArr = [];
		var checkbox = $("input[name=gongguMem]:checked");
		
		totalNum=0;
		let arr=[];
		checkbox.each(function(i) {
			let tr = checkbox.parent().parent().eq(i);
			let td = tr.children();
			let num = td.eq(3).text().split('개')[0];
			let id = td.eq(2).text();
			totalNum+=num*1;
			arr.push(id);
			
		/*	rowData.push(tr.text());
			
		 	// td.eq(0)은 체크박스 이므로  td.eq(1)의 값부터 가져온다.
			var no = td.eq(1).text()+", "
			var userid = td.eq(2).text()+", ";
			var name = td.eq(3).text()+", ";
			var email = td.eq(4).text()+", ";
			 */
		});
		const maxNum="${gonggu.num}";
		console.log(maxNum);
		if(totalNum>(maxNum*1)){
			alert("최대 선택 가능 수량 또는 인원은 "+maxNum+"개(명)입니다");
		}else{
			let strr='?gongguNo=${gonggu.gongguNo}&';
			for(let i=0;i<arr.length;i++){
				strr+="id="+arr[i]+"&";
			}
			location.href="${pageContext.request.contextPath }/gonggu/partiMemSelect.pa"+strr;
		}
	};
	
/*	
var table = document.getElementById('partiTable');
      var rowList = table.rows;

		for (i=0; i<rowList.length; i++) {
			var row = rowList[i];
        	var tdNum = 7;     //아래 for문에서 사용하기 위해 row 하위에 존재하는 td의 갯수를 구합니다.
        var arr="";
        row.onclick = function() {
              var row_value2 = this.cells[2].innerHTML;
             arr2=row_value2.replace('<b>','');
             arr2=arr2.replace('</b>','');
              var row_value3 = this.cells[3].innerHTML;
            arr=row_value3.split('개')[0];
        	console.log(arr2);
        };
        
      }
*/
</script>

<jsp:include page="/WEB-INF/views/common/footer.jsp" />