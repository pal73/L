/**
 * Created by PAL on 07.06.16.
 */
var time_cnt = 0;
window.onload=function(){
  var new_div = document.createElement("div");
  new_div.textContent="345";
  document.body.appendChild(new_div);
  //illumine(300);
  //setTimeout(func, 1000);
  illumine(500);
  //func();
};

function illumine(timeInterval){
  time_cnt++;
  //var temp = parseInt(document.getElementsByName("div")[1].innerHTML);
  //document.getElementsByName("div")[1].textContent=400;
  //setTimeout(illumine(10000),timeInterval);
  setTimeout(illumine,3000);
}

function func() {
  time_cnt++;
  setTimeout(func, 1000);
}

//
