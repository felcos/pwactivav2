<% 'select case request.cookies("config")("nav")
'case "jetmenu" %><!-- include virtual="/inc/body/jetmenu.asp" --><%
'case else %><!--#include virtual="/inc/body/simple.asp" --><% 
'end select %>