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
  #qnaAns{
    width: 1100px;
    margin: auto;
  }
  .ansTable {
  	margin: auto;
	border-collapse: collapse;
	text-align:center;
	}
  .ansTable thead {
	border-bottom: 2px solid;
	font-size: 20px;
  }
  .ansTable tbody tr {
	border-bottom: 1px solid rgb(214, 214, 214);
	font-size: 15px;
  }
  #replyBtnBox{ float:right;
  	margin-right:150px;
  }
  
  .replyBtn{
  	width:50px; height:30px; border: 1px solid; border-radius:5px;
  	background-color:white;
  }
  
</style>
<body>
<div id="qnaAns">
  <h1>1대1 답변</h1><br><br>

<form action="insertAnswer.do" >
    <table class="ansTable">
        <thead>
          <tr>
            <th width="100px">문의 번호</th>
            <th width="400px">제목</th>
            <th width="200px">작성자</th>
            <th width="100px">날짜</th>
          </tr>
        </thead>
        <tbody>
			<tr style="height:40px">
	            <th width="100px">${qna.qnaNo}</th>
	            <td width="400px">${qna.qnaTitle}</td>
	            <td width="200px">${qna.qnaWriter}</td>
	            <td width="100px">${qna.createAt}</td>
         	</tr>
        	<tr style="height:250px">
	            <th>문의 내용 </th>
	            <td colspan="2"><textarea style="resize: none; height:200px" readonly>${qna.qnaContent}</textarea></td>
				<td></td>
       		</tr>
			<tr style="height:250px">
	            <th>답변 내용</th>
	            <td colspan="2"><textarea name="qAnswer" style="resize: none; height:200px"></textarea></td>
				<td></td>
			</tr>
        </tbody>
      </table>
	  <input type="hidden" name="qnaNo" value="${qna.qnaNo}">
      <br>
	  <div id="replyBtnBox">
		  <button class="replyBtn" type="submit" onclick="location.href='QAnswerInsert.do'">작성</button>
		  <button class="replyBtn" type="reset">취소</button>
	  </div>
      
       <input type="hidden" name="qnaNo" value="${qna.qnaNo}">
		<!-- 부모글의 정보 -->
		<input type="hidden" name="ref" value="${qna.ref}">
		<input type="hidden" name="depth" value="${qna.depth}">
</form>      
</div>


<jsp:include page="/WEB-INF/views/common/footer.jsp" />