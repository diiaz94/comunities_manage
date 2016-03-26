function changeStatus(slug,id){
//alert("antes"+$("#input-update").val())
$("#input-update").val(id);
//alert("ahora"+$("#input-update").val())

$("#form-update").attr("action","/requests/"+slug)
//alert("action"+$("#form-update").attr("action"))
$("#form-update").submit();
}

function verifyCompletadas () {
	if (document.getElementById('check-completados').checked) {
            $('.completado').show();
        } else {
            $('.completado').hide();
        }
}
function createRequest(i){

	if( confirm("¿Estas seguro/a?")){
		$("#form-create-"+i).submit();
		
	}
}
$(document).on('ready page:load', function () {

  if ($(".completado").length==0) {
    $("#show-completados").hide();
	}


});