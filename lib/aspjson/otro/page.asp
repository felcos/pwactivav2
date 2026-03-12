<%@ Language="VBScript" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="utf-8" />
        <title></title>
    </head>
    <body>
        <!--#include file="json.asp"--> 
        <%

            function httpBuildQueryArray(key, items, count, out)
                dim result
                for i = 0 to count - 1
                    if isarray(items(i)) then
                        httpBuildQueryArray (key & "[" & i & "]"), items(i), UBound(items(i)), result
                    else
                        result = result & Server.URLEncode(key & "[" & i & "]") & "=" & Server.URLEncode(items(i))
                    end if
                    if i + 1 <> count then
                        result = result & "&"
                    end if
                next
                out = result
            end function

            ' httpBuildQuery(
            '   keys array     The keys of hash.Keys
            '   items array    The items of hash.Items
            '   count integer  The count of hash.Count
            '   out string     The output of the string
            ' )
            ' Takes a Scripting.Dictionary and build a query string
            function httpBuildQuery(keys, items, count, out)
                dim result
                for i = 0 to count - 1
                    if isarray(items(i)) then
                        httpBuildQueryArray keys(i), items(i), UBound(items(i)), result
                    else
                        result = result & Server.URLEncode(keys(i)) & "=" & Server.URLEncode(items(i))
                    end if
                    if i + 1 <> count then
                        result = result & "&"
                    end if
                next
                out = result
            end function

            'Remote JSON Request
            dim params
			
			set hash = CreateObject ("Scripting.Dictionary")
			Set rs = Server.CreateObject("ADODB.Recordset")
			sql = "SELECT TOP 3 * FROM inmuebles"
			rs.Open sql, session("cnxAccesos")
			
			do while not rs.eof
				hash.add rs("id"), rs("nombre")
				rs.movenext
			loop
			
			rs.close
			set rs = nothing
			
            httpBuildQuery hash.Keys, hash.Items, hash.Count, params

            set req = Server.CreateObject("MSXML2.ServerXMLHTTP")
            req.open "GET", "https://localhost:33816/test.html?" & params, false
            req.send ""

            dim myJSON
            set myJSON = JSON.parse(req.responseText)
            response.write myJSON.test
        %>
    </body>
</html>