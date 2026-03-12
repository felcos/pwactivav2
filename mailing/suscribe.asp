<!--#include virtual="/lib/funciones.asp" -->
<%
%>
<div class="modal-dialog"><!--  modal-lg -->
    <div class="modal-content">
        <div class="modal-header">
        	<!--
        	<button type="button" class="close" data-dismiss="modal" aria-hidden="true">x</button>
            <a href="#" data-dismiss="modal">x</a>
            -->
            <p>Suscribe Newsletter</p>
        </div>
		<div class="modal-body">
        	<div class="cliente">
<% select case request.Form("mailing")
case "unsuscribe" 
	'enviar email
	email = request.Form("email")
	%>
    <p>Hemos enviado un email a tu correo para confirmar tu identidad.</p>
    <p>Por favor, siga el enlace recibido para confirmar la suscripci&oacute;n.</p>
    <p>email: <span style="color:#ff6802;"><%= email %></span>.</p>
    <p>Gracias por su inter&eacute;s.</p>
    <br />
    <div class="botones">
        <input type="button" class="btn" value="Aceptar" data-dismiss="modal">
    </div>
    <br />
    
<% case else
    'comprobar email
    email = lcase(trim(request.Form("email")))
    
    
    Set rsEmails = Server.CreateObject("ADODB.Recordset")
    sql = "SELECT * FROM contactos_email WHERE email='" & email & "'"
    
    test_inyeccion_sql sql
    rsEmails.Open sql, session("connPW")
    
    if rsEmails.eof then
        'enviar email
        
        'registrar en la BD
        sql = "INSERT INTO contactos_email (email, fecha_alta, pw_es) VALUES ('" & email & "', GETDATE(), 1)"
        'session("connPW").execute sql
        
        %>
        <p>Hemos enviado un email a tu correo para confirmar tu identidad.</p>
        <p>Por favor, siga el enlace recibido para confirmar la suscripci&oacute;n.</p>
        <p>email: <%= email %>.</p>
        
        <p>Gracias por su inter&eacute;s.</p>
        <br />
        <div class="botones">
            <input type="button" class="btn" value="Aceptar" data-dismiss="modal">
        </div>
        <br />
        
    <% else		'rsEmails.eof
        'email ya registrado
		
        if rsEmails("pw_es")=1 then 	
			'no suscrito %>
            
            <p>El email introducido, <span style="color:#ff6802;"><%= email %></span><br />
            ya est&aacute; registrado en nuestra base de datos, pero no est&aacute; recibiendo nuestro mailing diario.</p>
            <p>&iquest;Quieres comenzar a recibir PW Flash?</p>
            
            <br />
            <div class="botones">
                <input type="button" class="btn" value="Cancelar" data-dismiss="modal">
                <input type="button" class="btn" value="Aceptar">
            </div>
            
        <% else 		'rsEmails("pw_es")=1
			'suscrito %>
            <form id="frm_unsuscribe" method="post">
                <input type="hidden" name="email" value="<%= email %>" />
                <input type="hidden" name="mailing" value="unsuscribe" />
            </form>
            <p>El email introducido, <span style="color:#ff6802;"><%= email %></span><br />
            ya est&aacute; registrado en nuestra base de datos.</p>
            <p>Si quiere puede <a href="#" style="color:#ff6802;" id="baja">darse de baja</a>.</p>
            <p>Gracias por su inter&eacute;s.</p>
            <br />
            <div class="botones">
                <input type="button" class="btn" value="Aceptar" data-dismiss="modal">
            </div>
            
        <% end if 		'rsEmails("pw_es")=1
        
    end if 	'rsEmails.eof
    
    rsEmails.close
    set rsEmails=nothing
    %>
<% end select %>
<br />

<% if 1=2 then %>
	<p>Property Web ha procedido a registrar su email.</p>
	<p>A partir de ahora comenzar&aacute; a recibir en su correo diariamente nuestro bolet&iacute;n PW Flash. </p>
	<p>email: <span style="color:#ff6802;"><%= request.Form("email") %></span>.</p>
	<p>&nbsp;</p>
	<p>Nota: podr&aacute; cancelar su suscripci&oacute;n en el momento que lo desee.</p>
<% end if %>

            </div>
		</div>
    </div>
</div>
<script type="text/javascript">
$(document).ready(function() {
	$("#baja").click(function(e) {
        e.preventDefault();
		
		$.ajax({
			type: "POST",
			url: "/mailing/suscribe.asp",
			data: $("#frm_unsuscribe").serialize(),
			beforeSend: function() {}, /* test_footer_suscribe */
			success: function(data, txtStatus, jqSHR) {
				$("#ModalBox").html(data);
			}
		})
		
    });
});
</script>





