$(document).ready(function() { 
 	
	$("#frm_busq").submit(function(e) {
		e.preventDefault();
		
		$.ajax({
			type: "POST",
			url: $("#frm_busq").attr("action"),
			data: $("#frm_busq").serialize(),
			beforeSend: f_before, 
			success: function(data, txtStatus, jqSHR) {
				$("#div_instrucciones").html(data);
				$("#buscando").fadeOut("slow");
			}
		})
		
		return false;
	})
	
	
	
	function f_before() {
		var ErrSubmit = "";
		
		$("#div_result").fadeOut("fast");
		$("#result").html("");
		
		if ( $("#uso").length ) {
			if ($("#uso").val()=="") {
				ErrSubmit = "<span id='result_noencontrado'>Es necesario indicar alg&uacute;n uso.</span>";
				ErrSubmit = ErrSubmit + "<p>Por favor, corr&iacute;jalo y vuelva a intentar la b&uacute;squeda.</p></span>";
				
				$("#busq").focus();
			};
		};
		
		if ($("#busq").val()=="") {
			ErrSubmit = "<span id='result_noencontrado'>Debe indicar alg&uacute;n criterio de b&uacute;squeda.</span>";
			ErrSubmit = ErrSubmit + "<p>Por favor, corr&iacute;jalo y vuelva a intentar la b&uacute;squeda.</p></span>";
			
			$("#busq").focus();
		};
		
		if ( ! checkdate($("#FechaI").val()) ) {
			ErrSubmit = "<span id='result_noencontrado'><p>La fecha introducida no tiene un formato v&aacute;lido.</p>";
			ErrSubmit = ErrSubmit + "<p>Por favor, corr&iacute;jala y vuelva a intentar la b&uacute;squeda.</p></span>";
			
			$("#FechaI").focus();
		};
		if ( ! checkdate($("#FechaF").val()) ) {
			ErrSubmit = "<span id='result_noencontrado'><p>La fecha introducida no tiene un formato v&aacute;lido.</p>";
			ErrSubmit = ErrSubmit + "<p>Por favor, corr&iacute;jala y vuelva a intentar la b&uacute;squeda.</p></span>";
			
			$("#FechaF").focus();
		};
		
		
		if (ErrSubmit=="") {
			$("#buscando").show();
			//$("#buscar").focus();
			$("#busq").focus();
			$("#FechaI").datepicker("hide");
			$("#FechaF").datepicker("hide");
			
		} else {
			$("#div_instrucciones").html(ErrSubmit);
			//$("#div_instrucciones").fadeIn("slow");
			//$("#busq").focus();
			return false;
		};
		
	};
	
	
	//validar fecha	
	//https://www.javascriptkit.com/script/script2/validatedate.shtml
	function checkdate(fecha) {
		var validformat=/^\d{2}\/\d{2}\/\d{4}$/ //Basic check for format validity
		var returnval=false
		
		if (validformat.test(fecha)) {
			var dayfield=fecha.split("/")[0]
			var monthfield=fecha.split("/")[1]
			var yearfield=fecha.split("/")[2]
			var dayobj = new Date(yearfield, monthfield-1, dayfield)
			
			if ((dayobj.getMonth()+1!=monthfield)||(dayobj.getDate()!=dayfield)||(dayobj.getFullYear()!=yearfield)) {
				//console.log("Invalid Day, Month, or Year range detected. Please correct and submit again.")
			} else {
				returnval=true
			}
			
		} else {
			//console.log("Invalid Date Format. Please correct and submit again.")
		}
		//if (returnval==false) $(input).focus()
		return returnval
	}

	if ( $("#uso").length ) {
		if ($("#uso").val()!="" && $("#busq").val()!="") { $("#frm_busq").submit() }
	} else {
		if ($("#busq").val()!="") { $("#frm_busq").submit() }
	} 
});


