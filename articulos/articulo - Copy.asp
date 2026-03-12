<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>
<%
'No Caché
response.addHeader "pragma", "no-cache"
response.CacheControl = "Private"
response.expires=0

'idMapa = 0
%>
<!--#include virtual="/inc/reg_accesos.asp" -->
<!--#include virtual="/lib/funciones.asp" -->
<!--#include virtual="/articulos/sin_acceso.asp" -->





<%
'response.Write(request.QueryString)
'response.End()

tiene_mapa = false

dim listNav
dim navId
dim navIdAnt
dim navIdSig
dim navMax

listNav=split(session("ArticulosSeleccionados"), ",")
if request.QueryString("nav")="" then
	navId=0
else
	navId=request.QueryString("nav")
	'if navId<0 then navId=
end if
	'if not(isnumeric(navId)) then navId=0
navArticulo=listNav(navId)

art_tipo = left(navArticulo,3)
art_id = mid(navArticulo, 5, len(navArticulo))

secc = request.Form("seccion")
orig = request.Form("origen")


if request.Cookies("dev")<>"" then %>
    <div class="dev">
        <li><strong>origen: </strong> <%= origen %>
        <li>[<%= art_tipo %>&nbsp;<%= art_id %>] // [session.origen: <%= session("origen") %>] // [request.origen: <%= request("origen") %>]</li>
    </div>
<% end if

select case art_tipo	
case "not"
	%><!--#include virtual="/articulos/contenido/noticia.asp" --><%	
case "rum"
	%><!--#include virtual="/articulos/contenido/rumor.asp" --><%
case "est"	
	%><!--#include virtual="/articulos/contenido/estudio.asp" --><%
case "ope"
	%><!--#include virtual="/articulos/contenido/operacion.asp" --><%
case "dem"
	%><!--#include virtual="/articulos/contenido/demanda.asp" --><%
case "sub"
	%><!--#include virtual="/articulos/contenido/subasta.asp" --><%
case "ven"
	%><!--#include virtual="/articulos/contenido/vencimientos.asp" --><%
case "ofe"
	%><!-- include virtual="/articulos/contenido/oferta.asp" --><%
case "t4a"
	%><!--#include virtual="/articulos/contenido/t4a.asp" --><%
case "dis"
	%><!--#include virtual="/articulos/contenido/disponibilidad.asp" --><%
end select


function AlcanzadoLimitesOperaciones(byRef pRS)	
	AlcanzadoLimitesOperaciones = false
	
	if instr(session("pw_ws").ArticulosLeidos(), "#ope" & pRS("ID") & "#")>0 then exit function
	
	seccion = pRS("seccion")
	
	dim idxOper
	dim idxSecc
	
	select case pRS("id_tipo_operacion")
	case 1, 3	'inversion / oc. propia
		idxOper = 0
		txtOper = "inversion"
	case 2, 4	'alquiler / traspaso
		idxOper = 1
		txtOper = "alquiler"
	end select
	
	
	if instr(seccion, "OFICINAS") then 
		if instr(session("pw_ws").Bloqueos, "oficinas " & txtOper) then AlcanzadoLimitesOperaciones=true
	end if
	
	if instr(seccion, "LOCALES") then 
		if instr(session("pw_ws").Bloqueos, "locales " & txtOper) then AlcanzadoLimitesOperaciones=true
	end if
	
	if instr(seccion, "HOTELES") then 
		if instr(session("pw_ws").Bloqueos, "hoteles " & txtOper) then AlcanzadoLimitesOperaciones=true
	end if
	
	if instr(seccion, "NAVES") then 
		if instr(session("pw_ws").Bloqueos, "naves " & txtOper) then AlcanzadoLimitesOperaciones=true
	end if
	
end function

sub Articulo	
	dim resultado
	
	IF 1=2 THEN 
		listNav=split(session("ArticulosSeleccionados"), ",")
		navMax=ubound(listNav)+1
		
		navId=request.QueryString("nav")
		
		navIdSig=navId+1
		if navIdSig>=navMax then
			navIdSig=navIdSig-navMax
		end if
		
		navIdAnt=navId-1
		if navIdAnt<0 then
			navIdAnt=navIdAnt+navMax
		end if
	END IF
	
	swMostrarDetalles = false
	select case art_tipo	
	case "not"	
		swMostrarDetalles = true
		sql = "SELECT * FROM C_NOTICIAS_INMOBILIARIAS WHERE web_es=1 AND ID = " & art_id
		set resultado = session("connPW").execute(sql) 
		if resultado.eof and resultado.bof then
			call ArticuloInexistente
		else
			call VerNoticia(resultado)
		end if
		resultado.close
		
	case "rum"	
		sql = "SELECT * FROM C_NOTICIAS_INMOBILIARIAS WHERE web_es=1 AND  ID = " & art_id
		Set resultado = session("connPW").execute(sql) 
		if resultado.eof and resultado.bof then
			call ArticuloInexistente
		else
			call VerRumor(resultado)
		end if
		resultado.close

        case "t4a"	
		sql = "SELECT * FROM View_Time4Change WHERE id = " & art_id
		
		Set resultado = session("connPW").execute(sql) 
		if resultado.eof and resultado.bof then
			call ArticuloInexistente
		else
			VerT4ac(resultado)
		end if
		resultado.close	
		
	case "est"	
		sql = "SELECT * FROM C_NOTICIAS_INMOBILIARIAS WHERE web_es=1 AND  ID = " & art_id
		Set resultado = session("connPW").execute(sql) 
		if resultado.eof and resultado.bof then
			call ArticuloInexistente
		else
			call VerEstudio(resultado)
		end if
		resultado.close
		
	case "ope"	
		tiene_mapa = true
		
		sql = "SELECT * FROM C_OPERACIONES WHERE web_es=1 AND ID=" & art_id
		Set resultado = session("connPW").execute(sql)
		
		if resultado.eof and resultado.bof then
			call ArticuloInexistente
		else
			'comprobar permisos
			swMostrarDetalles = false
			
			if session("IniCliente")=0 then 
				if session("pw_ws").accesoOperaciones then
					swMostrarDetalles=true
				elseif session("pw_ws").accesoOperacionesHoy then
					if abs(datediff("d", resultado("FECHA_ACTUALIZACION"), date))<=7 then
						swMostrarDetalles=true
					end if
				end if
				
				if not(session("pw_ws").accesoInternacional) then
					if resultado("id_pais")<>1 then
						swMostrarDetalles=false
					end if
				end if
				
				'select case pag_origen
				select case session("origen")
				case "invers"
					if session("pw_ws").accesoInversores then swMostrarDetalles=true
				case "infinm"
					if session("pw_ws").accesoInfoEdificio then swMostrarDetalles=true
				case "infemp"
					if session("pw_ws").accesoInfoEmpresa then swMostrarDetalles=true
				end select
				
				select case session("secc")
				case "empr"
					if session("pw_ws").accesoInfoEmpresa then swMostrarDetalles=true
				case "edif"
					if session("pw_ws").accesoInfoEdificio then swMostrarDetalles=true
				case "prop"
					if session("pw_ws").accesoInfoPropietario then swMostrarDetalles=true
				end select
			end if
			
			'Límite diario para operaciones
			if swMostrarDetalles then
				swOperacionesLimitadas = AlcanzadoLimitesOperaciones(resultado)
				if swOperacionesLimitadas then swMostrarDetalles=false
			end if
			
			if swMostrarDetalles then 
				call OperacionesTablaEntera(resultado)
			else
				
				if request.Cookies("licencia")="" then
					call NoCliente
				else
					if session("IniCliente")=0 then	'es cliente activo
						if swOperacionesLimitadas then 
							call OperacionesLimite(resultado) 
							
						elseif not(session("pw_ws").accesoOperacionesHoy) then
							call SinAcceso("Deal Analysis")
							
						elseif abs(datediff("d", resultado("FECHA_ACTUALIZACION"), date))>7 and not(session("pw_ws").accesoOperaciones) then 
							call AccesoSoloHoy("Deal Analysis")
							
						elseif resultado("id_pais")<>1 and not(session("pw_ws").accesoInternacional) then
							call AccesoSoloNacional("Deal Analysis")
							
						end if
						
					else
						call SinAcceso("Deal Analysis")
					end if
				
				end if
			
			end if
			
		end if
		resultado.close
		
		
	case "dem"	
		sql = "SELECT * FROM C_NOTICIAS_INMOBILIARIAS WHERE web_es=1 AND ID = " & art_id
		Set resultado = session("connPW").execute(sql) 
		if resultado.eof and resultado.bof then
			call ArticuloInexistente
		else
			call VerDemanda(resultado)
		end if
		resultado.close
		
	case "sub"	
		sql = "SELECT * FROM C_Concursos WHERE web_es=1 AND  Id = " & art_id
		
		Set resultado = session("connPW").execute(sql) 
		if resultado.eof and resultado.bof then
			call ArticuloInexistente
		else
			VerSubasta(resultado)
		end if
		resultado.close	
		
	case "ven"	
		tiene_mapa = true
		
		sql = "SELECT * FROM C_OPERACIONES WHERE web_es=1 AND Id = " & art_id
		
		Set resultado = session("connPW").execute(sql) 
		if resultado.eof and resultado.bof then
			call ArticuloInexistente
		else
			if session("pw_ws").accesoVencimientos then
				call Vencimiento(resultado)
			else
				call Vencimientos_SinAcceso
			end if
		end if
		resultado.close	
		
	case "ven_ANT"	
		if session("pw_ws").accesoVencimientos then
			listaVencimientos=""
			tmpLista=split(session("lista_vencimientos"),",")
			mm=ubound(tmpLista)
			
			for ii=0 to mm
				if listaVencimientos<>"" then listaVencimientos=listaVencimientos & ","
				listaVencimientos=listaVencimientos & mid(tmpLista(ii), instr(tmpLista(ii), "=")+1, len(tmpLista(ii)))
			next
			sql=" SELECT * FROM C_OPERACIONES WHERE ID IN (" & listaVencimientos & ")"
			Set resultado = session("connPW").Execute(SQL)
			
			call Vencimiento(resultado)
		else
			call Vencimientos_SinAcceso
		end if
		
	case "ofe"	
		sql = "SELECT * FROM easy_todo WHERE web_es=1 AND Id = " & art_id
		
		Set resultado = session("connPW").execute(sql) 
		if resultado.eof and resultado.bof then
			call ArticuloInexistente
		else
			VerOferta(resultado)
		end if
		resultado.close	


	case "dis"	
		sql = "SELECT * FROM c_inmuebles WHERE id=" & art_id
		
		Set resultado = session("connPW").execute(sql) 
		if resultado.eof and resultado.bof then
			call ArticuloInexistente
		else
			DisponibilidadTablaEntera(resultado)
		end if
		resultado.close	
		
end select

	set resultado = nothing
end sub 

call Articulo 

%>
<script>
<% if session("IniCliente")>0 then %>
	var frm = jQuery("<form>", {"action": "/articulos/", "method": "post"})
	var inputs;
	
	<% if request.Form<>"" then
		for each elto in request.Form %>
		frm.append(jQuery("<input>", {
			"name": "<%= elto %>",
			"value": "<%= request.Form(elto) %>",
			"type": "hidden"
		}))
		<% next
	elseif request.QueryString<>"" then
		for each elto in request.QueryString %>
		frm.append(jQuery("<input>", {
			"name": "<%= elto %>",
			"value": "<%= request.QueryString(elto) %>",
			"type": "hidden"
		}))
		<% next 
	else 
		response.Redirect("/")
		%>
		alert("sin nada seleccionado");
		return false;
	<% end if %>
	
'	$("#ModalBox").load(
'		"/acceso/password.asp",
'		frm.serialize(),
'		function(recibe, textStatus, xhr) { 
'			$("#ModalBox").modal("show");
'		}
'	);
	
<% end if %>
</script>