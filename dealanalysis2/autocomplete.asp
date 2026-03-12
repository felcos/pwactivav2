<link href="/lib/autocomplete/autocomplete_javier.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="/lib/autocomplete/jquery.autocomplete.js"></script>
<script type="text/javascript">
$().ready(function() {
	function log(event, data, formatted) {$("<li>").html( !data ? "Sin coincidencias!" : "Selected: " + formatted).appendTo("#result");}
	
	function formatItem(row) {return row[0] + " (<strong>id: " + row[1] + "</strong>)";}
	function formatResult(row) {return row[0].replace(/(<.+?>)/gi, '');}
	
	$("#busqlocalidad").autocomplete("/dealanalysis2/q/localidades_buscar_con_id.asp", {
		width: 260,
		selectFirst: true,
		matchContains: true,
		minChars: 1
	});
	
	$("#busqlocalidad").result(function(event, data, formatted) {
		if (data) {
			//console.log(event);
			document.frm_deal.localidad.value=data[1];
			document.frm_deal.provincia.value="";
			EstadoForm();
			comprobarForm();
		}
	});

});
</script>
