<%@page import="com.webjjang.board.vo.BoardVO"%>
<%@page import="com.webjjang.main.controller.ExeService"%>
<%@page import="com.webjjang.main.controller.Beans"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
// 자바 부분
// 1.넘어오는 데이터 받기 - 글번호
String strNo = request.getParameter("no");
long no = Long.parseLong(strNo);
// 2. 글번호에 맞는 데이터 가져오기 -> BoardViewService => /board/view.jsp
String url = "/board/view.jsp"; // 현재 URL과 다르므로 강제 세팅함.
BoardVO vo = (BoardVO)ExeService.execute(Beans.get(url), new Long[]{no,0L});
// 3. 서버 객체에 넣기
request.setAttribute("vo", vo);
%>


<!DOCTYPE html>
<html>
<head>
<link rel="shortcut icon" href="/favicon.ico" type="image/x-icon">
<link rel="icon" href="/favicon.ico" type="image/x-icon">
<meta charset="UTF-8">
<title>게시판 글쓰기 폼</title>

  <!-- Bootstrap 라이브러리 등록 - CDN방식 -->
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
  
  <!--  formUtil.js 등록 -->
  <script type="text/javascript" src="../js/formUtil.js"></script>
  
<script type="text/javascript">

$(function(){
	
	$("#cancelBtn").click(function(){
		//alert("취소");
		//이전 페이지로 이동
		history.back();
	});
	
	// submit() 이벤트에 데이터 검사
	$("#writeForm").submit(function(){
		//alert("데이터 전달 이벤트");
		
		// 필수 입력
		// 제목
		if(!require($("#title"), "제목")) return false;
		// 내용
		if(!require($("#content"), "내용")) return false;
		// 작성자
		if(!require($("#writer"), "작성자")) return false;
		// 길이
		// 제목 4자 이상
		if(!checkLength($("#title"), "제목" , 4)) return false;
		// 내용 4자 이상
		if(!checkLength($("#content"), "내용" , 4)) return false;
		// 작성자 2자 이상
		if(!checkLength($("#writer"), "작성자" , 2)) return false;
		// submit 이벤트 취소
	});
	
});


</script>

</head>
<body>
<div class="container">
	
	<h1>글수정</h1>
	<p>
		게시판 글쓰기 처리
	</p>
	<form action="update.jsp" id="writeForm" method="post">
		<div class="form-group">
			<!-- 제목 -->
			<label for="no">번호</label>
			<input name="no" class="form-control" id="no" readonly="readonly" 
			value="${vo.no }">
		</div>
		<div class="form-group">
			<!-- 제목 -->
			<label for="title">제목</label>
			<input name="title" class="form-control" id="title" required="required"
			placeholder="제목을 4자 이상 입력 하셔야 합니다." value="${vo.title }">
		</div>
		
		<div class="form-group">
			<!-- 내용 -->
			<label for="content">내용</label>
			<textarea rows="7" name="content" class="form-control" id="content" required="required"
			 placeholder="내용을 4자 이상 입력 하셔야 합니다." >${vo.content }</textarea>
		</div>		
		
		<div class="form-group">
		<!-- 작성자 -->
		<label for="writer">작성자</label>
		<input name="writer" class="form-control" id="writer" required="required"
		placeholder="작성자를 2자 이상 입력 하셔야 합니다."  value="${vo.writer }">
		</div>
		
		
<button>수정</button>
<button type="reset" >새로입력</button>
<button type="button" id="cancelBtn">취소</button>
</form>
</div>
</body>
</html>