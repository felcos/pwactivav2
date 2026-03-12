<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001" %>
<% 
Response.Buffer = False
%>
<!--#include virtual="/inc/js.asp" -->
<!--#include virtual="/dev/inc_funciones.asp" -->
<script type="text/javascript" src="/lib/ua-parser/ua-parser.min.js"></script>
<link href="/css/fonts/font-awesome.css" rel="stylesheet" type="text/css"/>
<style style="text/css">
  	table {
		width:100%; 
		border-collapse:collapse; 
	}
	table td { 
		/* padding:7px; */
		border:#4e95f4 1px solid;
	}
	/* Define the default color for all the table rows */
	table tr {
		background: #fff;
	}
	/* Define the hover highlight color for the table row */
    table tr:hover {
          background-color: #ffff99;
    }
	
	table tr.deleted {
		background: #CCC;
	}
	/* Define the hover highlight color for the table row */
    table tr.deleted:hover {
          background-color: #ffff99;
    }
	
	.mini {
		font-size:12px;
	}
	.peq {
		font-size:13px;
	}
	.med {
		font-size:14px;
	}
	.dra {
		text-align:right;
	}
	.calc {
		color:#600;
	}
	
	.fa {
		padding-left:6px;
		padding-right:6px;
	}
	
	.fa-mac:before, .fa-ios:before {
		content: "\f179";
	}
	.fa-ie:before {
		content: "\f26b";
	}
</style>
<script>
	var nn_ver;
</script>
<% 
server.ScriptTimeout=300

Set rs = Server.CreateObject("ADODB.Recordset")

'FechaI = request("FechaI")
'if FechaI="" then FechaI="01/09/2015"
'FechaF = DateAdd("d", 1, FechaI)

FechaF = DateAdd("d", 1, date)
FechaI = DateAdd("m", -1, FechaF)

'select case request("ver")
'case "conlicencia"
	sql = "cookie_lid IS NOT NULL"
'case "sinlicencia"
'	sql = "cookie_lid IS NULL"
'case else
'	sql = ""
'end select

'sql = sql & " AND http_mozilla='Mozilla/4.0'"
sql = sql & " AND http_mozilla<>''"
'sql = sql & " AND http_ip NOT IN ('192.168.1.101', '192.168.1.102')"

if sql<>"" then sql = " AND (" & sql & ")"

sql = "session_start>='" & FechaI & "' AND session_start<'" & FechaF & "'" & sql

sql = "SELECT * FROM reg_accesos WHERE (" & sql & ")"	' ORDER BY session_start DESC"
' TOP(1000)
'test_inyeccion_sql sql

rs.Open sql, session("connPWAcesos")

if request.Cookies("dev")("sql")<>"" then
	%><p class="peq"><%= sql %></p><%
end if
%>
<span id="nn_ver">0</span>
<hr />
<table width="100%" class="reg" id="tblreg" cellspacing="0">
  <thead>
  <tr>
    <th style="width:30px;">nn</th>
    <th style="width:75px;">fecha</th>
    <th style="width:55px;">hora</th>
    
    <th style="width:55px;">a.c.</th>
    
    <th style="width:60px;">session_id</th>
    
    <th style="width:100px; text-align:left;">cliente</th>
    <% if 1=2 then %>
    <th style="width:250px; text-align:left;">licencia</th>
    <% end if %>
    
    <th style="text-align:left; width:10px;">IP</th>
    
    <th style="text-align:left; width:100px;">mozilla</th>
    
    <th style="text-align:left; width:100px;">SO</th>
    <th style="text-align:left; width:100px;">js_</th>
    
    <th style="text-align:left; width:100px;">navegador</th>
    <th style="text-align:left; width:100px;">js_</th>
    
    <th style="text-align:left; width:100px;">js_engine</th>
    <th style="text-align:left; width:100px;">js_device</th>
    <th style="text-align:left; width:100px;">js_model</th>
    
    <th style="text-align:left; width:30px;"></th>
  </tr>
  </thead>
  <tbody>
<%
	nn = 0
	do while not rs.eof 
		nn = nn+1
		
		hora = rs("session_start")
		fecha = left(hora, instr(hora, " "))
		hora = mid(hora, instr(hora, " ")+1, len(hora))
		
		login = rs("session_login")
		if login<>"" then
			login = mid(login, instr(login, " ")+1, len(login))
		end if
		
		url = ""	'rs("info")
		
		'links
		link_reg_pags = "/admin/accesos/datos/session.asp?session_id=" & rs("session_id")
		link_cliente = "/admin/accesos/cliente/?uid=" & rs("cookie_uid") & "&u=" & rs("cookie_u")
		link_licencia =  "/admin/accesos/cliente/?uid=" & rs("cookie_uid") & "&u=" & rs("cookie_u") & "&lid=" & rs("cookie_lid") & "&l=" & rs("cookie_l")
		%>
<tr id="tr_<%= rs("session_id") %>" style="display:none;">	<!--   -->
	<td class="dra"><a href="<%= link_reg_pags %>" class="ver_reg_pags" data-id="<%= rs("session_id") %>"><%= nn %></a></td>
    <td class="dra"><a href="<%= link_reg_pags %>" class="ver_reg_pags" data-id="<%= rs("session_id") %>"><%= fecha %></a></td>
    <td class="dra"><a href="<%= link_reg_pags %>" class="ver_reg_pags" data-id="<%= rs("session_id") %>"><%= hora %></a></td>
    <td class="dra"><a href="<%= link_reg_pags %>" class="ver_reg_pags" data-id="<%= rs("session_id") %>"><%= login %></a></td>
    <td class="dra"><a href="<%= link_reg_pags %>" class="ver_reg_pags" data-id="<%= rs("session_id") %>"><%= rs("session_id") %></a></td>
    
	<% if 1=2 then %>
    <td><a href="<%= link_cliente %>" target="_blank"><%= rs("cookie_u") %> <span class="mini"><%= rs("cookie_uid") %></span></a></td>
    <% end if %>
    <td class="peq" nowrap="nowrap"><a href="<%= link_reg_pags %>" target="_blank" class="ver_reg_pags" data-id="<%= rs("session_id") %>"><%= rs("cookie_l") %></a></td>
    
    
    <td class="med"><%= rs("http_ip") %></td>
    <td class="med"><%= rs("http_mozilla") %></td>
    <%
	navegador = "" & rs("http_navegador")
	'if navegador="" then navegador = "<span class='destaca'>" & calcular_http_navegador(rs("http_user_agent")) & "</span>"
	'if navegador="" then navegador = calcular_http_navegador(rs("http_user_agent"))
	
	so = "" & rs("http_so")
	'if so="" then so = "<span class='destaca'>" & calcular_http_so(rs("http_user_agent")) & "</span>"
	%>
    <td id="bd_so_<%= rs("session_id") %>" class="med"><%= so %></td>
    <td id="js_so_<%= rs("session_id") %>" class="med calc"></td>
    <td id="bd_navegador_<%= rs("session_id") %>"><i class="fa fa-<%= navegador %>"></i><%= navegador %></td>
    <td id="js_navegador_<%= rs("session_id") %>" class="med calc"></td>
    
    <td class="med calc" id="js_engine_<%= rs("session_id") %>"></td>
    <td class="med calc" id="js_device_<%= rs("session_id") %>"></td>
    <td class="med calc" id="js_model_<%= rs("session_id") %>"></td>
    
    <td class="med" align="right"> <a href="#" class="ver_detalles" id="<%= rs("session_id") %>">+ info</a></td>
 </tr>
  
<tr id="row<%= rs("session_id") %>" style="display:none; background-color:#EEEEEE;">
	<td colspan="17" id="session_<%= rs("session_id") %>"></td>
</tr>
<tr id="rowinfo<%= rs("session_id") %>" style="display:none; background-color:#EEEEEE;">
	<td colspan="17" id="info_<%= rs("session_id") %>" class="peq">
<p><%= rs("http_user_agent") %></p>
<br />
    </td>
</tr>
	<script type="text/javascript">
    //parser.setUA("< %= rs("http_user_agent") %>");
	var result = UAParser("<%= rs("http_user_agent") %>")
	
	var js_so = "";
	if (result.os.name) {
		js_so = js_so + result.os.name.replace("Windows", "win") + ' ' + result.os.version;
		
		if (result.cpu.architecture) {js_so = js_so + ' ' + result.cpu.architecture.replace("amd64", "64") }
		$(document.getElementById("js_so_<%= rs("session_id") %>")).html(js_so);	//.toLowerCase();
		$(document.getElementById("js_so_<%= rs("session_id") %>")).prepend("<i class='fa fa-" + result.os.name.toLowerCase() + "'></i>");
		
	};
	
	if (result.browser.name) {
		$(document.getElementById("js_navegador_<%= rs("session_id") %>")).html((result.browser.name + ' ' + result.browser.version).toLowerCase());
		//$(document.getElementById("js_navegador_<%= rs("session_id") %>")).prepend("<i class='fa fa-" + result.browser.name.toLowerCase() + "'></i>");
	};
	
	if (result.engine.name) {
		document.getElementById("js_engine_<%= rs("session_id") %>").innerHTML = (result.engine.name + ' ' + result.engine.version).toLowerCase();
	};
	
	if (result.device.type) {
		document.getElementById("js_device_<%= rs("session_id") %>").innerHTML = result.device.type;
	};
	
	var js_device = "";	
	
	if (result.device.type) {
		js_device = js_device + result.device.vendor;
		js_device = js_device + ' ' + result.device.model;
		
		document.getElementById("js_model_<%= rs("session_id") %>").innerHTML = js_device;
	};
	
	var fila = document.getElementById("tr_<%= rs("session_id") %>");
	
	var bd_so = $(document.getElementById("bd_so_<%= rs("session_id") %>")).html()
	
	
	
	console.log(result.device.type)
	//if ( bd_so == js_so ) {		//	no coincide el SO
	if ( result.device.type) {		//	móvil, tablet...
		$("#nn_ver").html( parseInt($("#nn_ver").html())+1 );
		$(fila).show();
		
	} else {
		//$(fila).show();
		$(fila).remove()
	};
	
	/*	
	console.log(
		'HIDE [< %= rs("session_id") %>] ',
		bd_so,
		' // ',
		js_so,
		' // ' + (bd_so==js_so)
	);
	*/
	</script>
	<% rs.movenext
loop
%>
</tbody>
</table>
<p>Total: <span id="ver">0</span> / <%= nn %></p>
<%
rs.close
set rs=nothing
%>
<script language="javascript">	
$(document).ready(function(){
	$('#contador_accesos').html('(<%= nn %>)');
	
	$('#ver').html( $('#ver_nn').html() );
	
	$('.ver_detalles').click(function (e) {
		console.log("ver_detalles");
		var id=this.getAttribute("id");
		
		var fila=document.getElementById('rowinfo'+id);
		
		if (fila.style.display=='') {
			fila.style.display='none';
		} else {
			fila.style.display='';
		};
		
		/*
		var ncelda='#session_'+id;
		var celda = $(ncelda);
		
		if (celda.html()=='') {
			$.ajax({
				url: this.getAttribute("href"),
				data: '',
				beforeSend: function() {
					celda.html('<img src="/img/camera-loader.gif">');
				},
				success: function(data, status, xhr){
					celda.html(data);
				},
				error: function(xhr, status, err) {}
			});
		}
		*/
		return false;
	})
	$('.ver_reg_pags').click(function (e) {
		
		
		e.preventDefault();
		var id=$(this).data("id");
		
		var fila=document.getElementById('row'+id);
		
		if (fila.style.display=='') {
			fila.style.display='none';
		} else {
			fila.style.display='';
		};
		
		var ncelda='#session_'+id;
		var celda = $(ncelda);
		
		// celda.html(this.getAttribute("href"))
		
		if (celda.html()=='') {
			$.ajax({
				url: this.getAttribute("href"),
				data: '',
				beforeSend: function() {
					celda.html('<img src="/img/camera-loader.gif">');
				},
				success: function(data, status, xhr){
					celda.html(data);
				},
				error: function(xhr, status, err) {}
			});
		}
		
		//console.log($(celda).html());
		return false;
	})
})

function calcula(pId) {
	$("#js_navegador_" + pId).html("xxxx")
}
</script>
