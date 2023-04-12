<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Cyber Security Community 회원가입</title>
<link rel="stylesheet" href="css/signup.css">
<script src="https://kit.fontawesome.com/9174a5fbf3.js" crossorigin="anonymous"></script>
<script src="js/jquery-3.6.0.min.js"></script>
<script src="js/ShowPassword.js"></script>
<script type="text/javascript">
	$(document).ready(function(){
		let idCheckStatus = false;
		let passwdStatus = false;
		$('#alert-success').css('display', 'none');
		$('#checkID').css('visibility', 'hidden');

		$('#signup').on('click', function(){
			// 입력되지 않은 사항있는지 확인
			if($('#userID').val() == '' || $('#pwd1').val() == '' || $('#pwd2').val() == '' || $('#userEmail').val() == ''){
				alert('입력되지 않은 사항이 있습니다. 다시 한번 확인해주세요.');
			}
			// 아이디 중복 체크 여부
			else if($('#idCheckStatus').val() != 'idChecked'){
				alert("아이디 중복체크를 해주세요.");
			}
			if($('#pwd1').val() != '' || $('#pwd2').val() != ''){
				if($('#pwd1').val() == $('#pwd2').val()){
					passwdStatus = true;
				}
			}
			if(idCheckStatus == true && passwdStatus == true){
				$('.signup_form').submit();
			}
		})
		
		// 패스워드 일치 여부
		$('#pwd1').on('keyup', function(){
			$('#pwd2').keyup();
		})
		$('#pwd2').on('keyup', function(){
			if($('#pwd1').val() != '' || $('#pwd2').val() != ''){
				if($('#pwd1').val() == $('#pwd2').val()){
					$('#alert-success').css('display', 'block');
					$('#alert-danger').css('display', 'none');
				}
				else{
					$('#alert-success').css('display', 'none');
					$('#alert-danger').css('display', 'block');
				}
			}
		})
		$('.check_btn').click(function(){
			let userID = $('#userID').val();
			if(userID == ''){
				alert('아이디를 입력해 주세요.');
			}
			else{
				$('#idCheckStatus').val('idChecked');
				$.ajax({
					url: "idCheckServlet",
					type: "post",
					data: {userID: userID},
					dataType: "json",
					success: function(result){
						if(result == 0) {
							$('#checkID').html('<i class="fa-solid fa-ban" id="checkID_icon"></i>사용할 수 없는 아이디입니다.');
							$('#checkID').css('color', 'red');
							$('#checkID_icon').css('color', 'red');
							$('#checkID').css('visibility', 'visible');
						}
						else {
							$('#checkID').html('<i class="fa-solid fa-circle-check" id="checkID_icon"></i>사용할 수 있는 아이디입니다.');
							$('#checkID').css('color', '#225CCF');
							$('#checkID_icon').css('color', '#225CCF');
							$('#checkID').css('visibility', 'visible');
							idCheckStatus = true;
						}
					},
					error: function(){
						alert('서버요청실패');
					}
				});
			}
		})
		ShowPassword();
	})
</script>
</head>
<body>
	<%@ include file="navbar.jsp" %>
	<section>
		<form class="signup_form" method="post" name="userInfo" action="SignUpAction.jsp">
			<h2>회원가입</h2>
			<label><i class="fa-solid fa-star"></i><span>아이디</span></label>
			<div class="id_container">
				<input type="text" name="userID" id="userID" placeholder="아이디를 입력해 주세요" maxlength="20">
				<button class="check_btn" type="button">중복체크</button>
			</div>
			<input type="hidden" id="idCheckStatus">
			<p id="checkID"><i class="fa-solid fa-ban" id="checkID_icon"></i>사용할 수 없는 아이디입니다.</p>
			<label><i class="fa-solid fa-star"></i><span>비밀번호</span></label>
			<div class="pw_container">
				<input type="password" name="userPassword" id="pwd1" placeholder="비밀번호를 입력해 주세요" maxlength="20">
				<i class="fa-solid fa-eye-slash" id="eye_icon"></i>
			</div>
			<label><i class="fa-solid fa-star"></i><span>비밀번호 확인</span></label>
			<input type="password" name="passwordcheck" id="pwd2" placeholder="비밀번호를 한번 더 입력해 주세요" maxlength="20">
			<br>
			<!-- 비밀번호 일치 여부 확인 -->
			<div class="alert alert-success" id="alert-success">비밀번호가 일치합니다.</div>
			<div class="alert alert-danger" id="alert-danger">비밀번호가 일치하지 않습니다.</div>
			<label><i class="fa-solid fa-star"></i><span>이메일</span></label>
			<input type="email" name="userEmail" id="userEmail" placeholder="이메일을 입력해 주세요" maxlength="50">
			<p id="text">
				<i class="fa-solid fa-star"></i>는 필수 입력 항목입니다.
			</p>
			<input type="button" value="회원가입" id="signup">
		</form>
	</section>
</body>
</html>