<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<sec:authorize var="isLogin" access="isAuthenticated()" />

<!DOCTYPE html>
<html lang="ko">
<head>
	<meta charset="utf-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<title>Login</title>
	
	<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
	<link href="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/3.3.7/css/bootstrap.min.css" rel="stylesheet">

	<style type="text/css">
		body, html {
			height: 100%;
			background-repeat: no-repeat;
			background-image: linear-gradient(rgb(104, 145, 162), rgb(12, 97, 33));
		}
		
		.card-container.card {
			max-width: 350px;
			padding: 40px 40px;
		}
		
		.btn {
			font-weight: 700;
			height: 36px;
			-moz-user-select: none;
			-webkit-user-select: none;
			user-select: none;
			cursor: default;
		}
		
		.card {
			background-color: #F7F7F7;
			padding: 20px 25px 30px;
			margin: 0 auto 25px;
			margin-top: 50px;
			-moz-border-radius: 2px;
			-webkit-border-radius: 2px;
			border-radius: 2px;
			-moz-box-shadow: 0px 2px 2px rgba(0, 0, 0, 0.3);
			-webkit-box-shadow: 0px 2px 2px rgba(0, 0, 0, 0.3);
			box-shadow: 0px 2px 2px rgba(0, 0, 0, 0.3);
		}
		
		.profile-img-card {
			width: 96px;
			height: 96px;
			margin: 0 auto 10px;
			display: block;
			-moz-border-radius: 50%;
			-webkit-border-radius: 50%;
			border-radius: 50%;
		}
		
		.profile-name-card {
			font-size: 16px;
			font-weight: bold;
			text-align: center;
			margin: 10px 0 0;
			min-height: 1em;
		}
		
		.form-signin #username, .form-signin #password {
			direction: ltr;
			height: 44px;
			font-size: 16px;
		}
		
		.form-signin input[type=email], .form-signin input[type=password],
			.form-signin input[type=text], .form-signin button {
			width: 100%;
			display: block;
			margin-bottom: 10px;
			z-index: 1;
			position: relative;
			-moz-box-sizing: border-box;
			-webkit-box-sizing: border-box;
			box-sizing: border-box;
		}
		
		.form-signin .form-control:focus {
			border-color: rgb(104, 145, 162);
			outline: 0;
			-webkit-box-shadow: inset 0 1px 1px rgba(0, 0, 0, .075), 0 0 8px
				rgb(104, 145, 162);
			box-shadow: inset 0 1px 1px rgba(0, 0, 0, .075), 0 0 8px
				rgb(104, 145, 162);
		}
		
		.btn.btn-signin {
			display: inline-block;
			width: 49%;
			margin: 0;
			background-color: rgb(104, 145, 162);
			padding: 0px;
			font-weight: 700;
			font-size: 14px;
			height: 36px;
			-moz-border-radius: 3px;
			-webkit-border-radius: 3px;
			border-radius: 3px;
			border: none;
			-o-transition: all 0.218s;
			-moz-transition: all 0.218s;
			-webkit-transition: all 0.218s;
			transition: all 0.218s;
		}
		
		.btn.btn-signin:hover, .btn.btn-signin:active, .btn.btn-signin:focus {
			background-color: rgb(12, 97, 33);
		}
	</style>
</head>
<body>
	<div class="container">
		<div class="card card-container">
			<img id="profile-img" class="profile-img-card" src="//ssl.gstatic.com/accounts/ui/avatar_2x.png" />
			<p id="profile-name" class="profile-name-card"></p>
			<form class="form-signin" role="form" id="login" method="POST" action="/loginProcess">
				<input type="text" id="username" name="username" class="form-control" placeholder="Insert 'user' or 'admin'" required autofocus>
				<input type="password" value="password" id="password" name="password" class="form-control" placeholder="PASSWORD" required>
				<div id="remember" class="checkbox">
					<label> 
						<input type="checkbox" id="remember-me" name="remember-me">
						<span>Remember me</span>
					</label>
				</div>
				<div>
					<button id="form_submit" class="btn btn-lg btn-primary btn-block btn-signin" type="submit">FORM_LOGIN</button>
					<button id="ajax_submit" class="btn btn-lg btn-primary btn-block btn-signin" type="submit">AJAX_LOGIN</button>
				</div>
			</form>
		</div>
	</div>

	<script type="text/javascript">
		$(function(){
			'use strict';
			var login = {
				init: function(){
					var errorMessage = "${param.error}";
					if(errorMessage) {
						alert(errorMessage);
					}
					
					var isLogin = ${isLogin};
					if(isLogin) {
						alert('You are already logged in, move to mypage...');
						location.href = '/mypage';
						return;
					}
					this.event();
				},
				event: function(){
					$('button#ajax_submit').on('click', login.ajaxLogin);
				},
				ajaxLogin: function(e){
					e.preventDefault();
					$.ajax({
						url : '/loginProcess',
						data : $('.form-signin').serialize(),
						type : 'POST',
						dataType : 'json',
						beforeSend : function(xhr) {
							xhr.setRequestHeader("Accept", "application/json");
						},
						success : function(result){
							if(!result.success) {
								alert(result.error);
								return;
							}
							alert('Ajax Login is succeed.');
							location.href = result.redirect;
			            },
			            error : function(error){
			                alert(error);
			            }
		            });
				}
			}
			login.init();
		});
	</script>
</body>
</html>