<!--#include virtual="/inc/reg_accesos.asp" -->
<!--#include virtual="/lib/funciones.asp" -->
<%
Session("xUser")=Request.Cookies("xUser")
if Session("xUser")="" then

  usuario = request.Cookies("licencia")("n")
  if instr(usuario, "@")>0 then
	usuario = left(usuario, instr(usuario, "@")-1)
  end if

	if usuario="" then
		 Response.Cookies("xUser")=""
	end if
else

 Session("xUser")=Request.Cookies("xUser")
 usuario=Session("xUser")

end if


sec_actual = "buscadores"
pag_actual = "actualidad" 

dim f_desde
dim f_hasta
dim busqueda

swMostrarListado=true


%>

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

        #ComentariosX {
            -webkit-border-radius: 21px;
            -moz-border-radius: 21px;
            border-radius: 21px;
            border: 3px dotted #1C6EA4;
            border-radius: 21px;
            padding: 16px;
        }


        table.paleBlueRows2 {
          padding: 0px 0px 0px 0px;
            border: 0px solid #FFFFFF;
            width: 100%;
            text-align: left;
            border-collapse: collapse;
        }

            table.paleBlueRows2 td, table.paleBlueRows th {
                border: 0px solid #FFFFFF;
                padding: 0px 0px 0px 0px;
            }

            table.paleBlueRows2 tbody td {
                font-size: 13px;
		
            }

            table.paleBlueRows2 tr:nth-child(even) {
                background: #D0E4F5;
		
            }

            table.paleBlueRows2 thead {
                background: #EAE8E8;
		
                border-bottom: 8px solid #FFFFFF;
            }

                table.paleBlueRows2 thead th {
                    font-size: 18px;
                    font-weight: bold;
                    color: #F47C04;
                    text-align: center;
                    border-left: 2px solid #FFFFFF;
                }

                    table.paleBlueRows2 thead th:first-child {
                        border-left: none;
                    }

            table.paleBlueRows2 tfoot td {
                font-size: 14px;
		
            }

        table.paleBlueRows {
          padding: 0px 0px 0px 0px;
            border: 1px solid #FFFFFF;
            width: 100%;
            text-align: left;
            border-collapse: collapse;
        }



            table.paleBlueRows td, table.paleBlueRows th {
                border: 0px solid #FFFFFF;
                padding: 0px 0px 0px 0px;
            }

            table.paleBlueRows tbody td {
                font-size: 13px;
		border-bottom: 1px solid #AFAEAE;
            }

            table.paleBlueRows tr:nth-child(even) {
                background: #D0E4F5;
		border-bottom: 1px solid #AFAEAE;
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
<style type="text/css">
    h2{font-size: 21px;margin-bottom: 0px;text-align: center;}
 .tooltip {
     position: relative;
     font-weight: 700;
     display: inline-block;
     border-bottom: 1px dotted #1C6EA4; 
     opacity:0.9;
     font-family: 'questrial', Helvetica, sans-serif;
     font-size: 12px;
 }

 .tooltip .tiptext {
     visibility: hidden;
     width: 256px;
     background-color: #fffae4;
     font-weight: 400;
     color: #222222;
     text-align: center;
     border-radius: 6px;
     font-size: 18px;
     padding: 6px 4px;
     position: absolute;
     z-index: 1;
     box-shadow: 2px 5px 15px rgba(0, 0, 0, 0.6);
 }
 .tooltip text{
     font-family: 'questrial', Helvetica, sans-serif;
     font-size: 22px;
     }

 .tooltip a {
     text-decoration: none }
 a:link {
     color:#000000; }
 a:visited {
     color: #333333;  }
 .tooltip .tiptext::after {
     content: "";
     position: absolute;
     border-width: 7px;
     border-style: solid;
 }
 .tooltip:hover .tiptext {
     visibility: visible;
 }
 
 /* top */
 .tooltip.top .tiptext{
     margin-left: -133px;
     bottom: 100%;
     left: 50%;
 }
 .tooltip.top .tiptext::after{
     margin-left: -5px;
     top: 100%;
     left: 50%;
     border-color: #fffae4 transparent transparent transparent;
 }
 
 /* bottom */
 .tooltip.bottom .tiptext{
     margin-left: -60px;
     top: 150%;
     left: 50%;
 }
 .tooltip.bottom .tiptext::after{
     margin-left: -5px;
     bottom: 100%;
     left: 50%;
     border-color: transparent transparent #fffae4 transparent;
 }
 
 /* left */
 .tooltip.left .tiptext{
     top: -5px;
     right: 110%;
 }
 .tooltip.left .tiptext::after{
     margin-top: -5px;
     top: 50%;
     left: 100%;
     border-color: transparent transparent transparent #fffae4;
 }
 
 /* right */
 .tooltip.right .tiptext{
     top: -5px;
     left: 110%;
 }
 .tooltip.right .tiptext::after{
     margin-top: -5px;
     top: 50%;
     right: 100%;
     border-color: transparent #fffae4 transparent transparent;
 }
 
 /* Input */
 .tooltip input {
     margin: 4px 0;
 }
 </style>
<script type="text/javascript">


function writeCookie(name,value,days) {
    var date, expires;
    if (days) {
        date = new Date();
        date.setTime(date.getTime()+(days*24*60*60*1000));
        expires = "; expires=" + date.toGMTString();
            }else{
        expires = "";
    }
    document.cookie = name + "=" + value + expires + "; path=/";
}

function readCookie(name) {
    var i, c, ca, nameEQ = name + "=";
    ca = document.cookie.split(';');
    for(i=0;i < ca.length;i++) {
        c = ca[i];
        while (c.charAt(0)==' ') {
            c = c.substring(1,c.length);
        }
        if (c.indexOf(nameEQ) == 0) {
            return c.substring(nameEQ.length,c.length);
        }
    }
    return '';
}


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


        function SalirComentarios() {
		location.href ="https://www.propertyweb.eu/flash/?xUser=Salir";

        }

        function ObtenerComentarios() {

            $.getJSON('../../DataEntry/Comentarios/GetComentarios/' + <%=art_id %>, function (data) {
                $.each(data, function (index, item) {
                    var table = document.getElementById("myTable");
                    //var row = table.deleteRow(0);
                    var values = item.split(".- ");
                    //Select(x => x.Id + ".- " + x.Fecha + ".- " + x.Nombre + ".- " + x.Comentario ).Take(50).ToList();


                    var row1 = table.insertRow(1);

                    var cell11 = row1.insertCell(0);
                    var Id = parseFloat(values[0]);
		    var IdComentario = parseFloat(values[4]);
             		if (IdComentario==0)
				{ 
                   cell11.innerHTML =  "<p style='font-weight: bold;padding: 0px;margin: 0px;'>" + values[2] + ':</p>' + values[3] <% if (request.Cookies("licencia")("u")="PW") then %> + "<div align='right' id='BtnBorrar" + Id + "'><button type='button' style='color:#b4cdd0;text-size-adjust:50%;'  onclick='BorrarComentario(" + Id + ")'>borrar</button></div>"<% end if %>  + "<div align='right' id='BtnResponder" + Id + "'><form><table class='paleBlueRows2' ><tr><td style='font-weight: bold;padding: 0px;margin: 0px;'><%=usuario %>:</td></tr><tr><td><input type='hidden' id='xNombre_Usuario' name='xNombre_Usuario'  value='<%=usuario %>'/><input type='hidden' id='xId_Comentario_Usuario' name='xId_Comentario_Usuario'  value='<%=Id %>'/><textarea type='text' id='xComentario"+ Id +"' name='xComentario"+ Id +"' style='width:80%;'></textarea><input type='button'  id='Put_Comentario' name='Put_Comentario'   onclick='ResponderComentario(" + Id + ")' value='Responder' /></td></tr></table></form>";
                   var cell12 = row1.insertCell(0);
                   cell12.innerHTML = values[1] + "<br><img src='https://www.propertyweb.eu/img/no-user.png' style='width:50px;' />";
				}else
				{ 
var sTxtHtml0 =   "<p style='font-weight: bold;padding: 0px;margin: 0px;'>Respuesta de " + values[2] + ":</p><img src='https://www.propertyweb.eu/img/no-user.png' style='width:50px;' />" + "<p style='font-weight: bold;padding: 0px;margin: 0px;'>" + values[1] + ':</p>' + values[3] <% if (request.Cookies("licencia")("u")="PW") then %> + "<div align='right' id='BtnBorrar" + Id + "'><button type='button' style='color:#b4cdd0;text-size-adjust:50%;'  onclick='BorrarComentario(" + Id + ")'>borrar</button></div>"<% end if %>  + "<div align='right' id='BtnResponder" + Id;

var sTxtHtml1 = "'>";

cell11.innerHTML =  sTxtHtml0 + sTxtHtml1;

                    var cell12 = row1.insertCell(0);
                    cell12.innerHTML = "&nbsp; ";

				
				}; 
 
                 

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
                    
                    $('#xComentario').val('');

                },
                error: function (error) {
                    console.log(error.responseText);
                    //$('#Put_Comentario').val('Save');
                }
            });




        }


        function EntrarComentarios() 
	{

            var dataToLog = { 'Email': $('#xEmail_UsuarioE').val(), 'Password': $('#xPasswordE').val() };
            $.ajax({
                type: 'POST',
                url: '../../DataEntry/Comentarios/EntrarComentarios',
                data: JSON.stringify(dataToLog),
                contentType: 'application/json',
                success: function (data) {
                    $.each(data, function (index, item) {
                        var values = item.split(".-");
             		if (values[0]!="Mensaje")
				{ 
				writeCookie('xUser', values[0], 3);
				//session("xUser") = values[0];
				//location.href ="https://www.propertyweb.eu/flash/?xUser="+values[0];
				location.reload(true);
				
				}else
				{ 
				document.getElementById("MsgError").innerHTML = values[1]; 
				
				};
			
                    })
			
                },
                error: function (error) {
                    console.log(error.responseText);
                    //$('#Put_Comentario').val('Save');
                }
            });


        }

 
        function RegistrarComentarios() 
	{
	if ($('#xPasswordR').val()==$('#xPasswordR2').val())
	{
            var dataToLog = {  'Nombre': $('#xNombre_UsuarioR').val(), 'Email': $('#xEmail_UsuarioR').val(), 'Password': $('#xPasswordR').val() };
            $.ajax({
                type: 'POST',
                url: '../../DataEntry/Comentarios/RegistrarComentarios',
                data: JSON.stringify(dataToLog),
                contentType: 'application/json',
                success: function (data) {
                    $.each(data, function (index, item) {
                        var values = item.split(".-");
             		if (values[0]!="Mensaje")
				{ 
				writeCookie('xUser', values[0], 3);
				//location.href ="https://www.propertyweb.eu/flash/?xUser="+values[0];
				location.reload(true);
				}else
				{ 
				document.getElementById("MsgError").innerHTML = values[1]; 
				
				};
			
                    })
			
                },
                error: function (error) {
                    console.log(error.responseText);
                    //$('#Put_Comentario').val('Save');
                }
            });

	}
	else
	{alert("Las contraseñas deben ser iguales...");
	}
        }



        function DarLike() {
            var xId_Noticia = <%=art_id %>;
		var TipoC = 'R';
            var dataToLog = { 'Id': xId_Noticia, 'TipoComentario': TipoC };
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


        function ResponderComentario(Id) {
            var xId_Comentario = Id;
	    var xId_Noticia = <%=art_id %>;
            var texto = $('#xComentario'+ Id).val();
            texto = texto.replace(String.fromCharCode(13), "<br>");
	    var TipoC = 'R';
            var dataToLog = { 'Id': xId_Noticia, 'Nombre': $('#xNombre_Usuario').val(), 'Comentario': texto, 'TipoComentario': TipoC, 'Id_Comentario': xId_Comentario };
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
                        cell12.innerHTML = values[1] + ' ' + values[2] + ':';
                    })
                    
                    $('#xComentario').val('');
			location.reload(true);
                },
                error: function (error) {
                    console.log(error.responseText);
                    //$('#Put_Comentario').val('Save');
                }
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
id_edificio=pRS("id_edificio")
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
 'response.write(querystring)
if len(querystring) > 0 then
  url_web = url_web& "?" & querystring
end if
correo=""

dim url_web2
url_web2="https://www.PropertyWeb.eu/Articulos/Contenido/NoticiasCompartidas.asp?not=" & art_id 

if Session("xUser")="" then

  usuario = request.Cookies("licencia")("n")
  if instr(usuario, "@")>0 then
	usuario = left(usuario, instr(usuario, "@")-1)
  end if

else

Session("xUser")=Request.Cookies("xUser")
 usuario=Session("xUser")

end if

 %>

	<div id="descar_imprim">

		<% if not(modo_report) then %><a href="javascript:void(0);" onclick="imprimir();"><span class="txt_gris_claro" style="font-weight:bold;font-size:12px;">imprimir</span>&nbsp;&nbsp;<img src="/img/imprimir.png"></a>&nbsp;&nbsp;<% end if %>
		<span class="txt_gris_claro" style="font-weight:bold;font-size:12px;"><% if pRS("nacional")=1 then %>nacional<% else %>internacional<% end if %></span>&nbsp;&nbsp;<% if pRS("nacional")=1 then %><img src="/img/artic_nacional.png"><% else %><img src="/img/artic_internacional.png"><% end if %>

	</div>
    
    <p class="txt_gris_claro">Fecha Noticia: <%= pRS("Fecha_noticia") %> </p>
    <% pFechaLink=pRS("Fecha_noticia") %>

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
    <% if id_edificio<>0 then %>
    <table>
        <tr>
            <td style="width: 88%; margin-right: 5px;margin-left: 5px;">
                <div class="cuerpo" style=" padding-right: 5px; "><%= strTextoHTML %></div>
            </td>
            <td style="width: 12%; border: #F47C04; border-left-style: dotted; margin-left: 5px;" > 
                <div class="cuerpo" style=" margin-left: 5px;">
                	<div style="	left:0px; 
	right:0px;
	color:#4e5457;
	background: #e9eff2;margin-top:0px;
text-align: center;"><strong>Quieres Saber Mas...</strong></div>
	<p style="text-align: center;"></p>
	<div style="text-align:justify;margin: 8px;"><a <% if id_edificio<>0 then %> href="https://www.propertyweb.eu/info/edificio/?id=<%= id_edificio %>" <% end if %>> <strong>Todo sobre el activo:</strong> Propietario, Datos Historicos, etc. </a></div>
</div>
                </div>
            </td>
        </tr>
    </table>
    <% else %>
    <div class="cuerpo" style=" padding-right: 5px; "><%= strTextoHTML %></div>
    <% end if %>
    
    <p></p>


  <% if pRS("ID_FUENTE")>0 then %>
    	<div id="separator_line" style="clear:both;"></div>
        <div class="fuente">
            Fuente: <!--#include virtual="/lib/fuentes.asp" -->
            <% if pRS("NUMERO_PAGINA")<>"" and pRS("NUMERO_PAGINA")<>"0" then %><br>&nbsp;P&aacute;g: <%= pRS("NUMERO_PAGINA") %></span><% end if %>
        </div>
    <% end if %>
<table>
<tr>
<td>
<div><script src="//platform.linkedin.com/in.js" type="text/javascript"> lang: es_ES</script><script type="IN/Share"  data-href="<%=url_web2 %>" data-url="<%=url_web2 %>"></script></div>
</td>
<td>
<div class="fb-share-button" data-href="<%=url_web2 %>" data-layout="button_count" data-size="small" data-mobile-iframe="true"><a target="_blank" href="<%=url_web2 %>" class="fb-xfbml-parse-ignore">Compartir</a></div>
</td>
</tr>
</table>

 <% if usuario<>"" then %>
            <div >
                <form>
                    <table class="paleBlueRows">

                        <thead>
                            <tr>
                                <th style="border-right:0px;padding:0;border:0;"><div id="xNroLikesM"><div id="xNroLikes" style="font-style:normal;"></div></th><th style="border-right:0px;border-left:0px;text-align:left;"><img onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('xlike','','https://www.propertyweb.eu/rrss/likeicon.png',1)" src="https://www.propertyweb.eu/rrss/likeicon2.png" width="25px" title="Me Gusta" name="xlike" id="xlike" onclick="DarLike();"></div></th>

				<th style="border-right:0px;padding:0;border:0;"><img src="https://www.propertyweb.eu/img/icon_comments_74.png" />Comentarios, comparte lo que piensas</th>
                            </tr>
                        </thead>
                        <tbody>

                            <tr>
                                <td colspan="2" width="20%"><%=usuario %>:</td>
                                <td width="80%"><input type="hidden" id="xNombre_Usuario" name="xNombre_Usuario"  value="<%=usuario %>"  />
<textarea type="text" id="xComentario" name="xComentario" onkeyup="Textarea_Sin_Enter2(event.keyCode, event.which, 'xComentario');" style="width:80%;"></textarea><input type="button" id="Put_Comentario" name="Put_Comentario" onclick="EscribirComentarios()" value="Comentar" />
</td>
            
                                
                            </tr>

                        </tbody>

                    </table>
                </form>
            </div>
   <% else %>
<div id="EntrarRegistrar">
	<p style="background-color:#D3D3D3;color:#F47C04;padding: 0;margin: 0;"><strong>ENTRA PARA ESCRIBIR TUS COMENTARIOS AQUI: <%= usuario %></strong></p>
	<p style="background-color:#D3D3D3;color:#F47C04;padding: 0;margin: 0;"><strong>E-Mail: </strong>
	<input style="background-color:#D3D3D3;"  title="Escribe tu Correo Electronico para Entrar" type="email" id="xEmail_UsuarioE" name="xEmail_UsuarioE"  />
	<strong>Contraseña: </strong><input style="background-color:#D3D3D3;"  type="password" id="xPasswordE" name="xPasswordE"  > </input>
	<input style="padding: 0;margin: 0;" type="button" id="Entrar" name="Entrar" onclick="EntrarComentarios()" value="Entrar" /></p>

	<p style="background-color:#F0E68C;color:#F47C04;padding: 0;margin: 0;"><strong>SI NO ERES CLIENTE REGISTRATE PARA ENTRAR:</strong></p>
	<p style="background-color:#F0E68C;color:#F47C04;padding: 0;margin: 0;">
	<strong>E-Mail:&nbsp;&nbsp;&nbsp;&nbsp;</strong><input style="margin-left: 3em;border: 1px solid #555;background-color:#F0E68C;" title="Escribe tu Correo Electronico" type="email" id="xEmail_UsuarioR" name="xEmail_UsuarioR"  />
	</p><p style="background-color:#F0E68C;color:#F47C04;padding: 0;margin: 0;">
	<strong>Nombre:&nbsp;</strong><input  style="margin-left: 3em;border: 1px solid #555;background-color:#F0E68C;"  title="Escribe tu Nombre" type="text" id="xNombre_UsuarioR" name="xNombre_UsuarioR" />
	</p><p style="margin-left: 2em;background-color:#F0E68C;color:#F47C04;padding: 0;margin: 0;">
	<strong>Contraseña:&nbsp;&nbsp;</strong><input  style="margin-left: 1em;border: 1px solid #555;background-color:#F0E68C;" type="password" id="xPasswordR" name="xPasswordR"  > </input>
	</p><p style="margin-left: 2em;background-color:#F0E68C;color:#F47C04;padding: 0;margin: 0;"><strong>Confirmar Contraseña:&nbsp;&nbsp;</strong><input  style="margin-left: 1em;border: 1px solid #555;background-color:#F0E68C;" type="password" id="xPasswordR2" name="xPasswordR2"  > </input>	
	<input style="padding: 0;margin: 0;" type="button" id="Registrar" name="Registrar" onclick="RegistrarComentarios()" value="Registrar" /></p>

<div id="TextoComentarios" name="TextoComentarios" colspan="5"  style="border-left:0px;"></div>
<div id="MsgError" name="MsgError" colspan="5"  style="border-left:0px;"></div>

</div>
   <% end if%>
            <div id="Comentarios">
                <table name="myTableU" id="myTableU">

                    <tr>
                        <td width="20%"></td>
                        <td width="80%"></td>
                    </tr>


                </table>
                <table class="paleBlueRows" name="myTable" id="myTable">
                    <tr>
                        <td width="20%"></td>
                        <td width="80%"></td>
                    </tr>
                </table>
            </div>

<p style="font-size:x-small;"> El equipo editorial de PW no se hace responsable de las opiniones expresadas por sus lectores. </p>

            
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
    


<%

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

%>

<div class="container">
    <section id="s_buscador" class="row">

      <div id="div_formulario" name="div_formulario" class="caja col-md-11"><!---->
        <h1 class="heading">Art&iacute;culos relacionados:</h1>
    <form id="frm_busq" name="frm_busq" class="form-horizontal" action="/articulos/titulos/resumenb1.asp" method="post" autocomplete="off" target="_blank">
          <input type="hidden" name="secc" value="actualidad">
          <input id="busq" type="hidden" class=" form-control" name="busq" value="<%= busqueda %>" placeholder="Escriba una o m&aacute;s palabras separadas por espacios" required autofocus maxlength="50" />
          <input type="hidden" name="FechaI" id="FechaI" value="<%= f_desde %>" maxlength="10" class="form-control">
          <input type="hidden" name="FechaF" id="FechaF" value="<%= f_hasta %>" maxlength="10" class="form-control">
          <input type="hidden" name="pFechaLink" id="pFechaLink" value="<%= pFechaLink %>" maxlength="10" class="form-control">
          
        </form>
      </div>


    </section>
    <!-- resumen -->
    

   
    
    <section id="s_titulos" class="row">
      <div id="div_result" class="caja col-md-11" style="display:none;"><div id="result"></div>
</div>
    </section>
    
</div>

	<p class="copyright_articulo">&copy; Property Web Espa&ntilde;a</p>
<% end if %>
</div>
<% end sub %>

</body>
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
