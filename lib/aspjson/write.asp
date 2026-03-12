<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "https://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="https://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Documento sin título</title>
<!--#include virtual="/lib/aspjson/aspJSON1.17.asp" -->
</head>
<body>
<h3><a href="https://www.aspjson.com/">https://www.aspjson.com/</a></h3>
<%
Set oJSON = New aspJSON

With oJSON.data

    .Add "familyName", "Smith"                      'Create value
    .Add "familyMembers", oJSON.Collection()

    With oJSON.data("familyMembers")

        .Add 0, oJSON.Collection()                  'Create object
        With .item(0)
            .Add "firstName", "John"
            .Add "age", 41
        End With

        .Add 1, oJSON.Collection()
        With .item(1)
            .Add "firstName", "Suzan"
            .Add "age", 38
            .Add "interests", oJSON.Collection()    'Create array
            With .item("interests")
                .Add 0, "Reading"
                .Add 1, "Tennis"
                .Add 2, "Painting"
            End With
        End With

        .Add 2, oJSON.Collection()
        With .item(2)
            .Add "firstName", "John Jr."
            .Add "age", 2.5
        End With

    End With

End With

Response.Write oJSON.JSONoutput()                   'Return json string
%>

</body>
</html>
