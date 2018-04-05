<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!doctype html>
<html>

<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>POST</title>
	
	<script type="text/javascript" src="../resources/js/jquery-3.2.1.js"></script>
	
	<!-- 텍스트 창 -->
	<script src="http://ajax.googleapis.com/ajax/libs/jquery/1.7.0/jquery.min.js"></script>
	<script src="http://ajax.googleapis.com/ajax/libs/jqueryui/1.8.16/jquery-ui.min.js"></script>
	<script src="https://raw.github.com/carhartl/jquery-cookie/master/jquery.cookie.js"></script>

  <meta charset="utf-8" />
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

  <style>
    html { height: 100%; }
    body { margin: 0; height: 100%; }
    /* Height / width / positioning can be customized for your use case.
       For demo purposes, we make the user list 175px and firepad fill the rest of the page. */
    #userlist {
      position: absolute; left: 0; top: 0; bottom: 0; height: auto;
      width: 175px; height: 400px;
    }
    #firepad {
      position: absolute; left: 175px; top: 0; bottom: 0; right: 0; height: auto;
      height: 500px;
    }
    
    /* 텍스트창 */
    .sticky {
	  width: 250px;
	  height: 50px;
	  position: absolute;
	  cursor: pointer;
	  border: 1px solid #aaa;
	}
	
	textarea {
	  width: 100%;
	  height: 100%;
	}
	
	.selected {border-color: #f44;}
    
 	.footer {
	  text-align: center;
	  width: 100%;
	  height: 200px;
	  background-color: #e6ccff;
	  position: absolute;
	  top: 420px;
	  left: 0px;
	  margin-top: 100px;
	  padding: 0px;
	}
  </style>
  
  <script type="text/javascript">
  
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

	  // This is the primary "constructor" for symmetry with Firepad.
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

	    // Update Firebase when name changes.
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
	        // HACK: We go ahead and insert ourself in the DOM, so we can easily order other users against it.
	        // But don't show it.
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
  
  //텍스트 창
  $(function() {
  $('#new').click(function() {
    make();
    save();
  });

  $('#del').click(function() {
    $('.selected').remove();
    save();
  });

  function make() {
    var sticky = $('<div class="sticky">원하는 곳에 글을 써보세요!</div>');
    sticky.appendTo('.footer')
      .css('background-color', $('#color').val())
      .draggable({stop: save})
      .dblclick(function() {
        $(this).html('<textarea>' + $(this).html() + '</textarea>')
          .children()
          .focus()
          .blur(function() {
            $(this).parent().html($(this).val());
            save();
          });
      }).mousedown(function() {
        $('.sticky').removeClass('selected');
        $(this).addClass('selected');
      });
    return sticky;
  }

  function save() {
    var items = [];
    $('.sticky').each(function() {
      items.push(
        $(this).css('left'),
        $(this).css('top'),
        $(this).css('background-color'),
        $(this).html()
      );
    });
    $.cookie('sticky', items.join('\t'), {expires: 100});
  }

  function load() {
    if (!$.cookie('sticky')) return;
    var items = $.cookie('sticky').split('\t');
    for (var i = 0; i < items.length; i += 4) {
      make().css({
        left: items[i],
        top: items[i + 1],
        backgroundColor: items[i + 2]
      }).html(items[i + 3]);
    }
  }
  load();
});
  
  </script>
  
	<script>
		//공유
		function invite() {
			alert(window.location.href); //공유해야 할 url 주소(이걸 쪽지로 보내야 함)
		}
		
		//저장
		function save(){
			var title = document.getElementById("post_title");
			
			if(title.value == ''){
				alert('제목을 입력하세요.');
				return false;
			}
			
			var str = $(".CodeMirror.cm-s-default.CodeMirror-wrap").html();
			var hidden_form = document.hidden_form;
			
			hidden_form.hidden_data.value = String(str);
			hidden_form.submit();
		}
		
	</script>
</head>

<body onload="init()">

  <div id="userlist">
  
  		<!-- 초대하기 -->
		<input type="button" id="invite" name="invite" onclick="invite();" value="초대" style="float: left;"/>
		
		<!-- 저장하기 -->
		<input type="button" id="save" name="save" onclick="save();" value="저장" style="float: left;"/>

  </div>
  
  <div id="firepad">
  
  		<!-- 히든폼 -->
		<form action="write" method="post" name="hidden_form" style="position: relative;">
			제목 <input type="text" id="post_title" name="post_title" autocomplete="off">
			<input type="hidden" id="hidden_data" name="hidden_data">
			<input type="hidden" id="user_id" name="user_id" value="${loginId }">
		</form>
		
		<!-- 텍스트창 -->
		<select id="color">
			<option value="#ffc">黄色</option>
			<option value="#fcc">赤色</option>
			<option value="#cfc">緑色</option>
		</select>
		<input id="new" type="button" value="new">
		<input id="del" type="button" value="del">
  
  </div>
  
	<!-- 로고 등 이미지가 들어가는 div -->
  <div class="footer">
		<img src="../resources/img/a.png">
		<img src="../resources/img/b.png">
  </div>
  
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
