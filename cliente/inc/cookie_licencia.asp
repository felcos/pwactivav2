<% select case session("IniCliente")
case 0
	clase = "success"
	
case 1, 2
	clase = "warning "
case 3
	clase = "danger"
	
case else
	clase = "primary"
end select %>
<div class="panel-group">
    <div class="panel panel-<%= clase %>">
        <div class="panel-heading"><h4 class="panel-title"><a data-toggle="collapse" href="#panel-licencia">cookie. LICENCIA<span class="pull-right icon icon-minus"></span></a></h4></div>
        <div id="panel-licencia" class="panel-collapse collapse in">
            <ul class="list-group">
                <li class="list-group-item">
                  <% if request.Cookies("licencia")="" then %>
                    <div class="row">
                        <div class="col-xs-12"><strong>NO EXISTE</strong></div>
                    </div>
                  <% else %>
                    <div class="row">
                        <div class="col-xs-9"><%= request.Cookies("licencia")("n") %></div>
                        <div class="col-xs-3 peq"><%= request.Cookies("licencia")("user_id") %></div>
                    </div>
                    <div class="row">
                        <div class="col-xs-9"><%= request.Cookies("licencia")("u") %></div>
                        <div class="col-xs-3 peq"><%= request.Cookies("licencia")("client_id") %></div>
                    </div>
                  <% end if %>
                </li>
                
                <li class="list-group-item">
                    <div class="row">
                        <% select case session("IniCliente")
                        case 0
                            msg = "OK"
                        case 1
                            msg = "Licencia No Existe: Licencia Eliminada"
                        case 2
                            msg = "Cliente No Existe"
                        case 3
                            msg = "Cliente No Activo"
                        case 1000
                            msg = "Error Indefinido"
                        case else
                            msg = "??"
                        end select %>
                        <div class="col-xs-9">session.IniCliente:</div>
                        <div class="col-xs-3"><span data-toggle="tooltip" data-placement="right" title="<%= msg %>"><%= session("IniCliente") %></span></div>
                    </div>
                </li>
                <li class="list-group-item">
                    <div class="row">
                        <% 
                        resp = session("pw_ws").ComprobarEmpresa(request.Cookies("licencia")("u"),request.Cookies("licencia")("p"))
                        select case resp
                        case 0
                            msg = "OK"
                        case 1
                            msg = "Cliente No Existe"
                        case 2
                            msg = "Cliente No Activo"
                        case 1000
                            msg = "Error Indefinido"
                        case else
                            msg = "??"
                        end select %>
                        <div class="col-xs-9">.ComprobarEmpresa:</div>
                        <div class="col-xs-3"><span data-toggle="tooltip" data-placement="right" title="<%= msg %>"><%= resp %></span></div>
                    </div>
                    <div class="row">
                        <% 
                        resp = session("pw_ws").ComprobarLicencia(request.Cookies("licencia")("u"), request.Cookies("licencia")("p"), request.Cookies("licencia")("n"), request.Cookies("licencia")("movil"), request.Cookies("licencia")("user_id"))
                        select case resp
                        case 0
                            msg = "OK"
                        case 1
                            msg = "Licencia No Existe"
                        case 2
                            msg = "Cliente No Activo"
                        case 1000
                            msg = "Error Indefinido"
                        case else
                            msg = "??"
                        end select %>
                        <div class="col-xs-9">.ComprobarLicencia:</div>
                        <div class="col-xs-3"><span data-toggle="tooltip" data-placement="right" title="<%= msg %>"><%= resp %></span></div>
                    </div>
                </li>
                
              <li class="list-group-item dev">
                <div class="row">
                    <div class="col-xs-12">
                        <%= request.ServerVariables("SERVER_NAME") %>
                    </div>
                </div>
              </li>
              <% if request.Cookies("licencia")<>"" then %>
              <li class="list-group-item dev">
                <div class="row">
                    <div class="col-xs-12">
                        <% for each elto in request.Cookies("licencia")
                            %><span class="badge"><%= elto %>: <%= request.Cookies("licencia")(elto) %></span> <%
                        next %>
                    </div>
                </div>
              </li>
              <% end if %>
            </ul>
        </div>
    </div>
</div>