/**
 * Created by PAL73 on 25.04.16.
 */
(function (count,fileds) {
    function cl(id){x=document.getElementById(id);return x?(x.className.indexOf('bomb')!=-1?1:0):0;}
    var bombs=0;
    for(var i=0;i<fileds;i++){
        r=document.createElement('div');
        if(Math.random()*fileds<count){r.className='bomb close',document.getElementById('text').innerHTML=(++bombs)+' bomb\'s';}
        else r.className='close';
        r.id=Math.floor(i/10)+'_'+i%10;
        document.body.appendChild(r);
    }
    for(var o=0;o<fileds;o++){
        i=Math.floor(o/10),j=o%10,num=0,obj=document.getElementById(i+'_'+j);
        for(k=0;k<9;k++)num+=cl((i-(Math.floor(k/3)-1))+'_'+(j-(k%3-1)));
        obj.innerHTML=num==0?'&nbsp;':num;
        obj.onclick=function(){mix=this.id.split('_'),open(mix[0],mix[1]);}
        obj.oncontextmenu=function(){this.className=this.className.indexOf('flag')!=-1?this.className.replace(/ flag/,''):this.className+' flag';return false;}
    }
    function open(i,j){
        dom=document.getElementById(i+'_'+j);
        if(!dom||dom.className.indexOf('close')==-1)return;
        if(dom.className.indexOf('bomb')!=-1){
            divs=document.getElementsByTagName('div');
            for(i=0;i<divs.length;i++)divs[i].className=divs[i].className.indexOf('bomb')!=-1?'bomb':'';
            alert('You lose!');
        }
        else {
            dom.className='';
            var elems = document.getElementsByTagName('div'),len=0;
            for (ki in elems)if(elems[ki].className&&elems[ki].className.indexOf('close')!=-1)len++;
            if(len<=bombs)alert('You win!');
        }
        if(dom.innerHTML=='&nbsp;')for(var ks=0;ks<9;ks++)open(i-((Math.floor(ks/3)-1)),j-(((ks%3)-1)));
    }
}(10,100));