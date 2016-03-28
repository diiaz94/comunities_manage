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



var months=[
		        "Enero",
		        "Febrero",
		        "Marzo",
		        "Abril",
		        "Mayo",
		        "Junio",
		        "Julio",
		        "Agosto",
		        "Septiembre",
		        "Octubre",
		        "Noviembre",
		        "Diciembre"
		      ]

var days = [
			"Domingo","Lunes","Martes","Miercoles","Jueves","Viernes","Sabado"
			]
var today;		      
var contador;
var documentPDF;
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

  var p = location.pathname.split("/")[1]
  $("#op-"+p).addClass("active");
 $("#op-users").addClass(p=="types"?"active":"");
 $("#op-requests").addClass(p=="type_requests"||p=="status_requests"?"active":"");
 $("#op-comunities").addClass(p=="families" || p=="profiles"|| p=="members"|| p=="jobs"?"active":"");
 $("#op-locations").addClass(p=="states"|| p=="towns"|| p=="parishes"?"active":"");

today = new Date();
initClock();
  	$('.num-tlf').unbind();
  	$('.num-tlf').bind('keyup', function(){
		if(this.value.length>11){
	    	this.value = this.value.substring(0,11)
	    }
	});
	$('.num-tlf').bind('keypress', function(){
		if(this.value.length>10){
	    	this.value = this.value.substring(0,11)
	    }
	});
});

function initClock(){
var h=$("#clock").text();
if(h!=="null"){
	today.setDate(h.split(" ")[0].split("-")[2])
	today.setMonth(h.split(" ")[0].split("-")[1]-1)
	today.setFullYear(h.split(" ")[0].split("-")[0])
	today.setHours(h.split(" ")[1].split(":")[0])
	today.setMinutes(h.split(" ")[1].split(":")[1])
	today.setSeconds(h.split(" ")[1].split(":")[2])
}
$("#clock").text(DateToString(today));
clearTimeout(contador);
updateClock();
//alert(today);
//debugger

}

function updateClock(){
contador = setTimeout(increment,1000);
}
var increment = function(){
today.setTime(today.getTime()+1000)
$("#clock").text(DateToString(today));
updateClock();

}
function DateToString(date){
	if (typeof(date)=="object") {

		return days[date.getDay()]+", "+date.getDate()+" de "+months[date.getMonth()] +" de "+ date.getFullYear()+
		" - "+((date.getHours()<13?date.getHours():date.getHours()-12)<10?"0":"")+(date.getHours()<13?date.getHours():date.getHours()-12)+":"+
		(date.getMinutes()<10?"0":"")+date.getMinutes()+":"+
		(date.getSeconds()<10?"0":"")+date.getSeconds()+(date.getHours()>12?"PM":"AM");
	}else{
		return date;
	}
}

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
		
		//var divs = ["<div id='pedro-0' style='background-color: white;'>"+$(".pdf-style")[0].outerHTML+"</div>"]
		//createPDF(0,divs.length,new jsPDF(),divs,"prueba");
		var pdf = new jsPDF();
		$(".pdf-style").css("background","white");
		html2canvas($(".pdf-style"),{
					onrendered: function(canvas) {
						try{
			
							
							var imgData = canvas.toDataURL("image/jpeg",1.0);
							pdf.addImage(imgData, 'JPEG', 16, 22);
							
							//obj.remove();
							pdf.save("Solicitud.pdf")
						}catch(e){
							//obj.remove();
						}
					}
				});
}
