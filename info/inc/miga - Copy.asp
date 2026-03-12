<% 'select case request.Form("frmInfo_tipo")
select case request.Form("secc")
case "prop"
	miga = "Propietario Actual"
	
case "edif"
	if isnull(rsInmueble("id_tipo_edificio")) then
		miga = "Edificio"
	else
		miga = rsInmueble("tipo_edificio")
	end if
	
case "hot"
	miga = "Hotel"
	
case "cc"
	'miga = "Centro Comercial"
	if isnull(rsInmueble("id_tipo_edificio")) then
		miga = "Centro Comercial"
	else
		miga = rsInmueble("tipo_edificio")
	end if
	
end select %>
<div class="miga">
	 <% if request.Cookies("dev")<>"" then %><span class="dev" style="float:right;">[<%= rsInmueble("id") %>]</span><% end if %>
     <h2 class="tit_miga02"><%= miga %></h2>
</div>