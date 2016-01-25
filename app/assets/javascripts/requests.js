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

 $(document).ready(function() {
  if ($(".completado").length==0) {
    $("#show-completados").hide();
	}

});