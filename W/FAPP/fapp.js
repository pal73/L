/**
 * Created by PAL on 07.06.16.
 */
window.onload=function(){
  var new_div = document.createElement("div");
  new_div.textContent="345";
  document.body.appendChild(new_div);
  illumine(300);
};

function illumine(timeInterval){
  var temp = parseInt(document.getElementsByName("div")[1].innerHTML);
  document.getElementsByName("div")[1].textContent=++temp;
  setTimeout(illumine(300),timeInterval);
}
