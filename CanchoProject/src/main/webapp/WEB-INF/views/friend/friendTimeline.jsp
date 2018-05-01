<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
	<head>
		<meta http-equiv="content-type" content="text/html; charset=utf-8">
		<script type="text/javascript" src="<c:url value="../resources/js/jquery-3.2.1.js" />"></script>
		<meta name="viewport" content="width=device-width, initial-scale=1">
		<meta name="description" content="This is social network html5 template available in themeforest......">
		<meta name="keywords" content="Social Network, Social Media, Make Friends, Newsfeed, Profile Page">
		<meta name="robots" content="index, follow">
		<title>Friend Timeline</title>

    <!-- Stylesheets
    ================================================= -->
		<link rel="stylesheet" href="../resources/css/bootstrap.min.css">
		<link rel="stylesheet" href="../resources/css/style.css">
		<link rel="stylesheet" href="../resources/css/ionicons.min.css">
    <link rel="stylesheet" href="../resources/css/font-awesome.min.css">
    <link href="../resources/css/emoji.css" rel="stylesheet">
    
    <!--Google Font-->
    <link href="https://fonts.googleapis.com/css?family=Lato:300,400,400i,700,700i" rel="stylesheet">
    
    <!--Favicon-->
    <link rel="shortcut icon" type="image/png" href="../resources/images/fav.png">
    
		<script type="text/javascript">
			<c:if test="${errorMsg != null }">
				alert('${errorMsg }');
			</c:if>
			
			//텍스트 포스트 작성 이동
			function createPost(){
				location.href = "writePost";
			}
		</script>

		<style>
			A:link   { text-decoration: none; } /* a 태그에 마우스 올렸을 때 밑줄 같은 거 없애기 */
			A:visited   { text-decoration: none; }
			A:active   { text-decoration: none; }
			A:hover   { text-decoration: none; }
		</style>
	</head>
	<body>

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
            <a class="navbar-brand" href="/cancho"><img src="../resources/images/logo.png" alt="logo"></a>
          </div>

          <!-- Collect the nav links, forms, and other content for toggling -->
          <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
            <ul class="nav navbar-nav navbar-right main-menu">
              <li class="dropdown">
                <a href="/cancho">Timeline</a>
              </li>
              <li class="dropdown">
                <a href="../post/postList">My Page</a>
              </li>
              <li class="dropdown">
                <a href="../user/friendList">Friends</a>
              </li>
              <li class="dropdown">
                <a href="../user/logout">Logout</a>
              </li>
              <li class="dropdown">
                <a href="../user/contact">Contact</a>
              </li>
            </ul>
          </div><!-- /.navbar-collapse -->
        </div><!-- /.container -->
      </nav>
    </header>
    <!--Header End-->

    <div class="container">

      <!-- Timeline
      ================================================= -->
      <div class="timeline">
        <div class="timeline-cover">

          <!--Timeline Menu for Large Screens-->
          <div class="timeline-nav-bar hidden-sm hidden-xs">
            <div class="row">
              <div class="col-md-3">
                <div class="profile-info">
                  <!-- 프로필 사진이 있을 때 -->
            	<c:if test="${fprofile.p_originalfile != null }">
              		<img src="../post/downloadPic?user_id=${fprofile.user_id }" alt="post-image" class="img-responsive profile-photo">
              	</c:if>
              	
            	<!-- 프로필 사진이 없을 때 -->
            	<c:if test="${fprofile.p_originalfile == null }">
              		<img src="https://media.istockphoto.com/vectors/social-media-blue-bird-vector-id608578604?k=6&m=608578604&s=612x612&w=0&h=qvNEv9J5UlZqYsRTZvi548twflGRJUkcBZCQ_Q2Gt1c=" alt="" class="img-responsive profile-photo">
              	</c:if>
                  <h3>${floginName}</h3>
                </div>
              </div>
              <div class="col-md-9">
                <ul class="list-inline profile-menu">
                  <li><a href="" class="active">My Page</a></li>
                  <li><a href="friendProfile?friend_id=${friendId }">Profile</a></li>
                </ul>
                <ul class="follow-me list-inline">
                </ul>
              </div>
            </div>
          </div><!--Timeline Menu for Large Screens End-->

          <!--Timeline Menu for Small Screens-->
          <div class="navbar-mobile hidden-lg hidden-md">
            <div class="profile-info">
            
            <!-- 프로필 사진이 있을 때 -->
            	<c:if test="${fprofile.p_originalfile != null }">
              		<img src="../post/downloadPic?user_id=${fprofile.user_id }" alt="post-image" class="img-responsive profile-photo">
              	</c:if>
              	
            <!-- 프로필 사진이 없을 때 -->
            	<c:if test="${fprofile.p_originalfile == null }">
              		<img src="https://media.istockphoto.com/vectors/social-media-blue-bird-vector-id608578604?k=6&m=608578604&s=612x612&w=0&h=qvNEv9J5UlZqYsRTZvi548twflGRJUkcBZCQ_Q2Gt1c=" alt="" class="img-responsive profile-photo">
              	</c:if>
              	
              <h4>${floginName}</h4>
            </div>
            <div class="mobile-menu">
              <ul class="list-inline">
                  <li><a href="" class="active">My Page</a></li>
                  <li><a href="friendProfile?friend_id=${friendId }">Profile</a></li>
              </ul>
              
              <c:if test="${fprofile.p_originalfile != null }">
              </c:if>
              
            </div>
          </div><!--Timeline Menu for Small Screens End-->

        </div>
        <div id="page-contents" style="position: relative;">
          <div class="row">
            <div class="col-md-3"></div>
            <div class="col-md-7" style="width: 70%;">

              <!-- Post Create Box
              ================================================= -->
              <div class="create-post">
                <div class="row">
                      <!-- <button class="btn btn-primary pull-right" onclick="createPost();">Publish</button> -->
                </div>
              </div><!-- Post Create Box End-->


            <!-- Post Content
            ================================================= -->
            <!-- 게시글이 하나라도 존재하는 경우 -->
			<c:if test="${fpostList != null && fpostList.size() != 0}">
			
			<c:forEach items="${fpostList }" var="post">
				<div class="post-content">

				<!-- 제목이 없다(무조건 브이로그) -->
            	<c:if test="${post.post_title == null}">
	            	<video controls>
	                        <source src="../post/download?post_num=${post.post_num }" type="video/mp4">
	                </video>
            	</c:if>
            	
            	<!-- 제목이 있다(커버가 있거나 없는 글이다) -->
            	<c:if test="${post.post_title != null}">
				
					<!-- 표지가 있을 경우 -->
					<c:if test="${post.originalfile != null }">
					<a href="readOnePost?post_num=${post.post_num }">
					<img src="../post/download?post_num=${post.post_num }" alt="post-image" class="img-responsive post-image">
					</a>
					</c:if>
	                
	                <!-- 표지가 없을 경우 -->
	                <c:if test="${post.originalfile == null }">
	                <div class="user-info">
	                <h1 style="text-align: center;"><a href="../post/readOnePost?post_num=${post.post_num }">
	                ${post.post_title }</a></h1>
	                </div>
	                </c:if>
	             
	             </c:if>
                
                
                <div class="post-container">
                <!-- 프로필 사진이 있을 때 -->
            	<c:if test="${fprofile.p_originalfile != null }">
              		<img src="../post/downloadPic?user_id=${fprofile.user_id }" alt="post-image" class="profile-photo-md pull-left">
              	</c:if>
              	
            	<!-- 프로필 사진이 없을 때 -->
            	<c:if test="${fprofile.p_originalfile == null }">
              		<img src="https://media.istockphoto.com/vectors/social-media-blue-bird-vector-id608578604?k=6&m=608578604&s=612x612&w=0&h=qvNEv9J5UlZqYsRTZvi548twflGRJUkcBZCQ_Q2Gt1c=" alt="" class="profile-photo-md pull-left">
              	</c:if>
                  
                  
                  
                  <div class="post-detail">
                    <div class="user-info">
                      <h5><a href="" class="profile-link">${post.user_id }</a> <span class="following">following</span></h5>
                      <p class="text-muted">${post.post_date }</p>
                    </div>
                    <div class="reaction">
                      <a class="btn text-green"><i class="icon ion-thumbsup"></i>${post.post_like }</a>
                      <a class="btn text-red"><i class="fa fa-thumbs-down"></i>${post.post_dislike }</a>
                    </div>
                  </div>
                </div>
              </div>
			</c:forEach>
			</c:if>
			
			<c:if test="${fpostList == null || fpostList.size() == 0}">
			
			<div style="text-align: center;">
			<br>
			<p>There is no post at all!</p>
			</div>
			
			</c:if>
            </div>
            
          </div>
        </div>
      </div>
    </div>

    <!-- Footer
    ================================================= -->
		<footer id="footer">
      <div class="container">
      	<div class="row">
          <div class="footer-wrapper">
            <div class="col-md-3 col-sm-3">
              <a href="/cancho"><img src="../resources/images/logo-black.png" alt="" class="footer-logo" /></a>
              <ul class="list-inline social-icons">
              	<li><i class="icon ion-social-facebook"></i></li>
              	<li><i class="icon ion-social-twitter"></i></li>
              	<li><i class="icon ion-social-googleplus"></i></li>
              	<li><i class="icon ion-social-pinterest"></i></li>
              	<li><i class="icon ion-social-linkedin"></i></li>
              </ul>
            </div>
            <div class="col-md-2 col-sm-2">
              <h6>For individuals</h6>
              <ul class="footer-links">
                <li>Signup</li>
                <li>login</li>
                <li>Explore</li>
                <li>Finder app</li>
                <li>Features</li>
                <li>Language settings</li>
              </ul>
            </div>
            <div class="col-md-2 col-sm-2">
              <h6>For businesses</h6>
              <ul class="footer-links">
                <li>Business signup</li>
                <li>Business login</li>
                <li>Benefits</li>
                <li>Resources</li>
                <li>Advertise</li>
                <li>Setup</li>
              </ul>
            </div>
            <div class="col-md-2 col-sm-2">
              <h6>About</h6>
              <ul class="footer-links">
                <li>About us</li>
                <li>Contact us</li>
                <li>Privacy Policy</li>
                <li>Terms</li>
                <li>Help</li>
              </ul>
            </div>
            <div class="col-md-3 col-sm-3">
              <h6>Contact Us</h6>
                <ul class="contact">
                	<li><i class="icon ion-ios-telephone-outline"></i>+82 (02) 1566 5114</li>
                	<li><i class="icon ion-ios-email-outline"></i>canchoad@gmail.com</li>
                  <li><i class="icon ion-ios-location-outline"></i>524 Samsung Seoul, Korea</li>
                </ul>
            </div>
          </div>
      	</div>
      </div>
      <div class="copyright">
         <p>Tomo Log @2018. All rights reserved</p>
      </div>
		</footer>
    
    <!--preloader-->
    <div id="spinner-wrapper" style="display: none;">
      <div class="spinner"></div>
    </div>

    <!-- Scripts
    ================================================= -->
    
    <script src="../resources/js/bootstrap.min.js"></script>
    <script src="../resources/js/jquery-3.1.1.min.js"></script>
    <script src="../resources/js/jquery.sticky-kit.min.js"></script>
    <script src="../resources/js/jquery.scrollbar.min.js"></script>
    <script src="../resources/js/script.js"></script>

	</body>
</html>