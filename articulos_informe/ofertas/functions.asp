<% Function VERSALITA(Caden) 
    VERSALITA = UCase(Left(Caden, 1)) & LCase(Right(Caden, Len(Caden) - 1))
End Function %>

<% Function VERSALITA_TODO(Caden) 
on error resume next
Dim a 
Dim wordsI(100)
Dim CuentPal
Dim IniPal
Dim cami 
Caden = Caden & " "
CuentPal = 1
IniPal = 0
For a = 1 To Len(Caden)
    If Mid(Caden, a, 1) = " " Then
        wordsI(CuentPal) = LCase(Mid(Caden, IniPal + 1, (a - IniPal)))
        If wordsI(CuentPal) <> "el " And _
   		wordsI(CuentPal) <> "la " And  _
    	wordsI(CuentPal) <> "los " And wordsI(CuentPal) <> "las " And _
    	wordsI(CuentPal) <> "del " And wordsI(CuentPal) <> "de " Then
            wordsI(CuentPal) = VERSALITA(wordsI(CuentPal))
        End If
        If wordsI(CuentPal) = "I " Or wordsI(CuentPal) = "Ii " Or _
        wordsI(CuentPal) = "Iii " Or wordsI(CuentPal) = "Iv " Or _
        wordsI(CuentPal) = "V " Or wordsI(CuentPal) = "Vi " Or _
        wordsI(CuentPal) = "Vii " Or wordsI(CuentPal) = "Viii" Or _
        wordsI(CuentPal) = "Ix " Or wordsI(CuentPal) = "X " Or _
        wordsI(CuentPal) = "Xi " Or wordsI(CuentPal) = "Xii " Or _
        wordsI(CuentPal) = "Xiii " Or wordsI(CuentPal) = "Xiv" Then
            wordsI(CuentPal) = UCase(wordsI(CuentPal))
        End If
        cami = cami & wordsI(CuentPal)
        IniPal = a
        cuenpal = cuenpal + 1
    End If
Next

VERSALITA_TODO = Left(cami, Len(cami) - 1)
End Function%>

<% sub TABLAFOTOS
strFotos=Resultado("FOTOS") %>
<table width="500" height="50" border="0" align="right">
    <tr>
      <td width="500" align="left" valign="middle"> 
        <%for a= 1 to Resultado("NUMERO_FOTOS")
  	pathFoto = "../fotos/" & Left(strFotos, InStr(1, strFotos, "&") - 1)
   	strFotos = Right(strFotos, Len(strFotos) - InStr(1, strFotos, "&"))
	%>
        <a href="javascript:"  onclick="javascript:window.open('../pagfoto/verFoto.asp?b=<%=bloque%>&num=<%=Resultado("NUMERO_FOTOS")%>&<%=Resultado("FOTOS")%>','Fotos','scrollbars=no,resizable=no,width=300,height=300')"> 
        <img src="<%=pathFoto%>" width="100" hspace="0" vspace="0" border="0" align="right" id="img<%=a%>"> 
        </a> 
        <%next
	%>
	</td>
  </tr>
</table>
<%end sub%>
<%
function ConvierteTexto(rSting)	
	tmp = cstr(rSting)
	
	tmp = replace(tmp, "'", "''")
	
	ConvierteTexto = tmp
end function 

function ConvierteTexto(rSting)	
	tmp = cstr(rSting)
	
	tmp = replace(tmp, "'", "''")
	
	ConvierteTexto = tmp
end function 

function txtBD(rTexto)	
	txtP=rTexto
	if txtP<>"" then
		txtP=replace(txtP, "á", "&aacute;")
		txtP=replace(txtP, "Á", "&Aacute;")
		txtP=replace(txtP, "à", "&agrave;")
		txtP=replace(txtP, "À", "&Agrave;")
		txtP=replace(txtP, "é", "&eacute;")
		txtP=replace(txtP, "É", "&Eacute;")
		txtP=replace(txtP, "è", "&egrave;")
		txtP=replace(txtP, "È", "&Egrave;")
		txtP=replace(txtP, "í", "&iacute;")
		txtP=replace(txtP, "Í", "&Iacute;")
		txtP=replace(txtP, "ì", "&igrave;")
		txtP=replace(txtP, "Ì", "&Igrave;")
		txtP=replace(txtP, "ó", "&oacute;")
		txtP=replace(txtP, "Ó", "&Oacute;")
		txtP=replace(txtP, "ò", "&ograve;")
		txtP=replace(txtP, "Ò", "&Ograve;")
		txtP=replace(txtP, "ú", "&uacute;")
		txtP=replace(txtP, "Ú", "&Uacute;")
		txtP=replace(txtP, "ù", "&ugrave;")
		txtP=replace(txtP, "Ù", "&Ugrave;")
		txtP=replace(txtP, "ñ", "&ntilde;")
		txtP=replace(txtP, "Ñ", "&Ntilde;")
		txtP=replace(txtP, "ç", "&ccedil;")
		txtP=replace(txtP, "Ç", "&Ccedil;")
		
		txtP=replace(txtP, "€", "&euro;")
		txtP=replace(txtP, "¿", "&iquest;")
		txtP=replace(txtP, "º", "&deg;")
		txtP=replace(txtP, "ª", "&ordf;")
	end if
	txtBD=txtP
end function
%>