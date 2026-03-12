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
	    var TipoC = 'O';
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
		var TipoC = 'O';
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
	    var TipoC = 'O';
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
<% sub OperacionesTablaEntera(byRef pRS) 
	if not modo_report then
		secc = session("secc")
		if secc="" then secc = "ope"
		insert_reg_articulo secc, "ope", pRS("ID")
	end if
	
	if len(pRS("COMENTARIOS"))>5 then
		strComentariosHTML=pRS("COMENTARIOS")
		strTituloHTML=pRS("TITULO")& chr(13)
		'strPalabrasClavesHTML=pRS("PALABRAS_CLAVES")& chr(13)
	else
		strComentariosHTML=pRS("COMENTARIOS_PT")
		strTituloHTML=pRS("TITULO_PT")& chr(13)
		'strPalabrasClavesHTML=pRS("PALABRAS_CLAVES_PT")& chr(13)
	end if
	
	bloque="ope"
	
	'OPS. ALQ. solo PROPIETARIO
	'ops. compra/venta/inversion/traspaso	ARRENDADOR
	'INQUILINO SOLO EN OPS. ALQUILER
	if pRS("ID_TIPO_OPERACION")=1 or pRS("ID_TIPO_OPERACION")=3 then
		tipo_op = "venta"
	else
		tipo_op = "alq"
	end if
	
	dirGoogleMaps=""
	if (len(pRS("NOMBRE_CALLE"))>3 AND pRS("id_pais")=1) then
		dirGoogleMaps = pRS("TIPODIRECCION") & " " & pRS("NOMBRE_CALLE")
		if pRS("id_seccion")<>128  then		'solares 
		'and pRS("id_seccion")<>1 then 'centros comerciales
			dirGoogleMaps = dirGoogleMaps & " " & pRS("NUMERO_CALLE")
		end if
		dirGoogleMaps = dirGoogleMaps & ", "
	end if 
	dirGoogleMaps = dirGoogleMaps & pRS("LOCALIDAD") 
	if pRS("CODIGO_POSTAL")<>"" and len(pRS("CODIGO_POSTAL"))=5 then 
		dirGoogleMaps = dirGoogleMaps & ", " & pRS("CODIGO_POSTAL") 
	end if
	
	mapaGoogleMaps = dirGoogleMaps
	if instr(mapaGoogleMaps, "'") then
		mapaGoogleMaps = replace(mapaGoogleMaps, "'", " ")
	end if
	
	dirGoogleMaps = dirGoogleMaps & " (" & pRS("pais") & ")"
	
	if isnull(pRS("lat")) then
		coordsGoogleMaps = ""
	else
		coordsGoogleMaps = "@ " & pRS("lat") & " // " & pRS("lng")
	end if
	
	sFotos = "" & pRS("fotos")
	sFotos = sFotos & pRS("fotos_inmueble")
	
	%>
<div class="operaciones <% if modo_report then %>caja<% end if %>">

	<div class="miga">
		<h2 class="tit_miga"></span>Deal Analysis<% 
			if request.Cookies("dev")<>"" then %>&nbsp; <span class="dev">
				 [<a href="/articulos/?ope=<%= pRS("id") %>&origen=dev" target="_blank"><%= pRS("id") %></a>]
				 &nbsp; // &nbsp; origen: <%= session("origen") %>
			</span><% end if %></h2>
		<div class="imprimir">
			<% if not(modo_report) then %><a href="javascript:void(0);" onclick="imprimir();">imprimir <span class="icon icon-printer"></span></a><% end if %>
			<span><% if pRS("id_pais")=1 then %>nacional<% else %>internacional<% end if %> <% if pRS("id_pais")=1 then %><img src="/img/artic_nacional.png"><% else %><img src="/img/artic_internacional.png"><% end if %></span>
		</div>
	</div>    
    <% if request.Cookies("dev")<>"" then %>
        <div class="caja dev">QueryString: 
        <% for each elto in request.QueryString 
            if request.QueryString(elto)<>"" then %>[<b><%= elto %></b> = <%= request.QueryString(elto) %>] &nbsp; <% end if 
        next %>
        </div>
    <% end if %>
	<div class="row datos">
		<div class="col-sm-12">
			<% if not(isnull(pRS("id_edificio"))) and pRS("id_edificio")>0 then  %>
				<h1 class="encabezado_operaciones01"><span class="titu"> <%= pRS("inmueble") %></span><% 
				if request.Cookies("dev")<>"" then 
					if not(modo_report) then %> &nbsp; 
                	<a href="/info/inmueble/?id=<%= pRS("id_edificio") %>" target="_blank" class="btn btn-xs btn-dev"><%= pRS("id_edificio") %></a><% 
					end if
				end if %></h1>
            <% end if %>
			
			<% if session("modo")="dev" or modo_report then %><h2 class="titulo_noticia"><%= pRS("TITULO") %></h2><% end if %>
            
			<div class="direccion">
            	<% 
				if pRS("NOMBRE_CALLE")<>"N/D"  and pRS("NOMBRE_CALLE")<>"" then
					if pRS("TIPODIRECCION")<>"N/D" and pRS("TIPODIRECCION")<>"" then
						direccion = pRS("TIPODIRECCION") & " "
					end if 
					
					direccion = direccion & pRS("NOMBRE_CALLE")	'VERSALITA_TODO
					
					if pRS("NUMERO_CALLE")<>"N/D" and pRS("NUMERO_CALLE")<>"0" and pRS("NUMERO_CALLE")<>"" then
						direccion = direccion & " " & pRS("NUMERO_CALLE")
					end if
				end if
				
				if direccion<>"" then direccion = direccion & "<br>"
				
				if pRS("NOMBRE_ZONA")<>"N/D" AND pRS("NOMBRE_ZONA")<>"" then
					direccion = direccion & pRS("NOMBRE_ZONA") & "<br>"
				end if
				
				if pRS("LOCALIDAD")<>"N/D" THEN
					direccion = direccion & pRS("LOCALIDAD") & "<br>"
				end if
				
				if pRS("CODIGO_POSTAL")<>"N/D" and  len(pRS("CODIGO_POSTAL"))>3 then
					direccion = direccion & pRS("CODIGO_POSTAL") & " "
				end if
				if pRS("PROVINCIA")<>"N/D" AND pRS("PROVINCIA")<> pRS("LOCALIDAD") then
					direccion = direccion & pRS("PROVINCIA")
				end if 
				%>
				<span  class="tab01 tabDirec">DIRECCIÓN:</span>
				<p><%= direccion %></p>
                <% if pRS("TIPOAREA")<>"N/D" and pRS("TIPOAREA")<>"" THEN %>
                    <span class="tab01 tabDirec">ZONA:</span>
					<p><%= pRS("TIPOAREA") %></p>
				<% END IF %>
				
			</div>
			
			<table class="tb-operacion">
				<tr><td>Fecha <span class="hidden-xs450">Operación</span>:</td><td><%= pRS("FECHA_OPERACION") %></td></tr>
				<tr><td>Tipo <span class="hidden-xs450">de Operación</span>:</td><td><%= pRS("TIPOOPERACION") %></td></tr>
				<tr><td>Uso:</td><td><% if pRS("id_seccion")=4 then %>RETAIL<% else %><%= pRS("seccion") %><% end if %></td></tr>
                <!-- solar : INI -->
				<% if pRS("SECCION")="SOLARES" then
					'if pRS("USO_SOLAR")<>"" then 
						%><tr><td>Uso del Solar:</td><td><%=lcase(pRS("USO_SOLAR"))%></td></tr><%
					'end if 
					
					numero=pRS("SUPERFICIE_EDIFICABLE")
					if isnull(numero) or numero =0 then
					'if numero =0 then
						resp = "n/d"
					else
						
						resp = formatnumber(numero,0)& " m2"
					end if %>
                    <tr><td>Superficie Edificable:</td><td><%= resp %></td></tr>
                <% end if %>
                <!-- solar : FIN -->
                <!-- centro comercial : INI -->
				<% if pRS("SECCION")="CENTROS COMERCIALES" then
					numero=pRS("SuperficieBA")
                    if isnull(numero) or numero =0 then
                        resp = "n/d"
                    else
                        resp = formatnumber(numero,0)& " m2"
                    end if %>
                    <tr>
                        <td>Superficie Br. Alq.: </td>
                        <td><%= resp %></td>
                    </tr>
                    
                    <% numero = pRS("SuperficieConstruida")
                    if isnull(numero) or numero =0 then
                        resp = "n/d"
                    else
                        resp = formatnumber(numero,0)& " m2"
                    end if %>
                    <tr>
                        <td>Superficie Construible: </td>
                        <td><%= resp %></td>
                    </tr>
                <% end if %>
                <!-- centro comercial : FIN -->
			</table>
            
		</div>
		    
	</div>
	
	<div class="separador02"></div>
	
	
	<!-- datos: -->
	<div class="detalles clearfix">    
		
		<div class="bloqueLeft slider01">
        	<% if sFotos="" then %><img src="/_inc/javier/img/gnral/default-edif.jpg" width="373" height="209"/>
            <% else %><!--#include virtual="/inc/fotos_carousel2.asp" -->
            <% end if %>
		  <div class="separator"></div>
            <div class="pieImg">
            	<% if 1=2 then %><p>[ <a href="#" class="naranja">ver INFO - EDIFICIO</a> ]</p><% end if %>
            </div>
		</div>
		
		
		<div class="tablas bloqueRight">
			<h3>Plantas</h3>
				<div class="row ">
					<div class="col-xs-2">
<%
Set rsDetalles = Server.CreateObject("ADODB.Recordset")
rsDetalles.Open "SELECT * FROM C_OPERACIONES_DETALLE WHERE id_operacion=" & pRS("id") & " ORDER BY orden DESC", session("connPW")

' superficie_total
superficie_total = pRS("METROS_CUADRADOS")
if superficie_total = 0 then
	superficie_total = "n/d"
else
	superficie_total = formatnumber(superficie_total,0) & " m2"
end if

sumaSR=0
sumaBR=0
%>
<table class="tb-Gral planta">
<thead>
    <tr>
        <th>Uso</th>
        <th>Plt</th>
        <th>M²</th>
        
    </tr>
</thead>
<tbody>
<% do while not rsDetalles.eof 
	'planta
	if isnull(rsDetalles("planta")) then 
		planta = "N/D"
	else 
		planta = rsDetalles("planta")
	end if
    seccion=" "
    if isnull(rsDetalles("seccion")) then 
        seccion = "N/D"
    else 
        seccion = rsDetalles("seccion")
    end if
	'superf
	if rsDetalles("superficie")>0 then 
		superf = formatnumber(rsDetalles("superficie"),0)
		
		if rsDetalles("SobreRasante") then
			sumaSR = sumaSR + rsDetalles("superficie")
			'superf = superf & " S/R"
		else
			sumaBR = sumaBR + rsDetalles("superficie")
			'superf = superf & " B/R"
		end if
		
	else
		superf = ""
	end if
	%>
    <tr>
        <td class="tbl_plantas"><%= seccion %> </td>
        <td class="tbl_plantas"><%= planta %></td>
        <td class="tbl_plantas"><%= superf %></td>
    </tr>
	<% rsDetalles.movenext
loop 

	%>
	<tr class="total">
        <td> </td>
        <td>T </td>
        <td class="tbl_plantas"><% if pRS("METROS_CUADRADOS")>0 then %><%= FormatNumber(pRS("METROS_CUADRADOS"), 0) %><% else %>N/D<% end if %></td>
    </tr>
    
</tbody>
</table>
					</div>
					<div class="col-xs-10">
						<div class="tb-Gral-cont ">
<% 
' precio / renta    
if isnull(pRS("PRECIO_EUR")) then
	importe = 0
	ver_importe = "n/d"
else
	importe = pRS("PRECIO_EUR")
	if importe=0 then
		ver_importe = "n/d"
	elseif tipo_op="venta" and importe>1000 then
		ver_importe = formatNumber(importe,0)
	else
		ver_importe = formatNumber(importe,2)
	end if
end if

moneda = lcase(pRS("tipoprecio"))
if instr(moneda, "pts") then
	moneda = replace(moneda, "pts", "&euro;")
end if
if moneda="n/d" then moneda=""
%>
<table class="tb-Gral tb-Edif">
<thead>
    <tr>
        <th><% if tipo_op="venta" then %>Comprador<% else %>Inquilino<% end if %></th>
        <% if tipo_op="venta" then %><th>Vendedor</th><% end if %> <!--solo en inversión-->
        <th><% if tipo_op="venta" then %>Precio<% else %>Renta<% end if %><br><span class="renta">(<%= moneda %>)</span></th>
        <% if pRS("ID_TIPO_OPERACION")=2 then %><th>Fecha Contrato</th><% end if %>
        <th>Intermediario</th>
    </tr>
</thead>
<tbody>
	<tr>
        <td><% call Agentes(pRS,"C") %></td>
        <% if tipo_op="venta" then %><td><% call Agentes(pRS,"P") %></td><% end if %> <!--solo en inversión -->
        <td>
        	<p><%= ver_importe %></p>
			<% if pRS("PRECIO_SALIDA_EUR") <> 0 and pRS("PRECIO_SALIDA_EUR") <> "" then %>
                <p><% if pRS("ID_TIPO_OPERACION")=1 or pRS("ID_TIPO_OPERACION")=3 then %>
                  Pr.<% else %>
                  Renta<% end if %> 
                  Est. Salida:<br /><%=formatnumber(pRS("PRECIO_SALIDA_EUR"),2)%></p>
            <% end if %>
		</td>
        <% if pRS("ID_TIPO_OPERACION")=2 then 
			fIni = mid(pRS("FECHA_INICIO"), 4, 3) &  mid(pRS("FECHA_INICIO"), 9, 2)
			fFin = mid(pRS("FECHA_FIN"), 4, 3) & mid(pRS("FECHA_FIN"), 9, 2)
			%><td><%= fIni %>-<%= fFin %></td><% 
		end if %>
        <td><% call Agentes(pRS,"I") %></td>
    </tr>
</tbody>
</table>
<%
rsDetalles.close
set rsDetalles=nothing
%>
						</div>
					</div>
		
				</div>

			</div>
		</div>
   
		<div class="detalles clearfix">
			<div class="bloqueLeft ">
				<div class="cajaImg">
                    <div id="googleMapDeals<%= pRS("id") %>" class="mapaVer" style=" height:225px;"></div>
                    <div id="dirMap<%= pRS("id") %>" class="med"><% if request.Cookies("dev")<>"" then %>[<%= pRS("id") %>] <% end if %><%= mapaGoogleMaps %></div>
                    <% if request.Cookies("dev")<>"" then %><div id="coordsMap" class="dev peq"><%= coordsGoogleMaps %></div><% end if %>
				</div>
				<div class="pieImg"><p>MAPA/STREET VIEW<img src="/_inc/javier/img/info/muneco.gif" /></p></div>
			</div>
			
		    <div class="bloqueRight">
				<div class="descripcion"><!--cambiar-->
					<!--<div class="separador02"></div>   -->
					<h3>COMENTARIOS</h3>
                    <% 
					if 1=2 then
						dim palabra(500)
						a = 1
						posicion = 0
						texto=strComentariosHTML 
						
						For bucle = 1 To Len(texto) 
							If Mid(texto,bucle,1) = CHR(13) Then
								Palabra(a) = Trim(Mid(texto,Posicion+1,bucle-Posicion-1))
								Posicion = bucle
								a = a + 1
							End If
						Next
						For bucle = 1 To a
							palabra(bucle) = Replace(palabra(bucle), Chr(10) & Chr(124), "<div align=center><img src='/fotos/operaciones/")
							palabra(bucle) = Replace(palabra(bucle), Chr(124), "'></div>")
							'response.write palabra(bucle) & "<br>"
							palabra(bucle)=""
						next
					end if
					
					
					texto = strComentariosHTML
					lista = split(texto, chr(13))
					
					for each elto in lista
						
						for ii=1 to 3
							if len(elto)<1 then exit for
							char = asc(mid(elto, 1,1))
							if char=10 or char=45 or char=32 then		 'or char=46	"."
								elto = mid(elto, 2, len(elto)-1)
							end if
						next
						if elto<>"" then
							%><p><%= elto %></p><%
						end if
					next
					%>
				</div>
			</div>
		</div>
     
   

	</div>
    
    <% if modo_report then %>
    <% else %>
	    <br />
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
dim url_web2
url_web2="https://www.PropertyWeb.eu/Articulos/Contenido/NoticiaCompartida.asp?not=" & art_id 

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

    	<div id="separator_line" style="clear:both"></div>
		<p class="copyright_articulo">&copy; Property Web España</p>




     
<div id="separator_line"></div>
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

	<% end if %>
</div>
<script>
var myLatlng;
var variable_post="var_geocode";

//console.log("[< %= mapaGoogleMaps %>]")
<% if isnull(pRS("lat")) or modo_report then	'request.Form("presentacion")="informe" then %>
	$.post(
		"https://maps.googleapis.com/maps/api/geocode/json?address=<%= mapaGoogleMaps %>&region=ES", 
		function(data){
			//console.log(data);
			if (data["status"]=="OK") {
				myLatlng = data.results[0].geometry.location;
			} else {
				console.log("coords... id:<%= pRS("id") %>")
				myLatlng = inmuebleLatLng;
			};
			
			var mapProp = {
				center:new google.maps.LatLng(myLatlng.lat, myLatlng.lng),
				zoom:16,
				mapTypeId:google.maps.MapTypeId.ROADMAP
			};
			
			var map = new google.maps.Map(document.getElementById("googleMapDeals<%= pRS("id") %>"), mapProp);
			// dealanalysis/inc/markermanager.js
			
			var marker = new google.maps.Marker({
				<% if not(isnull(pRS("lat"))) then %>icon: "https://maps.google.com/mapfiles/ms/icons/yellow-dot.png",<% end if %>
				position: myLatlng,
				map: map,
				title: '<%= mapaGoogleMaps %>'
			});
		
		}
	);
<% else %>
	var lat = <%= replace(pRS("lat"), ",", ".") %>;
	var lng = <%= replace(pRS("lng"), ",", ".") %>;
	
	var position = {"lat": parseFloat(lat), "lng": parseFloat(lng)};
	//console.log(position);
	
	var mapProp = {
		center: position,
		zoom:17,
		scrollwheel: false,
		mapTypeId:google.maps.MapTypeId.ROADMAP
	};
		
	var map = new google.maps.Map(document.getElementById("googleMapDeals<%= pRS("id") %>"), mapProp);
	
	markLatLng = new google.maps.Marker({
		icon: "https://maps.google.com/mapfiles/ms/icons/yellow-dot.png",
		map: map,
		position: position,
		zIndex: 2
	});

<% end if %>
</script>
<% end sub %>

<% sub Agentes(byRef pRs, pTipo) 
	Set rsAg = Server.CreateObject("ADODB.Recordset")	
	select case pTipo
		case "C"
			sql = "tipo='C'"
		case "P"
			sql = "tipo='P'"
		case "I"
			sql = "(tipo='CI' or tipo='PI')"
	end select
	
	sql = "SELECT * FROM C_CONTACTOS_OPERACIONES WHERE id_operacion=" & pRS("ID") & " AND " & sql
	
	if pTipo="I" then
		 sql = sql & " ORDER BY ACTIVIDAD, tipo"
	end if 
	
	rsAg.Open sql, session("connPW")
	if not rsAg.eof then %>
<div>
<% 
cActividad =""
do while not rsAg.eof 
	
	if pTipo="I" then
		if cActividad<>lcase(rsAg("ACTIVIDAD")) then
			cActividad = lcase(rsAg("ACTIVIDAD"))
			%><p><strong><%= cActividad %></strong></p><%
		end if
		
		if isnull(rsAg("foto")) then
			img=false
		else
			img=true
		end if
		if rsAg("tipo")="CI" then
			if pRS("ID_TIPO_OPERACION")=1 or pRS("ID_TIPO_OPERACION")=3 then 
				cTipo = "  (C)" 
			else 
				cTipo = "  (I)"
			end if
			
		elseif rsAg("tipo")="PI" then
			if pRS("ID_TIPO_OPERACION")=1 or pRS("ID_TIPO_OPERACION")=3 then 
				cTipo = "  (V)"
			else 
				cTipo = "  (P)"
			end if
			
		end if
		
		
	else
		img=false
		cTipo = ""
	end if 
	img=false
	
	nombre = lcase(rsAg("NOMBRE"))
	
	%><!-- include virtual="/inc/fotos.asp" -->
<p><%= nombre %><%= cTipo %><% if img then %><img src="/img/clientes/<%= rsAg("foto") %>" height="32" /><% end if %></p>
	<% rsAg.movenext
    loop %>
</div>
	<% end if 
    rsAg.close
	%>
<% set rsArg = nothing
end sub %>

</body>