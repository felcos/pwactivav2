
    <script type="text/javascript">
        function MM_swapImgRestore() { //v3.0
            var i, x, a = document.MM_sr; for (i = 0; a && i < a.length && (x = a[i]) && x.oSrc; i++) x.src = x.oSrc;
        }
        function MM_preloadImages() { //v3.0
            var d = document; if (d.images) {
                if (!d.MM_p) d.MM_p = new Array();
                var i, j = d.MM_p.length, a = MM_preloadImages.arguments; for (i = 0; i < a.length; i++)
                    if (a[i].indexOf("#") != 0) { d.MM_p[j] = new Image; d.MM_p[j++].src = a[i]; }
            }
        }

        function MM_findObj(n, d) { //v4.01
            var p, i, x; if (!d) d = document; if ((p = n.indexOf("?")) > 0 && parent.frames.length) {
                d = parent.frames[n.substring(p + 1)].document; n = n.substring(0, p);
            }
            if (!(x = d[n]) && d.all) x = d.all[n]; for (i = 0; !x && i < d.forms.length; i++) x = d.forms[i][n];
            for (i = 0; !x && d.layers && i < d.layers.length; i++) x = MM_findObj(n, d.layers[i].document);
            if (!x && d.getElementById) x = d.getElementById(n); return x;
        }

        function MM_swapImage() { //v3.0
            var i, j = 0, x, a = MM_swapImage.arguments; document.MM_sr = new Array; for (i = 0; i < (a.length - 2); i += 3)
                if ((x = MM_findObj(a[i])) != null) { document.MM_sr[j++] = x; if (!x.oSrc) x.oSrc = x.src; x.src = a[i + 2]; }
        }



        function ObtenerComentarios() {

            $.getJSON('../../DataEntry/Comentarios/GetComentarios/' + <%=art_id %>, function (data) {
                $.each(data, function (index, item) {
                    var table = document.getElementById("myTable");
                    //var row = table.deleteRow(0);
                    var values = item.split(".- ");
                    //Select(x => x.Id + ".- " + x.Fecha + ".- " + x.Nombre + ".- " + x.Comentario).Take(50).ToList();


                    var row1 = table.insertRow(1);

                    var cell11 = row1.insertCell(0);
                    var Id = parseFloat(values[0]);
                    cell11.innerHTML = values[3] <% if (request.Cookies("licencia")("u")="PW") then %> + "<div align='right' id='BtnBorrar" + Id + "'><button type='button' style='color:#b4cdd0;text-size-adjust:50%;'  onclick='BorrarComentario(" + Id + ")'>borrar</button></div>"<% end if %> ;


                    var cell12 = row1.insertCell(0);
                    cell12.innerHTML = values[1] + ' ' + values[2] + ' ha dicho:';

                });

            });
        }

        function EscribirComentarios() {
            var xId_Noticia = <%=art_id %>;
            var texto = $('#xComentario').val();
            texto = texto.replace(String.fromCharCode(13), "<br>");
	    var TipoC = 'R';
            var dataToLog = { 'Id': xId_Noticia, 'Nombre': $('#xNombre_Usuario').val(), 'Comentario': texto, 'TipoComentario': TipoC };
            $.ajax({
                type: 'POST',
                url: '../../DataEntry/Comentarios/PutComentarios',

                data: JSON.stringify(dataToLog),

                contentType: 'application/json',
                success: function (data) {
                    $.each(data, function (index, item) {
                        var table = document.getElementById("myTable");
                        var values = item.split(".- ");
                        var row1 = table.insertRow(1);
                        var cell11 = row1.insertCell(0);
                        var Id = parseFloat(values[0]);
                     
                    cell11.innerHTML = values[3] + "<div align='right' id='BtnBorrar" + Id + "'><button type='button' style='color:#b4cdd0;text-size-adjust:50%;'  onclick='BorrarComentario(" + Id + ")'>borrar</button></div>";

                        var cell12 = row1.insertCell(0);
                        cell12.innerHTML = values[1] + ' ' + values[2] + ' ha dicho:';
                    })
                    $('#xNombre_Usuario').val('Anonimo');
                    $('#xComentario').val('');

                },
                error: function (error) {
                    console.log(error.responseText);
                    //$('#Put_Comentario').val('Save');
                }
            });




        }


        function DarLike() {
            var xId_Noticia = <%=art_id %>;
	    var TipoC = 'R';
            var dataToLog = { 'Id': xId_Noticia, 'TipoComentario': TipoC  };
            $.ajax({
                type: 'POST',
                url: '../../DataEntry/Comentarios/DarLike',

                data: JSON.stringify(dataToLog),

                contentType: 'application/json',
                success: function (data) {
                    $.each(data, function (index, item) {

                        var values = item.split(".- ");
                        if (values[0] == 0 ) {
                            document.getElementById("xNroLikes").innerHTML = values[1] + "<img src='https://www.propertyweb.eu/rrss/likeicon.png' width='25px'>";
                        };

                    })


                    document.getElementById("xlike").hidden = true;


                },
                error: function (error) {
                    console.log(error.responseText);
                    //$('#Put_Comentario').val('Save');
                }
            });




        }


        function BorrarComentario(Id) {
           
            $.getJSON('../../DataEntry/Comentarios/BorrarComentario/' + Id, function (data) {
                document.getElementById("BtnBorrar" + Id).innerHTML = " --> Borrado!";
            });
        }

        function VerLike() {
            var xId_Noticia = <%=art_id %>;

            var dataToLog = { 'Id': xId_Noticia  };
            $.ajax({
                type: 'POST',
                url: '../../DataEntry/Comentarios/VerLike',

                data: JSON.stringify(dataToLog),

                contentType: 'application/json',
                success: function (data) {
                    $.each(data, function (index, item) {

                        var values = item.split(".- ");
                        if (values[0] == 0 ) {
                            document.getElementById("xNroLikes").innerHTML = values[1];
                        };
                        if (values[0] == 1) {
                            //love
                        };

                    })





                },
                error: function (error) {

                }
            });




        }

    </script>

 <style>
        #xNroLikesM {
            border: 5px solid #F47C04;
            border-radius: 21px;
            -webkit-border-radius: 21px;
            -moz-border-radius: 21px;
            border-radius: 21px;
            text-align:center;
            vertical-align:middle;
            
        }

        #Comentario_Put {
            border-bottom: 3px dotted #1C6EA4;
            border-radius: 21px;
            padding: 16px;
        }

        #Comentarios {
            -webkit-border-radius: 21px;
            -moz-border-radius: 21px;
            border-radius: 21px;
            border: 3px dotted #1C6EA4;
            border-radius: 21px;
            padding: 16px;
        }

        table.paleBlueRows {
          
            border: 1px solid #FFFFFF;
            width: 100%;
            text-align: left;
            border-collapse: collapse;
        }

            table.paleBlueRows td, table.paleBlueRows th {
                border: 1px solid #FFFFFF;
                padding: 3px 2px;
            }

            table.paleBlueRows tbody td {
                font-size: 13px;
            }

            table.paleBlueRows tr:nth-child(even) {
                background: #D0E4F5;
            }

            table.paleBlueRows thead {
                background: #EAE8E8;
		
                border-bottom: 8px solid #FFFFFF;
            }

                table.paleBlueRows thead th {
                    font-size: 18px;
                    font-weight: bold;
                    color: #F47C04;
                    text-align: center;
                    border-left: 2px solid #FFFFFF;
                }

                    table.paleBlueRows thead th:first-child {
                        border-left: none;
                    }

            table.paleBlueRows tfoot td {
                font-size: 14px;
            }



    </style>

<div id="fb-root"></div>
<script>(function(d, s, id) {
  var js, fjs = d.getElementsByTagName(s)[0];
  if (d.getElementById(id)) return;
  js = d.createElement(s); js.id = id;
  js.src = 'https://connect.facebook.net/es_ES/sdk.js#xfbml=1&autoLogAppEvents=1&version=v3.1&appId=1804286003121861';
  fjs.parentNode.insertBefore(js, fjs);
}(document, 'script', 'facebook-jssdk'));</script>

<body onLoad="MM_preloadImages('https://www.propertyweb.eu/rrss/likeicon.png')">
<% sub VerRumor(byRef pRS) 
	'comprobar permisos
	swMostrarDetalles = false
	'resp = session("pw_ws").IniCliente(request.Cookies("licencia")("n"), request.Cookies("licencia")("u"), request.Cookies("licencia")("p"))
	'resp = session("pw_ws").IniCliente(request.Cookies("licencia")("user_id"), request.Cookies("licencia")("n"), request.Cookies("licencia")("u"), request.Cookies("licencia")("p"), request.Cookies("licencia")("movil"))
	
	'if session("pw_ws").IniCliente(request.Cookies("licencia")("n"), request.Cookies("licencia")("u"), request.Cookies("licencia")("p"))=0 then	'es cliente activo
	'if session("pw_ws").IniCliente(request.Cookies("licencia")("user_id"), request.Cookies("licencia")("n"), request.Cookies("licencia")("u"), request.Cookies("licencia")("p"), request.Cookies("licencia")("movil"))=0 then	'es cliente activo
	if session("pw_ws").accesoActivo then
		if session("pw_ws").accesoRumores then
			swMostrarDetalles=true
		elseif session("pw_ws").accesoRumoresHoy then
			if abs(datediff("d", pRS("FECHA_ACTUALIZACION"), date))<=7 then
				swMostrarDetalles=true
			end if
		end if
		
		if not session("pw_ws").accesoInternacional then
			if pRS("nacional")<>1 then
				swMostrarDetalles=false
			end if
		end if
		
		'origen
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
	
	if modo_report then swMostrarDetalles = true
	%>
<div id="contenedor_articulos" class="<% if modo_report then %>caja<% end if %>">

	<h3 class="encabezado_webaoido">Rumores & New Business.-</h3>
	<h1 class="titulo_noticia"><%= pRS("TITULO") %></h1>
<%

Dim sitio_web
sitio_web = Request.ServerVariables("HTTP_HOST") ' Obtenemos el nombre del dominio
Dim pagina_web
pagina_web = Request.ServerVariables("SCRIPT_NAME") ' Obtenemos el nombre del archivo o pagina
Dim querystring
querystring = Request.QueryString ' Obtenemos todas las variables
' Mezclamos todo
Dim url_web
url_web = "https://" & sitio_web
url_web = url_web & pagina_web
 
if len(querystring) > 0 then
  url_web = url_web& "?" & querystring
end if
correo=""

usuario = request.Cookies("licencia")("n")
if instr(usuario, "@")>0 then
	correo = left(usuario, instr(usuario, "@")-1)
end if
dim url_web2
url_web2="https://www.PropertyWeb.eu/Articulos/Contenido/NoticiasCompartidas.asp?not=" & art_id 


 %>

	<div id="descar_imprim">
<div><script src="//platform.linkedin.com/in.js" type="text/javascript"> lang: es_ES</script><script type="IN/Share"  data-href="<%=url_web2 %>" data-url="<%=url_web2 %>"></script></div>
<div class="fb-share-button" data-href="<%=url_web2 %>" data-layout="button_count" data-size="small" data-mobile-iframe="true"><a target="_blank" href="<%=url_web2 %>" class="fb-xfbml-parse-ignore">Compartir</a></div>

		<% if not(modo_report) then %><a href="javascript:void(0);" onclick="imprimir();"><span class="txt_gris_claro" style="font-weight:bold;font-size:12px;">imprimir</span>&nbsp;&nbsp;<img src="/img/imprimir.png"></a>&nbsp;&nbsp;<% end if %>
		<span class="txt_gris_claro" style="font-weight:bold;font-size:12px;"><% if pRS("nacional")=1 then %>nacional<% else %>internacional<% end if %></span>&nbsp;&nbsp;<% if pRS("nacional")=1 then %><img src="/img/artic_nacional.png"><% else %><img src="/img/artic_internacional.png"><% end if %>

	</div>
    
    <p class="txt_gris_claro">Fecha Noticia: <%= pRS("Fecha_noticia") %> </p>


    <div style="clear:both;"></div>
    <% if request.Cookies("dev")="" then %>
    <div id="separator_line"></div>
    <% else %>
	<div class="dev">
    	swMostrarDetalles: <%= swMostrarDetalles %>
    </div>
	<% end if %>
    
<% if swMostrarDetalles then
	if not modo_report then
		secc = session("secc")
		if secc="" then secc = "rum"
		insert_reg_articulo secc, "rum", pRS("ID")
	end if 
	
	strTextoHTML = pRS("TEXTO_NOTICIA")& chr(13)
    'strTextoHTML = replace(strTextoHTML, Chr(10) & Chr(172) & Chr(172), "<table border='1' align='Center' class='txtTabla' width='90%'><tr><td>")
    'strTextoHTML = replace(strTextoHTML, Chr(172) & Chr(172) & Chr(13), "</td></tr></table>")
    'strTextoHTML = replace(strTextoHTML, Chr(172) & Chr(13), "</td></tr><tr><td>")
    'strTextoHTML = replace(strTextoHTML, Chr(172), "</td><td>")
    strTextoHTML = replace(strTextoHTML, Chr(10) & "¬" & "¬", "<table border='1' align='Center' class='txtTabla' width='90%'><tr><td>")
    strTextoHTML = replace(strTextoHTML, "¬" & "¬" & Chr(13), "</td></tr></table>")
    strTextoHTML = replace(strTextoHTML, "¬" & Chr(13), "</td></tr><tr><td>")
    strTextoHTML = replace(strTextoHTML, "¬", "</td><td>")
	
    if instr(strTextoHTML, chr(124) & chr(124)) then 
        strLinkExterno=mid(strTextoHTML, instr(strTextoHTML, chr(124) & chr(124))+2)
        strLinkExterno=left(strLinkExterno, instr(strLinkExterno, chr(124) & chr(124))-1)
        
        strTextoHTML = replace(strTextoHTML, chr(10) & chr(124) & chr(124) & strLinkExterno & chr(124) & chr(124) & chr(13) , "")
        
        strTextoLink=left(strLinkExterno, instr(strLinkExterno, ".")-1)
        strLinkExterno="/informes/" & strLinkExterno
    else
        strLinkExterno=""
    end if
    
    strTextoHTML = replace(strTextoHTML, Chr(10) & Chr(124), "<div align=center><img src='https://www.propertyweb.eu/fotos/noticias/")
    strTextoHTML = replace(strTextoHTML, Chr(124) & chr(13), ".jpg'></div>")
    
    strTextoHTML = replace(strTextoHTML, Chr(13), "<br>")
    'response.write strTextoHTML
	
	sFotos = pRS("fotos")
	%>
	<!--#include virtual="/inc/fotos.asp" -->
    <div class="cuerpo"><%= strTextoHTML %></div>
    <p></p>


  <% if pRS("ID_FUENTE")>0 then %>
    	<div id="separator_line" style="clear:both;"></div>
        <div class="fuente">
            Fuente: <!--#include virtual="/lib/fuentes.asp" -->
            <% if pRS("NUMERO_PAGINA")<>"" and pRS("NUMERO_PAGINA")<>"0" then %><br>&nbsp;P&aacute;g: <%= pRS("NUMERO_PAGINA") %></span><% end if %>
        </div>




    <% end if %>
                <div>
                <form>
                    <table class="paleBlueRows">

                        <thead>
                            <tr>
                                <th style="border-right:0px;"><div id="xNroLikesM"><div id="xNroLikes" style="font-style:normal;"></div></th><th style="border-right:0px;border-left:0px;text-align:left;"><img onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('xlike','','https://www.propertyweb.eu/rrss/likeicon.png',1)" src="https://www.propertyweb.eu/rrss/likeicon2.png" width="25px" title="Me Gusta" name="xlike" id="xlike" onclick="DarLike();"></div></th>
                                
                                <th style="border-left:0px;">Mándame los cotilleos del mercado YA! Apúntate aquí...</th>
                            </tr>
                        </thead>
                        <tbody>

                            <tr>
                                <td colspan="2" width="20%">Anonimo/Nombre/E-mail:</td>
                                <td width="80%"><input  title="Escribe tu Nombre o Correo Electronico para que te puedan contactar..." type="text" id="xNombre_Usuario" name="xNombre_Usuario"  value="<%= usuario %>" style="width:80%;" /></td>
                            </tr>
                            <tr>
                                <td colspan="2">Comentario:</td>
                                <td><textarea type="text" id="xComentario" name="xComentario" onkeyup="Textarea_Sin_Enter2(event.keyCode, event.which, 'xComentario');" style="width:80%;"></textarea><input type="button" id="Put_Comentario" name="Put_Comentario" onclick="EscribirComentarios()" value="Comentar" /></td>
                            </tr>

                        </tbody>

                    </table>
                </form>
            </div>

            <div id="Comentarios">
                <table class="paleBlueRows" name="myTable" id="myTable">

                    <tr>
                        <td width="20%"></td>
                        <td width="80%"></td>
                    </tr>


                </table>
            </div>

<p style="font-size:smaller;"> El equipo editorial de PW no se hace responsable de las opiniones expresadas por sus lectores. </p>

            <script>ObtenerComentarios(); VerLike();</script>
	<% if request.Cookies("dev")<>"" and not(modo_report) then %>
    	<div class="caja dev" style="margin-bottom:10px;">
            <li>Fecha Publicaci&oacute;n: <strong><%= pRS("FECHA_NOTICIA") %></strong></li>
            <li>Fecha Actualizaci&oacute;n: <strong><%= pRS("FECHA_ACTUALIZACION") %></strong></li>
            <div id="separator_line" style="clear:both;"></div>
            <!--#include virtual="/articulos/palabras_clave.asp" -->
        </div>
    <% end if %>

<% else	'swMostrarDetalles
	%><div id="separator_line" style="clear:both;"></div><%
	if request.Cookies("licencia")="" then
		call NoCliente
	else
		if ini_cliente=0 then	'es cliente activo
			if not(session("pw_ws").accesoRumoresHoy) then
				call SinAcceso("Web ha o&iacute;do...")
				
			elseif abs(datediff("d", pRS("FECHA_ACTUALIZACION"), date))>7 and not(session("pw_ws").accesoRumores) then
				call AccesoSoloHoy("Web ha o&iacute;do...")
			
			elseif pRS("nacional")<>1 and not(session("pw_ws").accesoInternacional) then
				call AccesoSoloNacional("Web ha o&iacute;do...")
				
			else
				call SinAcceso("Web ha o&iacute;do...")
			end if
		else
			call SinAcceso("Web ha o&iacute;do...")
		end if
	end if
end if	'swMostrarDetalles

if modo_report then 
	%><div style="clear:both"></div><% 
else %>
	<div id="separator_line" style="clear:both"></div><br />
	<p class="copyright_articulo">&copy; Property Web Espa&ntilde;a</p>
<% end if %>
</div>
<% end sub %>

</body>