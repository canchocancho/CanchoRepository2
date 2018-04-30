<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
	<head>
		<meta http-equiv="content-type" content="text/html; charset=utf-8" />
		<script type="text/javascript" src="<c:url value="/resources/js/jquery-3.2.1.js" />"></script>
		<meta name="viewport" content="width=device-width, initial-scale=1">
		<meta name="description" content="This is social network html5 template available in themeforest......" />
		<meta name="keywords" content="Social Network, Social Media, Make Friends, Newsfeed, Profile Page" />
		<meta name="robots" content="index, follow" />
		<title>About Me | Learn Detail About Me</title>

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
            <a class="navbar-brand" href="../"><img src="../resources/images/logo.png" alt="logo" /></a>
          </div>

          <!-- Collect the nav links, forms, and other content for toggling -->
          <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
            <ul class="nav navbar-nav navbar-right main-menu">
              <li class="dropdown">
                <a href="/cancho">Timeline</a>
              </li>
              <li class="dropdown">
                <a href="">My Page</a>
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
                  <li><a href="" class="active">Profile</a></li>
                  <li><a href="friendList">Friends</a></li>
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
                  <li><a href="" class="active">Profile</a></li>
                  <li><a href="friendList">Friends</a></li>
              </ul>
                 <ul class="follow-me list-inline" style="padding-top: 5px;">
                  <li><i class="ion ion-android-person-add"></i> ${myFollower } people following me</li>
                </ul>
            </div>
          </div><!--Timeline Menu for Small Screens End-->

        </div>
        <div id="page-contents">
          <div class="row">
            <div class="col-md-3">
            
              <!--Edit Profile Menu-->
              <ul class="edit-menu">
              	<li class="active"><i class="icon ion-ios-information-outline"></i><a href="">Basic Information</a></li>
<!--               	<li><i class="icon ion-ios-briefcase-outline"></i><a href="">Education and Work(안함)</a></li>
              	<li><i class="icon ion-ios-heart-outline"></i><a href="">My Interests(안함)</a></li> -->
                <li><i class="icon ion-ios-settings"></i><a href="editProfile">Profile Update</a></li>
              	<li><i class="icon ion-ios-locked-outline"></i><a href="updateInfo">Change Information</a></li>
              </ul>

            </div>
            <div class="col-md-7">
				
				
			<c:if test="${sessionScope.profile != null }">
              <!-- About
              ================================================= -->
              <div class="about-profile">
                <div class="about-content-block">
                  <h4 class="grey"><i class="ion-ios-information-outline icon-in-title"></i>Who am I?</h4>
                  <p>${sessionScope.profile.p_introduce }</p>
                </div>
                <div class="about-content-block">
                  <h4 class="grey"><i class="ion-ios-briefcase-outline icon-in-title"></i>My Profile</h4>
                  <div class="organization">
                    <img src="../resources/images/envato.png" alt="" class="pull-left img-org" />
                    <div class="work-info">
                      <h5>Sex</h5>
                      <p>${sessionScope.profile.p_sex }</p>
                    </div>
                  </div>
                  <div class="organization">
                    <img src="../resources/images/envato.png" alt="" class="pull-left img-org" />
                    <div class="work-info">
                      <h5>Birthday</h5>
                      <p>${sessionScope.profile.p_birthDate }</p>
                    </div>
                  </div>
                  <div class="organization">
                    <img src="../resources/images/envato.png" alt="" class="pull-left img-org" />
                    <div class="work-info">
                      <h5>Email</h5>
                      <p>${sessionScope.profile.user_email }</p>
                    </div>
                  </div>
                  <!-- 프로필에 직장 정보가 있을 경우 -->
                  <c:if test="${sessionScope.profile.p_company != null }">
                  <div class="organization">
                    <img src="../resources/images/envato.png" alt="" class="pull-left img-org" />
                    <div class="work-info">
                      <h5>My Work</h5>
                      <p>${sessionScope.profile.p_company }</p>
                    </div>
                  </div>
                  </c:if>
                  <!-- 프로필에 학교 정보가 있을 경우 -->
                  <c:if test="${sessionScope.profile.p_school != null }">
                  <div class="organization">
                    <img src="../resources/images/envato.png" alt="" class="pull-left img-org" />
                    <div class="work-info">
                      <h5>My School</h5>
                      <p>${sessionScope.profile.p_school }</p>
                    </div>
                  </div>
                  </c:if>
                </div>
                <div class="about-content-block">
                  <h4 class="grey"><i class="ion-ios-location-outline icon-in-title"></i>Location</h4>
                  <p>${sessionScope.profile.p_city }, ${sessionScope.profile.p_country }</p>
                </div>
              </div>
              </c:if>
              
              <c:if test="${sessionScope.profile == null }">
              <div class="about-profile">
                <div class="about-content-block">
                  <h4 class="grey"><i class="ion-ios-information-outline icon-in-title"></i>Who am I?</h4>
                  <p>Please update your profile:)</p>
                </div>
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
    <div id="spinner-wrapper">
      <div class="spinner"></div>
    </div>

    <!-- Scripts
    ================================================= -->
    <script async defer src="https://maps.googleapis.com/maps/api/js?key=AIzaSyCTMXfmDn0VlqWIyoOxK8997L-amWbUPiQ&callback=initMap"></script>
    <script src="../resources/js/jquery-3.1.1.min.js"></script>
    <script src="../resources/js/bootstrap.min.js"></script>
    <script src="../resources/js/jquery.sticky-kit.min.js"></script>
    <script src="../resources/js/jquery.scrollbar.min.js"></script>
    <script src="../resources/js/script.js"></script>
    
  </body>
</html>