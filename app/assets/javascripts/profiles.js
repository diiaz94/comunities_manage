$(document).ready(function() {
	$("#view-normal").show()
   	$("#view2").hide();
   	if($("#viewtype").length)
		cargarbyFamilyView();

	    console.log( "ready!" );

$('#profile_telefono').bind('keydown', function(){
    if(this.value.length>11){
    	this.value = this.value.substring(0,10)
    }
});
});


function cargarbyFamilyView(){
	var profiles = $($("#view-normal").find(".profile"));
	var familycontainer;
	for (var i = 0 ; i <housesNameArray.length; i++) {
		familycontainer=$("#templatefamily").clone();
		familycontainer.find(".row").append(profiles.closest("#view-normal").find(".casa-"+housesNameArray[i]).clone());
		familycontainer[0].id="item-"+i;
		familycontainer.find(".title").text(housesNameArray[i]);
		if(familycontainer.find(".row").find(".casa-"+housesNameArray[i]).length>0)
		$("#view2").append(familycontainer);
	};


}
function onChangeView(){

	if($("#viewtype").val() == "1"){
    	$("#view-normal").show()
    	$("#view2").hide();
  	}else{
  		if($("#viewtype").val() == "2"){
  			if($("#view2")[0].children.length==0){
 				cargarbyFamilyView();
 			}
		    $("#view-normal").hide();
		  	$("#view2").show()
 			
  		}
  	}
}




function onChangeOrder(){
	if($("#viewtype").val() == "1"){
    	$("#view-normal").show()
    	$("#view2").hide();
  	}else{
  		if($("#viewtype").val() == "2"){
  			if($("#view2")[0].children.length==0){
 				loadbyFamilyView();
 			}
		    $("#view-normal").hide();
		  	$("#view2").show()
 			
  		}
  	}
}

