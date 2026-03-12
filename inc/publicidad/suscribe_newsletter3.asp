<% if request.Cookies("dev")("style")="" then %>
<aside id="mibloque3_menu">
<form action="/pw/suscribe_mailing.asp" method="post">
	<h1 class="h1_grande"><span class="txt_gris_claro">PropertyWeb Flash</span></h1>
Recibe diariamente nuestro mailing diario para disponer de toda la informaci&oacute;n en tu correo.<br />
<input type="email" name="emailAddress" id="recuadro_blanco" placeholder="Escribe tu mail aqu&iacute;" required maxlength="50" /><!-- quitado autofocus -->
<br>
<input type="checkbox">
<span class="txt_minimo">He le&iacute;do y Acepto las&nbsp;</span><span class="txt_naranja_min">condiciones de uso</span>
<br>
<div align="right">
	<input class="btn" type="submit" value="suscr&iacute;bete" />
</div>
</form>
</aside>
<% end if %>
<% if 1=2 then %>
<aside id="mibloque4">
<h1 class="h1_grande">
    <span class="txt_gris_claro">M&Aacute;S DE 15<p>INFORMES AL MES<p>POR SOLO 19 &euro;</span></h1><br>
    <ol>
        <li><span class="txt_naranja_min">Info-Empresas desde, 20 &euro;/mes</span></li>
        <li><span class="txt_naranja_min">Info-Inmuebles desde, 20 &euro;/mes</span></li>
        <li><span class="txt_naranja_min">Links.Ahorre m&aacute;s del 85%</span></li>
        <li><span class="txt_naranja_min">Directorio.Ahorre m&aacute;s del 90%</span></li>
    </ol>
</aside>
<% end if %>