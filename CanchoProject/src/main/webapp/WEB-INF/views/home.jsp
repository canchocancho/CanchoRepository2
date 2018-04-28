<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script type="text/javascript" src="<c:url value="resources/js/jquery-3.2.1.js" />"></script>
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta name="description" content="This is social network html5 template available in themeforest......" />
<meta name="keywords" content="Social Network, Social Media, Make Friends, Newsfeed, Profile Page" />
<meta name="robots" content="index, follow" />

<title>TOMOlog</title>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap-theme.min.css">
<script src="https://code.jquery.com/jquery-1.11.0.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.2.0/js/bootstrap.min.js"></script>
<script type="text/javascript" src="resources/js/jquery-3.2.1.js"></script>

    <!-- Stylesheets
    ================================================= -->
		<link rel="stylesheet" href="resources/css/bootstrap.min.css" />
		<link rel="stylesheet" href="resources/css/style.css" />
		<link rel="stylesheet" href="resources/css/ionicons.min.css" />
    <link rel="stylesheet" href="resources/css/font-awesome.min.css" />
    
    <!--Google Font-->
    <link href="https://fonts.googleapis.com/css?family=Lato:300,400,400i,700,700i" rel="stylesheet">
    
    <!--Favicon-->
    <link rel="shortcut icon" type="image/png" href="resources/images/fav.png"/>
    
    <script type="text/javascript">
    	<c:if test ="${errorMsg != null}">
			alert("${errorMsg}")
		</c:if>
		
		//텍스트 포스트 작성 이동
		function createPost(){
			location.href = "post/writePost";
		}
			
			$(function(){
				
				//유효성 검사
				$('#joinForm').on('submit',function(){
					var id = $('#user_id').val();
					var password = $('#user_password').val();
					var password2 = $('#user_password2').val();
					var name =  $('#user_name').val();
					var email = $('#user_email').val();
					
					if (id.length == 0) {
						alert("ID를 입력하세요.");
						return false;
					} else if (password.length == 0) {
						alert("비밀번호를 입력하세요.");
						return false;
					} else if (password2.length == 0) {
						alert("비밀번호 확인값을 입력하세요.");
						return false;
					} else if (password != password2) {
						alert("동일한 비밀번호를 입력하세요.");
						return false;
					} else if (name.length == 0) {
						alert("이름을 입력하세요.");
						return false;
					} else if (email.length == 0) {
						alert("이메일을 입력하세요.");
						return false;
					}
				});
			});
    </script>
		<style>
			A:link   { text-decoration: none; } /* a 태그에 마우스 올렸을 때 밑줄 같은 거 없애기 */
			A:visited   { text-decoration: none; }
			A:active   { text-decoration: none; }
			A:hover   { text-decoration: none; }
			
			.mySlides {display:none;}
		</style>
	</head>
	<body>
 
 
 	<c:if test="${sessionScope.loginId == null }">
    <!--preloader-->
    <div id="spinner-wrapper">
      <div class="spinner"></div>
    </div>

    <!-- Header
    ================================================= -->
		<header id="header" class="lazy-load">
      <nav class="navbar navbar-default navbar-fixed-top menu">
        <div class="container">

          <!-- Brand and toggle get grouped for better mobile display -->
          <div class="navbar-header">
            <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#bs-example-navbar-collapse-1" aria-expanded="false">
              <span class="sr-only">Toggle navigation</span>
              <span class="icon-bar"></span>
              <span class="icon-bar"></span>
              <span class="icon-bar"></span>
            </button>
            <a class="navbar-brand" href="/cancho"><img src="resources/images/logo.png" alt="logo" /></a>
          </div>

          <!-- Collect the nav links, forms, and other content for toggling -->
          <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
            <ul class="nav navbar-nav navbar-right main-menu">
              <li class="dropdown">
                <a href="user/loginPage">Login</a>
              </li>
              <li class="dropdown">
              	<a href="user/contact">Contact</a>
              </li>
            </ul>

          </div><!-- /.navbar-collapse -->
        </div><!-- /.container -->
      </nav>
    </header>
    <!--Header End-->

    <!-- Top Banner
    ================================================= -->
    	<video id="banner1" preload="auto" autoplay="autoplay" loop="loop">
    		<source src="resources/videos/video2.mp4" type="video/mp4">
    	</video>
		<!-- <section id="banner"> -->
			<div class="container">

        <!-- Sign Up Form
        ================================================= -->
        <div class="sign-up-form">
					<a href="" class="logo"><img src="resources/images/logo.png" alt="Friend Finder"/></a>
					<h2 class="text-white">Find My Friends</h2>
					<div class="line-divider"></div>
					<div class="form-wrapper">
						<p class="signup-text">Signup now and meet awesome people around the world</p>
						<form action="user/join" method="post" id="joinForm">
							<fieldset class="form-group">
								<input type="text" class="form-control" id="user_id" name="user_id" placeholder="Enter id" autocomplete="off">
							</fieldset>
							<fieldset class="form-group">
								<input type="password" class="form-control" id="user_password" name="user_password" placeholder="Enter a password">
							</fieldset>
							<fieldset class="form-group">
								<input type="password" class="form-control" id="user_password2" placeholder="Enter a password again">
							</fieldset>
							<fieldset class="form-group">
								<input type="text" class="form-control" id="user_name" name="user_name" placeholder="Enter name" autocomplete="off">
							</fieldset>
							<fieldset class="form-group">
								<input type="email" class="form-control" id="user_email" name="user_email" placeholder="Enter email" autocomplete="off">
							</fieldset>
						<p>By signning up you agree to the terms</p>
						<button class="btn-secondary">Signup</button>
						</form>
					</div>
					<a href="user/loginPage">Already have an account?</a>
					<img class="form-shadow" src="resources/images/bottom-shadow.png" alt="" />
				</div><!-- Sign Up Form End -->

        <svg class="arrows hidden-xs hidden-sm">
          <path class="a1" d="M0 0 L30 32 L60 0"></path>
          <path class="a2" d="M0 20 L30 52 L60 20"></path>
          <path class="a3" d="M0 40 L30 72 L60 40"></path>
        </svg>
			</div>
		<!-- </section> -->

    <!-- Features Section
    ================================================= -->
		<section id="features">
			<div class="container wrapper">
				<h1 class="section-title slideDown">social herd</h1>
				<div class="row slideUp">
					<div class="feature-item col-md-2 col-sm-6 col-xs-6 col-md-offset-2">
						<div class="feature-icon"><i class="icon ion-person-add"></i></div>
						<h3>Search Friends</h3>
					</div>
					<div class="feature-item col-md-2 col-sm-6 col-xs-6">
						<div class="feature-icon"><i class="icon ion-images"></i></div>
						<h3>Create Posts</h3>
					</div>
					<div class="feature-item col-md-2 col-sm-6 col-xs-6">
						<div class="feature-icon"><i class="icon ion-chatbox-working"></i></div>
						<h3>Private Chats</h3>
					</div>
					<div class="feature-item col-md-2 col-sm-6 col-xs-6">
						<div class="feature-icon"><i class="icon ion-compose"></i></div>
						<h3>Text&Video Editor</h3>
					</div>
				</div>
				<h2 class="sub-title">find awesome people like you</h2>
				<div id="incremental-counter" data-value="101242"></div>
				<p>People Already Signed Up</p>
				<img src="resources/images/face-map.png" alt="" class="img-responsive face-map slideUp hidden-sm hidden-xs" />
			</div>

		</section>

    <!-- Download Section
    ================================================= -->
		<section id="app-download">
			<div class="container wrapper">
				<h2 class="sub-title">stay connected anytime, anywhere</h2>
			</div>
		</section>

    <!-- Image Divider
    ================================================= -->
    <!-- <div class="img-divider hidden-sm hidden-xs"></div> -->

    <!-- Facts Section
    ================================================= -->
    	<video id="banner1" preload="auto" autoplay="autoplay" loop="loop">
    		<source src="resources/videos/video1.mp4" type="video/mp4">
    	</video>
    	

    <!-- Live Feed Section
    ================================================= -->
		<section id="live-feed">
			<div class="container wrapper">
				<h1 class="section-title slideDown">Our Features</h1><br><br>
				<div class="mission">
						<img class="mySlides w3-animate-right" src="resources/images/chat.jpg" width="100%">
						<img class="mySlides w3-animate-right" src="resources/images/chat1.jpg" width="100%">
			  			<img class="mySlides w3-animate-right" src="resources/images/edit2.jpg" width="100%">
			  			<img class="mySlides w3-animate-right" src="resources/images/people.jpg" width="100%">
			  			<img class="mySlides w3-animate-right" src="resources/images/text.jpg" width="100%">
			  			<!-- <div class="centered">Centered</div> -->
			  			
				</div>
			</div>
		</section>
		</c:if>
		<script>
			var myIndex = 0;
			carousel();
							
			function carousel() {
				var i;
				var x = document.getElementsByClassName("mySlides");
				for (i = 0; i < x.length; i++) {
					x[i].style.display = "none";  
				}
				myIndex++;
				if (myIndex > x.length) {myIndex = 1}    
					x[myIndex-1].style.display = "block";  
				setTimeout(carousel, 3000);    
				}
		</script>
		
		
		
		
		
		
		
		
	<!-- 로그인이 되어 있을 경우 -->	
	<c:if test="${sessionScope.loginId != null }">
    <!-- Header
    ================================================= -->
		<header id="header">
      <nav class="navbar navbar-default navbar-fixed-top menu">
        <div class="container">

          <!-- Brand and toggle get grouped for better mobile display -->
          <div class="navbar-header">
            <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#bs-example-navbar-collapse-1" aria-expanded="false">
              <span class="sr-only">Toggle navigation</span>
              <span class="icon-bar"></span>
              <span class="icon-bar"></span>
              <span class="icon-bar"></span>
            </button>
            <a class="navbar-brand" href="/cancho"><img src="resources/images/logo.png" alt="logo" /></a>
          </div>

          <!-- Collect the nav links, forms, and other content for toggling -->
          <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
            <ul class="nav navbar-nav navbar-right main-menu">
              <li class="dropdown">
                <a href="/cancho">Timeline</a>
              </li>
              <li class="dropdown">
                <a href="post/postList">My Page</a>
              </li>
              <li class="dropdown">
                <a href="user/friendList">Friends</a>
              </li>
              <li class="dropdown">
                <a href="user/logout">Logout</a>
              </li>
              <li class="dropdown">
                <a href="user/contact">Contact</a>
              </li>
            </ul>
          </div><!-- /.navbar-collapse -->
        </div><!-- /.container -->
      </nav>
    </header>
    <!--Header End-->

    <div id="page-contents">
    	<div class="container">
    		<div class="row">

          <!-- Newsfeed Common Side Bar Left
          ================================================= -->
    			<div class="col-md-3 static">
            <div class="profile-card">
            
                <!-- 프로필 사진이 있을 때 -->
            	<c:if test="${profile.p_originalfile != null }">
              		<img src="post/downloadPic?user_id=${profile.user_id }" alt="post-image" class="profile-photo">
              	</c:if>
              	
            	<!-- 프로필 사진이 없을 때 -->
            	<c:if test="${profile.p_originalfile == null }">
              		<img src="https://media.istockphoto.com/vectors/social-media-blue-bird-vector-id608578604?k=6&m=608578604&s=612x612&w=0&h=qvNEv9J5UlZqYsRTZvi548twflGRJUkcBZCQ_Q2Gt1c=" alt="" class="profile-photo">
              	</c:if>

            	<h5><a href="post/postList" class="text-white">${loginName }</a></h5>
            	<a href="#" class="text-white"><i class="ion ion-android-person-add"></i> 1,299 followers</a>
            </div><!--profile card ends-->
            <ul class="nav-news-feed">
              <li><i class="icon ion-ios-paper"></i><div><a href="newsfeed.html">My Newsfeed</a></div></li>
              <li><i class="icon ion-ios-people"></i><div><a href="newsfeed-people-nearby.html">People Nearby</a></div></li>
              <li><i class="icon ion-ios-people-outline"></i><div><a href="newsfeed-friends.html">Friends</a></div></li>
              <li><i class="icon ion-chatboxes"></i><div><a href="newsfeed-messages.html">Messages</a></div></li>
              <li><i class="icon ion-images"></i><div><a href="newsfeed-images.html">Images</a></div></li>
              <li><i class="icon ion-ios-videocam"></i><div><a href="newsfeed-videos.html">Videos</a></div></li>
            </ul><!--news-feed links ends-->
          </div>
          
    	<div class="col-md-7">

            <!-- Post Create Box
            ================================================= -->
            <div class="create-post">
            <button class="btn btn-primary pull-right" onclick="createPost();">Publish</button>
            </div><!-- Post Create Box End-->

            <!-- Post Content
            ================================================= -->
            <c:if test="${postList != null && postList.size() != 0}">
            <c:forEach items="${postList }" var="post">
            
            <div class="post-content">

           		<!-- 표지가 있을 경우 -->
				<c:if test="${post.originalfile != null }">
				<a href="post/readOnePost?post_num=${post.post_num }">
				<img src="post/download?post_num=${post.post_num }" alt="post-image" class="img-responsive post-image">
				</a>
				</c:if>
                
                <!-- 표지가 없을 경우 -->
                <c:if test="${post.originalfile == null }">
                <div class="user-info">
                <h1 style="text-align: center;"><a href="post/readOnePost?post_num=${post.post_num }">
                ${post.post_title }</a></h1>
                </div>
                </c:if>   

              <div class="post-container">
              	
                <img src="post/downloadPic?user_id=${post.user_id }" alt="post-image" class="profile-photo-md pull-left" onerror="javascript:src='http://www.tourniagara.com/wp-content/uploads/2014/10/default-img.gif'">
                <div class="post-detail">
                  <div class="user-info">

                    <c:if test="${post.user_id == sessionScope.loginId }">
                    <h5><a href="post/postList" class="profile-link">${post.user_id }</a><span class="following">following</span></h5>
                    </c:if>
                    
                    <c:if test="${post.user_id != sessionScope.loginId }">
                    <h5><a href="user/friendPage?friend_id=${post.user_id }" class="profile-link">${post.user_id }</a><span class="following">following</span></h5>
                    </c:if>

                    <p class="text-muted">${post.post_date }</p>
                  </div>
                  <div class="reaction">
                    <a href="post/postLike?post_num=${post.post_num }+&user_id=${sessionScope.loginId}" class="btn text-green"><i class="icon ion-thumbsup"></i>${post.post_like }</a>
                    <a href="post/postDislike?post_num=${post.post_num }+&user_id=${sessionScope.loginId}" class="btn text-red"><i class="fa fa-thumbs-down"></i>${post.post_dislike }</a>
                  </div>
                </div>
              </div>
            </div>
			
			</c:forEach>
			</c:if>
			
			<c:if test="${postList == null || postList.size() == 0}">
			
			<div style="text-align: center;">
			<p>There is no post at all!</p>
			<p>How about posting about yourself or following some friends?</p>
			</div>
			
			</c:if>
          </div>
    		</div>
    	</div>
    </div>

		</c:if>

    <!-- Footer
    ================================================= -->
		<footer id="footer">
      <div class="container">
      	<div class="row">
          <div class="footer-wrapper">
            <div class="col-md-3 col-sm-3">
              <a href=""><img src="resources/images/logo-black.png" alt="" class="footer-logo" /></a>
              <ul class="list-inline social-icons">
              	<li><a href="#"><i class="icon ion-social-facebook"></i></a></li>
              	<li><a href="#"><i class="icon ion-social-twitter"></i></a></li>
              	<li><a href="#"><i class="icon ion-social-googleplus"></i></a></li>
              	<li><a href="#"><i class="icon ion-social-pinterest"></i></a></li>
              	<li><a href="#"><i class="icon ion-social-linkedin"></i></a></li>
              </ul>
            </div>
            <div class="col-md-2 col-sm-2">
              <h6>For individuals</h6>
              <ul class="footer-links">
                <li><a href="">Signup</a></li>
                <li><a href="">login</a></li>
                <li><a href="">Explore</a></li>
                <li><a href="">Finder app</a></li>
                <li><a href="">Features</a></li>
                <li><a href="">Language settings</a></li>
              </ul>
            </div>
            <div class="col-md-2 col-sm-2">
              <h6>For businesses</h6>
              <ul class="footer-links">
                <li><a href="">Business signup</a></li>
                <li><a href="">Business login</a></li>
                <li><a href="">Benefits</a></li>
                <li><a href="">Resources</a></li>
                <li><a href="">Advertise</a></li>
                <li><a href="">Setup</a></li>
              </ul>
            </div>
            <div class="col-md-2 col-sm-2">
              <h6>About</h6>
              <ul class="footer-links">
                <li><a href="">About us</a></li>
                <li><a href="">Contact us</a></li>
                <li><a href="">Privacy Policy</a></li>
                <li><a href="">Terms</a></li>
                <li><a href="">Help</a></li>
              </ul>
            </div>
            <div class="col-md-3 col-sm-3">
              <h6>Contact Us</h6>
                <ul class="contact">
                	<li><i class="icon ion-ios-telephone-outline"></i>+1 (234) 222 0754</li>
                	<li><i class="icon ion-ios-email-outline"></i>info@thunder-team.com</li>
                  <li><i class="icon ion-ios-location-outline"></i>228 Park Ave S NY, USA</li>
                </ul>
            </div>
          </div>
      	</div>
      </div>
      <div class="copyright">
         <p>Tomo Log @2018. All rights reserved</p>
      </div>
		</footer>
		
		
		
		
		<!-- 원래 home.jsp -->
		<c:choose>
			<c:when test="${sessionScope.loginId == null }">
				<li><a href="user/joinForm">회원가입</a></li>
				<li><a href="user/loginPage">로그인</a></li>
				<li><a href="editor">브이로그 만들기</a></li>
				<li><a href="post/postList">포스트 목록</a></li>
				<li><a href="user/activateForm">휴면계정 복구</a></li>
			</c:when>
			<c:otherwise>
				<h3>${sessionScope.loginName }님 환영합니다. </h3>
				<li><a href="post/writePost">포스트 쓰기</a></li>
				<li><a href="post/postList">포스트 목록</a></li>		
				<li><a href="user/logout">로그아웃</a></li>
				<li><a href="user/myPage">마이페이지</a></li>
			</c:otherwise>
		</c:choose>
		
		<div id="idCheckResult"></div>
		
		
		
		
		

    <!-- Scripts
    ================================================= -->
    <script src="resources/js/jquery-3.1.1.min.js"></script>
    <script src="resources/js/bootstrap.min.js"></script>
    <script src="resources/js/jquery.appear.min.js"></script>
		<script src="resources/js/jquery.incremental-counter.js"></script>
    <script src="resources/js/script.js"></script>
	</body>
</html>