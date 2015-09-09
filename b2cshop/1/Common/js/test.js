var val='1';
function i(){
    document.write(val+'\r');
    val=2;
    document.write(this.val+'\r')
    console.log(val)
    this.val=3;
}
i();
var m2=new i();
/**
 * Created by iblovem on 14-3-26.
 */
