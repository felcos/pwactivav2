<% 
session("IniCliente") = session("pw_ws").IniCliente(request.Cookies("licencia")("n"), request.Cookies("licencia")("u"), request.Cookies("licencia")("p"), request.Cookies("licencia")("user_id"), request.Cookies("licencia")("movil"))

if request.Cookies("dev")<>"" then
	ver_contadores = true
	ver_contadores2 = true
	'ver_contadores2 = false
end if

chat_email=request.Cookies("licencia")("n")
chat_movil=request.Cookies("licencia")("movil")
chat_empresa=request.Cookies("licencia")("u")


'busq header
frmInfo_busq = trim(request.form("frmInfo_busq"))	'ucase
frmInfo_tipo = request.form("frmInfo_tipo")	
frmInfo_propietario = request.form("frmInfo_propietario")

if frmInfo_tipo="" then
	'frmInfo_tipo="edif"
	if instr(request.ServerVariables("URL"), "/disponibilidad/")>0 then frmInfo_tipo="disp"
	if instr(request.ServerVariables("URL"), "/takeup/")>0 then frmInfo_tipo="takeup"
	if instr(request.ServerVariables("URL"), "/nidisp/")>0 then frmInfo_tipo="nidisp"
end if



'ArticulosLeidos
dim ArticulosLeidos()
ii=0
for each elto in split(session("pw_ws").ArticulosLeidos(), "#")
	if elto<>"" then
		redim preserve ArticulosLeidos(ii)
		ArticulosLeidos(ii) = elto
		ii=ii+1
	end if
next
%>
<!--#include virtual="/cliente/informa.asp" -->
<div class="container ">
	<div id="containerHeader" class="row">
		<header class="containerHeader clearfix">

			<div class="col-sm-9 izquierda">
				<div class="row">
					<!--logoPW-->
					<div class=" col-sm-12 col-md-4 logoPW">
						<a href="/"><img src="/_inc/javier/img/logoPW.png" class="logo"></a> 
						<div class="visible-xs-inline-block tlfOculto">
							<% if request.Cookies("dev")="" then %>
								<span class="icon-phone"></span> 914 295 143 
							<% else %>
								<span class="icon-earth"></span> <%= lcase(session("pw_ws").ServidorWeb) %> &nbsp; 
								<span class="icon-database"></span> <%= lcase(session("pw_ws").ServidorBD) %> &nbsp; 
								<span style="float:right; font-size:11px;"><%= session("pw_ws").SessionID %></span>
								<li class="informa">
									<span class="informa_width">0</span> x <span class="informa_height">0</span>
									<% if session("movil") then %> - <span class="destaca">MOVIL</span><% end if %>&nbsp;-&nbsp;
                                    <span class="informa_touch"></span>
									<%= session("pw_ws").version() %>
									<a style="float:right;" href="/acceso/session_abandon.asp">abandon</a>
								</li>
								<li class="userGtr informa">
									reg: <% if session("pw_ws").IniciadoRegAccesos then %>iniciado<% else %>!<% end if %> &nbsp; - &nbsp; 
									<% if session("pw_ws").NoTrack then %><span class="destaca">NO TRACK</span><% else %><span>track</span><% end if %> &nbsp; - &nbsp; 
									<% if request.Cookies("dev")("css")="" then %><a href="/dev/bin/cookie_dev.asp?act=css_bs">css</a><% else %><a href="/dev/bin/cookie_dev.asp?act=css_none">css</a><% end if %>: <% if request.Cookies("dev")("css")="" then %>-<% else %>bs<% end if %>
								</li>
								<li class="links">
									<a href="/dev/">dev</a> - 
									<a href="/admin/">admin</a> - 
									<a href="/cliente/" >cliente</a>
									
									<a href="javascript:void(0);" data-toggle="notify" data-load="/cliente/quotas.asp" >quotas</a>
									<a href="javascript:void(0);" data-toggle="notify" data-load="/cliente/leidos.asp" >leidos</a>
								</li>
							<% end if %>
						</div><!-- //tlfOculto -->    
						<div class="aboutUs">
							<ul>
								<li class="li-movil"><a href="/flash/" class="PWhoy"><img src="/img/shared/newsPaper.png"/><p><span class="icoLogo"></span>PW News Summary</p></a></li>
								<li class="li-movil"><a href="/presenta/" target="_blank"><span class="icon-user-tie"></span><p>Con&oacute;zcanos</p></a></li>
								<li class="visible-xs-inline-block"><a href="#" id="head_btn_info"><span class="icon-search"></span><p>Info</p></a></li>
								<li class="visible-xs-inline-block"><a href="#" id="head_btn_busq"><span class="icon-list"></span><p>Busquedas</p></a></li> 
							</ul>
						</div><!-- //aboutUs -->
            
					</div>
					
					<div class="col-sm-12 col-md-8">
						<div class="row buscadores">
							<div class="col-sm-6 colInfo" id="head_div_info">
								<h1>Seleccionar Info:</h1>
                                <% select case frmInfo_tipo
								case "disp"
									url = "/disponibilidad/"
								case "nidisp"
									url = "/nidisp/"
								case "takeup"
									url = "/takeup/"
								case else
									url = "/info/"
								end select %>
								<form action="<%= url %>" method="post" id="frmInfo">
									<ul>
                                        <li>
											<input name="frmInfo_tipo" type="radio" class="infoRadio frmInfo_tipo" value="prop" id="frmInfo_prop" <% if frmInfo_tipo="prop" then %>checked<% end if %>/>
											<label for="frmInfo_prop" id="lblInfo_prop" class="lblInfo <% if frmInfo_tipo="prop" then %>activo<% end if %>"><span class="icon-key"></span> Propietario Actual<% if ver_contadores then %> <span data-toggle="contador_leidos" data-content="prop"><%= ubound(filter(ArticulosLeidos, "prop"))+1 %></span><% end if %></label>
											<% if not(session("pw_ws").accesoInfoPropietario) then %><span class="icon-lock"></span><% end if %>
										</li>
										<li>
											<input name="frmInfo_tipo" type="radio" class="infoRadio frmInfo_tipo" value="cc" id="frmInfo_cc" <% if frmInfo_tipo="cc" then %>checked<% end if %>/>
											<label for="frmInfo_cc" id="lblInfo_cc" class="lblInfo <% if frmInfo_tipo="cc" then %>activo<% end if %>"><span class="icon-coin-euro"></span>Centro/Parque/Nave Comercial<% if ver_contadores then %> <span data-toggle="contador_leidos" data-content="cc"><%= ubound(filter(ArticulosLeidos, "cc"))+1 %></span><% end if %></label>
											<% if not(session("pw_ws").accesoInfoCentroComercial) then %><span class="icon-lock"></span><% end if %>
										</li><% 'if request.Cookies("licencia")("u")="PW" then %>
										<li>
											<input name="frmInfo_tipo" type="radio" class="infoRadio frmInfo_tipo" value="ni" id="frmInfo_ni" <% if frmInfo_tipo="ni" then %>checked<% end if %>/>
											<label for="frmInfo_ni" id="lblInfo_ni" class="lblInfo <% if frmInfo_tipo="ni" then %>activo<% end if %>"><span class="icon-folder"></span> Industrial/Logistica<% if ver_contadores then %> <span data-toggle="contador_leidos" data-content="ni"><%= ubound(filter(ArticulosLeidos, "ni"))+1 %></span><% end if %></label>
											<% if not(session("pw_ws").accesoInfoEdificio) then %><span class="icon-lock"></span><% end if %>
										</li><% 'end if %>
										<% 'if request.Cookies("licencia")("u")="PW" then %>
										<li class="indent">
											<input name="frmInfo_tipo" type="radio" class="infoRadio frmInfo_tipo" value="nidisp" id="frmInfo_nidisp" <% if frmInfo_tipo="nidisp" then %>checked<% end if %>/>
											<label for="frmInfo_nidisp" id="lblInfo_nidisponib" class="lblInfo <% if frmInfo_tipo="nidisp" then %>activo<% end if %>"><span class="icon-checkmark"></span> Disponibilidad<% if ver_contadores then %> <span data-toggle="contador_leidos" data-content="dis"><%= ubound(filter(ArticulosLeidos, "dis"))+1 %></span><% end if %></label>
											<% if not(session("pw_ws").accesoDisponibilidad) then %><span class="icon-lock"></span><% end if %>
										</li>
										<% ' end if %>
										<li>
											<input name="frmInfo_tipo" type="radio" class="infoRadio frmInfo_tipo" value="hot" id="frmInfo_hot" <% if frmInfo_tipo="hot" then %>checked<% end if %>/>
											<label for="frmInfo_hot" id="lblInfo_hot" class="lblInfo <% if frmInfo_tipo="hot" then %>activo<% end if %>"><span class="icon-home"></span> Hotel<% if ver_contadores then %> <span data-toggle="contador_leidos" data-content="hot"><%= ubound(filter(ArticulosLeidos, "hot"))+1 %></span><% end if %></label>
											<% if not(session("pw_ws").accesoInfoHotel) then %><span class="icon-lock"></span><% end if %>
										</li>
										<li>
											<input name="frmInfo_tipo" type="radio" class="infoRadio frmInfo_tipo" value="edif" id="frmInfo_edif" <% if frmInfo_tipo="edif" then %>checked<% end if %>/>
											<label for="frmInfo_edif" id="lblInfo_edif" class="lblInfo <% if frmInfo_tipo="edif" then %>activo<% end if %>"><span class="icon-office"></span> <% if ver_contadores then %>Edificio o Dirección<span data-toggle="contador_leidos" data-content="edif"><%= ubound(filter(ArticulosLeidos, "edif"))+1 %></span>+<span data-toggle="contador_leidos" data-content="dir"><%= ubound(filter(ArticulosLeidos, "dir"))+1 %></span>+<span data-toggle="contador_leidos" data-content="zona"><%= ubound(filter(ArticulosLeidos, "zona"))+1 %></span><% else %>Edificio o Dirección<% end if %></label>
											<% if not(session("pw_ws").accesoInfoEdificio) then %><span class="icon-lock"></span><% end if %>
										</li>
										<li class="indent">
											<input name="frmInfo_tipo" type="radio" class="infoRadio frmInfo_tipo" value="disp" id="frmInfo_disp" <% if frmInfo_tipo="disp" then %>checked<% end if %>/>
											<label for="frmInfo_disp" id="lblInfo_disponib" class="lblInfo <% if frmInfo_tipo="disp" then %>activo<% end if %>"><span class="icon-checkmark"></span> Disponibilidad<% if ver_contadores then %> <span data-toggle="contador_leidos" data-content="dis"><%= ubound(filter(ArticulosLeidos, "dis"))+1 %></span><% end if %></label>
											<% if not(session("pw_ws").accesoDisponibilidad) then %><span class="icon-lock"></span><% end if %>
										</li>
                                        <li class="indent">
											<input name="frmInfo_tipo" type="radio" class="infoRadio frmInfo_tipo" value="takeup" id="frmInfo_takeup" <% if frmInfo_tipo="takeup" then %>checked<% end if %>/>
											<label for="frmInfo_takeup" id="lblInfo_takeup" class="lblInfo <% if frmInfo_tipo="takeup" then %>activo<% end if %>"><span class="icon-checkmark"></span> Take Up<% if ver_contadores then %> <span data-toggle="contador_leidos" data-content="takeup"><%= ubound(filter(ArticulosLeidos, "takeup"))+1 %></span><% end if %></label>
											<% if not(session("pw_ws").accesoTakeUp) then %><span class="icon-lock"></span><% end if %>
										</li>
										<li>
											<input name="frmInfo_tipo" type="radio" class="infoRadio frmInfo_tipo" value="empr" id="frmInfo_empr" <% if frmInfo_tipo="empr" then %>checked<% end if %>/>
											<label for="frmInfo_empr" id="lblInfo_empr" class="lblInfo <% if frmInfo_tipo="empr" then %>activo<% end if %>"><span class="icon-briefcase"></span> Empresa<% if ver_contadores then %> <span data-toggle="contador_leidos" data-content="empr"><%= ubound(filter(ArticulosLeidos, "empr"))+1 %></span><% end if %></label>
											<% if not(session("pw_ws").accesoInfoEmpresa) then %><span class="icon-lock"></span><% end if %>
										</li>
										<li style="display:none;">
											<input name="frmInfo_tipo" type="radio" class="infoRadio frmInfo_tipo" value="retail" id="frmInfo_retail" disabled="disabled"/>
											<label for="frmInfo_retail" id="lblInfo_retail" class="lblInfo <% if frmInfo_tipo="retail" then %>activo<% end if %>"><span class="icon-road"></span> Info - Calle <span class="enconstruccion">(en construcción)</span></label>
										</li>
										<li>
											<div class="inputField">
												<div class="input-group info-buscar" id="info-buscar" <% if frmInfo_tipo="prop" then %>style="display:none; background:#CCC;"<% end if %>>
													<input type="text" class="form-control" value="<%= trim(frmInfo_busq) %>" placeholder="" id="frmInfo_busq" name="frmInfo_busq" <% if frmInfo_tipo="prop" or frmInfo_tipo="disp" or frmInfo_tipo="takeup" then %>disabled="disabled"<% end if	' required="required" %>  autocomplete="off">
													<span class="input-group-btn"><button class="btn btn-default icon-search <% if frmInfo_tipo="prop" or frmInfo_tipo="disp" or frmInfo_tipo="takeup" then %>disabled<% end if %>" type="submit" id="frmInfo-submit" > </button></span>
												</div>
												<div id="info-propietarios" <% if not frmInfo_tipo="prop" then %>style="display:none;"<% end if %>>
													<%
													set rsHead = Server.CreateObject("ADODB.Recordset")
													'if session("pw_ws").AccesoActivo then 
													if session("pw_ws").AccesoInfoPropietario then %>
														<select id="frmInfo_propietario" name="frmInfo_propietario" <% if not frmInfo_tipo="prop" then %>disabled<% end if %> class="form-control info-buscar ">
                                                            <option value="" <% if frmInfo_propietario="" then %>selected<% end if %>>Seleccione Propietario</option>
                                                            <%
                                                            sql = "SELECT * FROM EMPRESAS WHERE ID IN ("
                                                            sql = sql & "SELECT id_empresa FROM c_inmuebles_agentes WHERE ((tipo='prop') AND (fecha_hasta IS NULL AND fecha_desde IS NOT NULL))"
                                                            sql = sql & ") ORDER BY NOMBRE"
                                                            rsHead.open sql, session("connPW")
                                                            do while not rsHead.eof
                                                                %><option value="<%= rsHead("id") %>" <% if cstr(rsHead("id"))=cstr(frmInfo_propietario) then %>selected<% end if %>><%= rsHead("nombre") %></option><%
                                                                rsHead.movenext
                                                            loop
                                                            rsHead.close
                                                            %>
                                                        </select>
													<% else %>
                                                    	<select class="form-control info-buscar ">
															<%
															sql = "SELECT COUNT(*) AS nn FROM EMPRESAS WHERE ID IN ("
															sql = sql & "SELECT id_empresa FROM c_inmuebles_agentes WHERE ((tipo='prop') AND (fecha_hasta IS NULL AND fecha_desde IS NOT NULL))"
															sql = sql & ")"
															rsHead.open sql, session("connPW")
																%><option value="" ><%= rsHead("nn") %> Propietarios registrados</option><%
															rsHead.close
															%>
														</select>
													<% end if
													set rsHead=nothing
													%>
												</div>

												<div class="tip-caja fade right in " role="" id="frmInfo-tip">
													<div class="arrow"></div>
													<div class="tip-title" id="frmInfo-tip-title">Para comenzar la b&uacute;squeda</div>
													<div class="tip-content" id="frmInfo-tip-content">Por favor, chequea una <span class="naranjaB">opci&oacute;n</span> antes </div>
												</div>
												
											</div><!--inputField : fin-->
										</li>
									</ul>
								</form>
							</div><!-- // colInfo -->
							<div class="col-sm-6 colBusqueda" id="head_div_busq">
								<h1>B&uacute;squedas:</h1>
								<ul>
									<li><a href="/dealanalysis/">Deal Analysis</a><% if ver_contadores2 then %><span data-toggle="contador_leidos" data-content="ope"><%= ubound(filter(ArticulosLeidos, "ope"))+1 %></span><% end if %><% 
										if not(session("pw_ws").accesoOperacionesHoy or session("pw_ws").accesoOperaciones) then %><span class="icon-lock"></span><% end if
									%></li>
									<li><a href="/actualidad/">News Data Base <% if not ver_contadores2 then %> <% else %>Inmob&hellip;<% end if %></a><% if ver_contadores2 then %><span data-toggle="contador_leidos" data-content="not"><%= ubound(filter(ArticulosLeidos, "not"))+1 %></span>/<span data-toggle="contador_leidos" data-content="rum"><%= ubound(filter(ArticulosLeidos, "rum"))+1 %></span><% end if %><% 
										if not(session("pw_ws").accesoNoticiasHoy or session("pw_ws").accesoNoticias) then %><span class="icon-lock"></span><% end if 
										if not(session("pw_ws").accesoRumoresHoy or session("pw_ws").accesoRumores) then %><span class="icon-lock"></span><% end if 
									%></li>
									<li><a href="/estudios/">Estudio de mercado</a><% if ver_contadores2 then %><span data-toggle="contador_leidos" data-content="est"><%= ubound(filter(ArticulosLeidos, "est"))+1 %></span><% end if %><%
										if not(session("pw_ws").accesoEstudiosHoy or session("pw_ws").accesoEstudios) then %><span class="icon-lock"></span><% end if 
									%></li>
									<li><a href="/inversores/">Inversores</a><% if ver_contadores2 then %><span data-toggle="contador_leidos" data-content="inv"><%= ubound(filter(ArticulosLeidos, "inv"))+1 %></span><% end if %><%
										if not(session("pw_ws").accesoInversores) then %><span class="icon-lock"></span><% end if
									%></li>
									<li><a href="/demandas/">Demandas</a><% if ver_contadores2 then %><span data-toggle="contador_leidos" data-content="dem"><%= ubound(filter(ArticulosLeidos, "dem"))+1 %></span><% end if %><%
										if not(session("pw_ws").accesoDemandas) then %><span class="icon-lock"></span><% end if 
									%></li>
									<li><a href="/vencimientos/">Vencimientos de contrato</a><% if ver_contadores2 then %><span data-toggle="contador_leidos" data-content="ven"><%= ubound(filter(ArticulosLeidos, "ven"))+1 %></span><% end if %><%
										if not(session("pw_ws").accesoVencimientos) then %><span class="icon-lock"></span><% end if 
									%></li>
									<li><a href="/subastas/">Subastas/Concursos</a><% if ver_contadores2 then %><span data-toggle="contador_leidos" data-content="sub"><%= ubound(filter(ArticulosLeidos, "sub"))+1 %></span><% end if %><%
										if not(session("pw_ws").accesoSubastas) then %><span class="icon-lock"></span><% end if 
									%></li>
									<li><a href="https://www.easyproperty.es/" target="_blank" class="logEasy"><img src="/img/shared/EasyProperty.png" alt=""/>EasyProperty</a></li>
								</ul>
							</div><!-- // colBusquedas -->
						</div>
					</div>
				
				</div>
			</div><!-- // col-sm-9 izquierda -->
			
			<div class="col-sm-3 derecha">
				<!--usuario-->
				<% 
				usuario = request.Cookies("licencia")("n")
				if instr(usuario, "@")>0 then
					usuario = left(usuario, instr(usuario, "@")-1)
				end if
				%>
				<div class="user hidden-xs">
					<ul>
						<li>
							<span class="icon-user"></span>
							<% if request.Cookies("licencia")="" then %>
								<a href="#" class="simplemodal">Registro de Clientes</a>
							<% else %>
								Bienvenido:
							<% end if %>
							<p id="header_licencia">
								<% if request.Cookies("dev")="" then 
									%><%= usuario %><% 
								else
									%><a href="/cliente/" data-toggle="popover" title="<%= request.Cookies("licencia")("n") %>" data-trigger="hover" data-content="<% call popover_licencia() %>" data-placement="bottom" data-html="true"><%= usuario %></a> <% 
								end if
								if request.Cookies("dev")("reg")<>"" or request.Cookies("licencia")("log")<>"" then 
									%>*<%
								end if
								if session("pw_ws").dev then 
									%>[ws DEV]<%
								end if %>
							</p>
						</li>
						<li class="userGtr"><span class="icon-briefcase"></span>
							Empresa:
							<p id="header_cliente"><% 
							if request.Cookies("dev")="" then 
								%><%= request.Cookies("licencia")("u") %><%
							else 
								%><a href="/cliente/" data-toggle="popover" title="xxxx" data-trigger="hover" data-content="<% call popover_empresa() %>" data-placement="bottom" data-html="true"><%= request.Cookies("licencia")("u") %></a><%
							end if %></p>
						</li>
						
						<% if request.Cookies("dev")="" then	'dev %>
						<li><span class="icon-user-tie"></span> Tu gestor:
							<p>Andy G.</p>
						</li>
						<% else	'dev %>
						<li class="informa">
							<span class="icon-earth"></span> <p><%= lcase(session("pw_ws").ServidorWeb) %> &nbsp; </p>
							<span class="icon-database"></span> <p><%= lcase(session("pw_ws").ServidorBD) %></p>
							<p style="float:right; font-size:11px;"><%= session("pw_ws").SessionID %></p>
						</li>
						<li class="informa">
							<span class="informa_width">0</span> x <span class="informa_height">0</span>
							<% if session("movil") then %> - <span class="destaca">MOVIL</span><% end if %>
							&nbsp;-&nbsp;<%= session("pw_ws").version() %>
							<a style="float:right;" href="/acceso/session_abandon.asp" class="bindev" target="_blank">abandon</a>
						</li>
						<li class="userGtr informa">
							reg: <% if session("pw_ws").IniciadoRegAccesos then %>iniciado<% else %>!<% end if %>
							<span <% if session("pw_ws").NoTrack then %>class="destaca"<% end if %> style="float:right;"><% if session("pw_ws").NoTrack then %>NO TRACK<% else %>track<% end if %></span>
						</li>
						<li class="links">
							<a href="/cliente/" >cliente</a>
							
							<a href="javascript:void(0);" data-toggle="notify" data-load="/cliente/quotas.asp" style="float:right;">quotas</a>
							<a href="javascript:void(0);" data-toggle="notify" data-load="/cliente/leidos.asp" style="float:right;">leidos</a>
						</li>
						<li class="links">
							<a href="/dev/">dev</a> &nbsp;-&nbsp; 
							<a href="/admin/">admin</a>
						</li>
						<% end if 'dev	%>
					</ul>
				</div>
				
				<!--contacto-->
				<% if request.Cookies("dev")="" then %>
				<div class="contact">
					<ul>
						<li class="tlf hidden-xs"><span class="icon-phone"></span> 914 295 143</li>
						<li class="hidden-xs"><a href="mailto:pw@propertyweb.eu"><span class="icon-mail4"></span> E-mail</a></li>
						<li><span class="miembro">Miembro de: </span><a href="javascript:void(0);"><img src="/img/shared/ricsPartner.png" alt="Rics"></a></li>
					</ul>
				</div>
				<% end if %>
				
			</div><!-- // col-sm-3 derecha -->

		</header>
	</div>
</div>
<div id="ModalBox" class="modal fade" tabindex="-1"></div>
<div style="clear:both;"></div>
<%' end select %>



<script type="text/javascript">

	$crisp.push(["set", "user:nickname", ["<%= chat_email %>"]])
	$crisp.push(["set", "user:company", ["<%= chat_empresa %>"]])	
	$crisp.push(["set", "user:phone", ["<%= chat_movil %>"]])
	$crisp.push(["set", "user:email", ["<%= chat_email %>"]])



</script>