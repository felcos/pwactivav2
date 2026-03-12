<%
frmInfo_tipo = request.form("frmInfo_tipo")	
frmInfo_busq = request.form("frmInfo_busq")
%>
<nav class="barraNav">
    <table style="width:100%">
        <tr>
            <td width="90%" >


    <form action="/info/" method="post" name="frm_volver" style="display:inline-block;">
        <input name="frmInfo_tipo" type="hidden" value="<%= request.Form("frmInfo_tipo") %>">
        <% if request.Form("frmInfo_tipo")="prop" then 
            %><input type="hidden" name="frmInfo_propietario" value="<%= request.Form("frmInfo_propietario") %>"><%
        else
            %><input type="hidden" name="frmInfo_busq" value="<%= request.Form("frmInfo_busq") %>"><%
        end if %>
        
        <% if request.Form("zoom")<>"" then %>
            <input type="hidden" id="setcoords_zoom" name="zoom" value="<%= request.Form("zoom") %>"><% if request.Cookies("dev")<>"" then %>zoom: <%= request.Form("zoom") %><% end if %>
            <input type="hidden" id="setcoords_lat" name="lat" value="<%= request.Form("lat") %>"><% if request.Cookies("dev")<>"" then %>lat: <%= request.Form("lat") %><% end if %>
            <input type="hidden" id="setcoords_lng" name="lng" value="<%= request.Form("lng") %>"><% if request.Cookies("dev")<>"" then %>lng: <%= request.Form("lng") %><% end if %>
        <% end if %>
        <%
        informa = "<ul>"
        informa = informa & "<li>frmInfo_tipo: " & request.Form("frmInfo_tipo") & "</li>"
        if request.Form("frmInfo_tipo")="prop" then 
            informa = informa & "<li>frmInfo_propietario: " & request.Form("frmInfo_propietario") & "</li>"
        else
            informa = informa & "<li>frmInfo_busq: " & request.Form("frmInfo_busq") & "</li>"
        end if
        if request.Form("zoom")<>"" then
            informa = informa & "<li>zoom: " & request.Form("zoom") & "</li>"
            informa = informa & "<li>lat: " & request.Form("lat") & "</li>"
            informa = informa & "<li>lng: " & request.Form("lng") & "</li>"
        end if
        'informa = informa & "<li>" &  & "</li>"
        informa = informa & "</ul>"
        %>
        <a class="btn blanco" onClick="javascript:frm_volver.submit();" <% if request.Cookies("dev")<>"" then %>data-toggle="popover" data-html="true" data-trigger="hover" data-content="<%= informa %>" data-placement="right" data-original-title="<%= url %>"<% end if %> >
           <span class="icon icon-arrow-left2"></span>
           <span class="lineLeft">Volver</span>
        </a>

    </form>
</td>
<td>
    

    <% if request.Cookies("licencia")("u")="PW" or request.Cookies("licencia")("u")="JP" then %>
    <form action="/info/informecompleto/?presentacion=informe&id=<%= request.Form("id_edificio") %>" method="post" name="frm_volver" target="_blank" style="display:inline-block;align-items:flex-end ;">
        
        <input type="hidden" name="frmInfo_tipo" value="edif">
        <input type="hidden" name="frmInfo_busq" value="edif">
        <input type="hidden" name="secc" value="edif">
        <input type="hidden" name="seltipo" value="edif">
        <input type="hidden" name="presentacion" value="informe">

                <input type="submit" target="_blank" value="Informe" class="btn <% 'if rsInmueble("es_complejo") then disabled%><% 'end if %>"/>

           
     
    </form>
    <% end if %>

</td>
</tr>
</table>
</nav>