/**
 * Created by PAL on 21.06.2016.
 */
var path_counter=0;
var max_x=0;

window.onload=function(){
    var result = prompt("Введите размерность таблицы",2);
    //alert("fglhopuiyh");
    max_x = parseInt(result);
/*    arr = [];
    for (var i=0; i<=max_x; i++) {
        var temp=[];

        for (var j=0; j<=max_x; j++){
            temp.push(0);
        }
        arr.push(temp);
    }
    console.log(arr);*/

    arr = [];
    for (var i=0; i<max_x; i++) {
        arr[i]=[max_x];
        for (var j=0; j<max_x; j++){
            arr[i][j]=0;
        }
    }

    path_counter=0;
    iter(0,0);
    alert("Всего "+path_counter + " возможных путей");
};

function iter(xx,yy){
    if((xx == max_x) && (yy == max_x)){
        path_counter++;
        return;
    }
    if(arr[xx][yy]!=0){
        path_counter+=arr[xx][yy];
        return;
    } else {
        var temp_path_counter = path_counter;
        if (xx != max_x)iter(xx + 1, yy);
        if (yy != max_x)iter(xx, yy + 1);
        arr[xx][yy]=path_counter-temp_path_counter;
    }
}
