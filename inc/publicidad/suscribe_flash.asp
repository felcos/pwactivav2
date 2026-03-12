<!--<link href="/inc/publicidad/suscribe_flash.css" rel="stylesheet" type="text/css"/>-->
<div class="caja">
  <div class="modulo">
  
    <h2 class="tit_mod"><span class="icon-newspaper"></span> PW Hoy</h2>
    <!-- JJ-->
    <div class="bloque suscribe-PwSemana">
      <div class="">
        <p class="enunciado">Recibe diariamente nuestro mailing diario para disponer de toda la informaci&oacute;n en tu correo.</p>
        <input type="text" name="not" placeholder="Escribe tu mail aqu&iacute;" value="" class="form-control">
        <p class="userConditions"><span class="icon-info"></span> He le&iacute;do y Acepto las <a href="">condiciones de uso</a>
          <input type="checkbox" class="checkbox" name="not" value="">
        </p>
        <div class="inputPwHoy">
          <input type="submit" class="btn roll" id="submit" value="Suscr&iacute;bete">
        </div>
        </form>
      </div>
    </div>
  <% if request.Cookies("dev")<>"" then
  		%><hr /><%
		for each elto in request.Form
			%><li><%= elto %>: <%= request.Form(elto) %></li><% 
		next
	end if %>
  </div>
</div>
