<script src="/informe_takeup/numeral.min.js"></script>
	<% 

''''''''''''''''''''''	
'	inversion M2'
''''''''''''''''''''''

    set rsData1 = Server.CreateObject("ADODB.Recordset")
    set rsData2 = Server.CreateObject("ADODB.Recordset")
    set rsData3 = Server.CreateObject("ADODB.Recordset")
	set rsData4 = Server.CreateObject("ADODB.Recordset")
	set rsData5 = Server.CreateObject("ADODB.Recordset")
    set rsData6 = Server.CreateObject("ADODB.Recordset")
    set rsData7 = Server.CreateObject("ADODB.Recordset")
	set rsData8 = Server.CreateObject("ADODB.Recordset")
	set rsData9 = Server.CreateObject("ADODB.Recordset")
    set rsData10 = Server.CreateObject("ADODB.Recordset")
    set rsData11 = Server.CreateObject("ADODB.Recordset")
	set rsData12 = Server.CreateObject("ADODB.Recordset")
	set rsData13 = Server.CreateObject("ADODB.Recordset")
    set rsData14 = Server.CreateObject("ADODB.Recordset")
    set rsData15 = Server.CreateObject("ADODB.Recordset")
	set rsData16 = Server.CreateObject("ADODB.Recordset")
	set rsData17 = Server.CreateObject("ADODB.Recordset")
    set rsData18 = Server.CreateObject("ADODB.Recordset")
    set rsData19 = Server.CreateObject("ADODB.Recordset")
	set rsData20 = Server.CreateObject("ADODB.Recordset")

    localidad=""
    dim yearx
	yearx=2020
	
    sql_m2="SELECT SUM(PRECIO_EUR) as MetrosCuad FROM dirs_w_OPS where ( ID_TIPO_OPERACION=1 OR ID_TIPO_OPERACION=3  OR ID_TIPO_OPERACION=2 ) AND seccion LIKE '%oficinas%' and web_es<>0 and ID_PAIS=1 and  FECHA_OPERACION BETWEEN '" & yearx & "0101' AND '" & yearx & "1231' and id_provincia = 3 "
    sql_eu="SELECT COUNT(id) as Nro_Ops FROM C_OPERACIONES where ( ID_TIPO_OPERACION=1 OR ID_TIPO_OPERACION=3  OR ID_TIPO_OPERACION=2 ) AND seccion LIKE '%oficinas%' and pw_es<>0 and ID_PAIS=1 and  FECHA_OPERACION BETWEEN '" & yearx & "0101' AND '" & yearx & "1231' and id_provincia = 3"
    
    if localidad="" then
        sqlw = sqlw & " AND id_pais = 1"
    else
    
        sqlw = sqlw & " AND "
        if localidad = "madrid" then
            sqlw = sqlw & "id_provincia = 3"
        elseif localidad = "barcelona" then
            sqlw = sqlw & "id_provincia = 3"
        elseif localidad = "londres" then
            sqlw = sqlw & "id_provincia = 60"
        else
            sqlw = sqlw & "localidad = '" & localidad & "'"
        end if
    end if
    
    sql_m2_alq_of="SELECT SUM(PRECIO_EUR) as MetrosCuad FROM dirs_w_OPS where ( ID_TIPO_OPERACION=2 ) AND seccion LIKE '%oficinas%' and web_es<>0 and ID_PAIS=1 and  FECHA_OPERACION BETWEEN '" & yearx & "0101' AND '" & yearx & "1231' and id_provincia = 3 "
    sql_op_alq_of="SELECT COUNT(id) as Nro_Ops FROM C_OPERACIONES where ( ID_TIPO_OPERACION=2 ) AND seccion LIKE '%oficinas%' and pw_es<>0 and ID_PAIS=1 and  FECHA_OPERACION BETWEEN '" & yearx & "0101' AND '" & yearx & "1231' and id_provincia = 3"
	sql_m2_inv_of="SELECT SUM(PRECIO_EUR) as MetrosCuad FROM dirs_w_OPS where ( ID_TIPO_OPERACION=1 OR ID_TIPO_OPERACION=3 ) AND seccion LIKE '%oficinas%' and web_es<>0 and ID_PAIS=1 and  FECHA_OPERACION BETWEEN '" & yearx & "0101' AND '" & yearx & "1231' and id_provincia = 3 "
    sql_op_inv_of="SELECT COUNT(id) as Nro_Ops FROM C_OPERACIONES where ( ID_TIPO_OPERACION=1 OR ID_TIPO_OPERACION=3  ) AND seccion LIKE '%oficinas%' and pw_es<>0 and ID_PAIS=1 and  FECHA_OPERACION BETWEEN '" & yearx & "0101' AND '" & yearx & "1231' and id_provincia = 3"
     
    sql_m2_alq_lc="SELECT SUM(PRECIO_EUR) as MetrosCuad FROM dirs_w_OPS where ( ID_TIPO_OPERACION=2 ) AND seccion LIKE '%locales comerciales%' and web_es<>0 and ID_PAIS=1 and  FECHA_OPERACION BETWEEN '" & yearx & "0101' AND '" & yearx & "1231' and id_provincia = 3 "
    sql_op_alq_lc="SELECT COUNT(id) as Nro_Ops FROM C_OPERACIONES where ( ID_TIPO_OPERACION=2 ) AND seccion LIKE '%locales comerciales%' and pw_es<>0 and ID_PAIS=1 and  FECHA_OPERACION BETWEEN '" & yearx & "0101' AND '" & yearx & "1231' and id_provincia = 3"
 	sql_m2_inv_lc="SELECT SUM(PRECIO_EUR) as MetrosCuad FROM dirs_w_OPS where ( ID_TIPO_OPERACION=1 OR ID_TIPO_OPERACION=3 ) AND seccion LIKE '%locales comerciales%' and web_es<>0 and ID_PAIS=1 and  FECHA_OPERACION BETWEEN '" & yearx & "0101' AND '" & yearx & "1231' and id_provincia = 3 "
    sql_op_inv_lc="SELECT COUNT(id) as Nro_Ops FROM C_OPERACIONES where ( ID_TIPO_OPERACION=1 OR ID_TIPO_OPERACION=3  ) AND seccion LIKE '%locales comerciales%' and pw_es<>0 and ID_PAIS=1 and  FECHA_OPERACION BETWEEN '" & yearx & "0101' AND '" & yearx & "1231' and id_provincia = 3"

	sql_m2_alq_vr="SELECT SUM(PRECIO_EUR) as MetrosCuad FROM dirs_w_OPS where ( ID_TIPO_OPERACION=2 ) AND seccion LIKE '%viviendas residenciales%' and web_es<>0 and ID_PAIS=1 and  FECHA_OPERACION BETWEEN '" & yearx & "0101' AND '" & yearx & "1231' and id_provincia = 3 "
    sql_op_alq_vr="SELECT COUNT(id) as Nro_Ops FROM C_OPERACIONES where ( ID_TIPO_OPERACION=2 ) AND seccion LIKE '%viviendas residenciales%' and pw_es<>0 and ID_PAIS=1 and  FECHA_OPERACION BETWEEN '" & yearx & "0101' AND '" & yearx & "1231' and id_provincia = 3"
 	sql_m2_inv_vr="SELECT SUM(PRECIO_EUR) as MetrosCuad FROM dirs_w_OPS where ( ID_TIPO_OPERACION=1 OR ID_TIPO_OPERACION=3 ) AND seccion LIKE '%viviendas residenciales%' and web_es<>0 and ID_PAIS=1 and  FECHA_OPERACION BETWEEN '" & yearx & "0101' AND '" & yearx & "1231' and id_provincia = 3 "
    sql_op_inv_vr="SELECT COUNT(id) as Nro_Ops FROM C_OPERACIONES where ( ID_TIPO_OPERACION=1 OR ID_TIPO_OPERACION=3  ) AND seccion LIKE '%viviendas residenciales%' and pw_es<>0 and ID_PAIS=1 and  FECHA_OPERACION BETWEEN '" & yearx & "0101' AND '" & yearx & "1231' and id_provincia = 3"
	 

	sql_m2_alq_cc="SELECT SUM(PRECIO_EUR) as MetrosCuad FROM dirs_w_OPS where ( ID_TIPO_OPERACION=2 ) AND seccion LIKE '%centros comerciales%' and web_es<>0 and ID_PAIS=1 and  FECHA_OPERACION BETWEEN '" & yearx & "0101' AND '" & yearx & "1231' and id_provincia = 3 "
    sql_op_alq_cc="SELECT COUNT(id) as Nro_Ops FROM C_OPERACIONES where ( ID_TIPO_OPERACION=2 ) AND seccion LIKE '%oficcentros comercialesinas%' and pw_es<>0 and ID_PAIS=1 and  FECHA_OPERACION BETWEEN '" & yearx & "0101' AND '" & yearx & "1231' and id_provincia = 3"
	sql_m2_inv_cc="SELECT SUM(PRECIO_EUR) as MetrosCuad FROM dirs_w_OPS where ( ID_TIPO_OPERACION=1 OR ID_TIPO_OPERACION=3 ) AND seccion LIKE '%centros comerciales%' and web_es<>0 and ID_PAIS=1 and  FECHA_OPERACION BETWEEN '" & yearx & "0101' AND '" & yearx & "1231' and id_provincia = 3 "
    sql_op_inv_cc="SELECT COUNT(id) as Nro_Ops FROM C_OPERACIONES where ( ID_TIPO_OPERACION=1 OR ID_TIPO_OPERACION=3  ) AND seccion LIKE '%centros comerciales%' and pw_es<>0 and ID_PAIS=1 and  FECHA_OPERACION BETWEEN '" & yearx & "0101' AND '" & yearx & "1231' and id_provincia = 3"
	 
	
	sql_m2_alq_ho="SELECT SUM(PRECIO_EUR) as MetrosCuad FROM dirs_w_OPS where ( ID_TIPO_OPERACION=2 ) AND seccion LIKE '%hoteles%' and web_es<>0 and ID_PAIS=1 and  FECHA_OPERACION BETWEEN '" & yearx & "0101' AND '" & yearx & "1231' and id_provincia = 3 "
    sql_op_alq_ho="SELECT COUNT(id) as Nro_Ops FROM C_OPERACIONES where ( ID_TIPO_OPERACION=2 ) AND seccion LIKE '%hoteles%' and pw_es<>0 and ID_PAIS=1 and  FECHA_OPERACION BETWEEN '" & yearx & "0101' AND '" & yearx & "1231' and id_provincia = 3"
	sql_m2_inv_ho="SELECT SUM(PRECIO_EUR) as MetrosCuad FROM dirs_w_OPS where ( ID_TIPO_OPERACION=1 OR ID_TIPO_OPERACION=3 ) AND seccion LIKE '%hoteles%' and web_es<>0 and ID_PAIS=1 and  FECHA_OPERACION BETWEEN '" & yearx & "0101' AND '" & yearx & "1231' and id_provincia = 3 "
    sql_op_inv_ho="SELECT COUNT(id) as Nro_Ops FROM C_OPERACIONES where ( ID_TIPO_OPERACION=1 OR ID_TIPO_OPERACION=3  ) AND seccion LIKE '%hoteles%' and pw_es<>0 and ID_PAIS=1 and  FECHA_OPERACION BETWEEN '" & yearx & "0101' AND '" & yearx & "1231' and id_provincia = 3"
	 
	
	sql_m2_alq_ni="SELECT SUM(PRECIO_EUR) as MetrosCuad FROM dirs_w_OPS where ( ID_TIPO_OPERACION=2 ) AND seccion LIKE '%naves industriales%' and web_es<>0 and ID_PAIS=1 and  FECHA_OPERACION BETWEEN '" & yearx & "0101' AND '" & yearx & "1231' and id_provincia = 3 "
    sql_op_alq_ni="SELECT COUNT(id) as Nro_Ops FROM C_OPERACIONES where ( ID_TIPO_OPERACION=2 ) AND seccion LIKE '%naves industriales%' and pw_es<>0 and ID_PAIS=1 and  FECHA_OPERACION BETWEEN '" & yearx & "0101' AND '" & yearx & "1231' and id_provincia = 3"
	sql_m2_inv_ni="SELECT SUM(PRECIO_EUR) as MetrosCuad FROM dirs_w_OPS where ( ID_TIPO_OPERACION=1 OR ID_TIPO_OPERACION=3 ) AND seccion LIKE '%naves industriales%' and web_es<>0 and ID_PAIS=1 and  FECHA_OPERACION BETWEEN '" & yearx & "0101' AND '" & yearx & "1231' and id_provincia = 3 "
    sql_op_inv_ni="SELECT COUNT(id) as Nro_Ops FROM C_OPERACIONES where ( ID_TIPO_OPERACION=1 OR ID_TIPO_OPERACION=3  ) AND seccion LIKE '%naves industriales%' and pw_es<>0 and ID_PAIS=1 and  FECHA_OPERACION BETWEEN '" & yearx & "0101' AND '" & yearx & "1231' and id_provincia = 3"
	 
	
	sql_m2_alq_so="SELECT SUM(PRECIO_EUR) as MetrosCuad FROM dirs_w_OPS where ( ID_TIPO_OPERACION=2 ) AND seccion LIKE '%solares%' and web_es<>0 and ID_PAIS=1 and  FECHA_OPERACION BETWEEN '" & yearx & "0101' AND '" & yearx & "1231' and id_provincia = 3 "
    sql_op_alq_so="SELECT COUNT(id) as Nro_Ops FROM C_OPERACIONES where ( ID_TIPO_OPERACION=2 ) AND seccion LIKE '%solares%' and pw_es<>0 and ID_PAIS=1 and  FECHA_OPERACION BETWEEN '" & yearx & "0101' AND '" & yearx & "1231' and id_provincia = 3"
	sql_m2_inv_so="SELECT SUM(PRECIO_EUR) as MetrosCuad FROM dirs_w_OPS where ( ID_TIPO_OPERACION=1 OR ID_TIPO_OPERACION=3 ) AND seccion LIKE '%solares%' and web_es<>0 and ID_PAIS=1 and  FECHA_OPERACION BETWEEN '" & yearx & "0101' AND '" & yearx & "1231' and id_provincia = 3 "
    sql_op_inv_so="SELECT COUNT(id) as Nro_Ops FROM C_OPERACIONES where ( ID_TIPO_OPERACION=1 OR ID_TIPO_OPERACION=3  ) AND seccion LIKE '%solares%' and pw_es<>0 and ID_PAIS=1 and  FECHA_OPERACION BETWEEN '" & yearx & "0101' AND '" & yearx & "1231' and id_provincia = 3"
	 
	sql_m2_alq_oc="SELECT SUM(PRECIO_EUR) as MetrosCuad FROM dirs_w_OPS where ( ID_TIPO_OPERACION=2 ) AND seccion LIKE '%ocio%' and web_es<>0 and ID_PAIS=1 and  FECHA_OPERACION BETWEEN '" & yearx & "0101' AND '" & yearx & "1231' and id_provincia = 3 "
    sql_op_alq_oc="SELECT COUNT(id) as Nro_Ops FROM C_OPERACIONES where ( ID_TIPO_OPERACION=2 ) AND seccion LIKE '%ocio%' and pw_es<>0 and ID_PAIS=1 and  FECHA_OPERACION BETWEEN '" & yearx & "0101' AND '" & yearx & "1231' and id_provincia = 3"
	sql_m2_inv_oc="SELECT SUM(PRECIO_EUR) as MetrosCuad FROM dirs_w_OPS where ( ID_TIPO_OPERACION=1 OR ID_TIPO_OPERACION=3 ) AND seccion LIKE '%ocio%' and web_es<>0 and ID_PAIS=1 and  FECHA_OPERACION BETWEEN '" & yearx & "0101' AND '" & yearx & "1231' and id_provincia = 3 "
    sql_op_inv_oc="SELECT COUNT(id) as Nro_Ops FROM C_OPERACIONES where ( ID_TIPO_OPERACION=1 OR ID_TIPO_OPERACION=3  ) AND seccion LIKE '%ocio%' and pw_es<>0 and ID_PAIS=1 and  FECHA_OPERACION BETWEEN '" & yearx & "0101' AND '" & yearx & "1231' and id_provincia = 3"
	 
	
	sql_m2_alq_pa="SELECT SUM(PRECIO_EUR) as MetrosCuad FROM dirs_w_OPS where ( ID_TIPO_OPERACION=2 ) AND seccion LIKE '%parking%' and web_es<>0 and ID_PAIS=1 and  FECHA_OPERACION BETWEEN '" & yearx & "0101' AND '" & yearx & "1231' and id_provincia = 3 "
    sql_op_alq_pa="SELECT COUNT(id) as Nro_Ops FROM C_OPERACIONES where ( ID_TIPO_OPERACION=2 ) AND seccion LIKE '%parking%' and pw_es<>0 and ID_PAIS=1 and  FECHA_OPERACION BETWEEN '" & yearx & "0101' AND '" & yearx & "1231' and id_provincia = 3"
	sql_m2_inv_pa="SELECT SUM(PRECIO_EUR) as MetrosCuad FROM dirs_w_OPS where ( ID_TIPO_OPERACION=1 OR ID_TIPO_OPERACION=3 ) AND seccion LIKE '%parking%' and web_es<>0 and ID_PAIS=1 and  FECHA_OPERACION BETWEEN '" & yearx & "0101' AND '" & yearx & "1231' and id_provincia = 3 "
    sql_op_inv_pa="SELECT COUNT(id) as Nro_Ops FROM C_OPERACIONES where ( ID_TIPO_OPERACION=1 OR ID_TIPO_OPERACION=3  ) AND seccion LIKE '%parking%' and pw_es<>0 and ID_PAIS=1 and  FECHA_OPERACION BETWEEN '" & yearx & "0101' AND '" & yearx & "1231' and id_provincia = 3"
	 
	
	sql_m2_alq_vi="SELECT SUM(PRECIO_EUR) as MetrosCuad FROM dirs_w_OPS where ( ID_TIPO_OPERACION=2 ) AND seccion LIKE '%vivienda/coliving%' and web_es<>0 and ID_PAIS=1 and  FECHA_OPERACION BETWEEN '" & yearx & "0101' AND '" & yearx & "1231' and id_provincia = 3 "
    sql_op_alq_vi="SELECT COUNT(id) as Nro_Ops FROM C_OPERACIONES where ( ID_TIPO_OPERACION=2 ) AND seccion LIKE '%vivienda/coliving%' and pw_es<>0 and ID_PAIS=1 and  FECHA_OPERACION BETWEEN '" & yearx & "0101' AND '" & yearx & "1231' and id_provincia = 3"
	sql_m2_inv_vi="SELECT SUM(PRECIO_EUR) as MetrosCuad FROM dirs_w_OPS where ( ID_TIPO_OPERACION=1 OR ID_TIPO_OPERACION=3 ) AND seccion LIKE '%vivienda/coliving%' and web_es<>0 and ID_PAIS=1 and  FECHA_OPERACION BETWEEN '" & yearx & "0101' AND '" & yearx & "1231' and id_provincia = 3 "
    sql_op_inv_vi="SELECT COUNT(id) as Nro_Ops FROM C_OPERACIONES where ( ID_TIPO_OPERACION=1 OR ID_TIPO_OPERACION=3  ) AND seccion LIKE '%vivienda/coliving%' and pw_es<>0 and ID_PAIS=1 and  FECHA_OPERACION BETWEEN '" & yearx & "0101' AND '" & yearx & "1231' and id_provincia = 3"
	 
	sql_m2_alq_hc="SELECT SUM(PRECIO_EUR) as MetrosCuad FROM dirs_w_OPS where ( ID_TIPO_OPERACION=2 ) AND seccion LIKE '%hospital/centro de salud%' and web_es<>0 and ID_PAIS=1 and  FECHA_OPERACION BETWEEN '" & yearx & "0101' AND '" & yearx & "1231' and id_provincia = 3 "
    sql_op_alq_hc="SELECT COUNT(id) as Nro_Ops FROM C_OPERACIONES where ( ID_TIPO_OPERACION=2 ) AND seccion LIKE '%hospital/centro de salud%' and pw_es<>0 and ID_PAIS=1 and  FECHA_OPERACION BETWEEN '" & yearx & "0101' AND '" & yearx & "1231' and id_provincia = 3"
	sql_m2_inv_hc="SELECT SUM(PRECIO_EUR) as MetrosCuad FROM dirs_w_OPS where ( ID_TIPO_OPERACION=1 OR ID_TIPO_OPERACION=3 ) AND seccion LIKE '%hospital/centro de salud%' and web_es<>0 and ID_PAIS=1 and  FECHA_OPERACION BETWEEN '" & yearx & "0101' AND '" & yearx & "1231' and id_provincia = 3 "
    sql_op_inv_hc="SELECT COUNT(id) as Nro_Ops FROM C_OPERACIONES where ( ID_TIPO_OPERACION=1 OR ID_TIPO_OPERACION=3  ) AND seccion LIKE '%hospital/centro de salud%' and pw_es<>0 and ID_PAIS=1 and  FECHA_OPERACION BETWEEN '" & yearx & "0101' AND '" & yearx & "1231' and id_provincia = 3"
     
        
    sql_m2_alq_rt="SELECT SUM(PRECIO_EUR) as MetrosCuad FROM dirs_w_OPS where ( ID_TIPO_OPERACION=2 ) AND seccion LIKE '%residencia tercera edad%' and web_es<>0 and ID_PAIS=1 and  FECHA_OPERACION BETWEEN '" & yearx & "0101' AND '" & yearx & "1231' and id_provincia = 3 "
    sql_op_alq_rt="SELECT COUNT(id) as Nro_Ops FROM C_OPERACIONES where ( ID_TIPO_OPERACION=2 ) AND seccion LIKE '%residencia tercera edad%' and pw_es<>0 and ID_PAIS=1 and  FECHA_OPERACION BETWEEN '" & yearx & "0101' AND '" & yearx & "1231' and id_provincia = 3"
	sql_m2_inv_rt="SELECT SUM(PRECIO_EUR) as MetrosCuad FROM dirs_w_OPS where ( ID_TIPO_OPERACION=1 OR ID_TIPO_OPERACION=3 ) AND seccion LIKE '%residencia tercera edad%' and web_es<>0 and ID_PAIS=1 and  FECHA_OPERACION BETWEEN '" & yearx & "0101' AND '" & yearx & "1231' and id_provincia = 3 "
    sql_op_inv_rt="SELECT COUNT(id) as Nro_Ops FROM C_OPERACIONES where ( ID_TIPO_OPERACION=1 OR ID_TIPO_OPERACION=3  ) AND seccion LIKE '%residencia tercera edad%' and pw_es<>0 and ID_PAIS=1 and  FECHA_OPERACION BETWEEN '" & yearx & "0101' AND '" & yearx & "1231' and id_provincia = 3"
	 
	sql_m2_alq_dc="SELECT SUM(PRECIO_EUR) as MetrosCuad FROM dirs_w_OPS where ( ID_TIPO_OPERACION=2 ) AND seccion LIKE '%deuda/credito%' and web_es<>0 and ID_PAIS=1 and  FECHA_OPERACION BETWEEN '" & yearx & "0101' AND '" & yearx & "1231' and id_provincia = 3 "
    sql_op_alq_dc="SELECT COUNT(id) as Nro_Ops FROM C_OPERACIONES where ( ID_TIPO_OPERACION=2 ) AND seccion LIKE '%deuda/credito%' and pw_es<>0 and ID_PAIS=1 and  FECHA_OPERACION BETWEEN '" & yearx & "0101' AND '" & yearx & "1231' and id_provincia = 3"
	sql_m2_inv_dc="SELECT SUM(PRECIO_EUR) as MetrosCuad FROM dirs_w_OPS where ( ID_TIPO_OPERACION=1 OR ID_TIPO_OPERACION=3 ) AND seccion LIKE '%deuda/credito%' and web_es<>0 and ID_PAIS=1 and  FECHA_OPERACION BETWEEN '" & yearx & "0101' AND '" & yearx & "1231' and id_provincia = 3 "
    sql_op_inv_dc="SELECT COUNT(id) as Nro_Ops FROM C_OPERACIONES where ( ID_TIPO_OPERACION=1 OR ID_TIPO_OPERACION=3  ) AND seccion LIKE '%deuda/credito%' and pw_es<>0 and ID_PAIS=1 and  FECHA_OPERACION BETWEEN '" & yearx & "0101' AND '" & yearx & "1231' and id_provincia = 3"
	 
	sql_m2_alq_pi="SELECT SUM(PRECIO_EUR) as MetrosCuad FROM dirs_w_OPS where ( ID_TIPO_OPERACION=2 ) AND seccion LIKE '%polígonos industriales%' and web_es<>0 and ID_PAIS=1 and  FECHA_OPERACION BETWEEN '" & yearx & "0101' AND '" & yearx & "1231' and id_provincia = 3 "
    sql_op_alq_pi="SELECT COUNT(id) as Nro_Ops FROM C_OPERACIONES where ( ID_TIPO_OPERACION=2 ) AND seccion LIKE '%polígonos industriales%' and pw_es<>0 and ID_PAIS=1 and  FECHA_OPERACION BETWEEN '" & yearx & "0101' AND '" & yearx & "1231' and id_provincia = 3"
	sql_m2_inv_pi="SELECT SUM(PRECIO_EUR) as MetrosCuad FROM dirs_w_OPS where ( ID_TIPO_OPERACION=1 OR ID_TIPO_OPERACION=3 ) AND seccion LIKE '%polígonos industriales%' and web_es<>0 and ID_PAIS=1 and  FECHA_OPERACION BETWEEN '" & yearx & "0101' AND '" & yearx & "1231' and id_provincia = 3 "
    sql_op_inv_pi="SELECT COUNT(id) as Nro_Ops FROM C_OPERACIONES where ( ID_TIPO_OPERACION=1 OR ID_TIPO_OPERACION=3  ) AND seccion LIKE '%polígonos industriales%' and pw_es<>0 and ID_PAIS=1 and  FECHA_OPERACION BETWEEN '" & yearx & "0101' AND '" & yearx & "1231' and id_provincia = 3"
	 
	sql_m2_alq_es="SELECT SUM(PRECIO_EUR) as MetrosCuad FROM dirs_w_OPS where ( ID_TIPO_OPERACION=2 ) AND seccion LIKE '%escuela%' and web_es<>0 and ID_PAIS=1 and  FECHA_OPERACION BETWEEN '" & yearx & "0101' AND '" & yearx & "1231' and id_provincia = 3 "
    sql_op_alq_es="SELECT COUNT(id) as Nro_Ops FROM C_OPERACIONES where ( ID_TIPO_OPERACION=2 ) AND seccion LIKE '%escuela%' and pw_es<>0 and ID_PAIS=1 and  FECHA_OPERACION BETWEEN '" & yearx & "0101' AND '" & yearx & "1231' and id_provincia = 3"
	sql_m2_inv_es="SELECT SUM(PRECIO_EUR) as MetrosCuad FROM dirs_w_OPS where ( ID_TIPO_OPERACION=1 OR ID_TIPO_OPERACION=3 ) AND seccion LIKE '%escuela%' and web_es<>0 and ID_PAIS=1 and  FECHA_OPERACION BETWEEN '" & yearx & "0101' AND '" & yearx & "1231' and id_provincia = 3 "
    sql_op_inv_es="SELECT COUNT(id) as Nro_Ops FROM C_OPERACIONES where ( ID_TIPO_OPERACION=1 OR ID_TIPO_OPERACION=3  ) AND seccion LIKE '%escuela%' and pw_es<>0 and ID_PAIS=1 and  FECHA_OPERACION BETWEEN '" & yearx & "0101' AND '" & yearx & "1231' and id_provincia = 3"
	 
	sql_m2_alq_it="SELECT SUM(PRECIO_EUR) as MetrosCuad FROM dirs_w_OPS where ( ID_TIPO_OPERACION=2 ) AND seccion LIKE '%instalaciones técnicas, etc...%' and web_es<>0 and ID_PAIS=1 and  FECHA_OPERACION BETWEEN '" & yearx & "0101' AND '" & yearx & "1231' and id_provincia = 3 "
    sql_op_alq_it="SELECT COUNT(id) as Nro_Ops FROM C_OPERACIONES where ( ID_TIPO_OPERACION=2 ) AND seccion LIKE '%instalaciones técnicas, etc...%' and pw_es<>0 and ID_PAIS=1 and  FECHA_OPERACION BETWEEN '" & yearx & "0101' AND '" & yearx & "1231' and id_provincia = 3"
	sql_m2_inv_it="SELECT SUM(PRECIO_EUR) as MetrosCuad FROM dirs_w_OPS where ( ID_TIPO_OPERACION=1 OR ID_TIPO_OPERACION=3 ) AND seccion LIKE '%instalaciones técnicas, etc...%' and web_es<>0 and ID_PAIS=1 and  FECHA_OPERACION BETWEEN '" & yearx & "0101' AND '" & yearx & "1231' and id_provincia = 3 "
    sql_op_inv_it="SELECT COUNT(id) as Nro_Ops FROM C_OPERACIONES where ( ID_TIPO_OPERACION=1 OR ID_TIPO_OPERACION=3  ) AND seccion LIKE '%instalaciones técnicas, etc...%' and pw_es<>0 and ID_PAIS=1 and  FECHA_OPERACION BETWEEN '" & yearx & "0101' AND '" & yearx & "1231' and id_provincia = 3"
     

	sql_m2_alq_cs="SELECT SUM(PRECIO_EUR) as MetrosCuad FROM dirs_w_OPS where ( ID_TIPO_OPERACION=2 ) AND seccion LIKE '%centro social/cultural%' and web_es<>0 and ID_PAIS=1 and  FECHA_OPERACION BETWEEN '" & yearx & "0101' AND '" & yearx & "1231' and id_provincia = 3 "
    sql_op_alq_cs="SELECT COUNT(id) as Nro_Ops FROM C_OPERACIONES where ( ID_TIPO_OPERACION=2 ) AND seccion LIKE '%centro social/cultural%' and pw_es<>0 and ID_PAIS=1 and  FECHA_OPERACION BETWEEN '" & yearx & "0101' AND '" & yearx & "1231' and id_provincia = 3"
	sql_m2_inv_cs="SELECT SUM(PRECIO_EUR) as MetrosCuad FROM dirs_w_OPS where ( ID_TIPO_OPERACION=1 OR ID_TIPO_OPERACION=3 ) AND seccion LIKE '%centro social/cultural%' and web_es<>0 and ID_PAIS=1 and  FECHA_OPERACION BETWEEN '" & yearx & "0101' AND '" & yearx & "1231' and id_provincia = 3 "
    sql_op_inv_cs="SELECT COUNT(id) as Nro_Ops FROM C_OPERACIONES where ( ID_TIPO_OPERACION=1 OR ID_TIPO_OPERACION=3  ) AND seccion LIKE '%centro social/cultural%' and pw_es<>0 and ID_PAIS=1 and  FECHA_OPERACION BETWEEN '" & yearx & "0101' AND '" & yearx & "1231' and id_provincia = 3"
     
	





        rsData1.open sql_m2_inv_of, session("connPW")
        rsData2.open sql_m2_inv_cc, session("connPW")
        rsData3.open sql_m2_inv_cs, session("connPW")
		rsData4.open sql_m2_inv_dc, session("connPW")
		rsData5.open sql_m2_inv_es, session("connPW")
        rsData6.open sql_m2_inv_hc, session("connPW")
        rsData7.open sql_m2_inv_ho, session("connPW")
		rsData8.open sql_m2_inv_it, session("connPW")
		rsData9.open sql_m2_inv_lc, session("connPW")
        rsData10.open sql_m2_inv_ni, session("connPW")
        rsData11.open sql_m2_inv_oc, session("connPW")
		rsData12.open sql_m2_inv_pa, session("connPW")
		rsData13.open sql_m2_inv_pi, session("connPW")
        rsData14.open sql_m2_inv_rt, session("connPW")
        rsData15.open sql_m2_inv_so, session("connPW")
		rsData16.open sql_m2_inv_vi, session("connPW")
		rsData17.open sql_m2_inv_vr, session("connPW")


		if rsData1("MetrosCuad")  <> "" then  Nro_Ops1=Round( rsData1("MetrosCuad") ,0)    else  Nro_Ops1=0 end if
		if rsData2("MetrosCuad")  <> "" then  Nro_Ops2=Round( rsData2("MetrosCuad") ,0)     else  Nro_Ops2=0 end if
		if rsData3("MetrosCuad")  <> "" then  Nro_Ops3=Round( rsData3("MetrosCuad") ,0)     else  Nro_Ops3=0 end if
		if rsData4("MetrosCuad")  <> "" then  Nro_Ops4=Round( rsData4("MetrosCuad") ,0)     else  Nro_Ops4=0 end if
		if rsData5("MetrosCuad")  <> "" then  Nro_Ops5=Round( rsData5("MetrosCuad") ,0)     else  Nro_Ops5=0 end if
		if rsData6("MetrosCuad")  <> "" then  Nro_Ops6=Round( rsData6("MetrosCuad") ,0)     else  Nro_Ops6=0 end if
		if rsData7("MetrosCuad")  <> "" then  Nro_Ops7=Round( rsData7("MetrosCuad") ,0)     else  Nro_Ops7=0 end if
		if rsData8("MetrosCuad")  <> "" then  Nro_Ops8=Round( rsData8("MetrosCuad")  ,0)    else  Nro_Ops8=0 end if
		if rsData9("MetrosCuad")  <> "" then  Nro_Ops9=Round( rsData9("MetrosCuad")  ,0)    else  Nro_Ops9=0 end if
		if rsData10("MetrosCuad")  <> "" then  Nro_Ops10=Round( rsData10("MetrosCuad") ,0)     else  Nro_Ops10=0 end if
		if rsData11("MetrosCuad")  <> "" then  Nro_Ops11=Round( rsData11("MetrosCuad")  ,0)    else  Nro_Ops11=0 end if
		if rsData12("MetrosCuad")  <> "" then  Nro_Ops12=Round( rsData12("MetrosCuad")  ,0)    else  Nro_Ops12=0 end if
		if rsData13("MetrosCuad")  <> "" then  Nro_Ops13=Round( rsData13("MetrosCuad")  ,0)    else  Nro_Ops13=0 end if
		if rsData14("MetrosCuad")  <> "" then  Nro_Ops14=Round( rsData14("MetrosCuad") ,0)     else  Nro_Ops14=0 end if
		if rsData15("MetrosCuad")  <> "" then  Nro_Ops15=Round( rsData15("MetrosCuad")  ,0)    else  Nro_Ops15=0 end if
		if rsData16("MetrosCuad")  <> "" then  Nro_Ops16=Round( rsData16("MetrosCuad")  ,0)    else  Nro_Ops16=0 end if
		if rsData17("MetrosCuad")  <> "" then  Nro_Ops17=Round( rsData17("MetrosCuad")  ,0)    else  Nro_Ops17=0 end if
		
		


    %>
<script>var dato01=<%=Nro_Ops1 %>;</script>
<script>var dato02=<%=Nro_Ops2 %>;</script>
<script>var dato03=<%=Nro_Ops3 %>;</script>
<script>var dato04=<%=Nro_Ops4 %>;</script>
<script>var dato05=<%=Nro_Ops5 %>;</script>
<script>var dato06=<%=Nro_Ops6 %>;</script>
<script>var dato07=<%=Nro_Ops7 %>;</script>
<script>var dato08=<%=Nro_Ops8 %>;</script>
<script>var dato09=<%=Nro_Ops9 %>;</script>
<script>var dato10=<%=Nro_Ops10 %>;</script>
<script>var dato11=<%=Nro_Ops11 %>;</script>
<script>var dato12=<%=Nro_Ops12 %>;</script>
<script>var dato13=<%=Nro_Ops13 %>;</script>
<script>var dato14=<%=Nro_Ops14 %>;</script>
<script>var dato15=<%=Nro_Ops15 %>;</script>
<script>var dato16=<%=Nro_Ops16 %>;</script>
<script>var dato17=<%=Nro_Ops17 %>;</script>

<%
    rsData1.close
    rsData2.close
    rsData3.close
	rsData4.close
	rsData5.close
    rsData6.close
    rsData7.close
	rsData8.close
	rsData9.close
    rsData10.close
    rsData11.close
	rsData12.close
	rsData13.close
    rsData14.close
    rsData15.close
	rsData16.close
	rsData17.close
    %>
    
    <meta charset="UTF-8">
<script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.9.3/Chart.min.js" integrity="sha512-s+xg36jbIujB2S2VKfpGmlC3T5V2TF3lY48DX7u2r9XzGzgPsa6wTpOQA7J9iffvdeBN0q9tKzRxVxw1JviZPg==" crossorigin="anonymous"></script>
<script src="/informe_takeup/utils.js" ></script>
    
	<div id="canvas-holder" style="width:400px">
		<canvas id="chart-area"></canvas>
	</div>

<script>
    window.chartColors = {
	red: 'rgb(255, 99, 132)',
	orange: 'rgb(255, 159, 64)',
	yellow: 'rgb(255, 205, 86)',
	green: 'rgb(75, 192, 192)',
	blue: 'rgb(54, 162, 235)',
	purple: 'rgb(153, 102, 255)',
	grey: 'rgb(201, 203, 207)',
	teal: 'rgb(99, 175, 188)',
	cyan: 'rgb(0, 114, 150)',
	aquam: 'rgb(0, 160, 174)',
	verdi: 'rgb(0, 196, 176)',
    dusty: 'rgb(0, 149, 169)',
	seag: 'rgb(133, 216, 220)',
	seaf: 'rgb(38, 202, 211)',
	jungle: 'rgb(1, 148, 130)',
    celeste: 'rgb(80, 133, 139)',
    color1: 'rgb(32, 176, 168)',
	color2: 'rgb(83, 180, 129)',
	color3: 'rgb(66, 145, 175)',
	color4: 'rgb(12, 136, 128)',

	pw_naranja: 'rgb(234, 103, 32)',
    pw_naranja_claro: 'rgb(237, 165, 125)',
    pw_naranja_oscuro: 'rgb(201, 88, 27)',
	pw_azul_oscuro: 'rgb(126, 173, 201)',
	pw_azul_claro: 'rgb(199, 218, 231)',
};
</script>
        <script>
          
		var randomScalingFactor = function() {
			return Math.round(Math.random() * 100);
		};

		var config = {
			type: 'pie',
			data: {
				datasets: [{
					data: [
                    dato01,
					dato02,
					dato03,
					dato04,
					dato05,
					dato06,
					dato07,
					dato08,
					dato09,
					dato10,
					dato11,
					dato12,
					dato13,
					dato14,
					dato15,
					dato16,
					dato17
					],
					backgroundColor: [
						window.chartColors.pw_naranja,
						window.chartColors.orange,
						window.chartColors.pw_naranja_claro,
						window.chartColors.pw_naranja_oscuro,
						window.chartColors.pw_azul_claro,
						window.chartColors.pw_azul_oscuro,
						window.chartColors.grey,
						window.chartColors.teal,
						window.chartColors.cyan,
						window.chartColors.aquam,
						window.chartColors.verdi,
						window.chartColors.dusty,
						window.chartColors.seag,
						window.chartColors.seaf,
						window.chartColors.jungle,
						window.chartColors.celeste,
						window.chartColors.color1
					],
					
            borderWidth: 0
				}],
				labels: [
				'Oficinas',
					'Centros Comerciales','Centro Social/Cultural','Deuda/Crédito','Escuela','Hospital/Centro de Salud','Hotel','Instalaciones Técnicas','Locales Comerciales','Naves Industriales',
					'Ocio','Parking','Polígonos Industriales','Residencias Tercera Edad','Solares','Vivienda/Coliving','Viviendas Residenciales'
				],
			},
			options: {
				responsive: true,

				title: {
					display: true,
					text: 'Inversión Barcelona 2020',
                    fontFamily: 'sans-serif',
                    fontSize: 12,
                    fontColor: window.chartColors.pw_naranja
				},
				animation: {
					animateScale: true,
					animateRotate: true
				},
                layout: {
                    padding: {
                        left: -170,
                        right: 0,
                        top: -10,
                        bottom: 0
                    }
                },
                tooltips: {
                    
                    mode: 'single',
                    intersect: false,
					callbacks: {
						title: function (tooltipItem, data) { 
							return  data.labels[tooltipItem[0].index]; 
						},
						label: function(tooltipItems, data) {
							console.log(data.datasets[0].data[tooltipItems.index]);
							//console.log(tooltipItems[0].index);
							
								return numeral(data.datasets[0].data[tooltipItems.index]).format('0,0')  + ' €'; 

						},
						//footer: function (tooltipItem, data) { return "..."; }
					}
                },
                legend: {
                display: false,
                position: 'bottom'
                }

			}
		};

		window.onload = function() {
			var ctxd = document.getElementById('chart-area').getContext('2d');
			window.myDoughnut = new Chart(ctxd, config);
		};

		document.getElementById('randomizeData').addEventListener('click', function() {
			config.data.datasets.forEach(function(dataset) {
				dataset.data = dataset.data.map(function() {
					return randomScalingFactor();
				});
			});

			window.myDoughnut.update();
		});

		var colorNames = Object.keys(window.chartColors);
		document.getElementById('addDataset').addEventListener('click', function() {
			var newDataset = {
				backgroundColor: [],
				data: [],
				label: 'New dataset ' + config.data.datasets.length,
			};

			for (var index = 0; index < config.data.labels.length; ++index) {
				newDataset.data.push(randomScalingFactor());

				var colorName = colorNames[index % colorNames.length];
				var newColor = window.chartColors[colorName];
				newDataset.backgroundColor.push(newColor);
			}

			config.data.datasets.push(newDataset);
			window.myDoughnut.update();
		});

		document.getElementById('addData').addEventListener('click', function() {
			if (config.data.datasets.length > 0) {
				config.data.labels.push('data #' + config.data.labels.length);

				var colorName = colorNames[config.data.datasets[0].data.length % colorNames.length];
				var newColor = window.chartColors[colorName];

				config.data.datasets.forEach(function(dataset) {
					dataset.data.push(randomScalingFactor());
					dataset.backgroundColor.push(newColor);
				});

				window.myDoughnut.update();
			}
		});

		document.getElementById('removeDataset').addEventListener('click', function() {
			config.data.datasets.splice(0, 1);
			window.myDoughnut.update();
		});

		document.getElementById('removeData').addEventListener('click', function() {
			config.data.labels.splice(-1, 1); // remove the label first

			config.data.datasets.forEach(function(dataset) {
				dataset.data.pop();
				dataset.backgroundColor.pop();
			});

			window.myDoughnut.update();
		});

		document.getElementById('changeCircleSize').addEventListener('click', function() {
			if (window.myDoughnut.options.circumference === Math.PI) {
				window.myDoughnut.options.circumference = 2 * Math.PI;
				window.myDoughnut.options.rotation = -Math.PI / 2;
			} else {
				window.myDoughnut.options.circumference = Math.PI;
				window.myDoughnut.options.rotation = -Math.PI;
			}

			window.myDoughnut.update();
		});
	</script>