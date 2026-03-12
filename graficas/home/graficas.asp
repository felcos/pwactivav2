<div id="graf_titulo"></div>
<div id="graf_subtitulo"></div>
<div id="graf"></div>
<div id="graf_fuente"></div>
<%
num_grafs = 8		'numero de graficas
espera = 30			'segundos del timer

if request.QueryString("g")="" then 
	randomize
	actual = int(num_grafs*Rnd + 1)
else
	actual = int(request.QueryString("g"))
end if

anterior = actual-1
if anterior=0 then anterior=num_grafs

siguiente = actual+1
if siguiente=(num_grafs+1) then siguiente=1

if actual<10 then
	actual = "0" & actual
end if
%>
<script src="/graficas/home/g<%= actual %>.js"></script>
<script class="code" type="text/javascript">
$(document).ready(function(){
	//console.log("cargada grafica #< %= actual %>")
	$('#graf_num').html('<%= actual %>');
	
	//$('#graf').unbind();
	$('.graf_next').unbind();
	$('.graf_prev').unbind();
	
	//$('#graf').bind('jqplotDataClick', function (ev, seriesIndex, pointIndex, data) {
		//$('#info').html('series: '+seriesIndex+', point: '+pointIndex+', data: '+data);
	//});
	
	$('.graf_next').click(function(e) {
		$.ajax({
			url: "/graficas/home/graficas.asp?g=<%= siguiente %>",
			success: function(data, status, xhr) { $("#para_ver").html(data) }
		});
		return false;
	});
	
	$('.graf_prev').click(function(e) {
		$.ajax({
			url: "/graficas/home/graficas.asp?g=<%= anterior %>",
			success: function(data, status, xhr) { $("#para_ver").html(data) }
		});
		return false;
	});
	
	$('.graf_stop').click(function(e) {
		clearTimeout(timerid)
		return false;
	});
});

clearTimeout(timerid);
var timerid = setTimeout(function() { $('.graf_next').click(); }, <%= espera*1000 %>);

</script>