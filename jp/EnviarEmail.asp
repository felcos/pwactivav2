<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "https://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="https://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Documento sin título</title>
</head>
<body>
<h3>Enviar email</h3>
<% 
subj = "probando"
body = "cuerpo del mensaje."

rr = session("pw_ws").EnviarEmail("probando", "cuerpo del mensaje.")

%>
<p>r: <%= rr %></p>
</body>
</html>
