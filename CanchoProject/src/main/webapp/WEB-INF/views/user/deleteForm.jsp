<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
	<head>
		<meta http-equiv="content-type" content="text/html; charset=utf-8" />
		<meta name="viewport" content="width=device-width, initial-scale=1">
		<meta name="description" content="This is social network html5 template available in themeforest......" />
		<meta name="keywords" content="Social Network, Social Media, Make Friends, Newsfeed, Profile Page" />
		<meta name="robots" content="index, follow" />
		<title>Deactivate Account</title>
		<script type="text/javascript" src="<c:url value="/resources/js/jquery-3.2.1.js" />"></script>

    <!-- Stylesheets
    ================================================= -->
		<link rel="stylesheet" href="../resources/css/bootstrap.min.css" />
		<link rel="stylesheet" href="../resources/css/style.css" />
		<link rel="stylesheet" href="../resources/css/ionicons.min.css" />
    <link rel="stylesheet" href="../resources/css/font-awesome.min.css" />
    
    <!--Google Font-->
    <link href="https://fonts.googleapis.com/css?family=Lato:300,400,400i,700,700i" rel="stylesheet">
    
    <!--Favicon-->
    <link rel="shortcut icon" type="image/png" href="../resources/images/fav.png"/>
    
    <script type="text/javascript">
		<c:if test ="${errorMsg != null}">
			alert("${errorMsg}");
		</c:if>

		$(function(){
			$('#deleteForm').on('submit',function(){
				var password = $('#password').val();
				
				if (password.length == 0) {
					alert("비밀번호를 입력하세요.");
					return false;
				}
			});
		});
    </script>
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
            <a class="navbar-brand" href="../post/postList"><img src="../resources/images/logo.png" alt="logo" /></a>
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
            	<c:if test="${profile.p_originalfile != null }">
              		<img src="../post/downloadPic?user_id=${profile.user_id }" alt="post-image" class="img-responsive profile-photo">
              	</c:if>
              	
            	<!-- 프로필 사진이 없을 때 -->
            	<c:if test="${profile.p_originalfile == null }">
              		<img src="https://media.istockphoto.com/vectors/social-media-blue-bird-vector-id608578604?k=6&m=608578604&s=612x612&w=0&h=qvNEv9J5UlZqYsRTZvi548twflGRJUkcBZCQ_Q2Gt1c=" alt="" class="img-responsive profile-photo">
              	</c:if>
                  <h3>${sessionScope.loginName }</h3>
                </div>
              </div>
              <div class="col-md-9">
                <ul class="list-inline profile-menu">
                  <li><a href="../post/postList">My Page</a></li>
                  <li><a href="myPage" class="active">Profile</a></li>
                  <li><a href="">Album</a></li>
                  <li><a href="friendList">Friends</a></li>
                </ul>
                <ul class="follow-me list-inline">
                  <li>1,299 people following her</li>
                  <li><button class="btn-primary">Add Friend</button></li>
                </ul>
              </div>
            </div>
          </div><!--Timeline Menu for Large Screens End-->

          <!--Timeline Menu for Small Screens-->
          <div class="navbar-mobile hidden-lg hidden-md">
            <div class="profile-info">
                  <!-- 프로필 사진이 있을 때 -->
            	<c:if test="${profile.p_originalfile != null }">
              		<img src="../post/downloadPic?user_id=${profile.user_id }" alt="post-image" class="img-responsive profile-photo">
              	</c:if>
              	
            	<!-- 프로필 사진이 없을 때 -->
            	<c:if test="${profile.p_originalfile == null }">
              		<img src="https://media.istockphoto.com/vectors/social-media-blue-bird-vector-id608578604?k=6&m=608578604&s=612x612&w=0&h=qvNEv9J5UlZqYsRTZvi548twflGRJUkcBZCQ_Q2Gt1c=" alt="" class="img-responsive profile-photo">
              	</c:if>
              <h4>${sessionScope.loginName }</h4>
            </div>
            <div class="mobile-menu">
              <ul class="list-inline">
                <li><a href="../post/postList">My Page</a></li>
                <li><a href="myPage" class="active">Profile</a></li>
                <li><a href="">Album</a></li>
                <li><a href="friendList">Friends</a></li>
              </ul>
              <button class="btn-primary">Add Friend</button>
            </div>
          </div><!--Timeline Menu for Small Screens End-->

        </div>
        <div id="page-contents">
          <div class="row">
            <div class="col-md-3">
              
              <!--Edit Profile Menu-->
              <ul class="edit-menu">
              	<li><i class="icon ion-ios-information-outline"></i><a href="myPage">Basic Information</a></li>
                <li><i class="icon ion-ios-settings"></i><a href="editProfile">Profile Update</a></li>
              	<li class="active"><i class="icon ion-ios-locked-outline"></i><a href="updateInfo">Change Information</a></li>
              </ul>
            </div>

            <div class="col-md-7">

              <!-- Change Password
              ================================================= -->
              <div class="edit-profile-container">
                <div class="block-title">
                  <h4 class="grey"><i class="icon ion-ios-locked-outline"></i>Deactivate Account</h4>
                  <div class="line"></div>
                  <p>Please enter your password again if you want to deactivate the account.</p>
                  <div class="line"></div>
                </div>
                <div class="edit-block">
                  <form name="deleteForm" id="deleteForm" class="form-inline" action="deleteAccount" method="post">
                    <div class="row">
                      <div class="form-group col-xs-12">
                        <label for="my-password">Password</label>
                        <input id="password" class="form-control input-group-lg" type="password" name="password" title="Enter password"/>
                      </div>
                    </div>
					<br>
					<input type="submit" value="Deactivate Account" class="btn btn-primary">
                  </form>
                </div>
              </div>
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
              <a href="/cancho"><img src="resources/images/logo-black.png" alt="" class="footer-logo" /></a>
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
    <div id="spinner-wrapper">
      <div class="spinner"></div>
    </div>

    <!-- Scripts
    ================================================= -->
    <script src="../resources/js/jquery-3.1.1.min.js"></script>
    <script src="../resources/js/bootstrap.min.js"></script>
    <script src="../resources/js/jquery.sticky-kit.min.js"></script>
    <script src="../resources/js/jquery.scrollbar.min.js"></script>
    <script src="../resources/js/script.js"></script>
    
  </body>
</html>