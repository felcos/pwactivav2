<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>
<!--#include virtual="/inc/reg_accesos.asp" -->
<!--#include virtual="/lib/funciones.asp" -->
<!--#include virtual="/flash/lib.asp" -->

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

            $.getJSON('../../DataEntry/Comentarios/GetComentarios/55', function (data) {
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
            var xId_Noticia = 55;
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
            var xId_Noticia = 55;
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



        function ResponderComentario(Id) {
            var xId_Comentario = Id;
	    var xId_Noticia = 55;
            var texto = $('#xComentario'+ Id).val();
            texto = texto.replace(String.fromCharCode(13), "<br>");
	    var TipoC = 'N';
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
            var xId_Noticia = 55;

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
                         
document.getElementById("xNroLikes").innerHTML = values[1] + "<img src='https://www.propertyweb.eu/rrss/likeicon.png' width='25px'>";
                       


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


<%

if Session("xUser")="" then

  usuario = request.Cookies("licencia")("n")
  if instr(usuario, "@")>0 then
	usuario = left(usuario, instr(usuario, "@")-1)
  end if

else
 Session("xUser")=Request.Cookies("xUser")
 usuario=Session("xUser")

end if


correo=""



set resultado = Server.CreateObject("ADODB.Recordset")
pFecha = request.Form("fecha")

pFecha2 = DateAdd("m",9,pFecha)
pFecha3 = DateAdd("m",8,pFecha)
if not(isdate(pFecha)) then response.End()
if request.Cookies("dev")="" then
	if datediff("d", pFecha, date)>7 or datediff("d", pFecha, date)<0 then pFecha = date
end if
origen = "&origen=flash"
'if pFecha<>date then 
	origen = origen & "&f=" & pFecha
'end if

set xt4ac = Server.CreateObject("ADODB.Recordset")
sqlt4ac = "SELECT TOP 3 * FROM View_Time4Change where vivo=1 ORDER BY fecha DESC"
xt4ac.Open sqlt4ac, session("connPW")	',1,1


%>
<form id="frm_flash" name="frm_flash" action="/articulos/" method="post">
<input name="origen" type="hidden" value="flash" />
<% 'if pFecha<>date then %><input name="f" type="hidden" value="<%= pFecha %>" /><% 'end if %>
<div class="row">
    <div class="col-md-6">
    
        <h2 class="tit_box"><span class="icon icon-arrow-down-right2"></span>PW News Summary  <img src="https://www.propertyweb.eu/rrss/gratis1.png" width="85px"  /></h2>
        <% 'Actualidad	
        bloque="not"
        strin="not"
        ErrMesage=""
        num_titulo=0
        apart= ""
        seccion2=""
        
        SQL_SELECT = "SELECT TITULO, ID, FECHA_ACTUALIZACION, TIPOSECCION AS APARTADO, TITULO_ING AS TITULO_AUX,"
        SQL_SELECT = SQL_SELECT & "icono_seccion FROM C_NOTICIAS_INMOBILIARIAS "
        
        SQL_WHERE = " WHERE "
        SQL_WHERE = SQL_WHERE & "(FECHA_NOTICIA >= CONVERT(DATETIME, '" & pFecha & "', 103) AND FECHA_ACTUALIZACION <= CONVERT(DATETIME, '" & pFecha & "', 103)) "	
        'SQL_WHERE = SQL_WHERE & "(FECHA_NOTICIA BETWEEN  CONVERT(DATETIME, '" & pFecha & "', 103) AND CONVERT(DATETIME, '" & pFecha & "', 103) OR "
        'SQL_WHERE = SQL_WHERE & "FECHA_ACTUALIZACION BETWEEN CONVERT(DATETIME, '" & pFecha & "', 103) AND CONVERT(DATETIME, '" & pFecha & "', 103)) "	
    
        SQL_WHERE = SQL_WHERE & "AND web_es <> 0 "
        SQL_WHERE = SQL_WHERE & "AND TIPO_NOTICIA = 'N' "
        
        SQL_ORDER = "ORDER BY TIPOSECCION "
        
        'test_inyeccion_sql (sql_select & sql_where)
        primero = true
        %>
        <div class="box_blanco">
            <% 'nacional	
            SQL = SQL_SELECT & SQL_WHERE & " AND nacional=1 " & SQL_ORDER
            resultado.Open sql, session("connPW")	',1,1
            if not resultado.eof then %>
                <div class="bloque_ubic<% if primero then %> primero<% end if %>"><img src="/img/drop.png">&nbsp;Nacional</div>
                <% call BloqueTitulos()
                primero = false
            end if
            resultado.close %>
            <% 'internacional	
            SQL = SQL_SELECT & SQL_WHERE & " AND (nacional<>1 OR nacional IS NULL) " & SQL_ORDER	
            resultado.Open sql, session("connPW")
            if not resultado.eof then %>
                <% if not(primero) then %><div class="ubicacion_separador"></div><% end if %>
                <div class="bloque_ubic<% if primero then %> primero<% end if %>"><img src="/img/drop.png">&nbsp;Internacional</div>
                <% call BloqueTitulos()
            end if
            resultado.close %>
        </div>
        
        
        <h2 class="tit_box"><span class="icon icon-arrow-down-right2"></span>Vencimientos de Contrato</h2>
        <%' Vencimientos	
        bloque="ven"
        strin="ven"	'vencimientos
        ErrMesage=""
        num_titulo=0
        apart= ""
        seccion2="VENCIMIENTOS"
        enlace_base = "/articulos/?"
        
        sql_vencim = "SELECT ID, TITULO, TITULO_pt AS TITULO_AUX, FECHA_ACTUALIZACION,  SECCION AS APARTADO, "
        sql_vencim = sql_vencim & "LOCALIDAD, PROVINCIA, TIPOACTIVIDAD, METROS_CUADRADOS, ID_TIPO_OPERACION "
        sql_vencim = sql_vencim & "FROM C_OPERACIONES WHERE "
        sql_vencim = sql_vencim & "(FECHA_PUBLICACION_VENCIMIENTO BETWEEN  CONVERT(DATETIME, '" & pFecha & "', 103) AND CONVERT(DATETIME, '" & pFecha & "', 103)) "	
	sql_vencim = sql_vencim & "or (FECHA_FIN BETWEEN  CONVERT(DATETIME, '" & pFecha3 & "', 103) AND CONVERT(DATETIME, '" & pFecha2 & "', 103)) and FECHA_FIN is not null "	
                
	sql_vencim = sql_vencim & "AND web_es <> 0"
        sql_vencim = sql_vencim & " ORDER BY SECCION"
        
        'test_inyeccion_sql sql_vencim
        primero = true
        
        resultado.Open sql_vencim, session("connPW")	',1,1
        %>
        <% if not resultado.eof then %>
        <div class="box_blanco"><% call BloqueVencimientos(resultado) %></div>
        <% end if
        resultado.close %>
        
        
        <h2 class="tit_box"><span class="icon icon-arrow-down-right2"></span>Ofertas<img src="https://www.propertyweb.eu/rrss/gratis1.png" width="85px"  /></h2>
        <%' Ofertas	
        bloque="ofe"
        strin="ofe"
        ErrMesage=""
        num_titulo=0
        apart= ""
        
        sql = "SELECT * FROM anuncios_envio "
        sql = sql & "WHERE ("
        
        sql = sql & "(web_es<>0) AND ("
        sql = sql & "(FECHA_PUBLICACION BETWEEN  CONVERT(DATETIME, '" & pFecha & "', 103) AND CONVERT(DATETIME, '" & pFecha & "', 103))"
        sql = sql & " OR "
        sql = sql & "(FECHA_ACTUALIZACION BETWEEN CONVERT(DATETIME, '" & pFecha & "', 103) AND CONVERT(DATETIME, '" & pFecha & "', 103)) "
        sql = sql & "OR "
        sql = sql & "NOT(FechaVisibleHasta < CONVERT(DATETIME, '" & pFecha & "', 103) OR FechaVisibleDesde > CONVERT(DATETIME, '" & pFecha & "', 103)) "
        sql = sql & ")"
        sql = sql & ") ORDER BY id_seccion, id_pais, provincia desc"
        
        'test_inyeccion_sql sql
        resultado.Open sql, session("connPW")	',1,1
        
        if not resultado.eof then %>
        <div class="box_blanco">
            <div class="seccion_tit">
                <span style="float:right; font-size:11px; line-height:normal; margin-top:26px;">
                <p>Publica totalmente gratis <br>
                tus <strong>anuncios</strong> y <strong>ofertas</strong></p>
                <p style="margin-top:8px; font-size:11px;"><a href="mailto:anuncios@easyproperty.es?Subject=EasyProperty - publicar anuncio" style="color:#F47C04;"><strong>Haz click aquí</strong></a></p>
                </span>
                <a href="https://www.easyproperty.es" target="_new"><img src="/img/logos/easylogo.png"></a>
                <span style="display:block; font-size:10px; margin:-10px 170px 0 170px;"><a href="https://www.easyproperty.es" target="_new">acceso gratuito</a></span>
            </div>
            <% call BloqueTitulosEasy() %>
        </div>
        <% end if
        resultado.close %>
    






    
    </div>

    <div class="col-md-6">
    
        <h2 class="tit_box"><span class="icon icon-arrow-down-right2"></span>Web ha o&iacute;do...</h2>
        <% 'Rumores		
        bloque="rum"
        strin="rum"
        ErrMesage=""
        num_titulo=0
        apart= ""
        seccion2=""
        
        swMostrar = true
        
        SQL_SELECT = "SELECT TITULO, ID, FECHA_ACTUALIZACION, TIPOSECCION AS APARTADO, TITULO_ING AS TITULO_AUX,"
        SQL_SELECT = SQL_SELECT & "icono_seccion FROM C_NOTICIAS_INMOBILIARIAS "
        
        SQL_WHERE = " WHERE "
        SQL_WHERE = SQL_WHERE & "(FECHA_NOTICIA >= CONVERT(DATETIME, '" & pFecha & "', 103) AND FECHA_ACTUALIZACION <= CONVERT(DATETIME, '" & pFecha & "', 103)) "
        SQL_WHERE = SQL_WHERE & "AND web_es <> 0 "
        SQL_WHERE = SQL_WHERE & "AND TIPO_NOTICIA = 'W' "
        
        SQL_ORDER = "ORDER BY TIPOSECCION "
        
        'test_inyeccion_sql (sql_select & sql_where)
        primero = true
        %>
        <div class="box_blanco">
            <% 'nacional		
            SQL = SQL_SELECT & SQL_WHERE & " AND nacional=1 " & SQL_ORDER
            resultado.Open sql, session("connPW")	',1,1
            if not resultado.eof then %>
                <div class="bloque_ubic<% if primero then %> primero<% end if %>"><img src="/img/drop.png">&nbsp;Nacional</div>
                <% call BloqueTitulos()
                primero = false
            end if
            resultado.close %>
            <% 'internacional	
            SQL = SQL_SELECT & SQL_WHERE & " AND (nacional<>1 OR nacional IS NULL) " & SQL_ORDER
            resultado.Open sql, session("connPW")
            if not resultado.eof then %>
                <% if not(primero) then %><div class="ubicacion_separador"></div><% end if %>
                <div class="bloque_ubic<% if primero then %> primero<% end if %>"><img src="/img/drop.png">&nbsp;Internacional</div>
                <% call BloqueTitulos()
            end if
            resultado.close %>
        </div>
        
        
        <h2 class="tit_box"><span class="icon icon-arrow-down-right2"></span>Deal Analysis</h2>
        <%' Operaciones	
        bloque="ope"		'dan
        strin="ope"			'dan
        ErrMesage=""
        num_titulo=0
        apart= ""
        
        SQL_SELECT = "SELECT ID, TITULO,TITULO_pt AS TITULO_AUX, FECHA_ACTUALIZACION, seccion AS APARTADO, icono_seccion "
        SQL_SELECT = SQL_SELECT & "FROM w_OPERACIONES "
        
        SQL_WHERE = " WHERE "
        SQL_WHERE = SQL_WHERE & "web_es <> 0"
        SQL_WHERE = SQL_WHERE & " AND (FECHA_PUBLICACION >= CONVERT(DATETIME, '" & pFecha & "', 103) AND FECHA_ACTUALIZACION <= CONVERT(DATETIME, '" & pFecha & "', 103))"
        'SQL_WHERE = SQL_WHERE & "(FECHA_PUBLICACION BETWEEN  CONVERT(DATETIME, '" & pFecha & "', 103) AND CONVERT(DATETIME, '" & pFecha & "', 103) OR "
        'SQL_WHERE = SQL_WHERE & "FECHA_ACTUALIZACION BETWEEN CONVERT(DATETIME, '" & pFecha & "', 103) AND CONVERT(DATETIME, '" & pFecha & "', 103)) "	
        
        SQL_ORDER = "ORDER BY seccion "
        
        'test_inyeccion_sql sql
        primero = true
        %>
        <div class="box_blanco">
            <% 'nacional		
            sql = SQL_SELECT & SQL_WHERE & " AND id_pais=1 " & SQL_ORDER
            resultado.Open sql, session("connPW")	',1,1
            if not resultado.eof then %>
                <div class="bloque_ubic<% if primero then %> primero<% end if %>"><img src="/img/drop.png"><span class="ubic">nacional</span></div>
                <% call BloqueTitulos()
                primero = false
            end if
            resultado.close %>
            <% 'internacional	
            SQL = SQL_SELECT & SQL_WHERE & " AND (id_pais<>1 OR id_pais IS NULL) " & SQL_ORDER
            resultado.Open sql, session("connPW")	',1,1
            if not resultado.eof then %>
                <% if not(primero) then %><div class="ubicacion_separador"></div><% end if %>
                <div class="bloque_ubic<% if primero then %> primero<% end if %>"><img src="/img/drop.png"><span class="ubic">internacional</span></div>
                <% call BloqueTitulos()
            end if
            resultado.close %>
        </div>
        
        
        <h2 class="tit_box"><span class="icon icon-arrow-down-right2"></span> Time4aChange <img src="https://www.propertyweb.eu/rrss/gratis1.png" width="85px"  /></h2>

  <% 
		
	
        bloque="t4a"
        strin="t4a"		'dema
        ErrMesage=""
        Seccion2="t4a"
        num_titulo=0
        apart= ""
        
        swMostrar = true

        SQL_SELECT = "SELECT * FROM View_Time4Change "
   
        
        SQL_WHERE = "  WHERE vivo=1 and (fecha >= CONVERT(DATETIME, '" & pFecha & "', 103) AND fecha <= CONVERT(DATETIME, '" & pFecha & "', 103)) "
        SQL_WHERE = SQL_WHERE & "AND Vivo <> 0 "

        
        SQL_ORDER = "  "
        


sql = "SELECT * FROM View_Time4Change WHERE vivo=1 and (fecha >= CONVERT(DATETIME, '" & pFecha & "', 103) AND fecha <= CONVERT(DATETIME, '" & pFecha & "', 103)) "
        
        

 	resultado.Open sql, session("connPW")	',1,1

        if not resultado.eof then %>
        <div class="box_blanco">
            <div class="seccion_tit">
                <span style="float:right; font-size:11px; line-height:normal; margin-top:26px;">
                <p>Quieres contarnos de tu cambio? <br>
                manda un email a <strong>andyg@propertyweb.eu</strong><br> o llamame a: <strong>617835023</strong></p>
                <p style="margin-top:8px; font-size:11px;"><a href="mailto:andyg@propertweb.eu?Subject=Time4Achange - publicar cambio" style="color:#F47C04;"><strong>Haz click aquí</strong></a></p>
                </span>
                <img src="https://www.propertyweb.eu/img/logos/logoT4AC2.png" width="266" >
                <span style="display:block; font-size:10px; margin:-10px 170px 0 156px;">acceso gratuito</span>
            </div>
            <% call BloqueTitulosT4ac() %>
        </div>
        <% end if
        resultado.close %>









        <h2 class="tit_box"><span class="icon icon-arrow-down-right2"></span>Estudios de Mercado</h2>
        <% 'Estudios	
        bloque="est"
        strin="est"
        ErrMesage=""
        num_titulo=0
        apart= ""
        seccion2=""
        
        swMostrar = true
        
        SQL_SELECT = "SELECT TITULO, ID, FECHA_ACTUALIZACION, TIPOSECCION AS APARTADO, TITULO_ING AS TITULO_AUX,"
        SQL_SELECT = SQL_SELECT & "icono_seccion FROM C_NOTICIAS_INMOBILIARIAS "
        
        SQL_WHERE = " WHERE "
        SQL_WHERE = SQL_WHERE & "(FECHA_NOTICIA >= CONVERT(DATETIME, '" & pFecha & "', 103) AND FECHA_ACTUALIZACION <= CONVERT(DATETIME, '" & pFecha & "', 103)) "
        SQL_WHERE = SQL_WHERE & "AND TIPO_NOTICIA = 'E' "
        
        SQL_ORDER = "ORDER BY TIPOSECCION "
        
        'test_inyeccion_sql (sql_select & sql_where)
        primero = true
        %>
        <div class="box_blanco">
            <% 'nacional		
            SQL = SQL_SELECT & SQL_WHERE & " AND nacional=1 " & SQL_ORDER
            resultado.Open sql, session("connPW")
            if not resultado.eof then %>
                <div class="bloque_ubic<% if primero then %> primero<% end if %>"><img src="/img/drop.png"><span class="ubic">nacional</span></div>
                <% call BloqueTitulos()
                primero = false
            end if
            resultado.close %>
            <% 'internacional	
            SQL = SQL_SELECT & SQL_WHERE & " AND (nacional<>1 OR nacional IS NULL) " & SQL_ORDER
            resultado.Open sql, session("connPW")
            if not resultado.eof then %>
                <% if not(primero) then %><div class="ubicacion_separador"></div><% end if %>
                <div class="bloque_ubic<% if primero then %> primero<% end if %>"><img src="/img/drop.png"><span class="ubic">internacional</span></div>
                <% call BloqueTitulos()
            end if
            resultado.close %>
        </div>
        




        <h2 class="tit_box"><span class="icon icon-arrow-down-right2"></span>Web "Tit Bits"<img src="https://www.propertyweb.eu/rrss/gratis1.png" width="85px"  /></h2>


<% 
		
	
        bloque="t4a"
        strin="t4a"		'dema
        ErrMesage=""
        Seccion2="t4a"
        num_titulo=0
        apart= ""
        
        swMostrar = true

        SQL_SELECT = "SELECT * FROM View_Noticias_Comentrios "
        SQL_WHERE = "  WHERE (vivo1=1 or vivo2=1)  "
        SQL_ORDER = "  "
      
sql = "SELECT * FROM View_Noticias_Comentrios where Id_Noticia!=55 Order by fecha desc , Comentario desc "
        
 	resultado.Open sql, session("connPW")	',1,1

        if not resultado.eof then %>
        <div class="box_blanco">
            <div class="seccion_tit">
                <span style="float:right; font-size:11px; line-height:normal; margin-top:26px;">
                <p>Quieres dejar tus comentarios? <br>
                Escribe tus comentarios al final de cualquier articulo...<br>
		Aqui veras los ultimos articulos comentados</p>
                <p style="margin-top:8px; font-size:11px;"><a href="mailto:andyg@propertweb.eu?Subject=WebTitBits " style="color:#F47C04;"><strong>Haz click aquí</strong></a></p>
                </span>
                <img src="https://www.propertyweb.eu/img/webtitbits.png" width="156" >
               
            </div>


            <% call BloqueTitulosWTB() %>
<div class="bloque">
<% if usuario="" then %>
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
<% else %>
               <div id="Comentar">
                <form>
                    <table class="paleBlueRows">

                        <thead>
                            <tr>
                                <th style="border-right:0px;"><div id="xNroLikesM"><div id="xNroLikes" style="font-style:normal;"></div></th><th style="border-right:0px;border-left:0px;text-align:left;"><img onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('xlike','','https://www.propertyweb.eu/rrss/likeicon.png',1)" src="https://www.propertyweb.eu/rrss/likeicon2.png" width="25px" title="Me Gusta" name="xlike" id="xlike" onclick="DarLike();"></div></th>
                                
                                <th style="border-left:0px;">Mándame los cotilleos del mercado YA! Apúntalos aquí...</th>
                            </tr>
                        </thead>
                        <tbody>

                            <tr>
                                <td colspan="2" width="30%">Anonimo/Nombre/E-mail:</td>
                                <td width="60%"><input  title="Escribe tu Nombre o Correo Electronico para que te puedan contactar..." type="text" id="xNombre_Usuario" name="xNombre_Usuario"  value="<%= usuario %>" style="width:80%;" /><input style="padding: 0;margin: 0;" type="button" id="Salir" name="Salir" onclick="SalirComentarios()" value="Salir" /></td>
                            </tr>
                            <tr>
                                <td colspan="2">Comentario:</td>
                                <td><textarea type="text" id="xComentario" name="xComentario" onkeyup="Textarea_Sin_Enter2(event.keyCode, event.which, 'xComentario');" style="width:80%;"></textarea><input style="padding: 0;margin: 0;" type="button" id="Put_Comentario" name="Put_Comentario" onclick="EscribirComentarios()" value="Comentar" /></td>
                            </tr>

                        </tbody>

                    </table>
                </form>
            </div>

   
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
<% end if%>
	

</div>
        </div>
        <% end if
        resultado.close %>




        
        <h2 class="tit_box"><span class="icon icon-arrow-down-right2"></span>Subastas/Concursos</h2>
        <%' Subastas	
        bloque="sub"
        strin="sub"
        ErrMesage=""
        num_titulo=0
        apart= ""
        
        sql = "SELECT TITULO, Id_Concurso AS ID, FECHA_ACTUALIZACION, tipo_concurso AS APARTADO, icono_seccion "
        sql = sql & "FROM C_CONCURSOS_DETALLE "
        sql = sql & "WHERE ("
        sql = sql & "web_es<>0"
        sql = sql & " AND (FECHA_PUBLICACION >= CONVERT(DATETIME, '" & dateadd("d",-7, pFecha) & "', 103) AND FECHA_ACTUALIZACION <= CONVERT(DATETIME, '" & pFecha & "', 103))"
    
        'sql = sql & "FECHA_PUBLICACION BETWEEN CONVERT(DATETIME, '" & dateadd("d",-7, pFecha) & "', 103) AND CONVERT(DATETIME, '" & pFecha & "', 103) OR "
        'sql = sql & "FECHA_ACTUALIZACION BETWEEN CONVERT(DATETIME, '" & dateadd("d",-7, pFecha) & "', 103) AND CONVERT(DATETIME, '" & pFecha & "', 103)"
        sql = sql & ") "
        
        sql = sql & " ORDER BY APARTADO "
        
        'test_inyeccion_sql sql
        primero = true
        
        resultado.Open sql, session("connPW")	',1,1
        %>
        <% if not resultado.eof then %>
        <div class="box_blanco"><% call BloqueTitulos() %></div>
        <% end if
        resultado.close %>
        
        
        <h2 class="tit_box"><span class="icon icon-arrow-down-right2"></span>Demandas</h2>
        <% 'Demandas	
        bloque="dem"
        strin="dem"		'dema
        ErrMesage=""
        Seccion2="DEMANDAS"
        num_titulo=0
        apart= ""
        
        swMostrar = true
        
        SQL_SELECT = "SELECT TITULO, ID, FECHA_ACTUALIZACION, TIPOSECCION AS APARTADO, TITULO_ING AS TITULO_AUX,"
        SQL_SELECT = SQL_SELECT & "icono_seccion FROM C_NOTICIAS_INMOBILIARIAS "
        
        SQL_WHERE = " WHERE "
        SQL_WHERE = SQL_WHERE & "(FECHA_NOTICIA >= CONVERT(DATETIME, '" & pFecha & "', 103) AND FECHA_ACTUALIZACION <= CONVERT(DATETIME, '" & pFecha & "', 103)) "
        SQL_WHERE = SQL_WHERE & "AND web_es <> 0 "
        SQL_WHERE = SQL_WHERE & "AND TIPO_NOTICIA = 'B' "
        
        SQL_ORDER = "ORDER BY TIPOSECCION "
        
        sql = SQL_SELECT & SQL_WHERE & SQL_ORDER
        
        'test_inyeccion_sql (sql_select & sql_where)
        primero = true
        
        resultado.Open sql, session("connPW")	',1,1
        %>
        <% if not resultado.eof then %>
        <div class="box_blanco"><% call BloqueTitulos() %></div>
        <% end if
        resultado.close %>
        





    </div>
</div>

<div style="clear:both;"></div>
<!--
<div style="text-align:center; margin:3em;">
	<input type="submit" class="btn" id="submit" value="Leer art&iacute;culos seleccionados">
</div>
-->
</form>
<%
set resultado = nothing

function FormatFecha(rFecha) 
	FormatFecha = FormatDateTime(rFecha, 1)
end function

function FormatFechaCorta(rFecha) 
	tmp = weekdayname(weekday(rFecha)) &  ", "
	FormatFechaCorta = tmp & FormatDateTime(rFecha, 2)
end function
%>
<script type="text/javascript">
$(document).ready(function() { 
	//$("#submit").unbind();
	$(".simplemodal").unbind();


	
	$("#fecha_actual").text("<%= FormatFecha(pFecha) %>");
	$("#fecha_actual_corta").text("<%= FormatFechaCorta(pFecha) %>");
	
	
	$(".simplemodal").click(function (e) {
		//e.preventDefault();
		var href = $(this).attr("href");
		href = href.substr( href.indexOf("?")+1, href.length);
		
		//var conds = getCookie("condiciones");
		if ( getCookie("condiciones")=="" ) {
			$("#ModalBox").load(
				"/acceso/password.asp",
				href,
				function(recibe, textStatus, xhr) { $("#ModalBox").modal("show") }
			);
			return false;	
		}
		
	});
	
	$("#frm_flash").submit(function() {
		if ($("#frm_flash input:checkbox:checked").length<=0) {
			//alert("Debe seleccionar algún artículo. \n\nMarque los artículos que quiera leer y vuelva a intentarlo.\n");
			$("#ModalBox").load(
				"/articulos/nada_seleccionado.asp",
				function(recibe, textStatus, xhr) { $("#ModalBox").modal("show"); }
			);
			return false;
		};
				
	'	if ( getCookie("condiciones")=="" ) {
	'		$("#ModalBox").load(
	'			"/acceso/password.asp",
	'			$("#frm_flash").serialize(),
	'			function(recibe, textStatus, xhr) {}
	'		);
	'		
	'		$("#ModalBox").modal("show");
	'		
	'		return false;
	'		
	'		
	'	}
		
	});
	
})
</script>




















