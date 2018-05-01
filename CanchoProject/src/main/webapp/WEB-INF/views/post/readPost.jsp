<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
	<head>
		<meta http-equiv="content-type" content="text/html; charset=utf-8">
		<script type="text/javascript" src="<c:url value="/resources/js/jquery-3.2.1.js" />"></script>
		<meta name="viewport" content="width=device-width, initial-scale=1">
		<meta name="description" content="This is social network html5 template available in themeforest......">
		<meta name="keywords" content="Social Network, Social Media, Make Friends, Newsfeed, Profile Page">
		<meta name="robots" content="index, follow">
		<title>Read Post</title>

    <!-- Stylesheets
    ================================================= -->
		<link rel="stylesheet" href="../resources/css/bootstrap2.min.css">
		<link rel="stylesheet" href="../resources/css/style.css">
		<link rel="stylesheet" href="../resources/css/ionicons.min.css">
 	    <link rel="stylesheet" href="../resources/css/font-awesome.min.css">
   		<link href="../resources/css/emoji.css" rel="stylesheet">
    
	  	<!-- Firepad -->
	  	<link rel="stylesheet" href="../resources/css/firepad.css" />
	  	<link rel="stylesheet" href="../resources/css/firepad_fc_fs.css" />
    
    <!--Google Font-->
    <link href="https://fonts.googleapis.com/css?family=Lato:300,400,400i,700,700i" rel="stylesheet">
    
    <!--Favicon-->
    <link rel="shortcut icon" type="image/png" href="../resources/images/fav.png">
    
		<script type="text/javascript">
			<c:if test="${errorMsg != null }">
				alert('${errorMsg }');
			</c:if>
			
			function deleteCheck(){
			       return confirm("포스트를 삭제하시겠습니까?");
			}
			
			function deleteComment(){
			       return confirm("코멘트를 삭제하시겠습니까?");
			}
		</script>

		<style>
			A:link   { text-decoration: none; } /* a 태그에 마우스 올렸을 때 밑줄 같은 거 없애기 */
			A:visited   { text-decoration: none; }
			A:active   { text-decoration: none; }
			A:hover   { text-decoration: none; }
			
			textarea {
				-webkit-box-sizing: none;
				-moz-box-sizing: none;
				box-sizing: none;
				width: 100%;
			}
			
			.delete {
				color: #8dc63f;
  			  	font-size: 12px;
    			margin-left: 20px;
    			text-align: right;
			}
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
            <a class="navbar-brand" href="/cancho"><img src="../resources/images/logo.png" alt="logo" /></a>
          </div>

          <!-- Collect the nav links, forms, and other content for toggling -->
          <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
            <ul class="nav navbar-nav navbar-right main-menu">
              <li class="dropdown">
                <a href="/cancho">Timeline</a>
              </li>
              <li class="dropdown">
                <a href="postList">My Page</a>
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

                <img src="downloadPic?user_id=${post.user_id }" alt="post-image" class="img-responsive profile-photo" onerror="javascript:src='http://www.tourniagara.com/wp-content/uploads/2014/10/default-img.gif'">

                  <h3>${post.user_id}</h3>
                </div>
              </div>
              <div class="col-md-9">
                <ul class="list-inline profile-menu">
                <li><a href="../" class="active">Timeline</a></li>
                  <li><a href="../user/friendPage?friend_id=${post.user_id }">My Page</a></li>
                  <li><a href="../user/friendProfile?friend_id=${post.user_id }">Profile</a></li>
                  <li><a href="../user/friendList">Friends</a></li>
                </ul>
                 <ul class="follow-me list-inline" style="padding-top: 5px;">
                  <li><i class="ion ion-android-person-add"></i> ${myFollower } people following me</li>
                </ul>
              </div>
              
            </div>
          </div><!--Timeline Menu for Large Screens End-->

          <!--Timeline Menu for Small Screens-->
          <div class="navbar-mobile hidden-lg hidden-md">
            <div class="profile-info">
            
            <!-- 프로필 사진이 있을 때 -->
            	<c:if test="${profile.p_originalfile != null }">
              		<img src="downloadPic?user_id=${profile.user_id }" alt="post-image" class="img-responsive profile-photo">
              	</c:if>
              	
            <!-- 프로필 사진이 없을 때 -->
            	<c:if test="${profile.p_originalfile == null }">
              		<img src="https://media.istockphoto.com/vectors/social-media-blue-bird-vector-id608578604?k=6&m=608578604&s=612x612&w=0&h=qvNEv9J5UlZqYsRTZvi548twflGRJUkcBZCQ_Q2Gt1c=" alt="" class="img-responsive profile-photo">
              	</c:if>
              	
              <h4>${post.user_id}</h4>
            </div>
            <div class="mobile-menu">
              <ul class="list-inline">
                <li><a href="timline.html" class="active">Timeline</a></li>
                <li><a href="timeline-about.html">About</a></li>
                <li><a href="timeline-album.html">Album</a></li>
                <li><a href="timeline-friends.html">Friends</a></li>
              </ul>
              <button class="btn-primary">Add Friend</button>
            </div>
          </div><!--Timeline Menu for Small Screens End-->

        </div>
        <div id="page-contents" style="position: relative;">
          <div class="row">
            <div class="col-md-3"></div>
            <div class="col-md-7">

            <!-- Post Content
            ================================================= -->
                      <p>${postText }</p>
                    <br>
                    
                    <div class="line-divider"></div>
                    
                    <c:forEach items="${commentList }" var="comment">
						<c:if test="${post.post_num == comment.post_num }">
							<div class="post-comment">
	                     	 
	                     	 <p><a href="../user/friendPage?friend_id=${comment.user_id }" class="profile-link">${comment.user_id }</a> ${comment.comment_text }
								<c:if test="${loginId == comment.user_id }">
									<a href="deleteComment?comment_num=${comment.comment_num }&post_num=${comment.post_num }" class="delete" onclick="return deleteComment();">delete</a>
								</c:if>
							</p>
							</div>
						</c:if>
                    </c:forEach>
                    
                    
                    <!-- 댓글 달기 -->
                    <form id="replyForm" action="insertComment" method="post">
                    <div class="post-comment">
                      		
							<input type="hidden" name="post_num" id="post_num" value="${post.post_num }">
							<input type="text" class="form-control" name="comment_text" id="comment_text" placeholder="Post a comment" autocomplete="off">
                    </div>
                    </form>
                    
                    <!-- 포스트 삭제 -->
                    <c:if test="${loginId == post.user_id }">
                    	<br>
                    	<div style="text-align: right;">
						<a href="deletePost?post_num=${post.post_num }" onclick="return deleteCheck();">Delete Post</a>
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