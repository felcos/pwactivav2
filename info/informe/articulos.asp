<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>
<% 
set resultado = Server.CreateObject("ADODB.Recordset")
set rsArt = Server.CreateObject("ADODB.Recordset")
session("connPW").CommandTimeout = 120
%>

<!--#include virtual="/info/inc/calcular_sql.asp" -->

<!-- include virtual="/info/inc/lib_titulos.asp" -->
<!--#include virtual="/articulos/contenido/noticia.asp" -->
<!--#include virtual="/articulos/contenido/rumor.asp" -->
<!--#include virtual="/articulos/contenido/estudio.asp" -->
<!--#include virtual="/articulos/contenido/demanda.asp" -->
<!--#include virtual="/articulos/contenido/operacion.asp" -->
<!--#include virtual="/articulos/contenido/subasta.asp" -->
<!--#include virtual="/articulos/contenido/vencimientos.asp" -->

<% if request.Form("op_alquiler")<>"" then
	strin="ope"
	
	sql="SELECT * FROM C_OPERACIONES WHERE "
	sql = sql & calcular_sqlw("ops_alquiler")
	sql = sql & " ORDER BY seccion, FECHA_ACTUALIZACION DESC"
	
	'test_inyeccion_sql sql
	resultado.Open sql, session("connPW"), 1, 1

	do while not resultado.eof
		call OperacionesTablaEntera(resultado)
		
		resultado.movenext
	loop
	
	resultado.close
	ErrMesage=""
	
	'call operaciones("alquiler") %>
<% end if %>
<% if request.Form("op_inversion")<>"" then %>
	<!--h2 style="color:#0973AE">Operaciones de Inversi&oacute;n</h2-->
	<%
	strin="ope"
	sql="SELECT * FROM C_OPERACIONES WHERE "
	sql = sql & calcular_sqlw("ops_inversion")
	sql = sql & " ORDER BY seccion, FECHA_ACTUALIZACION DESC"
	
	'test_inyeccion_sql sql
	resultado.Open sql, session("connPW"), 1, 1

	do while not resultado.eof
		call OperacionesTablaEntera(resultado)
		
		resultado.movenext
	loop
	
	resultado.close
	ErrMesage=""
	
	'call operaciones("inversion") %>
<% end if %>
<% if request.Form("noticias")<>"" then %>
	<!--h2 style="color:#0973AE">Noticias</h2 -->
	<%
	strin="not"
	titulo="NOTICIAS"
	color="roj"
	bloque="notici"
	
	sql = "SELECT * FROM C_NOTICIAS_INMOBILIARIAS"
	sql = sql & " WHERE " & calcular_sqlw("noticias")
	sql = sql & " ORDER BY TIPOSECCION, FECHA_ACTUALIZACION DESC"
		
	server.ScriptTimeout=400
	'test_inyeccion_sql sql
	resultado.Open sql, session("connPW"), 1, 1
	
	do while not resultado.eof
		
		call VerNoticia(resultado)
		
		resultado.movenext
	loop
	
	resultado.close
	ErrMesage=""
	'call noticias %>
<% end if %>
<% if request.Form("rumores")<>"" then %>
	<!--h2 style="color:#0973AE">Rumores</h2-->
	<%
	strin="rum"
	titulo="RUMORES"
	color="gri"
	bloque="rumore"
	sql = "SELECT * FROM C_NOTICIAS_INMOBILIARIAS"
	sql = sql & " WHERE " & calcular_sqlw("rumores")
	sql = sql & " ORDER BY TIPOSECCION, FECHA_ACTUALIZACION DESC"
	
	'test_inyeccion_sql sql
	resultado.Open sql,session("connPW"), 1, 1
	do while not resultado.eof
		
		call VerRumor(resultado)
		
		resultado.movenext
	loop
	
	'if resultado.eof and resultado.bof then
	'	R=0
	'else
	'	resultado.movelast
	'	R=resultado.recordcount
	'	resultado.movefirst
	'	call TablaResultados("rum")
	'end if
	
	resultado.close
	ErrMesage=""
	'call cotilleos %>
<% end if %>
<% if request.Form("estudios")<>"" then %>
	<!--h2 style="color:#0973AE">Estudios</h2-->
	<%
	strin="est"
	titulo="ESTUDIOS"
	color="mor"
	bloque="estudi"
	
	sql = "SELECT * FROM C_NOTICIAS_INMOBILIARIAS"
	sql = sql & " WHERE " & calcular_sqlw("estudios")
	sql = sql & " ORDER BY TIPOSECCION, FECHA_ACTUALIZACION DESC"
	
	'test_inyeccion_sql sql
	resultado.Open sql,session("connPW"), 1, 1
	
	do while not resultado.eof
		
		call VerEstudio(resultado)
		
		resultado.movenext
	loop
	
	resultado.close
	ErrMesage=""
	'call estudios %>
<% end if %>

<div style="clear:both;"></div>

<% if request.Cookies("dev")("request")<>"" then %>
<div style="background:#FFFFCC; font-size:11px; margin:2px;border:#000000 1px solid;">
	form: &nbsp; <% for each elto in request.Form
		if request.Form(elto)<>"" then
			%><%= elto %>:[<%= request.Form(elto) %>]&nbsp;<%
		end if
	next %>
</div>
<% end if 


set resultado = nothing
set rsArt = nothing
%>
<script type="text/javascript">
$(document).ready(function () {
	
	$(".articulos").click(function(e) {
		//e.preventDefault();
		var href = $(this).attr("href");
		href = href.substr( href.indexOf("?")+1, href.length);
		
		if ( getCookie("condiciones")=="" ) {
			$("#ModalBox").load(
				"/acceso/password.asp",
				href,
				function(recibe, textStatus, xhr) { $("#ModalBox").modal("show"); }
			);
			return false;
			
		} else {
			/*
			var inputs = href.split("&")
			var frm = jQuery("<form>", {"action": "/articulos/", "method": "post"})
			
			inputs.forEach(function (elem, index, array) {
				var datos = elem.split("=")
				
				frm.append(jQuery("<input>", {
					"name": datos[0],
					"value": datos[1],
					"type": "hidden"
				}))
			});
			
			frm.submit();
			*/
		}
			
	});
	
	$("#frm_titulos").submit(function(){
		if ($("#frm_titulos input:checkbox:checked").length<=0) {
			//alert("Debe seleccionar algún artículo. \n\nMarque los artículos que quiera leer y vuelva a intentarlo.\n");
			$("#ModalBox").load(
				"/articulos/nada_seleccionado.asp",
				function(recibe, textStatus, xhr) { $("#ModalBox").modal("show"); }
			);
			return false;
		};
		
		if ( getCookie("condiciones")=="" ) {
			$("#ModalBox").load(
				"/acceso/password.asp",
				$("#frm_titulos").serialize(),
				function(recibe, textStatus, xhr) {}
			);
			
			$("#ModalBox").modal("show");
			
			return false;
			
		} else {}
		
	});
	
});

function marcar() {
	if(document.getElementById("check_all").checked==true){
	   for (i=0;i<document.frm_titulos.elements.length;i++) 
		  if(document.frm_titulos.elements[i].type == "checkbox") 
			 document.frm_titulos.elements[i].checked=1; 
   }else{
		for (i=0;i<document.frm_titulos.elements.length;i++) 
		  if(document.frm_titulos.elements[i].type == "checkbox") 
			 document.frm_titulos.elements[i].checked=0
   };
   return false;
}

</script>