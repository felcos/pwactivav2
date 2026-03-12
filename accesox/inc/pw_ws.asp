<div class="panel-group">
	<div class="panel panel-primary">
    	<div class="panel-heading">
    		<h4 class="panel-title"><a data-toggle="collapse" href="#panel-ws">session (ws) <span class="pull-right icon icon-minus"></span></a></h4>
	    </div>
		<div id="panel-ws" class="panel-collapse in">
            <ul class="list-group">
                <li class="list-group-item">
                    <div class="row">
                        <div class="col-xs-4">.Licencia: </div>
                        <div class="col-xs-8"><%= session("pw_ws").Licencia %></div>
                    </div>
                    <div class="row">
                        <div class="col-xs-4">.LicenciaId: </div>
                        <div class="col-xs-8"><%= session("pw_ws").LicenciaId %></div>
                    </div>
                    <div class="row">
                        <div class="col-xs-4">.LicenciaNum: </div>
                        <div class="col-xs-8"><%= session("pw_ws").LicenciaNum %></div>
                    </div>
                </li>
                
                <li class="list-group-item">
                    <div class="row">
                        <div class="col-xs-6">.AccesoActivo: </div>
                        <div class="col-xs-6"><%= session("pw_ws").AccesoActivo %></div>
                    </div>
                    <div class="row">
                        <div class="col-xs-6">.ClienteActivo: </div>
                        <div class="col-xs-6"><%= session("pw_ws").ClienteActivo %></div>
                    </div>
                    <div class="row">
                        <div class="col-xs-6">.IniciadoRegAccesos: </div>
                        <div class="col-xs-6"><%= session("pw_ws").IniciadoRegAccesos %></div>
                    </div>
                </li>
                
            </ul>
            <table class="table" width="100%">
                <tr><td valign="top">.SessionId:</td><td><%= session("pw_ws").SessionId %></td></tr>
                <tr><td valign="top">.Host:</td><td><%= session("pw_ws").Host %></td></tr>
                <tr><td valign="top">.Mozilla:</td><td><%= session("pw_ws").Mozilla %></td></tr>
                <tr><td valign="top">.Navegador:</td><td><%= session("pw_ws").Navegador %></td></tr>
                <tr><td valign="top">.SO:</td><td><%= session("pw_ws").SO %></td></tr>
                <tr><td valign="top">.IP:</td><td><%= session("pw_ws").IP %></td></tr>
			</table>
		</div>
	</div>
</div>