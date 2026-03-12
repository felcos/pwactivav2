<link href="/lib/chart/chart.css" rel="stylesheet" type="text/css" />
<div id="div_info_areas" style="padding:10px; margin-top:5px; min-height:450px;">
    <div id="div_chart" name="div_chart" style="margin-top:3px;">
        <table id="chartData">
            <tr>
                <th>Area</th>
                <th>metros cuadrados</th>
            </tr>
            <%
            'chart	
            dim colore(10)
            colore(0)="#0DA068"
            colore(1)="#194E9C"
            colore(2)="#ED9C13"
            colore(3)="#ED5713"
            colore(4)="#057249"
            colore(5)="#5F91DC"
            colore(6)="#F88E5D"
            
            nn=0
            row_nd=0
            'total2=0
            
            Set resultado = Server.CreateObject("ADODB.Recordset")
            sql = "SELECT ID_TIPO_AREA, TIPOAREA AS area, COUNT(ID) AS operaciones, SUM(METROS_CUADRADOS) AS superficie FROM "
            
            IF intermediario<>"%" OR comprador<>"%" OR vendedor<>"%" THEN 
                sql = sql & "C_OPERACIONES_AGENTES"
            else
                sql = sql & "C_OPERACIONES"
            end if
            
            sql = sql & " WHERE (" & sqlW & ") GROUP BY ID_TIPO_AREA, TIPOAREA ORDER BY ID_TIPO_AREA"
            'response.Write(sql)
            
            resultado.Open sql, session("connPW")
            
            do while not resultado.eof 
                if resultado("ID_TIPO_AREA")=0 then
                    row_nd = resultado("superficie")
                    resultado.movenext
                    if resultado.eof then exit do
                end if 
                
                if isnull(resultado("area")) then
                    c_area=0
                else
                    c_area=resultado("area")
                end if
                
                if isnull(resultado("superficie")) then
                    c_superficie=0
                else
                    c_superficie=resultado("superficie")
                end if
                
                %>
            <tr style="color: <%= colore(nn) %>">
                <td><%= c_area %></td>
                <td><%= c_superficie %></td>
            </tr>
                <% 'total2=total2+resultado("superficie")
                nn=nn+1
                resultado.movenext	
            loop
            resultado.close
            
            if row_nd>0 then %>
            <tr style="color: <%= colore(nn) %>">
                <td>N/D</td>
                <td><%= row_nd %></td>
            </tr>
            <% end if %>
        </table>
        <canvas id="chart" width="480" height="400"></canvas>
    </div>

</div>
<script src="/lib/chart/chart.js"></script>