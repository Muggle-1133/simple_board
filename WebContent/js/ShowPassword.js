function ShowPassword(){
	let password_input = document.getElementById('pwd1');
	let stat = document.getElementById('eye_icon');
	
	stat.addEventListener('click', function(){
		password_input.classList.toggle('active');
		if(password_input.className == 'active'){
			stat.className = "fa-solid fa-eye";
			password_input.setAttribute('type', 'text');
		}
		else{
			stat.className = "fa-solid fa-eye-slash";
			password_input.setAttribute('type', 'password');
		}
	})
		
}
