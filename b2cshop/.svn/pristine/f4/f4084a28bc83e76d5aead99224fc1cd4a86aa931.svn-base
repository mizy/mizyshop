(function(){
	var imlook = new imLook();
	imlook.start();

})();



function imLook(url,ele,time){

	this.time = time||10000;

	this.status = false;

	this.url = url;

	this.timeout = "";

	this.upload = function(data,callback){

		if(typeof data == undefined ||data == ""){

			var data;

			$(ele).on( "image", function( event, dataUrl ){ 
				data = dataUrl;
			});
		}

		var url=this.url;
		$.ajax({
			url:url,
			type:"post",
			data:{data:data},
			success:function(callback,info){
				try{callback(info);}catch(e){

				}
				
			}
		})
	}

	this.start = function(){

			this.status = "on";
			this.timeout = setTimeout(this.upload,this.time);

	}

	this.stop = function(){

		this.status = "off";
		clearTimeout(this.timeout);
	}


}