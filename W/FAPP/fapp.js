/**
 * Created by PAL on 07.06.16.
 */
var time_cnt = 0;
window.onload=function(){
  var new_div = document.createElement("div");
  temp=document.getElementById("table").style;
  new_div.textContent=/*"234";//*/document.getElementById("table").style.top;
  document.body.appendChild(new_div);
  //illumine(300);
  //setTimeout(func, 1000);
  var plazma1=document.getElementById("plazma1");
  plazma1.style.width="100px";
  plazma1.style.backgroundColor="red";
  illumine(500);
  //document.getElementById("key2").style.left="800px";
  document.getElementById("key2").onclick=function(){
     temp=document.getElementById("key2").style.left.split("px")[0];
    temp-=10;
    document.getElementById("key2").style.left=temp+"px";
  };
  //func();
};

function illumine(timeInterval){
  time_cnt++;
  //var temp = parseInt(document.getElementsByName("div")[1].innerHTML);
  document.getElementById("plazma1").textContent=time_cnt;
  //setTimeout(illumine(10000),timeInterval);
  setTimeout(illumine,1000);
}

function func() {
  time_cnt++;
  setTimeout(func, 1000);
}

//
