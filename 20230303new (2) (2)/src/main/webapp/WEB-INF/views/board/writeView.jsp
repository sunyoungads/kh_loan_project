<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<html>
<%@include file="../include/header.jsp"%>
<head>
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.1.0/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.0/umd/popper.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.1.0/js/bootstrap.min.js"></script>

<title>자유게시판</title>
</head>
<script type="text/javascript">
	$(document).ready(function() {
		var formObj = $("form[name='writeForm']");
		$(".write_btn").on("click", function() {
			if (fn_valiChk()) {
				return false;
			}
			formObj.attr("action", "../board/write");
			formObj.attr("method", "post");
			formObj.submit();
		});
	})
	function fn_valiChk() {
		var regForm = $("form[name='writeForm'] .chk").length;
		for (var i = 0; i < regForm; i++) {
			if ($(".chk").eq(i).val() == "" || $(".chk").eq(i).val() == null) {
				alert($(".chk").eq(i).attr("title"));
				return true;
			}
		}
	}
	function fn_addFile(){
	      var fileIndex = 1;
	      //$("#fileIndex").append("<div><input type='file' style='float:left;' name='file_"+(fileIndex++)+"'>"+"<button type='button' style='float:right;' id='fileAddBtn'>"+"추가"+"</button></div>");
	      $(".fileAdd_btn").on("click", function(){
	         $("#fileIndex").append("<div><input type='file' style='float:left;' name='file_"+(fileIndex++)+"'>"+"</button>"+"<button type='button' style='float:right;' id='fileDelBtn'>"+"삭제"+"</button></div>");
	      });
	      $(document).on("click","#fileDelBtn", function(){
	         $(this).parent().remove();
	         
	      });
	   }
</script>
<body>

    <div class="container" style="padding:50px;">
		<div class="card shadow">
		<section id="container">
		<div class="card-body">
	<div id="root" align="center">
		<header>
			<h1 style="color:#2793F2;">자유게시판</h1>
		</header>
		<hr />

		
		<hr />

		<section id="container">
			<form name="writeForm" method="post" action="/board/write" enctype="multipart/form-data">
				<table>
					<tbody>
						<c:if test="${member.userId != null}">
							<tr>
								<td><label for="title">제목</label><input type="text" 
									id="title" name="title" class="chk" title="제목을 입력하세요." /></td>
							</tr>
							<tr>
								<td><label for="content">내용</label> 
								<textarea id="content" name="content" class="chk" style="width:1000px;height:1000px;font-size:30px
										title="내용을 입력하세요."></textarea></td>
							</tr>
							<tr>
								<td><label for="writer">작성자</label><input type="text"
									id="writer" name="writer" class="chk" title="작성자를 입력하세요."
									value="${member.userId}" readonly /></td>
							<tr>							
								
							<tr>
								<td>
									<input type="file" name= "file">							
								</td>
							<tr>
								<td>
									<button class="write_btn" type="submit">작성</button>
								</td>
							</tr>
						</c:if>
						<c:if test="${member.userId == null}">
							<p>로그인 후에 작성하실 수 있습니다.</p>
						</c:if>

					</tbody>
				</table>
			</form>
</section>
</div>
</div>
</section>
</div>
</div>

		</section>
		<div class="container-fluid text-white" style="background-color: #77B9F2; margin-top:50px;padding-top:30px;padding-bottom:10px">
			<div class="container">
				<h2>HANUNE</h2>
				<p>http://hunune.nett/</p>
				<p>주소: IT 하누네시 한눈에구 알아보동</p>
				
				<p>사업자번호 : 000-111-222</p>
			</div>
	</div>
</body>
</html>