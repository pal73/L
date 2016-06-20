/**
 * Created by PAL on 20.06.16.
 */
var path_counter=0;
var max_x=0;
window.onload=function(){
    var result = prompt("¬ведите размерность таблицы",2);
    //alert("fglhopuiyh");
    max_x = parseInt(result);
    //var result__= result_*2;
    path_counter=0;
    iter(0,0);
    alert("aaa "+path_counter + " вариантов");
};

function iter(xx,yy){
    if((xx == max_x) && (yy == max_x)){
        path_counter++;
        return;
    }
    if(xx != max_x)iter(xx+1,yy);
    if(yy != max_x)iter(xx,yy+1);
}


