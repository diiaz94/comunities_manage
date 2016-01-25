$(document).ready(function() {
	$("#view1").show()
   	$("#view2").hide();
   	if($("#viewtype").length)
		loadbyFamilyView();
});
function isFamilycontExist(familyName){
	var containerFamilies = $("#view2").children();
	for (var i = 0; i<containerFamilies.length; i++) {
		if (familyName===containerFamilies[i].children[0].children[0].children[0].childNodes[0].data) {
			return $("#item-"+i);
		}
	}
	return false;
}
function loadbyFamilyView(){
	var profiles = $("#view1").children().clone()
	var family;
	var nextFamily;
	var count=0;
	var i=0;
	while(profiles.length>0){
		var familycontainer;
		var familyname;


		
		while(profiles.length>0){
			familyname=profiles[0].children[0].children[1].children[2].childNodes[0].data
			familycontainer=isFamilycontExist(familyname)
			if(familycontainer==false){
				familycontainer=$("#templatefamily").clone();
				familycontainer[0].id="item-"+($("#view2").children().length);
				familycontainer.find(".title").text(familyname);
				$("#view2").append(familycontainer);
			}
			familycontainer.find(".row").append(profiles[i]);
			profiles.splice(i,1);			
			
		}
		
		
	}
}
function onChangeView(){
	if($("#viewtype").val() == "1"){
    	$("#view1").show()
    	$("#view2").hide();
  	}else{
  		if($("#viewtype").val() == "2"){
  			if($("#view2")[0].children.length==0){
 				loadbyFamilyView();
 			}
		    $("#view1").hide();
		  	$("#view2").show()
 			
  		}
  	}
}


function onChangeOrder(){
	if($("#viewtype").val() == "1"){
    	$("#view1").show()
    	$("#view2").hide();
  	}else{
  		if($("#viewtype").val() == "2"){
  			if($("#view2")[0].children.length==0){
 				loadbyFamilyView();
 			}
		    $("#view1").hide();
		  	$("#view2").show()
 			
  		}
  	}
}

$( document ).ready(function() {
    console.log( "ready!" );

$('#profile_telefono').bind('keydown', function(){
    if(this.value.length>11){
    	this.value = this.value.substring(0,10)
    }
});
});