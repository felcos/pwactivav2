<%' Vencimientos	
bloque="ven"
strin="ven"
ErrMesage=""
num_titulo=0
apart= ""
seccion2="VENCIMIENTOS"
origen="DailyFlash"

sql_vencim = "SELECT ID, TITULO, TITULO_pt AS TITULO_AUX, FECHA_ACTUALIZACION,  SECCION AS APARTADO, "
sql_vencim = sql_vencim & "LOCALIDAD, PROVINCIA, TIPOACTIVIDAD, METROS_CUADRADOS, ID_TIPO_OPERACION "
sql_vencim = sql_vencim & "FROM C_OPERACIONES WHERE "
sql_vencim = sql_vencim & "(FECHA_PUBLICACION_VENCIMIENTO BETWEEN  CONVERT(DATETIME, '" & pFecha & "', 103) AND CONVERT(DATETIME, '" & pFecha & "', 103)) "	
sql_vencim = sql_vencim & "AND web_es <> 0"
sql_vencim = sql_vencim & " ORDER BY SECCION"

test_inyeccion_sql sql_vencim
resultado.Open sql_vencim, session("connPW")	',1,1

if not resultado.eof then %>
<% call BloqueVencimientosFlash(resultado) %>
<% end if
resultado.close %>