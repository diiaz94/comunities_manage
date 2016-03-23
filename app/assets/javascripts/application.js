// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require turbolinks
//= require bootstrap
//= require_tree .


$(document).on('ready', function () {

  if($("#notice").text().trim().length == 1){
    $("#notice").addClass("hidden");
  }else{
    $("#notice").removeClass("hidden");
  }
  //alert($("#error").text().trim().length)
   if($("#error").text().trim().length == 10){
    $("#error").addClass("hidden");
  }else{
    $("#error").removeClass("hidden");
  }
  
});

$(document).on('ready page:load', function () {
  
  	if($(".eliminar").length&&$(".eliminar").children().length==0)
 	 	$(".eliminar").append(" <span class='glyphicon glyphicon-trash' aria-hidden='true'></span>")
	if($(".mostrar").length&&$(".mostrar").children().length==0)	
		$(".mostrar").append(" <span class='glyphicon glyphicon-check' aria-hidden='true'></span>")
	if($(".editar").length&&$(".editar").children().length==0)
  		$(".editar").append(" <span class='glyphicon glyphicon-edit' aria-hidden='true'></span>")
 
});
function createPDF(i,dim,pdf,divs,filename){
	try{
		if(i<dim){
			$("body").append($(divs[i]));
			var obj = $("#"+$(divs[i]).attr("id"));
			if(obj.length){
				html2canvas(obj,{
					onrendered: function(canvas) {
						try{
							var imgData = canvas.toDataURL("image/jpeg",1.0);
							pdf.addImage(imgData, 'JPEG', 18, 18, obj.offsetWidth, obj.offsetHeight);
							if(i<dim-1)
								pdf.addPage();
							createPDF(i+1,dim,pdf,divs,filename);
							obj.remove();
						}catch(e){
							obj.remove();
						}
					}
				});
			}else{
				$("body").children()[$("body").children().length-1].remove();
			}
		}else{
			pdf.save(filename);
		}
	}catch(e){
		for(i=0;i<divs.length;i++){
			if($("#"+$(divs[i]).attr("id")).length){
				$("#"+$(divs[i]).attr("id")).remove();
			}
		}
	}
}

function PDFprueba(){
		
		var divs = ["<div id='pedro-0' style='background-color: white;'>"+$(".pdf-style")[0].outerHTML+"</div>"]
		createPDF(0,divs.length,new jsPDF(),divs,"prueba");
	
}

