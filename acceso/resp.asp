<% sub EnviarLicencia %>
    <h1>&iexcl;&iexcl;AVISO!!</h1>
    <p><%= cliente %> tiene contratadas <%= intContratadas %> licencias de las cuales <%= intEntregadas %> se han entregado.</p>
    <p>&iquest;Quieres dar de alta la licencia n&ordm; <%= intEntregadas + 1 %> para tu equipo?</p>
    <p>&nbsp;</p>
    <form action="/acceso/password.asp" method="post" target="_self" name="frm_confirm" id="frm_confirm">
        <input type="hidden" name="frmAdminLogin" value="adelante">
        <input type="hidden" name="cliente" value="<%= cliente %>">
        <input type="hidden" name="password" value="<%= password %>">
        <input type="hidden" name="usuario" value="<%= usuario %>">
        <div class="botones">
            <input type="submit" value="Aceptar" class="btn">
        </div>
    </form>
    <p>&nbsp;</p>
<script type="text/javascript">
$(document).ready(function() { 
	$('#frm_confirm').ajaxForm({
		success: function(responseText) {
			
			$("#access-confirm").html(responseText);
			$("#access-response").slideUp();
			$("#access-confirm").slideDown();
		}
	}); 
	
}); 

</script>
<% end sub %>

<% sub IncorrectoCliente 	
	sql = "INSERT INTO FALLOS (usuario, password, nombre, fecha, hora, REMOTE_HOST, REMOTE_ADDR, HTTP_USER_AGENT) VALUES ("
	sql = sql & "'" & Acomodar(request.form("cliente")) & "', "
	sql = sql & "'" & Acomodar(request.form("password")) & "', "
	sql = sql & "'" & Acomodar(request.form("usuario")) & "', "
	sql = sql & "'" & fecha & "', "
	sql = sql & "'" & hora & "', "
	sql = sql & "'" & http_rem_host & "', "
	sql = sql & "'" & http_rem_addr & "', "
	sql = sql & "'" & left(http_ua, 150) & "'"
	sql = sql & ")"
	'session("connPWAcesos").execute sql
	%>
    <h1>Fallo de identificaci&oacute;n</h1>
    <br />
    <p>Nombre de Empresa o clave de acceso incorrectos.</p>
    <br />
    <p>Vuelve a introducir los datos de acceso de tu Empresa.</p>
    <p>Si no eres cliente y quieres m&aacute;s informaci&oacute;n del servicio, pulsa <a href="javascript:alert('suscribe');">aqu&iacute;</a>.</p>
    <p>&nbsp;</p>
    <div class="botones">
        <input type="button" value="Volver" onclick="volver();" class="btn"/>
    </div>
    <p>&nbsp;</p>
<% end sub %>

<% sub IncorrectoSinLicencias	
	sql = "INSERT INTO LICENCIA_DENEGADA (usuario, password, nombre, fecha, hora, REMOTE_HOST, REMOTE_ADDR, HTTP_USER_AGENT) VALUES ("
	sql = sql & "'" & Acomodar(usuario) & "', "
	sql = sql & "'" & Acomodar(password) & "', "
	sql = sql & "'" & Acomodar(cliente) & "', "
	sql = sql & "'" & fecha & "', "
	sql = sql & "'" & hora &"', "
	sql = sql & "'" & http_rem_host & "', "
	sql = sql & "'" & http_rem_addr & "', "
	sql = sql & "'" & left(http_ua, 150) & "'"
	sql = sql & ")"
	'session("connPWAcesos").execute sql
	%>
    <h1>AVISO</h1>
    <br />
    <p>El n&uacute;mero de licencias contratadas por&nbsp;<%= request.form("usuario") %> es  <%= intContratadas %>, y ya han sido registradas todas</p>
    <br />
    <p>No podemos darte acceso a los resultados.</p>
    <p>En caso de duda ponte en contacto con la persona encargada de Property Web en tu empresa <br />
    o ll&aacute;manos a Property Web ( 914.295.143 )</p>
    <p>&nbsp;</p>
    <div class="botones">
	    <input type="button" value="Volver" onclick="volver();" class="btn"/>
    </div>
    <p>&nbsp;</p>
<% end sub %>


<%
function Acomodar(rSting)	
	tmp = trim(cstr("" & rSting))
	if tmp<>"" then
		tmp = replace(tmp, "'", "''")
	end if
	Acomodar = tmp
end function
%>