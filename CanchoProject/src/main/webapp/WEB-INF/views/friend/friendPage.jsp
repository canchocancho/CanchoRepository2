<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script type="text/javascript" src="<c:url value="../resources/js/jquery-3.2.1.js" />"></script>
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta name="description" content="This is social network html5 template available in themeforest......">
<meta name="keywords" content="Social Network, Social Media, Make Friends, Newsfeed, Profile Page">
<meta name="robots" content="index, follow">
<title>Friend List | Your Friend List</title>

<!-- Stylesheets
    ================================================= -->
	<link rel="stylesheet" href="../resources/css/bootstrap.min.css">
	<link rel="stylesheet" href="../resources/css/style.css">
	<link rel="stylesheet" href="../resources/css/ionicons.min.css">
    <link rel="stylesheet" href="../resources/css/font-awesome.min.css">
    
    <!--Google Font-->
    <link href="https://fonts.googleapis.com/css?family=Lato:300,400,400i,700,700i" rel="stylesheet">
    
    <!--Favicon-->
    <link rel="shortcut icon" type="image/png" href="../resources/images/fav.png">

		
		<script type="text/javascript">
			<c:if test ="${errorMsg != null}">
				alert("${errorMsg}");
			</c:if> 
				
			<c:if test ="${errorMsg1 != null}">
				alert("${errorMsg}");
			</c:if> 
			
			function deleteFriend(friend_id){
				if (confirm("해당 친구를 정말로 삭제하시겠습니까?")) {
					alert("삭제되었습니다.");
					location.href = "deleteFriend?friend_id="+friend_id;
				} else {
					return;
				}
			}
			
			function insertFriend(user_id){
				if (confirm("해당 ID를 친구로 추가할까요?")) {
					location.href = 'insertFriend?user_id='+ user_id;
				} else {
					return false;
				}
			}
			
			function formSubmit(){
				var form = document.getElementById('s1');
				form.submit();
			}
			
			//유효성 검사
			$(function(){
				$('#s1').on('submit', function(){
					var id = $('user_id').val();
					
					if (id.length == 0) {
						alert("검색할 ID를 입력하세요");
						return;
					}
				});
			});
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
            <a class="navbar-brand" href="../"><img src="../resources/images/logo.png" alt="logo"></a>
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
                <a href="">Friends</a>
              </li>
              <li class="dropdown">
                <a href="logout">Logout</a>
              </li>
              <li class="dropdown">
                <a href="contact">Contact</a>
              </li>
            </ul>
            <form action="searchFriendId" method="post" id="s1" class="navbar-form navbar-right hidden-sm">
              <div class="form-group">
                <i class="icon ion-android-search" onclick="formSubmit();" style="cursor: pointer;"></i>
                <input type="text" id="user_id" name="user_id" class="form-control" placeholder="Search friends by ID" autocomplete="off">
              </div>
            </form>
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
              		<img src="../post/downloadPic?user_id=${profile.user_id }" alt="post-image" class="profile-photo">
              	</c:if>
              	
            	<!-- 프로필 사진이 없을 때 -->
            	<c:if test="${profile.p_originalfile == null }">
              		<img src="https://media.istockphoto.com/vectors/social-media-blue-bird-vector-id608578604?k=6&m=608578604&s=612x612&w=0&h=qvNEv9J5UlZqYsRTZvi548twflGRJUkcBZCQ_Q2Gt1c=" alt="" class="profile-photo">
              	</c:if>
            	<h5><a href="../post/postList" class="text-white">${sessionScope.loginName }</a></h5>
            	<p class="text-white"><i class="ion ion-android-person-add"></i> ${myFollower } followers</p>
            </div><!--profile card ends-->
            <ul class="nav-news-feed">
              <li><i class="icon ion-ios-paper"></i><div><p>My Newsfeed</p></div></li>
              <li><i class="icon ion-ios-people"></i><div><p>People Nearby</p></div></li>
              <li><i class="icon ion-ios-people-outline"></i><div><p>Friends</p></div></li>
              <li><i class="icon ion-chatboxes"></i><div><p>Messages</p></div></li>
              <li><i class="icon ion-images"></i><div><p>Images</p></div></li>
              <li><i class="icon ion-ios-videocam"></i><div><p>Videos</p></div></li>
            </ul><!--news-feed links ends-->
          </div>
          
    	<div class="col-md-7" >


            <!-- Friend List
            ================================================= -->
            <div class="friend-list">
            	<div class="row">
		            <c:if test="${fList != null }">
						<c:forEach var="friend" items="${fList }">
		            		<div class="col-md-6 col-sm-6">
		                  		<div class="friend-card">
              					<img src="../post/downloadPic?user_id=${friend.friend_id }" alt="" class="img-responsive cover" onerror="javascript:src='http://www.tourniagara.com/wp-content/uploads/2014/10/default-img.gif'">	
		                  		<div class="card-info">
			                      	<div class="friend-info">
			                        	<a href="javascript:deleteFriend('${friend.friend_id }')" class="pull-right text-green">Delete</a>
			                      		<h5><a href="friendPage?friend_id=${friend.friend_id }" class="profile-link">${friend.friend_id }</a></h5>
			                      	</div>
		                    	</div>
		                 		</div>
		                	</div>
						</c:forEach>
					</c:if>
				</div>
		    </div>
         </div>
            
            

    			<!-- Newsfeed Common Side Bar Right
          ================================================= -->
    	<div class="col-md-2 static">
            <div class="suggestions" id="sticky-sidebar" style="">
              <h4 class="grey">Search Result</h4>
              	<div class="follow-user">
		            <c:if test="${list != null }">
						<c:forEach var="user" items="${list }">
							<c:if test="${user.user_id != sessionScope.loginId }">
				            <img src="../post/downloadPic?user_id=${user.user_id }" alt="" class="profile-photo-sm pull-left" onerror="javascript:src='http://www.tourniagara.com/wp-content/uploads/2014/10/default-img.gif'">
				            
				                <div>
				                  <h5><a href="friendPage?friend_id=${user.user_id }">${user.user_id }</a></h5>
				                  <a href="javascript:insertFriend('${user.user_id }')" class="text-green">Add friend</a>
				                </div>
				                </c:if>
						</c:forEach>
					</c:if>
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
    <script src="../resources/js/jquery-3.1.1.min.js"></script>
    <script src="../resources/js/bootstrap.min.js"></script>
    <script src="../resources/js/jquery.sticky-kit.min.js"></script>
    <script src="../resources/js/jquery.scrollbar.min.js"></script>
    <script src="../resources/js/script.js"></script>

	</body>
</html>