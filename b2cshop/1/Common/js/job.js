function huanhang(info){
    /**
     * Created by iblovem on 14-3-30.
     */
    var div=document.getElementsByTagName('div');
    for(i in div){
        if(div[i].className==info){
            var html=div[i].innerHTML;
            html=html.replace(/；/g,"<br \/>");
            html=html.replace(/&nbsp/g,"");
            html=html.replace(/;/g,"");
            html=html.replace(/ /g,"");
            div[i].innerHTML=html;
            delete html;
        }
    }
}
var  newhuanhang=new huanhang('info');