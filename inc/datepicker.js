$(document).ready(function(){
	var ant_date;
	
	$("#FechaI, #FechaF").datepicker({
		language: "es",
		format: "dd/mm/yyyy",
		autoclose: true
	})
	.on("show", function(e) {
		ant_date=this.value;
		//console.log(ant_date);
    })
	/*
	https://eternicode.github.io/bootstrap-datepicker/
	
	.on("changeDate", function(e) {
		if (this.value!=ant_date) {
			//console.log(this.value);
			//$("#f_desde").val(this.value)
			//$("#frm_busq").submit();
		}
    })
	*/
});