<!--#include virtual="/articulos/titulos/libb1.asp" -->

<%
on error resume next
contarNoticias = 0
contarWeb = 0
contarEstudios = 0
contarDemandas = 0
contarSubastas = 0

supera_limite = false

if request.Cookies("dev")("request")<>"" then %>
    <div class="dev peq"> 
        Form: &nbsp; <% 
        for each elto in request.Form 
            if request.Form(elto)<>"" then 
                %>[<b><%= elto %></b> = <%= request.Form(elto) %>]&nbsp;<% 
            end if 
        next %>
    </div>
<% end if

swParar = false


array_texto=split(pRS("PALABRAS_CLAVES"),"#")
'response.write "--------------" + pRS("PALABRAS_CLAVES")
texto_clave=""
for each palabra in array_texto
	texto_clave=texto_clave & palabra & " "
next
f_desde=Date-11000
f_hasta=Date
swMostrarListado=true
busqueda=texto_clave


set resultado = Server.CreateObject("ADODB.Recordset")

dim que_tipo_articulos
que_tipo_articulos="actualidad"

select case que_tipo_articulos

case "actualidad"
	sql = "SELECT COUNT(*) AS cont, TIPO_NOTICIA FROM w_noticias WHERE "
	sql = sql & calcularSQLWB1("NW")
	sql = sql & " GROUP BY TIPO_NOTICIA  " 
case "estudios"
	sql = "SELECT COUNT(*) AS cont, TIPO_NOTICIA FROM w_noticias WHERE "
	sql = sql & calcularSQLWB1("E")
	sql = sql & " GROUP BY TIPO_NOTICIA  "	
case "demandas"
	sql = "SELECT COUNT(*) AS cont, TIPO_NOTICIA FROM w_noticias WHERE "
	sql = sql & calcularSQLWB1("B")
	sql = sql & " GROUP BY TIPO_NOTICIA  "	
	
case "subastas"
	sql = "SELECT COUNT(*) AS cont FROM C_Concursos_Detalle WHERE ("
	sql = sql & calcularSQLWB1_subastas()
	sql = sql & ")  "
	
case else
	response.End()
end select

'test_inyeccion_sql sql

resultado.open sql, session("connPW")

select case que_tipo_articulos
case "actualidad", "estudios", "demandas"
	do while not resultado.eof
		select case resultado("TIPO_NOTICIA")
		case "N"
			contarNoticias = resultado("cont")
		case "W"
			contarWeb = resultado("cont")
		case "E"
			contarEstudios = resultado("cont")
		case "B"
			contarDemandas = resultado("cont")
		end select
		resultado.movenext
	loop
	
case "subastas"
	contarSubastas = resultado("cont")
	
end select

%>
<div class="alert azul" style="width:100%;">
<h2>Art&iacute;culos relacionados:</h2><hr>
<%

swMostrarTitulos = false

select case que_tipo_articulos
case "actualidad"
	contar = contarNoticias + contarWeb
	limite = application("limite_actualidad")
	
case "estudios"
	contar = contarEstudios
	limite = application("limite_estudios")
	
case "demandas"
	contar = contarDemandas
	limite = application("limite_demandas")
	
case "subastas"
	contar = contarSubastas
	limite = application("limite_subastas")	
	
end select

if contar>limite then supera_limite=true

if contar=0 then %>
	<div class="noencontrados">
        <br />
        <p>* No se ha encontrado ning&uacute;n art&iacute;culo relacionado.</p>
        <span id="result_noencontrado" class="result_noencontrado"><p>Por favor, depure los criterios de b&uacute;squeda.</p></span>
    </div>
<% else 
	swMostrarTitulos = true %>
    <div class="encontrados">
        <ul>
        <% select case que_tipo_articulos
        case "actualidad" %>
            <li><p><span class="icon-bullhorn"></span> Noticias: <%= contarNoticias %></p></li>
            <li><p><span class="icon-bullhorn"></span> Web ha o&iacute;do...: <%= contarWeb %></p></li>
        <% case "estudios" %>
            <li><p><span class="icon-bullhorn"></span> Estudios de Mercado: <%= contarEstudios %></p></li>
        <% case "demandas" %>
            <li><p><span class="icon-bullhorn"></span> Demandas: <%= contarDemandas %></p></li>
        
        <% case "subastas" %>
            <li><p><span class="icon-bullhorn"></span> Subastas/Concursos: <%= contarSubastas %></p></li>
        <% end select %>
        </ul>
	</div>
<% end if 

if request.Cookies("dev")("sql")<>"" then %>
	<div class="dev mini"><%= sql %></div>
<% end if

'if contarNoticias>application("limite_actualidad") and contarWeb>application("limite_actualidad") then 
if supera_limite then 
	swMostrarTitulos = false %>
    <div class="noencontrados">
        <br />
        <p>El l&iacute;mite de art&iacute;culos relacionados para mostrar es de <%= limite %>.</p>
        <span id="result_noencontrado" class="result_noencontrado">Por favor, depure los criterios de b&uacute;squeda.</span>
	</div>
<% end if 

resultado.close
set resultado = nothing
%>
</div>
<% if swMostrarTitulos then %>
<script type="text/javascript">
$(document).ready( function(){
	$.ajax({
		type: "POST",
		url: "/articulos/titulos/listadob1.asp",
		data: $('#frm_busq').serialize(),
		success: function(data, status, xhr){
			$("#result").html(data);
			$("#div_result").fadeIn("slow");
		},
		error: function(xhr, status, err) {
			alert(status + ": " + err);
		}
	});
	//return false;
	$.scrollTo('#div_instrucciones', 800);
});
</script>
<% end if %>
