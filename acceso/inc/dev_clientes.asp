<% if request.QueryString("id_cliente")="" then %>
	<style>
    .ver_todos {
        float:right;
        display:none;
    }
    .dev_fila.cliente {
        display:none;
    }
    .dev_fila:hover {
        background:#CCC;
        cursor:pointer;
    }
    .tbl_licencias td  {
        font-size:11px;
    }
    .tbl_licencias td.peq  {
        font-size:10px;
    }
    .tbl_licencias td.mini  {
        font-size:9px;
    }
    </style>
    <%
    set rsClientes = Server.CreateObject("ADODB.Recordset")
    
    sql = "SELECT * FROM clientes ORDER BY ACTIVO DESC, EMPRESA"
    rsClientes.Open sql, session("connPW")
    
    %>
    <div class="panel panel-default">
        <div class="panel-heading"><span class="ver_todos"><a href="#">todos</a></span>dev - SET licencia</div>
        <div class="panel-body">
            
<table width="100%">
<tr>
    <th colspan="3"><input type="text" name="filtro_busq" id="filtro_busq"></th>
    <th colspan="2"></th>
    <th>
<select name="filtro_activos">
  <option value="*">todos</option>
  <option value="1">activos</option>
  <option value="0">inactivos</option>
</select>
    </th>
</tr>
<tr>
    <th>id</th>
    <th>nombre</th>
    <th>empresa</th>
    <th colspan="2">licencias</th>
    <th>activo</th>
</tr>
<% do while not rsClientes.eof %>
<tr data-id="<%= rsClientes("ID") %>" class="dev_fila cliente">
    <td><%= rsClientes("ID") %></td>
    <td class="filtrar"><%= rsClientes("EMPRESA") %></td>
    <td ><%= rsClientes("NOMBRE_EMPRESA") %></td>
    <td><%= rsClientes("LICENCIAS_ENVIADAS") %></td>
    <td> / <%= rsClientes("NUM_LICENCIAS") %></td>
    <td><%= rsClientes("ACTIVO") %></td>
</tr>
    <% rsClientes.movenext 
loop %>
</table>
    
    <div id="recibe_licencias"></div>
    
        </div>
    </div>
    <%
    rsClientes.close
    set rsClientes=nothing
    %>
    <script language="javascript">
    $(document).ready(function() {
        $(".dev_fila.cliente").click(function(e) {
            var fila_actual = $(this).data("id");
            $(".dev_fila").each(function(index, element) {
                if ($(element).data("id")!=fila_actual) { $(element).hide() }
            });
            
            $(".ver_todos").show();
            
            $("#recibe_licencias").load(
                "/acceso/inc/dev_clientes.asp",
                "id_cliente=" + fila_actual,
                function(responseText, textStatus, XMLHttpRequest) {}
            )
            
        });
        
        
        $(".ver_todos a").click(function(e) {
            e.preventDefault();
            
            $(".ver_todos").hide();
            $("#recibe_licencias").html("")
            
            $(".dev_fila").each(function(index, element) {
                $(element).show()
            });
        })
        
        
        $("#filtro_busq").keyup(function(e) {
            var filtro =  $(this).val();
            var visible = true;
            
            $(".dev_fila").each(function(i, tr) {
                
                $("td", this).each(function(j, td) {
                    if ( $(td).hasClass("filtrar") ) {
                        if (  $(td).html().toLowerCase().indexOf(filtro.toLowerCase()) ) {
                            $(tr).hide();
                        } else {
                            $(tr).show();
                        }
                    }
                });
                
            });
        });
        
        
        
    })
    </script>

<% elseif request.QueryString("id_cliente")<>"" then
	set rsLicencias = Server.CreateObject("ADODB.Recordset")
	
	sql = "SELECT * FROM clientes_licencias WHERE ID_EMPRESA=" & request.QueryString("id_cliente") & " ORDER BY NUMERO_LICENCIA"
	rsLicencias.Open sql, session("connPW")
	%><hr>
	<table width="100%" class="tbl_licencias">
	<tr>
		<th>n&deg;</th>
		<th>nombre</th>
		<th>registrado</th>
		
		<th>ip</th>
		<th>mozilla</th>
		<th>navegador</th>
		<th>sis.op.</th>
		
		<th>last_login</th>
	</tr>
	<% do while not rsLicencias.eof 
		url = "u=" & rsLicencias("USUARIO") & "&p=" & rsLicencias("PASSWORD") & "&n=" & rsLicencias("NOMBRE")
		url = url & "&client_id=" & rsLicencias("ID_EMPRESA") & "&user_id=" & rsLicencias("id")
		if not isnull(rsLicencias("acceso_movil")) then
			url = url & "&movil=" & rsLicencias("acceso_movil")
		end if
		
		nombre = rsLicencias("NOMBRE")
		if not(isnull(rsLicencias("acceso_movil"))) and rsLicencias("acceso_movil")<>"" then
			nombre = nombre & "&nbsp; (" & rsLicencias("acceso_movil") & ")"
		end if
		%>
	
    <tr data-id="<%= url %>" class="dev_fila">
		<td ><%= rsLicencias("NUMERO_LICENCIA") %></td>
		
		<td class="peq"><a href="/acceso/dev/licencia.asp?act=set&<%= url %>" class="licencia" target="_blank"><%= nombre %></a></td>
		
		<td class="peq"><%= rsLicencias("FECHA") %>&nbsp;<%= rsLicencias("HORA") %></td>
		
		<td class="peq"><%= rsLicencias("IP") %></td>
		<td class="peq"><%= rsLicencias("http_mozilla") %></td>
		<td class="peq"><%= rsLicencias("http_navegador") %></td>
		<td class="peq"><%= rsLicencias("http_so") %></td>
		
		<td><%= rsLicencias("last_login") %></td>
	</tr>
    
		<% rsLicencias.movenext 
	loop %>
	</table>
	
		</div>
	</div>
	<%
	rsLicencias.close
	set rsLicencias=nothing
	%>
    <script language="javascript">
    $(document).ready(function() {
        $(".licencia").click(function(e) {
            e.preventDefault();
			
			$.post(
				$(this).attr("href"),
				function(data){
					$("#informa").html(data);
				}
			);
			//var fila_actual = $(this).attr("href");
            //console.log( fila_actual )
			
            
        });
        
        
        
        
    })
    </script>
<% end if %>



