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
	$(document)
			.ready(
					function() {
						var formObj = $("form[name='readForm']");

						// 수정 
						$(".update_btn").on("click", function() {
							formObj.attr("action", "/board/updateView");
							formObj.attr("method", "get");
							formObj.submit();
						})

						// 삭제
						$(".delete_btn").on("click", function() {

							var deleteYN = confirm("삭제하시겠습니까?");
							if (deleteYN == true) {

								formObj.attr("action", "../board/delete");
								formObj.attr("method", "post");
								formObj.submit();

							}
						})

						// 취소
						$(".list_btn").on("click", function() {

							location.href = "/board/list";
						})

						// 목록
						$(".list_btn")
								.on(
										"click",
										function() {

											location.href = "/board/list?page=${scri.page}"
													+ "&perPageNum=${scri.perPageNum}"
													+ "&searchType=${scri.searchType}&keyword=${scri.keyword}";
										})
						//댓글
						$(".replyWriteBtn").on("click", function() {
							var formObj = $("form[name='replyForm']");
							formObj.attr("action", "/board/replyWrite");
							formObj.submit();
						});

						//댓글 수정 View
						$(".replyUpdateBtn")
								.on(
										"click",
										function() {
											location.href = "/board/replyUpdateView?bno=${read.bno}"
													+ "&page=${scri.page}"
													+ "&perPageNum=${scri.perPageNum}"
													+ "&searchType=${scri.searchType}"
													+ "&keyword=${scri.keyword}"
													+ "&rno="
													+ $(this).attr("data-rno");
										});

						//댓글 삭제 View
						$(".replyDeleteBtn")
								.on(
										"click",
										function() {
											location.href = "/board/replyDeleteView?bno=${read.bno}"
													+ "&page=${scri.page}"
													+ "&perPageNum=${scri.perPageNum}"
													+ "&searchType=${scri.searchType}"
													+ "&keyword=${scri.keyword}"
													+ "&rno="
													+ $(this).attr("data-rno");
										});

					})
					function fn_fileDown(fileNo){
         var formObj = $("form[name='readForm']");
         $("#FILE_NO").attr("value", fileNo);
         formObj.attr("action", "/board/fileDown");
         formObj.submit();
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

		<div align="center";>
			<%@include file="nav.jsp"%>
		</div>
		<hr />

		<section id="container">
			<form name="readForm" role="form" method="post">
				<input type="hidden" id="bno" name="bno" value="${read.bno}" /> <input
					type="hidden" id="page" name="page" value="${scri.page}"> <input
					type="hidden" id="perPageNum" name="perPageNum"
					value="${scri.perPageNum}"> <input type="hidden"
					id="searchType" name="searchType" value="${scri.searchType}">
				<input type="hidden" id="keyword" name="keyword"
					value="${scri.keyword}">
					<input type="hidden" id="keyword" name="keyword" value="${scri.keyword}">
            <input type="hidden" id="FILE_NO" name="FILE_NO" value="">
			</form>
			<table>
				<tbody>
					<tr>
						<td><label for="regdate">작성날짜</label> <fmt:formatDate
								value="${read.regdate}" pattern="yyyy-MM-dd" /></td>
					</tr>
					<tr>
						<td><label for="writer">작성자 ID</label><input type="text" 
							id="writer" name="writer" value="${read.writer}"
							readonly="readonly" /></td>
					</tr>
					<tr>
						<td><label for="title">제목</label><input type="text" 
							id="title" name="title" value="${read.title}" readonly="readonly" />
						</td>
					</tr>
					<tr>
						<td><label for="content" >내용</label> <textarea id="content" style="width:500px;height:500px;font-size:30px" 
								name="content" readonly="readonly"><c:out
									value="${read.content}" /></textarea></td>
					</tr>
					
				</tbody>
			</table>
			
            <span>파일 목록</span>
            <div class="form-group" style="border: 10px solid #dbdbdb;">
               <c:forEach var="file" items="${file}">
                  <a href="#" onclick="fn_fileDown('${file.FILE_NO}'); return false;">${file.ORG_FILE_NAME}</a>(${file.FILE_SIZE}kb)<br>
               </c:forEach>
               
            </div>
   
			<div>
				<button type="submit" class="update_btn" style="background-color: #77B9F2;" >수정</button>
				<button type="submit" class="delete_btn" style="background-color: #FA0C2D;">삭제</button>
				<button type="submit" class="list_btn">목록</button>
			</div>
			 <hr>

			<!-- 댓글 -->
			<div id="reply">
				<ol class="replyList">
					<c:forEach items="${replyList}" var="replyList">
						<li>
							<p>
								작성자 : ${replyList.writer}<br /> 작성 날짜 :
								<fmt:formatDate value="${replyList.regdate}"
									pattern="yyyy-MM-dd" />
							</p>

							<p>${replyList.content}</p>
							<div>
								<button type="button" class="replyUpdateBtn"
									data-rno="${replyList.rno}">수정</button>
								<button type="button" class="replyDeleteBtn"
									data-rno="${replyList.rno}">삭제</button>
							</div>
						</li>
					</c:forEach>
				</ol>
			</div>

			<form name="replyForm" method="post">
				<input type="hidden" id="bno" name="bno" value="${read.bno}" /> <input
					type="hidden" id="page" name="page" value="${scri.page}"> <input
					type="hidden" id="perPageNum" name="perPageNum"
					value="${scri.perPageNum}"> <input type="hidden"
					id="searchType" name="searchType" value="${scri.searchType}">
				<input type="hidden" id="keyword" name="keyword"
					value="${scri.keyword}">

				<div>
					<label for="writer">댓글 작성자</label><input type="text" id="writer"
						name="writer" /> <br /> <label for="content">댓글 내용</label><input
						type="text" id="content" name="content" />
				</div>
				<div>
					<button type="button" class="replyWriteBtn">작성</button>
				</div>
			</form>
		</section>
		<hr />
	</div>
	</div>
	</section>
	</div>
	</div>
	
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