// JavaScript Document
function скрыть_показать()	{
	if(document.getElementById('trans').value == 'Скрыть ответ'){
		document.getElementById('trans').value='Показать ответ';
		textColor='#ffffff';
	}else{
		document.getElementById('trans').value='Скрыть ответ';
		textColor='#000000';
	}
	var таблица = document.getElementById('учить')
	var строки = таблица.getElementsByTagName('tr')
	for(var i=0; i<строки.length; i++){
		ячейки=строки[i].getElementsByTagName('td')
		колЯч=ячейки.length
		ячейки[колЯч-1].style.color = textColor   
	}
}

