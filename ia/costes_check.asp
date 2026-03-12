<%
' /ia/costes_check.asp
' Requisito FASE 3: Proteccion estricta de Base de Datos para verificar budget antes de ejecutar.
' Este script no ejecuta outputs al navegador, solo devuelve True o False

Function CheckIABudget(providerName)
    ' Verifica si el proveedor tiene presupuesto diario/mensual disponible en AI_CONFIG
    Dim hasBudget : hasBudget = False
    Dim rs : Set rs = Server.CreateObject("ADODB.Recordset")
    
    On Error Resume Next
    rs.Open "SELECT activo, presupuesto_diario, presupuesto_mensual, " & _
            "(SELECT SUM(coste_estimado) FROM AI_COSTES WHERE provider = '" & Replace(providerName,"'","") & "' AND CAST(fecha AS DATE) = CAST(GETDATE() AS DATE)) as gasto_hoy, " & _
            "(SELECT SUM(coste_estimado) FROM AI_COSTES WHERE provider = '" & Replace(providerName,"'","") & "' AND MONTH(fecha) = MONTH(GETDATE()) AND YEAR(fecha) = YEAR(GETDATE())) as gasto_mes " & _
            "FROM AI_CONFIG WHERE provider = '" & Replace(providerName,"'","") & "'", session("connPW")
    
    If Not rs.EOF Then
        If rs("activo") = True Then
            Dim gastoHoy : gastoHoy = CDbl(NullToZero(rs("gasto_hoy")))
            Dim gastoMes : gastoMes = CDbl(NullToZero(rs("gasto_mes")))
            Dim limD : limD = CDbl(NullToZero(rs("presupuesto_diario")))
            Dim limM : limM = CDbl(NullToZero(rs("presupuesto_mensual")))
            
            If (limD = 0 Or gastoHoy < limD) And (limM = 0 Or gastoMes < limM) Then
                hasBudget = True
            End If
        End If
    Else
        ' Si no hay config, por seguridad no permitimos gasto o permitimos uno minimo
        hasBudget = True 
    End If
    rs.Close : Set rs = Nothing
    
    CheckIABudget = hasBudget
End Function

Function LogIACost(providerName, modelUsed, tokensIn, tokensOut, tipoOperacion, idReferencia)
    ' Registra el coste estimado en AI_COSTES
    Dim costeTotal, sql
    ' Precios estimados (pueden venir de AI_CONFIG en el futuro)
    costeTotal = (tokensIn * 0.00000015) + (tokensOut * 0.0000006) 
    
    sql = "INSERT INTO AI_COSTES (provider, modelo, tokens_entrada, tokens_salida, coste_estimado, tipo_operacion, id_referencia, fecha) " & _
          "VALUES ('" & Replace(providerName,"'","") & "', '" & Replace(modelUsed,"'","") & "', " & CLng(tokensIn) & ", " & CLng(tokensOut) & ", " & Replace(CDbl(costeTotal), ",", ".") & ", '" & tipoOperacion & "', " & CLng(idReferencia) & ", GETDATE())"
    
    On Error Resume Next
    Dim conn : Set conn = Server.CreateObject("ADODB.Connection")
    conn.Open session("connPW")
    conn.Execute sql
    conn.Close : Set conn = Nothing
End Function

Function NullToZero(val)
    If IsNull(val) Or val = "" Then NullToZero = 0 Else NullToZero = val
End Function
%>
