<div class="panel-group">
    <div class="panel panel-primary">
        <div class="panel-heading">
        	<a data-toggle="collapse" href="#panel-navegador"><h4 class="panel-title">Navegador<span class="pull-right icon icon-minus"></span></h4></a>
        </div>
        <div id="panel-navegador" class="panel-collapse collapse in">
            <ul class="list-group">
                <% 'Sistema Operativo	
                    http_so = session("pw_ws").so
                    http_so = replace(http_so, " 64", "")
                    
                    select case http_so
                    case "win 10", "win 8.1", "win 8", "win 7", "win Vista", "win XP", "win XP/2003", "win 2000"
                        src = "/img/ua/os/windows.png"
                        
                    case "MacOS 10", "iOS 7", "iOS 8", "iPad"
                        src = "/img/ua/os/mac.png"
                        
                    case else
                        src = "/img/ua/os/" &  lcase(session("pw_ws").so) & ".png"
                    end select %>
                <li class="list-group-item">
                    <div class="row">
                    <!-- <div class="row informa" style="background-image:url('');"> -->
                        <div class="col-xs-4">Sist. Op.:</div>
                        <div class="col-xs-6"><%= session("pw_ws").so %></div>
                        <div class="col-xs-2" style="margin-top:-6px; margin-bottom:-6px;"><img src="<%= src %>" width="32px" /></div>
                    </div>
                </li>
                
                <% 'Navegador	
                    select case session("pw_ws").navegador
                    case "ie 11", "ie 10", "ie 9"
                        src = "/img/ua/browser/ie.png"
                    case "ie 8", "ie 7", "ie 6"
                        src = "/img/ua/browser/ie8.png"
                        
                    case else
                        src = "/img/ua/browser/" &  lcase(session("pw_ws").navegador) & ".png"
                        
                    end select %>
                <li class="list-group-item">
                    <div class="row">
                        <div class="col-xs-4">Navegador:</div>
                        <div class="col-xs-6"><%= session("pw_ws").navegador %></div>
                        <div class="col-xs-2" style="margin-top:-6px; margin-bottom:-6px;"><img src="<%= src %>" width="32px" /></div>
                    </div>
                </li>
                
                <li class="list-group-item">
                    <div class="row">
                        <div class="col-xs-4">Mozilla:</div>
                        <div class="col-xs-6"><%= session("pw_ws").mozilla %><% if session("navegador")<>"" then %><span class="destaca">modo OLD</span><% end if %></div>
                        <div class="col-xs-2"></div>
                    </div>
                </li>
                
                <li class="list-group-item">
                    <div class="row">
                        <div class="col-xs-4">IP cliente:</div>
                        <div class="col-xs-6"><%= session("pw_ws").ip %></div>
                        <div class="col-xs-2">&nbsp;</div>
                    </div>
                </li>
                
                <li class="list-group-item">
                    <div class="row">
                        <div class="col-xs-4">Pantalla:</div>
                        <div class="col-xs-6"><span id="pantalla_width" style="width:100px;">0</span> x <span id="pantalla_height">0</span></div>
                        <div class="col-xs-2"></div>
                    </div>
                </li>
                
                <li class="list-group-item">
                    <div class="row">
                        <div class="col-xs-4">EsMovil:</div>
                        <div class="col-xs-5">???<%'= lcase(EsMovil("")) %></div>
                        <div class="col-xs-3">ASP</div>
                    </div>
                </li>
                
                <li class="list-group-item">
                    <div class="row">
                        <div class="col-xs-4">matchMedia:</div>
                        <div class="col-xs-5" id="mobile_matchMedia"></div>
                        <div class="col-xs-3">js</div>
                    </div>
                </li>
                
            </ul>
        </div>
    </div>
</div>
<script type="text/javascript">
	
	var isMobile = window.matchMedia("only screen and (max-width: 760px)");
	document.getElementById("mobile_matchMedia").innerHTML = "" + isMobile.matches;
	
	dimensionesPantalla();
	document.getElementById("pantalla_width").innerHTML = winW;
	document.getElementById("pantalla_height").innerHTML = winH;
	
</script>