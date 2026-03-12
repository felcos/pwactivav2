<% 
ver_grafica = true
ver_tabla = true
ver_data = false

%>
<div id="graf_titulo"></div>
<div id="graf"></div>
<p>&nbsp;</p>
<div id="datos"><% call Articulos() %></div>

<% 'if 1=2 then %>
<script type="text/javascript">
$(document).ready(function(){
	$('#graf_titulo').html('Art&iacute;culos leidos');
	
	var datos = [ [<% call Articulos() %>] ]
	
	graf = $.jqplot('graf', datos, {
		axes:{
			xaxis:{
				renderer:$.jqplot.DateAxisRenderer,
				tickOptions:{
					formatString:'%b&nbsp;%Y'
				} 
			},
			yaxis:{
				tickOptions:{
					//formatString:'%.0f'
					//formatString: formateaNumero()
				}
			}
		},
		highlighter: {
			show: true,
			sizeAdjust: 7.5
		},
		cursor: {
			show: false
		}
	});
	
});
</script>
<% 'end if %>
<% sub Articulos()	
	Set rs = Server.CreateObject("ADODB.Recordset")
	sql = "SELECT DATEPART(yy, fecha) AS yy, DATEPART(mm, fecha) AS mm, COUNT(id) AS articulos FROM reg_articulos "
	sql = sql & "WHERE fecha>='01/01/2010' "
	sql = sql & "GROUP BY DATEPART(yy, fecha), DATEPART(mm, fecha) "
	sql = sql & "ORDER BY  DATEPART(yy, fecha), DATEPART(mm, fecha)"
	
	rs.Open sql, session("connPWAcesos")
	
	'primero = true
	
	do while not rs.eof
		'if primero then 
		'	primero=false
		'else
			
		'end if
		if mm<10 then 
			mm = "0" & rs("mm")
		else
			mm = rs("mm")
		end if
		'mm = monthname(rs("mm"))
		yy = rs("yy")
		'yy = mid(cstr(yy), 3, 2)
		
		%>['<%= yy %>-<%= mm %>-01', <%= rs("articulos") %>], <%
		rs.movenext
	loop
	
	rs.close
	set rs=nothing
end sub %>
