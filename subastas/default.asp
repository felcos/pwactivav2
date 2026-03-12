<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>
<!--#include virtual="/inc/reg_accesos.asp" -->
<!--#include virtual="/lib/funciones.asp" -->
<%
sec_actual = "/subastas/"

dim f_desde
dim f_hasta
dim busqueda

swMostrarListado=false

if request.Form="" then
	f_hasta=date
'	f_desde=dateadd("d", -14, date)
	f_desde=dateadd("m", -6, date)

else
	f_desde=cdate(Request.Form("FechaI"))
	f_hasta=cdate(Request.Form("FechaF"))
	
	busqueda=Request.Form("busq")
end if

Set objRecordset = Server.CreateObject("ADODB.Recordset")
%>
<!DOCTYPE html>
<html lang="es">
<head>
<title>PropertyWeb - Subastas, Concursos de Obras, Venta de Suelo...</title>

<!--#include virtual="/inc/head.asp" -->

<link href="/lib/bootstrap-datepicker/bootstrap-datepicker3.css" rel="stylesheet" type="text/css">
<script src="/lib/bootstrap-datepicker/bootstrap-datepicker.min.js"></script>
<script src="/lib/bootstrap-datepicker/bootstrap-datepicker.es.js"></script>
<!-- Global site tag (gtag.js) - Google Analytics -->
<script async src="https://www.googletagmanager.com/gtag/js?id=UA-143927921-1"></script>
<script>
  window.dataLayer = window.dataLayer || [];
  function gtag(){dataLayer.push(arguments);}
  gtag('js', new Date());

  gtag('config', 'UA-143927921-1');
</script>
</head>
<body>
<!--#include virtual="/inc/body-header.asp" -->

<div class="container">
  <section id="s_buscador" class="row">
    <div class="caja">
      <h1 class="heading">Subastas/Concursos</h1>
    </div>
    <!--      <div class="grid-2 grid-flow-opposite"></div>-->
    <div class="col-md-8 caja">
      <p class="">Selecciona las m&aacute;s interesantes subastas y concursos privados o p&uacute;blicos, de obras , venta de suelo terciario, comercial, vivienda libre o V.P.O.</p>
      <form id="frm_busq" name="frm_busq"  class="form-horizontal" action="/articulos/titulos/resumen.asp" method="post" autocomplete="off" target="_blank">
        <input type="hidden" name="secc" value="subastas" >
        
        <!-- tipo -->
        <div class="form-group clearfix">
          <label for="tiposubastas" class="col-sm-2 control-label"> Tipo Subasta: </label>
          
          <div class="col-sm-10">
            <select name="tiposubastas" id="tiposubastas" onChange="cambio_tipo_subasta()" autofocus class="form-control" >
              <option <% if request.Form("tiposubastas")="%" or request.Form("tiposubastas")="" then %>selected<% end if %> value="%">Seleccionar un tipo</option>
              <%
            objRecordset.Open "SELECT ID, NOMBRE FROM TIPOS_DE_CONCURSOS WHERE ACTIVO<>0" , session("connPW")
        
            do while not objRecordset.EOF
            op=objrecordset("NOMBRE")
            if len(op)>45 then op=left(op,45)& "..."
            %>
              <option <% if cstr(objRecordset("ID"))=request.Form("tiposubastas") then %>selected<% end if %> value="<%= objRecordset("ID") %>"><%= op %></option>
              <%
            objRecordset.MoveNext 
            Loop 
        
            objRecordset.Close
			%>
            </select>
          </div>
        </div>
        <div class="form-group clearfix">
          <div id="div_uso_solar" name="div_uso_solar" ><!-- uso solar -->
            <label for="uso_solar" class="col-sm-2 control-label">Uso solar:</label>
            <div class="col-sm-10">
              <select name="uso_solar" id="uso_solar" class="form-control" >
                <option selected value="%">Cualquiera</option>
                <%
                objRecordset.open "SELECT ID, NOMBRE FROM TIPOS_DE_USOS_SOLAR WHERE ACTIVO <>0 AND ID>0 ORDER BY NOMBRE" , session("connPW")
            
                do while not objRecordset.eof
                    op = lcase(objRecordset("NOMBRE"))
                    'if len(op)>35 then op = left(op,35)& "..."
                %>
                <option value="<%= objRecordset("ID") %>"><%= op %></option>
                <%
                    objRecordset.movenext 
                Loop 
                objRecordset.close
                %>
              </select>
            </div>
          </div>
        </div>
        <div class="form-group clearfix">
          <div id="div_seccion_subastas" name="div_seccion_subastas" style="display:none;"><!-- seccion -->
            <label for="seccion_subastas" class="col-sm-2 control-label">Secci&oacute;n:</label>
            <div class="col-sm-10">
              <select name="seccion_subastas" id="seccion_subastas" class="form-control" >
                <option value="%" selected>Cualquiera</option>
                <%
                objRecordset.Open "SELECT ID, NOMBRE FROM TIPOS_DE_SECCIONES_OPERACIONES WHERE ACTIVO <>0 ORDER BY NOMBRE", session("connPW")
                do while not objRecordset.EOF
                    'op = (left(objRecordset("NOMBRE"),1)) & (lcase(right(objRecordset("NOMBRE"),len(objRecordset("NOMBRE"))-1)))
                    '     (left(objRecordset("NOMBRE_LNG"),1)) & (lcase(right(objRecordset("NOMBRE_LNG"),len(objRecordset("NOMBRE_LNG"))-1)))
                    op = lcase(objRecordset("NOMBRE"))
                    if len(op)>35 then op=left(op,35)& "..."
                %>
                <option value="<%= objRecordset("ID") %>"> <%= op %> </option>
                <%
                    objRecordset.MoveNext 
                loop 
                objRecordset.Close
                %>
              </select>
            </div>
          </div>
        </div>
        <div class="form-group clearfix">
         <!-- provincia -->
            
            <label for="provincia" class="col-sm-2 control-label">Provincia:</label>
            <div class="col-sm-4">
              <select name="provincia" onChange="CargarCombo(MatrizDatos, document.frm_busq.provincia, document.frm_busq.localidad)" class="form-control" >
                <option value="%" selected>cualquiera</option>
                <% 
            objRecordset.open "SELECT * FROM PROVINCIAS WHERE id_pais=1 ORDER BY NOMBRE", session("connPW")
            do while not objRecordset.eof %>
                <option value="<%= objRecordset("ID") %>"><%= lcase(objRecordset("NOMBRE")) %></option>
                <% objRecordset.movenext
            loop
            objRecordset.close
            %>
              </select>
           
          </div>
          
          <!-- población -->
          
            <label for="localidad" class="col-sm-2 control-label">Poblaci&oacute;n:</label>
            <div class="col-sm-4">
              <select name="localidad" class="form-control" >
                <option value="%" selected>seleccione una provincia</option>
              </select>
            </div>
        
        </div>
        
        <div class="form-group clearfix">
          <label for="FechaI" class="col-sm-2 control-label">Per&iacute;odo de:</label>
          <div class="col-sm-4"> 
            <input type="text" name="FechaI" id="FechaI" value="<%= f_desde %>" maxlength="10" class="form-control">
          </div>
          <label for="FechaI" class="col-sm-2 control-label">hasta:</label>
          <div class="col-sm-4"> 
            <input type="text" name="FechaF" id="FechaF" value="<%= f_hasta %>" maxlength="10" class="form-control">
          </div>
        </div>
        
        <div class="form-botones clearfix">
          <input name="reset" type="button" value="restablecer" class="btn grisB" onClick="location.assign('/subastas/');">
          <input type="submit" value="buscar" class="btn">
        </div>
        
      </form>
   	 </div> 
     <!--publi--> 
         <div class="col-md-4 hidden-sm hidden-xs"><!--#include virtual="/inc/publicidad/suscribe_flash.asp" --></div>
    <!-- fn publi--> 
  </section>
  
  <section id="s_resumen" class="row">
    <div id="div_instrucciones" name="div_instrucciones" class="caja clearfix" style="display:none;"></div>
  </section>
  
  
  <section id="s_titulos" class="row">
    <div id="div_result" class="caja" style="display:none;">
        <div id="result"></div>
    </div>
  </section>
</div>

<!--#include virtual="/inc/body-footer.asp" -->
</body>
</html>

<script type="text/javascript">
$(document).ready(function() { 
	var opciones= {
		beforeSubmit: mostrarLoader, 
		success: mostrarRespuesta,
	};
	
	$("#frm_busq").ajaxForm(opciones) ; 
	
	function mostrarLoader(){
		var ErrSubmit="";
		
		$("#result").html("");
		
		if (document.frm_busq.tiposubastas.value=="%") {ErrSubmit="Debe indicar un tipo de subasta para realizar la b&uacute;squeda."};
		//if (document.frm_busq.busq.value.length<3) {ErrSubmit="Debe escribir al menos 2 caracteres para realizarla b&uacute;squeda."};
		
		$("#div_instrucciones").fadeIn("slow");
		$("#div_instrucciones").html(ErrSubmit);
		if (ErrSubmit=="") {
			$("#buscando").fadeIn("fast");
		} else {
			return false;
		}
	};
	function mostrarRespuesta (responseText){ 
		$("#div_instrucciones").html(responseText);
		$("#buscando").fadeOut("slow");
	};
	
	if ($("#tiposubastas").val()!="%") {
		//console.log($("#tiposubastas").val());
		$("#frm_busq").submit();
	}
});
</script>

<script language="JavaScript">
	MatrizDatos = new Array();
	<%
	set rslocalidades = Server.CreateObject("ADODB.Recordset")
	sql = "SELECT LOCALIDADES.* FROM LOCALIDADES INNER JOIN PROVINCIAS ON LOCALIDADES.id_provincia = PROVINCIAS.ID WHERE PROVINCIAS.id_Pais = 1 ORDER BY LOCALIDADES.NOMBRE"
	rslocalidades.Open sql, session("connPW")

	dim fila
	fila = 0
	while (NOT rslocalidades.EOF) %>
		MatrizDatos[<%=fila%>] = new Array(3); 
		MatrizDatos[<%=fila%>][0] = "<%=(rslocalidades.Fields.Item("ID_PROVINCIA").Value)%>";
		MatrizDatos[<%=fila%>][1] = "<%=(rslocalidades.Fields.Item("ID").Value)%>";
		MatrizDatos[<%=fila%>][2] = "<%=lcase(rslocalidades.Fields.Item("NOMBRE").Value)%>";
	<% rslocalidades.MoveNext()
	fila = fila + 1
	wend %>
	var numprovincias = <%= fila %>
	
	MatrizPrecios = new Array();
	MatrizPrecios[0]=new Array(2);MatrizPrecios[0][0]="venta";MatrizPrecios[0][1]="€";
	MatrizPrecios[1]=new Array(2);MatrizPrecios[1][0]="venta";MatrizPrecios[1][1]="€/M2";
	MatrizPrecios[2]=new Array(2);MatrizPrecios[2][0]="alquiler";MatrizPrecios[2][1]="€/AÑO";
	MatrizPrecios[3]=new Array(2);MatrizPrecios[3][0]="alquiler";MatrizPrecios[3][1]="€/M2/AÑO";
	MatrizPrecios[4]=new Array(2);MatrizPrecios[4][0]="alquiler";MatrizPrecios[4][1]="€/MES";
	MatrizPrecios[5]=new Array(2);MatrizPrecios[5][0]="alquiler";MatrizPrecios[5][1]="€/M2/MES";
	var numprec = 6
	<%
	rslocalidades.close
	set rslocalidades = nothing
	%>
function cambio_tipo_subasta() {
	tipo=document.frm_busq.tiposubastas.options[document.frm_busq.tiposubastas.selectedIndex].value 
	switch (tipo){
	case "%":
		$("#div_uso_solar").css({ display: 'none', });
		$("#div_seccion_subastas").css({ display: 'none', });
		break;
		
	case "2":
		document.frm_busq.seccion_subastas.selectedIndex=0
		//document.frm_busq.seccion_subastas.disabled='disabled'
		
		$("#div_uso_solar").fadeIn("fast");
		$("#div_seccion_subastas").css({ display: 'none', });
		
		break;
		
	default:
		$("#div_seccion_subastas").fadeIn("fast");
		$("#div_uso_solar").css({ display: 'none', });
		
		//document.subastas.seccion_subastas.removeAttribute('disabled');
		break;
	}
}

function CargarCombo(Matriz, lstOrigen, lstDestino) {
	var seleccion
	if("a"=="a") { /*GetNavegador()=="NS4"*/
		seleccion = lstOrigen.options[lstOrigen.selectedIndex].value;
		var nuevoElemento = new Option()
		do {lstDestino.options[(lstDestino.length) - 1] = null;} while (lstDestino.length != 0)
		
		if (seleccion == "%") {
			nuevoElemento = new Option("seleccione una provincia","%",false,true);
			lstDestino.options[0] = nuevoElemento;
		} else {
			nuevoElemento = new Option("cualquiera","%",false,true);
			lstDestino.options[0] = nuevoElemento;
			nuevoElemento=null;
			for (var i=0; i<numprovincias; i++) {
				if (seleccion == Matriz[i][0]){
					nuevoElemento = new Option(Matriz[i][2],Matriz[i][1],false,false);
					lstDestino.options[(lstDestino.length)] = nuevoElemento;
					nuevoElemento=null;
				}
			}
			
		}
		lstDestino.options[0].selected=true;
	} else {
		seleccion = lstOrigen.value;
		do {lstDestino.remove((lstDestino.length) - 1)} 
		while (lstDestino.length != 0)
		if (seleccion == "%") {
			var nuevaOpcion = document.createElement("option");
			nuevaOpcion.value = "%";
			nuevaOpcion.text = "cualquiera";
			lstDestino.add(nuevaOpcion); 	
		} else {
			var nuevaOpcion = document.createElement("option");
			nuevaOpcion.value = "%";
			nuevaOpcion.text = "cualquiera";
			lstDestino.add(nuevaOpcion);	
			for (i=0; i<numprovincias; i++) {
				if (Matriz[i][0] == seleccion) {
					var nuevaOpcion = document.createElement("option");
					nuevaOpcion.value = Matriz[i][1];
					nuevaOpcion.text = Matriz[i][2];
					lstDestino.add(nuevaOpcion);
				}
			 }
		}
	}
}

</script>

<script src="/inc/datepicker.js" type="text/javascript"></script>

