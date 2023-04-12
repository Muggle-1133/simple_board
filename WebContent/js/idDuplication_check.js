function id_check(){
	let id = document.getElementById("userID").value;
	if(!id){
		alert('아이디를 입력해주세요.');
		return false;
	}
	else{
		let param = "userID="+userID;
		httpRequest = getXMLHttpRequest();
		httpRequest.onreadystatechange = callback;
		httpRequest.open("POST", "UserIDCheckAction.do", true);
		httpRequest.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
		httpRequest.send(param);
	}
}

function callback(){
	if(httpRequest.readyState == 4){
		let resultText = httpRequest.responseText;
		if(resultText == 0){
			alert('사용할 수 없는 아이디입니다.');
			document.getElementById('')
		}
	}
}