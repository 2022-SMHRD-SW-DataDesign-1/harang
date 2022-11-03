<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport"
	content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">

<!-- Facebook Meta Tags / 페이스북 오픈 그래프 -->
<meta property="og:url" content="http://kindtiger.dothome.co.kr/insta">
<meta property="og:type" content="website">
<meta property="og:title" content="instagram">
<meta property="og:description" content="instagram clone">
<meta property="og:image"
	content="http://kindtiger.dothome.co.kr/insta/imgs/instagram.jpeg">
.
<!-- Twitter Meta Tags / 트위터 -->
<meta name="twitter:card" content="instagram clone">
<meta name="twitter:title" content="instagram">
<meta name="twitter:description" content="instagram clone">
<meta name="twitter:image"
	content="http://kindtiger.dothome.co.kr/insta/imgs/instagram.jpeg">

<!-- Google / Search Engine Tags / 구글 검색 엔진 -->
<meta itemprop="name" content="instagram">
<meta itemprop="description" content="instagram clone">
<meta itemprop="image"
	content="http://kindtiger.dothome.co.kr/insta/imgs/instagram.jpeg">


<title>instagram</title>
<link rel="stylesheet" href="css/reset.css">
<link rel="stylesheet" href="css/common.css">
<link rel="stylesheet" href="css/style.css">
<link rel="stylesheet" href="css/new_post.css">
<link rel="shortcut icon" href="imgs/instagram.png">
</head>
<body>


	<section id="container">


		<header id="header">
			<section class="h_inner">

				<h1 class="logo">
					<a href="Main.jsp">
						<div class="sprite_insta_icon"></div>
						<div>
							<div class="sprite_write_logo"></div>
						</div>
					</a>
				</h1>

				<div class="search_field">
					<input type="text" placeholder="검색" tabindex="search_field">

					<div class="fake_field">
						<span class=sprite_small_search_icon></span> <span>검색</span>
					</div>
				</div>


				<div class="right_icons">
					<a href="Login.jsp"><img src="imgs/로그인.PNG"
						class="sprite_compass_icon"></a> <a href="Profile.jsp"><img
						src="imgs/프로필.PNG" class="sprite_user_icon_outline"></a> <a
						href="Top10Ranking.jsp"><img src="imgs/랭킹버튼.PNG"
						class="sprite_user_icon_outline"></a> <a href="DM.jsp"> <img
						src="imgs/채팅.PNG" class="sprite_user_icon_outline"></a>
				</div>
			</section>
		</header>



		<div id="main_container">

			<div class="post_form_container">
				<form action="#" class="post_form">
					<div class="title">NEW POST</div>
					<div class="preview">
						<div class="upload">
							<div class="post_btn">
								<div class="plus_icon">
									<span></span> <span></span>
								</div>
								<p>포스트 이미지 추가</p>
								<canvas id="imageCanvas"></canvas>
								<!--<p><img id="img_id" src="#" style="width: 300px; height: 300px; object-fit: cover" alt="thumbnail"></p>-->
							</div>
						</div>
					</div>
					<p>
						<input type="file" name="photo" id="id_photo" required="required">
					</p>
					<p>
						<textarea name="content" id="text_field" cols="50" rows="5"
							placeholder="140자 까지 등록 가능합니다.
#태그명 을 통해서 검색 태그를 등록할 수 있습니다.
예시 : I # love # insta!"></textarea>

					</p>
					<input class="submit_btn" type="submit" value="저장">
				</form>

			</div>

		</div>


	</section>

	<script src="js/insta.js"></script>

	<script>
		var fileInput = document.querySelector("#id_photo"), button = document
				.querySelector(".input-file-trigger"), the_return = document
				.querySelector(".file-return");

		// Show image
		fileInput.addEventListener('change', handleImage, false);
		var canvas = document.getElementById('imageCanvas');
		var ctx = canvas.getContext('2d');

		function handleImage(e) {
			var reader = new FileReader();
			reader.onload = function(event) {
				var img = new Image();
				// var imgWidth =
				img.onload = function() {
					canvas.width = 300;
					canvas.height = 300;
					ctx.drawImage(img, 0, 0, 300, 300);
				};
				img.src = event.target.result;
				// img.width = img.width*0.5
				// canvas.height = img.height;
			};
			reader.readAsDataURL(e.target.files[0]);
		}
	</script>
</body>
</html>