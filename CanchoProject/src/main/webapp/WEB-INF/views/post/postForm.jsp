<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html lang="en">
	<head>
		<meta http-equiv="content-type" content="text/html; charset=utf-8" />
		<script type="text/javascript" src="<c:url value="/resources/js/jquery-3.2.1.js" />"></script>
		<script src="../resources/js/sockjs-0.3.4.js"></script>
		
		<meta name="viewport" content="width=device-width, initial-scale=1">
		<meta name="description" content="This is social network html5 template available in themeforest......" />
		<meta name="keywords" content="Social Network, Social Media, Make Friends, Newsfeed, Profile Page" />
		<meta name="robots" content="index, follow" />
		<title>Write Post</title>
	
	
    <!-- Stylesheets
    ================================================= -->
	    <!-- Firebase -->
	  	<script src="https://www.gstatic.com/firebasejs/3.3.0/firebase.js"></script>
	
	  	<!-- CodeMirror -->
	  	<script src="https://cdnjs.cloudflare.com/ajax/libs/codemirror/5.17.0/codemirror.js"></script>
	  	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/codemirror/5.17.0/codemirror.css" />
	
	  	<!-- Firepad -->
	  	<link rel="stylesheet" href="../resources/css/firepad.css" />
		<script src="https://cdn.firebase.com/libs/firepad/1.4.0/firepad.min.js"></script>
		
		<!-- Firepad Userlist -->
		<link rel="stylesheet" href="../resources/css/firepad-userlist.css" />
	    
		<link rel="stylesheet" href="../resources/css/bootstrap.min.css" />
		<link rel="stylesheet" href="../resources/css/style.css" />
		<link rel="stylesheet" href="../resources/css/ionicons.min.css" />
	    <link rel="stylesheet" href="../resources/css/font-awesome.min.css" />
	
	    <!--Google Font-->
	    <link href="https://fonts.googleapis.com/css?family=Lobster" rel="stylesheet">
	    <link href="https://fonts.googleapis.com/css?family=Lato:300,400,400i,700,700i" rel="stylesheet">
	
	    <!--Favicon-->
	    <link rel="shortcut icon" type="image/png" href="../resources/images/fav.png"/>
	    
	<style>
    #userlist {
      position: absolute; left: 0; top: 58px; bottom: 0; height: 200px; width: 175px;
    }
    #firepad {
      position: absolute; left: 175px; top: 58px; bottom: 0; right: 0; height: auto;
    }
    .firepad-userlist {
      height: 100%;
    }
	#post_title {
	    width: 100%;
	    padding: 12px 20px;
	    margin: 8px 0;
	    box-sizing: border-box;
	    border: 3px solid #ccc;
	    -webkit-transition: 0.5s;
	    transition: 0.5s;
	    outline: none;
	}
	#post_title:focus {
	    border: 3px solid #555;
	}
	</style>
  
  <script type="text/javascript">
	<c:if test ="${errorMsg != null}">
		alert("${errorMsg}");
	</c:if>

  var FirepadUserList = (function() {
	  function FirepadUserList(ref, place, userId, displayName) {
	    if (!(this instanceof FirepadUserList)) {
	      return new FirepadUserList(ref, place, userId, displayName);
	    }

	    this.ref_ = ref;
	    this.userId_ = userId;
	    this.place_ = place;
	    this.firebaseCallbacks_ = [];

	    var self = this;
	    this.hasName_ = !!displayName;
	    this.displayName_ = displayName || "${loginId}";
	    this.firebaseOn_(ref.root.child('.info/connected'), 'value', function(s) {
	      if (s.val() === true && self.displayName_) {
	        var nameRef = ref.child(self.userId_).child('name');
	        nameRef.onDisconnect().remove();
	        nameRef.set(self.displayName_);
	      }
	    });

	    this.userList_ = this.makeUserList_()
	    place.appendChild(this.userList_);
	  }

	  //This is the primary "constructor" for symmetry with Firepad.
	  FirepadUserList.fromDiv = FirepadUserList;

	  FirepadUserList.prototype.dispose = function() {
	    this.removeFirebaseCallbacks_();
	    this.ref_.child(this.userId_).child('name').remove();

	    this.place_.removeChild(this.userList_);
	  };

	  FirepadUserList.prototype.makeUserList_ = function() {
	    return elt('div', [
	      this.makeHeading_(),
	      elt('div', [
	        this.makeUserEntryForSelf_(),
	        this.makeUserEntriesForOthers_()
	      ], {'class': 'firepad-userlist-users' })
	    ], {'class': 'firepad-userlist' });
	  };

	  FirepadUserList.prototype.makeHeading_ = function() {
	    var counterSpan = elt('span', '0');
	    this.firebaseOn_(this.ref_, 'value', function(usersSnapshot) {
	      setTextContent(counterSpan, "" + usersSnapshot.numChildren());
	    });

	    return elt('div', [
	      elt('span', 'ONLINE ('),
	      counterSpan,
	      elt('span', ')')
	    ], { 'class': 'firepad-userlist-heading' });
	  };

	  FirepadUserList.prototype.makeUserEntryForSelf_ = function() {
	    var myUserRef = this.ref_.child(this.userId_);

	    var colorDiv = elt('div', null, { 'class': 'firepad-userlist-color-indicator' });
	    this.firebaseOn_(myUserRef.child('color'), 'value', function(colorSnapshot) {
	      var color = colorSnapshot.val();
	      if (isValidColor(color)) {
	        colorDiv.style.backgroundColor = color;
	      }
	    });

	    var nameInput = elt('input', null, { type: 'text', 'class': 'firepad-userlist-name-input'} );
	    nameInput.value = this.displayName_;

	    var nameHint = elt('div', 'ENTER YOUR NAME', { 'class': 'firepad-userlist-name-hint'} );
	    if (this.hasName_) nameHint.style.display = 'none';

	    //Update Firebase when name changes.
	    var self = this;
	    on(nameInput, 'change', function(e) {
	      var name = nameInput.value || "${loginId}";
	      myUserRef.child('name').onDisconnect().remove();
	      myUserRef.child('name').set(name);
	      nameHint.style.display = 'none';
	      nameInput.blur();
	      self.displayName_ = name;
	      stopEvent(e);
	    });

	    var nameDiv = elt('div', [nameInput, nameHint]);

	    return elt('div', [ colorDiv, nameDiv ], {
	      'class': 'firepad-userlist-user ' + 'firepad-user-' + this.userId_
	    });
	  };

	  FirepadUserList.prototype.makeUserEntriesForOthers_ = function() {
	    var self = this;
	    var userList = elt('div');
	    var userId2Element = { };

	    function updateChild(userSnapshot, prevChildName) {
	      var userId = userSnapshot.key;
	      var div = userId2Element[userId];
	      if (div) {
	        userList.removeChild(div);
	        delete userId2Element[userId];
	      }
	      var name = userSnapshot.child('name').val();
	      if (typeof name !== 'string') { name = 'Guest'; }
	      name = name.substring(0, 20);

	      var color = userSnapshot.child('color').val();
	      if (!isValidColor(color)) {
	        color = "#ffb"
	      }

	      var colorDiv = elt('div', null, { 'class': 'firepad-userlist-color-indicator' });
	      colorDiv.style.backgroundColor = color;

	      var nameDiv = elt('div', name || 'Guest', { 'class': 'firepad-userlist-name' });

	      var userDiv = elt('div', [ colorDiv, nameDiv ], {
	        'class': 'firepad-userlist-user ' + 'firepad-user-' + userId
	      });
	      userId2Element[userId] = userDiv;

	      if (userId === self.userId_) {
	        //HACK: We go ahead and insert ourself in the DOM, so we can easily order other users against it.
	        //But don't show it.
	        userDiv.style.display = 'none';
	      }

	      var nextElement =  prevChildName ? userId2Element[prevChildName].nextSibling : userList.firstChild;
	      userList.insertBefore(userDiv, nextElement);
	    }

	    this.firebaseOn_(this.ref_, 'child_added', updateChild);
	    this.firebaseOn_(this.ref_, 'child_changed', updateChild);
	    this.firebaseOn_(this.ref_, 'child_moved', updateChild);
	    this.firebaseOn_(this.ref_, 'child_removed', function(removedSnapshot) {
	      var userId = removedSnapshot.key;
	      var div = userId2Element[userId];
	      if (div) {
	        userList.removeChild(div);
	        delete userId2Element[userId];
	      }
	    });

	    return userList;
	  };

	  FirepadUserList.prototype.firebaseOn_ = function(ref, eventType, callback, context) {
	    this.firebaseCallbacks_.push({ref: ref, eventType: eventType, callback: callback, context: context });
	    ref.on(eventType, callback, context);
	    return callback;
	  };

	  FirepadUserList.prototype.firebaseOff_ = function(ref, eventType, callback, context) {
	    ref.off(eventType, callback, context);
	    for(var i = 0; i < this.firebaseCallbacks_.length; i++) {
	      var l = this.firebaseCallbacks_[i];
	      if (l.ref === ref && l.eventType === eventType && l.callback === callback && l.context === context) {
	        this.firebaseCallbacks_.splice(i, 1);
	        break;
	      }
	    }
	  };

	  FirepadUserList.prototype.removeFirebaseCallbacks_ = function() {
	    for(var i = 0; i < this.firebaseCallbacks_.length; i++) {
	      var l = this.firebaseCallbacks_[i];
	      l.ref.off(l.eventType, l.callback, l.context);
	    }
	    this.firebaseCallbacks_ = [];
	  };

	  /** Assorted helpers */
	  function isValidColor(color) {
	    return typeof color === 'string' &&
	      (color.match(/^#[a-fA-F0-9]{3,6}$/) || color == 'transparent');
	  }


	  /** DOM helpers */
	  function elt(tag, content, attrs) {
	    var e = document.createElement(tag);
	    if (typeof content === "string") {
	      setTextContent(e, content);
	    } else if (content) {
	      for (var i = 0; i < content.length; ++i) { e.appendChild(content[i]); }
	    }
	    for(var attr in (attrs || { })) {
	      e.setAttribute(attr, attrs[attr]);
	    }
	    return e;
	  }

	  function setTextContent(e, str) {
	    e.innerHTML = "";
	    e.appendChild(document.createTextNode(str));
	  }

	  function on(emitter, type, f) {
	    if (emitter.addEventListener) {
	      emitter.addEventListener(type, f, false);
	    } else if (emitter.attachEvent) {
	      emitter.attachEvent("on" + type, f);
	    }
	  }

	  function off(emitter, type, f) {
	    if (emitter.removeEventListener) {
	      emitter.removeEventListener(type, f, false);
	    } else if (emitter.detachEvent) {
	      emitter.detachEvent("on" + type, f);
	    }
	  }

	  function preventDefault(e) {
	    if (e.preventDefault) {
	      e.preventDefault();
	    } else {
	      e.returnValue = false;
	    }
	  }

	  function stopPropagation(e) {
	    if (e.stopPropagation) {
	      e.stopPropagation();
	    } else {
	      e.cancelBubble = true;
	    }
	  }

	  function stopEvent(e) {
	    preventDefault(e);
	    stopPropagation(e);
	  }

	  return FirepadUserList;
	})();
  </script>
  
	<script>
		//초대
		function invite() {
			var url = window.location.href; //공유해야 할 url 주소
			
			invite_form.url.value = String(url); //공유할 url 주소를 invite_form 안에 넣기
			
			var user_id = $('#user_id').val();
			
			$.ajax({
				url : "../user/searchFriendList",
				type : "post",
				data : {
					user_id : user_id
				},
				success : function(obj){
					
					var str = "";
					
					str += '<input type="button" class="btn btn-primary pull-right" id="invite" name="invite" onclick="invite();" value="Invite Friends" style="width: 100%;"/><br><br>';
					
					for(var i in obj){
						str += '<a href="#" style="color: #00004d; font-size: 10pt;" onclick="addInvite(\''+obj[i].friend_id+'\');">'+obj[i].friend_id+'</a><br>';
					}

					document.getElementById('inviteList').innerHTML=str;
				},
				error : function(err){
					console.log(err);
				}
			});
		}
		
		function addInvite(friend_id){
			
			invite_form.friend_id.value = String(friend_id);
			
				var friend_id = $('#friend_id').val();
				var url = $('#url').val();
				var user_id = $('#user_id').val();
				
				$.ajax({
					url : "invite",
					type : "post",
					data : {
						friend_id : friend_id,
						url : url,
						user_id : user_id
					},
					success : function(){
						alert("초대 메일을 발송하였습니다.");
					},
					error : function(e){
						alert("알 수 없는 오류가 발생하였습니다. 다시 시도해주세요.");
					}
				}); 
		}

		//표지 만들기
		function makeCover(){
			window.open('makeCoverForm', 'newWindow', 'width=1280px, height=602px, resizable=no, scrollbar=no');
		}
		
		//저장
		function save(){
			var title = document.getElementById("post_title");
			
			if(title.value == ''){
				alert('제목을 입력하세요.');
				return false;
			}
			
			var str = $(".CodeMirror-code").html();
			var hidden_form = document.hidden_form;
			
			hidden_form.hidden_data.value = String(str);
			hidden_form.submit();
		}
	</script>
	
	<script type="text/javascript">
		$(document).ready(function(){
			$('h1').fadeIn(600);
			$('.highlight').fadeIn(1700);
		});
		var textarea = document.getElementById("messageWindow");
		var webSocket = new WebSocket('ws://10.10.15.149:8888/cancho/broadcasting');
		var inputMessage = document.getElementById('inputMessage');
		webSocket.onerror = function(event) {
		    onError(event)
		};
		webSocket.onopen = function(event) {
		    onOpen(event)
		};
		webSocket.onmessage = function(event) {
		    onMessage(event)
		};
		function onMessage(event) {
		    var message = event.data.split("|");
		    var sender = message[0];
		    var content = message[1];
		    
		    if (content == "") {
		        
		    } else {
		        if (content.match("/")) {
		            if (content.match(("/" + $("#chat_id").val()))) {
		                var temp = content.replace("/" + $("#chat_id").val(), "(귓속말) :").split(":");
		                if (temp[1].trim() == "") {
		                } else {
		                    $("#messageWindow").html($("#messageWindow").html() + "<p class='whisper'>"
		                        + sender + content.replace("/" + $("#chat_id").val(), "(귓속말) :") + "</p>");
		                }
		            } else {
		            }
		        } else {
		            if (content.match("!")) {
		                $("#messageWindow").html($("#messageWindow").html()
		                    + "<p class='chat_content'><b class='impress'>" + sender + " : " + content + "</b></p>");
		            } else {
		                $("#messageWindow").html($("#messageWindow").html()
		                    + "<p class='chat_content'>" + sender + " : " + content + "</p>");
		            }
		        }
		    }
		}
		function onOpen(event) {
		    $("#messageWindow").html("<p class='chat_content'>채팅에 참여하였습니다.</p>");
		}
		function onError(event) {
		    /* alert("오류가 발생했습니다."); */
		}
		function send() {
		    if ($("#inputMessage").val() == "") {
		    } else {
		        $("#messageWindow").html($("#messageWindow").html()
		            + "<p class='chat_content'>${loginId} : " + $("#inputMessage").val() + "</p>");
		    }
		    webSocket.send($("#chat_id").val() + "|" + $("#inputMessage").val());
		    $("#inputMessage").val("");
		}
		//엔터키를 통해 send함
		function enterkey() {
		    if (window.event.keyCode == 13) {
		        send();
		    }
		}
		//채팅이 많아져 스크롤바가 넘어가더라도 자동적으로 스크롤바가 내려가게함
		window.setInterval(function() {
		    var elem = document.getElementById('messageWindow');
		    elem.scrollTop = elem.scrollHeight;
		}, 0);
	</script>
	</head>
	
	
	
  <body onload="init()">
  
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

    <!-- 404 Error
    ================================================= -->
	<div class="error-page">

		<div id="userlist"></div>
  			
		<div id="inviteList" name="inviteList" style="background-color: #a5dff9; width: 175px; height: 200px; margin-top: 200px; margin-left: 0;">
			<!-- 초대하기 -->
			<input type="button" class="btn btn-primary pull-right" id="invite" name="invite" onclick="invite();" value="Invite Friends" style="width: 100%"/>
		</div>
		
			<!--채팅창 -->
			<input type="hidden" value="${loginId}" id="chat_id">
		    <div id="_chatbox" style="float:left; width: 175px;">
		        <fieldset>
		            <div id="messageWindow" style="overflow-y: scroll; height:310px;" ></div>
		            <input id="inputMessage" type="text" onkeyup="enterkey()" style="width: 100%;"/><br>
		            <input type="submit" value="Send Message" onclick="send()" class="btn btn-primary pull-right"/>
		        </fieldset>
		    </div>
		
  		<div id="firepad" style="width: 80%; margin: 0 auto;">

  			<div class="titleDiv">
	
	  		<!-- 히든폼 -->
			<form action="write" method="post" name="hidden_form" enctype="multipart/form-data" style="position: relative;">
			
				<input type="text" id="post_title" name="post_title" autocomplete="off" style="width: 100%; margin-top: 10px;" placeholder="Title">
				
				<div style="width: 500px; margin-right: 0 auto;">
				<table style="margin: 0 auto; width: 100%;">
					<tr>
						<td>
							<p style="size: 30px;">Upload Cover</p>
						</td>
						<td style="width: 80%;">
							<input type="file" name="upload">
						</td>
					</tr>
				</table>
				</div>
				<input type="hidden" id="hidden_data" name="hidden_data">
				<input type="hidden" id="user_id" name="user_id" value="${loginId }">
			</form>

			</div>
			
			<div class="buttonDiv" style="height: 34px;">
				<!-- 저장하기 -->
				<input type="button" class="btn btn-primary pull-right" id="save" name="save" onclick="save();" value="Save"/>

				<!-- 표지 만들기 -->
				<input type="button" class="btn btn-primary pull-right" id="makeCover" name="makeCover" onclick="makeCover();" value="Make Cover"/>
			</div>
			
			<!-- 히든폼2(초대) -->
			<form action="invite" method="post" id="invite_form" name="invite_form" method="post">
				<input type="hidden" id="user_id" name="user_id" value="${loginId }">
				<input type="hidden" id="url" name="url">
				<input type="hidden" id="friend_id" name="friend_id">
			</form>	
			
  		</div>
	</div>


    
    <!-- Footer
    ================================================= -->
    <footer id="footer" style="margin-bottom: 0;">
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
    <script src="../resources/js/script.js"></script>
    
    <script>
    function init() {
      //// Initialize Firebase.
      //// TODO: replace with your Firebase project configuration.
      var config = {
        apiKey: "AIzaSyC_JdByNm-E1CAJUkePsr-YJZl7W77oL3g",
        authDomain: "firepad-tests.firebaseapp.com",
        databaseURL: "https://firepad-tests.firebaseio.com"
      };
      firebase.initializeApp(config);

      //// Get Firebase Database reference.
      var firepadRef = getExampleRef();

      //// Create CodeMirror (with lineWrapping on).
      var codeMirror = CodeMirror(document.getElementById('firepad'), { lineWrapping: true });

      // Create a random ID to use as our user ID (we must give this to firepad and FirepadUserList).
      var userId = "${loginId}";

      //// Create Firepad (with rich text features and our desired userId).
      var firepad = Firepad.fromCodeMirror(firepadRef, codeMirror,
          { richTextToolbar: true, richTextShortcuts: true, userId: userId});

      //// Create FirepadUserList (with our desired userId).
      var firepadUserList = FirepadUserList.fromDiv(firepadRef.child('users'),
          document.getElementById('userlist'), userId);

      //// Initialize contents.
      firepad.on('ready', function() {
        if (firepad.isHistoryEmpty()) {
          firepad.setText('당신의 하루를 기록해보세요.');
        }
      });
    }

    // Helper to get hash from end of URL or generate a random one.
    function getExampleRef() {
      var ref = firebase.database().ref();
      var hash = window.location.hash.replace(/#/g, '');
      if (hash) {
        ref = ref.child(hash);
      } else {
        ref = ref.push(); // generate unique location.
        window.location = window.location + '#' + ref.key; // add it as a hash to the URL.
      }
      if (typeof console !== 'undefined') {
        console.log('Firebase data: ', ref.toString());
      }
      return ref;
    }
  </script>
    
    
  </body>
</html>