let answer = confirm("취소 하시겠습니까?");
function cancel(){
	if (answer) {
	  history.back();
	}	
}