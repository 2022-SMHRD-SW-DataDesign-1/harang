<%@page import="com.smhrd.model.FollowDTO"%>
<%@page import="com.smhrd.model.MemberDAO"%>
<%@page import="com.smhrd.model.PolicyDAO"%>
<%@page import="com.smhrd.model.PolicyDTO"%>
<%@page import="java.math.BigDecimal"%>
<%@page import="com.smhrd.model.CommentDTO"%>
<%@page import="com.smhrd.model.CommentDAO"%>
<%@page import="com.smhrd.model.BoardDTO"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.smhrd.model.FollowDAO"%>
<%@page import="com.smhrd.model.BoardDAO"%>
<%@page import="com.smhrd.model.MemberDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<script src="http://code.jquery.com/jquery-latest.js"></script>
<style>
  /* 여러 채팅창 간의 간격과 배열 위치*/
  .float-left{
    float:left;
    margin: 5px;
  }
</style>
<body>

	<%
	MemberDTO info = (MemberDTO) session.getAttribute("info");
	
	%>
	<!-- 기능 테스트 페이지 -->

	<hr>
	<!-- 회원가입 o -->
	<form action="JoinService" method="post">
		Id:<input type="text" name="m_Id" id="inputID">
		<input type="button" value="ID중복체크" onclick="checkID()"><br>
		<span id="resultCheckID"></span> <br> 
		Pw: <input type="password" name="m_Pw"> <br> 
		Email: <input type="text" name="m_Email"><br>
		Nickname: <input type="text" name="m_Nickname"><br>
		Phone: <input type="text" name="m_Phone"> <br> <input
			type="submit" value="test 전송" id = "joinBtn" disabled="disabled">
	</form>


	<!-- 아이디 중복 체크 o -->
	
	<script>
		function checkID() {
			let inputID = $("#inputID").val();
			console.log(inputID);

			$.ajax({
				// 요청서버 url
				url : "IDCheckService",
				// 요청할 때 같이 보내줄 데이터
				data : {"inputID" : inputID},
				// 요청 타입
				type : 'get', 
				// 통신 성공 function(넘겨준데이터)
				success : function(data) {
					console.log(typeof data);
					if (data == 'true') {
						$("#resultCheckID").text("중복");
						$("#joinBtn").attr("disabled",true);
					} else {
						$("#resultCheckID").text("가능");
						$("#joinBtn").attr("disabled",false);
					}
				},
				// 통신 실패
				error : function() {
					console.log("조샀다 !");
				}
			})
		}
	</script>

	<hr>
	<!-- 로그인 o -->
	<form action="LoginService" method="post">
		Id:<input type="text" name="m_Id"> <br>
		Pw: <input type="password" name="m_Pw"> <br> 
		<input type="submit" value="test 로그인">
	</form>
	<%if(info != null){ %>
	 멤버정보 :<%= info.toString() %>
	 <%} %>
	 
	 
	 
	<hr>
	<!-- 로그아웃 o -->
	<br>
	<%if(info != null){ %>
	<a href="LogoutService">로그아웃</a> 
	<%} %>
	
	
	
	<hr>
	<!-- 게시글 작성 o -->
		<form action="BoardService"  enctype="multipart/form-data"  method="post">
		사진등록 :<input  type="file" style="float: right;" name="filename">
		게시글 입력 : <textarea  rows="10" style="resize: none;" name="content"></textarea><br> 
		<input type="submit" value="게시글 등록">
	</form>
	
	<hr>
	<!-- 게시글 목록 출력 o + 댓글 작성 o + 출력 o -->
	<%if(info != null){ %>
	게시글 내용(사진포함)
	<%
		//댓글 dao
		CommentDAO cmtDAO = new CommentDAO();
		//게시판 dao
		BoardDAO dao = new BoardDAO();  
		
		// 게시판 글 모음 dao에서 로그인한 아이디와 같은 글을 arraylist에 담음 
		ArrayList<BoardDTO> bList = dao.showBoard(info.getM_Id());
		
		for(BoardDTO b_dto : bList){%>
			게시글 : <%= b_dto.toString() %><br>	
		<%BigDecimal b_num = b_dto.getB_num();
		ArrayList<CommentDTO> cmtList = cmtDAO.showComment(b_num);
		/* 좋아용 버튼 + 좋아요 누를 때 좋아요 카운트 올라가게 ==> mapper 구성 필요하고, dao 필요하고 <== 모르면 물어보면서 */
				/*  
				
				
				
				*/
		if(cmtList != null){
		for(CommentDTO cmt : cmtList){%>
		댓글 : <%=cmt.toString() %>
		<br>
		
		<%} %>
		<%} %>
			
		<% }%>		
	<%} %>
	<form action="CommentService">
		게시글 번호 입력 : <input type="text" name ="b_num">
		댓글입력 : <textarea  rows="10" style="resize: none;" name="c_content"></textarea><br> 
		<input type ="submit" value="댓글 등록">
</form>


	<hr>
	<!-- 정책 작성 o-->
	<!-- 정책 작성 id가 admin일 때 보이게 만들기 등록 버튼 구현... 하기 -->
	
	<%-- <%if(info != null && info.getM_Id().equals("admin")){   %> --%>
	
	<form action="PolicyService"  enctype="multipart/form-data"  method="post" >
		정책 제목 : <input type = "text" name = "p_title">
		정책사진 등록 :<input  type="file" style="float: right;" name="p_filename">
		정책 게시글 입력 : <textarea  rows="10" style="resize: none;" name="p_content"></textarea><br> 
		<input type="submit" value="정책게시글 등록">
	</form>
	
	
	
	<!-- 정책 목록 출력 + 리뷰 작성 + 출력-->
	<%if(info != null){%>
	정책 게시글 포함 
	
	<% PolicyDAO dao = new PolicyDAO();
	ArrayList<PolicyDTO> p_list = dao.showPolicy();
	
	for(PolicyDTO pdto : p_list){%>
		정책 :<%=pdto.toString() %>
	<% }%>
		 
	
	<%}%> 
	
	
	
	
	

	<hr>
	<!-- 채팅창 팝업 or open용 -->
	 
	  	
	
	<hr>
	<!-- 회원 전체 목록 +  팔로우, 차단 데이터베이스 값 전달 -->
	<%if(info != null){%>
		<% FollowDAO fdao = new FollowDAO(); %>
		<%ArrayList<MemberDTO> mList =  new MemberDAO().showAll(info.getM_Id());%>
		<%for(MemberDTO temp : mList){%>
		<%=temp.toString() %><br>
		
		<%String m_id = info.getM_Id();
		String Follow_id = temp.getM_Id();
		FollowDTO fc_dto = new FollowDTO(m_id,Follow_id); %>
		 <%if(fdao.followCheck(fc_dto)>0){ %>
		 <button id="follow_cnt" onclick="unfollow()">언팔</button><br>
		<script>
		function unfollow() {
		let follow_cnt = fdao.followCheck(fc_dto);
			console.log(follow_cnt);

			$.ajax({
				// 요청서버 url
				url : "FollowService",
				// 요청할 때 같이 보내줄 데이터
				data : {"follow_cnt" : follow_cnt},
				// 요청 타입
				type : 'get', 
				// 통신 성공 function(넘겨준데이터)
				success : function(data) {
					console.log(typeof data);
					if (data == 'true') {
					}
					} else {
					}
				},
				// 통신 실패
				error : function() {
					console.log("조샀다 !");
				}
			})
		}
	</script>
		<%}else{ %>
		<button>팔로우</button><br>
		<%} %>
	 <%} %>
	<%}%>
	
	
	
	
	
	

	<hr>
	<!-- 프로필 출력 o + 업데이트 -->
	<% if(info != null) {%>
	아이디 : <%=info.getM_Id() %><br>
	닉네임 : <%=info.getM_Nickname() %><br>
	<%int count = new BoardDAO().countBoard(info.getM_Id());  %>
	게시물 <%=count %> <br> 
	<%int count2 = new FollowDAO().countFollow(info.getM_Id()); %>
	<%int count3 = new FollowDAO().countFollower(info.getM_Id()); %>
	팔로우 수 <%=count2 %>
	팔로워 수 <%=count3 %>
	<%} %>
	<!-- 프로필 수정  -->

</body>
</html>