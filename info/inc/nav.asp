<%
frmInfo_tipo = request.form("frmInfo_tipo")	
frmInfo_busq = request.form("frmInfo_busq")
%>
<nav class="barraNav">
    <table style="width:100%">
        <tr>
            <td width="90%" >


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