<script type="text/javascript" src="/_inc/jp/jetmenu.js"></script>
<%
resp = session("PW_WS").Comprobar_Licencia(request.Cookies("licencia")("u"), request.Cookies("licencia")("p"), request.Cookies("licencia")("n"), request.Cookies("licencia")("movil"), request.Cookies("licencia")("user_id"))
ini = session("PW_WS").IniCliente(request.Cookies("licencia")("n"), request.Cookies("licencia")("u"), request.Cookies("licencia")("p"), request.Cookies("licencia")("user_id"), request.Cookies("licencia")("movil"))


busqueda = request.form("busq")

sw_edif = false
sw_cc = false
sw_hotel = false
sw_retail = false
sw_empr = false
sw_prop = false
sw_disponib = false

if busqueda<>"" then
	select case request.form("tipo")
	case "edif"		
		sw_edif = true
		sw_cc = false
		sw_hotel = false
		sw_retail = false
		sw_empr = false
		sw_prop = false
		sw_disponib = false
		
		busqueda_txt = busqueda
		input_propietarios = false
		input_textos = true
		
	case "cc"		
		sw_edif = false
		sw_cc = true
		sw_hotel = false
		sw_retail = false
		sw_empr = false
		sw_prop = false
		sw_disponib = false
		
		busqueda_txt = busqueda
		input_propietarios = false
		input_textos = true
		
	case "hot"		
		sw_edif = false
		sw_cc = false
		sw_hotel = true
		sw_retail = false
		sw_empr = false
		sw_prop = false
		sw_disponib = false
		
		busqueda_txt = busqueda
		input_propietarios = false
		input_textos = true
		
	case "empr"		
		sw_edif = false
		sw_cc = false
		sw_hotel = false
		sw_retail = false
		sw_empr = true
		sw_prop = false
		sw_disponib = false
		
		busqueda_txt = busqueda
		input_propietarios = false
		input_textos = true
		
	case "retail"		
		sw_edif = false
		sw_cc = false
		sw_hotel = false
		sw_retail = true
		sw_empr = false
		sw_prop = false
		sw_disponib = false
		
		busqueda_txt = busqueda
		input_propietarios = false
		input_textos = true
		
	case "prop"		
		sw_edif = false
		sw_cc = false
		sw_hotel = false
		sw_retail = false
		sw_empr = false
		sw_prop = true
		sw_disponib = false
		
		busqueda_txt = ""
		input_propietarios = true
		input_textos = false
		
		'busq_prop = busqueda
		id_prop = request.form("id_prop")
		
	case "disponib"		
		sw_edif = false
		sw_cc = false
		sw_hotel = false
		sw_retail = false
		sw_empr = false
		sw_prop = false
		sw_disponib = true
		
		busqueda_txt = busqueda
		input_propietarios = false
		input_textos = true
		
	end select
end if

if not(input_propietarios or input_textos) then input_textos = true
%>
<% if request.Cookies("config")("header")="" then %>
<header class="header wrap">
    <div id="inner-header" class="clearfix">
    	<% if request.Cookies("dev")("menu")<>"" then %><div class="informa_servidor"><!--#include virtual="/inc/dev/menu.asp" --></div><% end if %>
        
        <div id="logo">
        <a title="Property Web" href="javascript:void(0);"><img src="/img/logo_pw.png" alt="Property Web: market intelligence: spain"></a>
        </div>
        
    </div>
</header>
<% end if %>
<div class="share-bar sticky">
    
    <div id="navmain">
        <ul class="navmain loadini">
        	<li class="home"><a href="/">P<span class="dt">roperty </span>W<span class="dt">eb</span></a></li>
            <li><a href="/flash/"><i class="icomoon-flash"></i><span class="dt">Daily Flash</span></a></li>
            <li><a href="javascript:void(0);"><i class="icomoon-buscadores"></i><span class="dt">Buscadores</span></a>
                <ul class="megamenu menu-form dropdown menu-buscadores">
                	<li><a href="/actualidad/" class="icobusq-actualidad">Actualidad<span class="dtt"> Inmobiliaria</span></a></li>
                    <li class="second"><a href="/estudios/" class="icobusq-estudios">Estudios<span class="dtt"> de Mercado</span></a></li>
                    <li><a href="/dealanalysis/" class="icobusq-dealanalysis">Deal Analysis</a></li>
                    <li class="second"><a href="/inversores/" class="icobusq-inversores">Inversores</a></li>
                    <li><a href="/vencimientos/" class="icobusq-vencimientos">Vencimientos<span class="dtt"> de Contrato</span></a></li>
                    <li class="second"><a href="/demandas/" class="icobusq-demandas">Demandas</a></li>
                    <li><a href="/subastas/" rel="nofollow" class="icobusq-subastas">Subastas<span class="dtt">/Concursos</span></a></li>
                    <li class="second"><a href="/info/" class="icobusq-info-activos">Info</a></li>
                </ul>
            </li>
            <li id="head_btn_info"><a href="javascript:void(0);"><i class="icomoon-info"></i><span class="dt">Info</span></a>
                <div class="megamenu menu-form menu-info" id="head_div_info">
                    <div class="row">
                        <div class="menu-box">
<form action="/info/" method="post" id="frmInfo">
    <div id="info-buscar" <% if not input_textos then %>style="display:none;"<% end if %>>
        <input type="text" name="busq" value="<%= busqueda_txt %>" id="info-busq" placeholder="Buscar Info..." <% if not input_textos then %>disabled="disabled"<% end if %> required="required" autocomplete="off" >
    </div>
    <div id="info-propietarios" <% if not input_propietarios then %>style="display:none;"<% end if %> >
        <input id="id_prop" type="hidden" name="id_prop" value="<%= id_prop %>"/>
        <select name="busq" id="select-propietarios" <% if not input_propietarios then %>disabled<% end if %> >
            <option value="" <% if request.Form("id_prop")="" then %>selected<% end if %>>seleccionar propietario</option>
            <%
            set rsHeadProp = Server.CreateObject("ADODB.Recordset")
            
            sql = "SELECT * FROM EMPRESAS WHERE ID IN ("
            sql = sql & "SELECT id_empresa FROM c_inmuebles_agentes WHERE ((tipo='prop') AND (fecha_hasta IS NULL AND fecha_desde IS NOT NULL))"
            sql = sql & ") ORDER BY NOMBRE"
            
            rsHeadProp.open sql, session("connPW")
            do while not rsHeadProp.eof
                %><option value="<%= rsHeadProp("id") %>" <% if cstr(rsHeadProp("id"))=cstr(id_prop) then %>selected<% end if %>><%= rsHeadProp("nombre") %></option>
                <% rsHeadProp.movenext
                loop
                rsHeadProp.close	
            set rsHeadProp=nothing
            %>
        </select>
    </div>
    
    <input type="submit" value="Buscar" id="info-submit" name="submit">
    <ul>
        <li>
            <input name="tipo" type="radio" class="infoRadio opt_tipo" value="prop" id="prop" <% if sw_prop then %>checked<% end if %>/>
            <label for="prop"><span class="icomoon-key"></span> Propietario Actual</label>
        </li>
        <li>
            <input name="tipo" type="radio" class="infoRadio opt_tipo" value="cc" id="cc" <% if sw_cc then %>checked<% end if %>/>
            <label for="cc"><span class="icomoon-coin-euro"></span> Centro Comercial</label>
        </li>
        <li>
            <input name="tipo" type="radio" class="infoRadio opt_tipo" value="hot" id="hot" <% if sw_hotel then %>checked<% end if %>/>
            <label for="hot"><span class="icomoon-home"></span> Hotel</label>
        </li>
        <li>
            <input name="tipo" type="radio" class="infoRadio opt_tipo" value="edif" id="edif" <% if sw_edif then %>checked<% end if %>/>
            <label for="edif"><span class="icomoon-office"></span> Edificio o Direcci&oacute;n</label>
        </li>
        <li class="indent">
            <input name="tipo" type="radio" class="infoRadio opt_tipo" value="disponib" id="disponib" <% if sw_disponib then %>checked<% end if %>/>
            <label for="disponib"><span class="icomoon-checkmark"></span> Disponibilidad</label>
        </li>
        <li>
            <input name="tipo" type="radio" class="infoRadio opt_tipo" value="empr" id="empr" <% if sw_empr then %>checked<% end if %>/>
            <label for="empr"><span class="icomoon-briefcase"></span> Empresa</label>
        </li>
        <% IF 1=2 THEN %>
        <li>
            <input name="tipo" type="radio" class="infoRadio opt_tipo" value="retail" id="retail" disabled="disabled"/>
            <label for="retail"><span class="icomoon-road"></span> Info - Calle (Retail)</label>
        </li>
        <% END IF %>
    </ul>
    
</form>
                        </div>
                    </div>
                </div>
            </li>
            
            
            <li><a href="javascript:void(0);"><i class="icomoon-info2"></i><span class="pages">Desarrollo</span></a>
                <ul class="megamenu menu-form dropdown dropdown menu-admin">
	                <li><a title="desarrollo" href="/dev/">Desarrollo</a></li>
					
                    <li class="sub5"><a href="/_inc/config.asp?set=modo&val=foldy" id="btn" class="bin"><% if session("modo")="foldy" then %><span class="destaca">foldy</span><% else %>foldy<% end if %></a></li>
                    <li class="sub5"><a href="/_inc/config.asp?set=modo&val=jp" id="btn" class="bin"><% if session("modo")="jp" then %><span class="destaca">jp</span><% else %>jp<% end if %></a></li>
                    <li class="sub5"><a href="/_inc/config.asp?set=modo&val=daniel" id="btn" class="bin"><% if session("modo")="daniel" then %><span class="destaca">daniel</span><% else %>daniel<% end if %></a></li>
                    <li class="sub5"><a href="/_inc/config.asp?set=modo&val=normal" id="btn" class="bin"><% if session("modo")="normal" then %><span class="destaca">normal</span><% else %>normal<% end if %></a></li>
                    <li class="sub5"><a href="/_inc/config.asp?set=modo&val=javier" id="btn" class="bin"><% if session("modo")="javier" then %><span class="destaca">javier</span><% else %>javier<% end if %></a></li>
                    
                    <li class="sub2"><a title="Session Abandon" href="/acceso/session_abandon.asp">Session Abandon</a></li>
				    <li class="sub2"><a title="LogOut" href="javascript: LogOut();">LogOut</a></li>
                    
                    <li class="sub"><a title="informa" href="/dev/informa.asp">Informa</a></li>
                    <li class="sub"><a title="Test Mododernizr" href="/dev/modernizr.asp">Mododernizr</a></li>
                    
                    <li><a title="Admin" href="/admin/">Admin</a></li>
                    <li><a title="Gr&aacute;ficas" href="/graficas/">Gr&aacute;ficas</a></li>
                    
                    <li><a href="/admin/inmuebles/" title="Mantenimiento de Inmuebles">Mantenimiento de Inmuebles</a>
                    <li class="sub"><a href="/admin/inmuebles/todos.asp" title="Todos">Todos</a></li>
                    <li class="sub"><a href="/admin/inmuebles/centros/" title="Centros Comerciales">Centros</a></li>
                    <li class="sub"><a href="/admin/inmuebles/hoteles/" title="Hoteles">Hoteles</a></li>
                    
                    
                    <li><a href="/admin/clientes/">Clientes</a></li>
                    <li class="sub"><a href="/admin/clientes/no-acceden.asp">No Acceden</a></li>
                    <li class="sub"><a href="/admin/accesos/">Accesos</a></li>
                    <li class="sub"><a href="/admin/graf/">gr&aacute;ficas</a></li>
                    
                </ul>
            </li>
            
            
            <% if 1=2 then %>
            <li class="right gle"><a title="Info-Activos" href="/info/"><i class="icomoon-busq-info-activos"></i></a></li>
            <li class="right twit"><a title="Subastas/Concursos" href="/subastas/"><i class="icomoon-busq-subastas"></i></a></li>
            <li class="right gle"><a title="Demandas" href="/demandas/"><i class="icomoon-busq-demandas"></i></a></li>
            <li class="right twit"><a title="Posibles Vencimientos de Contrato" href="/vencimientos/"><i class="icomoon-busq-vencimientos"></i></a></li>
            <li class="right rss"><a title="Inversores" href="/inversores/"><i class="icomoon-busq-inversores"></i></a></li>
            <li class="right mail"><a title="Deal Analysis" href="/dealanalysis/"><i class="icomoon-busq-dealanalysis"></i></a></li>
            <li class="right fbk"><a title="Estudios de Mercado" href="/estudios/"><i class="icomoon-busq-estudios"></i></a></li>
            <li class="right rss"><a title="Actualidad Inmobiliaria" href="/actualidad/"><i class="icomoon-busq-actualidad"></i></a></li>
            
            <li class="right mnu-dev"><a title="user" href="javascript:void(0);"><i class="icomoon-mnu-user"></i></a></li>
            <li class="right mnu-dev"><a title="config" href="javascript:void(0);"><i class="icomoon-mnu-config"></i></a></li>
            <% end if %>
            
            
            <!--
            <li class="mnu-informa"><i class="icomoon-mnu-informa-pantalla"></i></li>
            <li class="mnu-informa"><i id="informa-navegador" class="fa fa-mnu-informa"></i></li>
            -->
            <!-- class="right mnu-dev" -->
            
            
            <% if 1=2 then %>
            
            <li class="right mnu-dev"><a title="desarrollo" href="javascript:void(0);"><i class="icomoon-mnu-dev"></i><span class="pages">Desarrollo</span></a>
<ul class="megamenu menu-form dropdown dropdown">
    <li><a title="Session Abandon" href="/acceso/session_abandon.asp">Session Abandon</a></li>
    <li class="second"><a title="LogOut" href="javascript: LogOut();">LogOut</a></li>
    
</ul>
            </li>
			
            
            <li class="right mnu-dev"><a title="admin" href="#" id="aaa"><i class="icomoon-mnu-admin"></i><span class="pages">Admin</span></a>
            	<div class="megamenu menu-form zzzz">
                    <div class="row">
                        <div class="menu-box">
                            <form method="get" action="">
                                <input type="text" name="s" placeholder="Enter search terms" required>
                                <input type="submit" value="Search" id="searchsubmit" name="submit" class="submit">
                            </form>
                        </div>
                    </div>
                </div>
            </li>
            
            <!--
            <li class="mnu-dev mnu-informa"><a title="xxx" href="javascript:void(0);"><i class="icomoon-mnu-informa-so"></i></a></li>
            -->
            
            <% end if %>
            
        </ul>
        <!---->
        <ul id="navmain-informa">
        	<li><i id="informa-navegador2" class="fa fa-mnu-informa"></i></li>
            <li><a title="Informa Pantalla" href="javascript:_informa_top();"><i class="icomoon-mnu-informa-pantalla"></i></a></li>
        </ul>
        
    </div>
    
</div>
<% IF 1=2 THEN %>
<div id="barrita" style="background:#658db5; border-top:1px solid #7397BB; color:#FFF;">
    <nav role="navigation" class="nav clearfix">
        <ul class="tabs-top">
            <li class="highlight"><a href="#">Magazine</a></li>
            <li><a class="icon-heart" href="#"><span class="mobile-tabs">Popular</span></a></li>
            <li><a class="icon-star" href="#"><span class="mobile-tabs">Recommended</span></a></li>
        </ul>
    </nav>
</div>
<% END IF 

select case session("http_navegador")
case "edge", "ie 11", "ie 10", "ie 9", "ie 8", "ie 7", "ie 6"
	navegador = "internet-explorer"
case else
	navegador = session("http_navegador")
end select
%>
<script type="text/javascript">
jQuery(document).ready( function($) {
	$(".nulo").click(function(e) {
        return false;
    });
	
	$().navmain();
	
	$("#informa-navegador").addClass("fa-<%= navegador %>");
	$("#informa-navegador2").addClass("fa-<%= navegador %>");
	
	$(".navmain").removeClass("loadini");
	/*
	var stickyNavTop = $(".share-bar").offset().top;
	
	var stickyNav = function(){
		var scrollTop = $(window).scrollTop();
			 
		if (scrollTop > stickyNavTop) { 
			$(".share-bar").addClass("sticky");
		} else {
			$(".share-bar").removeClass("sticky"); 
		}
	};


	stickyNav();

	$(window).scroll(function() {
		//console.log("scroll...")
		stickyNav();
	});
	*/

});

function fija_top() {
	$("header").slideToggle();
	
}
function informa_top() {
	$("#barrita").slideToggle();
	
}

$(document).ready(function() {
	
	$('.simplemodal').click(function (e) {
		//console.log(".simplemodal.click")
		
		var href = $(this).attr("href");
		if (href=="#") {
			$("#ModalBox").load(
				"/acceso/password.asp",
				href,
				function(recibe, textStatus, xhr) { $("#ModalBox").modal("show") }
			);
			return false;
			
		} else {
			href = href.substr( href.indexOf("?")+1, href.length);
			
			if ( getCookie("condiciones")=="" ) {
				$("#ModalBox").load(
					"/acceso/password.asp",
					href,
					function(recibe, textStatus, xhr) { $("#ModalBox").modal("show") }
				);
				return false;
				
			} else {}
		}
	});
	
	$(".opt_tipo").click(function () {	 
		var rtipo = $('input:radio[name=tipo]:checked').val();
		
		if (rtipo=="edif") {
			$("#info-propietarios").hide();
			$("#info-buscar").show();
			
			$("#select-propietarios").prop("disabled", true);
			$("#info-busq").prop("disabled", false);
			
			$("#info-busq").focus();
			$("#info-busq").select();
			
		} else if (rtipo=="disponib") {
			$("#info-propietarios").hide();
			$("#info-buscar").show();
			
			$("#select-propietarios").prop("disabled", true);
			$("#info-busq").prop("disabled", false);
			
			$("#info-busq").focus();
			$("#info-busq").select();
			
		} else if (rtipo=="cc") {
			$("#info-propietarios").hide();
			$("#info-buscar").show();
			
			$("#select-propietarios").prop("disabled", true);
			$("#info-busq").prop("disabled", false);
			
			$("#info-busq").focus();
			$("#info-busq").select();
			
		} else if (rtipo=="hot") {
			$("#info-propietarios").hide();
			$("#info-buscar").show();
			
			$("#select-propietarios").prop("disabled", true);
			$("#info-busq").prop("disabled", false);
			
			$("#info-busq").focus();
			$("#info-busq").select();
			
		} else if (rtipo=="retail") {
			$("#info-propietarios").hide();
			$("#info-buscar").show();
			
			$("#select-propietarios").prop("disabled", true);
			$("#info-busq").prop("disabled", false);
			
			$("#info-busq").focus();
			$("#info-busq").select();
			
		} else if (rtipo=="empr") {
			$("#info-propietarios").hide();
			$("#info-buscar").show();
			
			$("#select-propietarios").prop("disabled", true);
			$("#info-busq").prop("disabled", false);
			
			$("#info-busq").focus();
			$("#info-busq").select();
			
		} else if (rtipo=="prop") {
			$("#info-buscar").hide();
			$("#info-propietarios").show();
			
			$("#select-propietarios").prop("disabled", false);
			$("#info-busq").prop("disabled", true);
			
			$("#select-propietarios").focus();
			
		}
		
	});
	
	$("#select-propietarios").change(function() {
		
		if ($("#select-propietarios").val()) {
			
			$("#id_prop").val($("#select-propietarios").val());
			//$("#frmInfo").submit();
			//document.getElementById("frmInfo").submit();
			$("#info-submit").click();
		}
	});
	
	
});

function ver_div_info() {
	//$("#head_div_info").show();
	$("#head_btn_info").trigger("mouseover");
	$("#head_div_info").trigger("mouseover");
}

</script>