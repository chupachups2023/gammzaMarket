<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param value="제목" name="title"/>
</jsp:include>

</head>
<style>
    * {margin: 0 10%;}
  .qnaAns{
    width: 1100px;
  }
  .ansTable {
	width:800px;
	border-collapse: collapse;
	}
  .ansTable thead {
	border-bottom: 2px solid;
	font-size: 20px;
  }
  .ansTable tbody tr {
	border-bottom: 1px solid rgb(214, 214, 214);
	font-size: 15px;
  }
  
</style>
<body>
<div id="qnaAns">
  <h1>1대1 답변</h1><br><br>

<form action="insertAnswer">
    <table class="ansTable">
        <thead>
          <tr>
            <th width="100px">NO</th>
            <th width="400px">제목</th>
            <th width="200px">작성자</th>
            <th width="100px">날짜</th>
          </tr>
        </thead>
        <tbody>
			<tr style="height:40px">
	            <th>${qna.qnaNo}</th>
	            <td>${qna.qnaTitle}</td>
	            <td>${qna.qnaWriter}</td>
	            <td>${qna.createAt}</td>
         	</tr>
        	<tr style="height:250px">
	            <th>문의 내용 </th>
	            <td colspan="2"><textarea cols="65" rows="15" style="resize: none;" readonly>${qna.qnaContent}</textarea></td>
				<td></td>
       		</tr>
			<tr style="height:250px">
	            <th>답변 내용</th>
	            <td colspan="2"><textarea name="qAnswer" cols="65" rows="15" style="resize: none;"></textarea></td>
				<td></td>
			</tr>
        </tbody>
      </table>
	  <div style="display: inline;">
		  <input type="submit" value="작성" onclick="location.href="QAnswerInsert.do"><input type="reset" value="취소">
	  </div>
	  <input type="hidden" name="qnaNo" value="${qna.qnaNo}">
</form>      
</div>


<jsp:include page="/WEB-INF/views/common/footer.jsp" />