<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "https://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="https://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Documento sin título</title>
</head>
<body>
<table border="0" cellspacing="0" cellpadding="2">
<% for ii=0 to 63 %>
    <tr>
        <td><%= ii %>: &nbsp;</td>
        <td><img src="https://maps.google.com/mapfiles/kml/pal2/icon<%= ii %>.png"/></td>
        <td><img src="https://maps.google.com/mapfiles/kml/pal3/icon<%= ii %>.png"/></td>
        <td><img src="https://maps.google.com/mapfiles/kml/pal4/icon<%= ii %>.png"/></td>
        <td><img src="https://maps.google.com/mapfiles/kml/pal5/icon<%= ii %>.png"/></td>
    </tr>
<% next %>
</table>


:<br />

</body>
</html>
