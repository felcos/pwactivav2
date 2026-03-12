<%@ LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>
<!--#include virtual="/inc/reg_accesos.asp" -->
<!--#include virtual="/lib/funciones.asp" -->

<!DOCTYPE html>
<html>
<head>
    <title>PropertyWeb - DESARROLLO</title>
    <!--#include virtual="/inc/head.asp" -->
    
    <link href="/lib/bootstrap-datepicker/bootstrap-datepicker3.css" rel="stylesheet" type="text/css">
    <script src="/lib/bootstrap-datepicker/bootstrap-datepicker.min.js"></script>
    <script src="/lib/bootstrap-datepicker/bootstrap-datepicker.es.js"></script>
    <script src="/inc/datepicker.js"></script>
<%
f_hasta = date
f_desde = dateadd("m", -3, f_hasta)
%>
</head>
<body>
<!--#include virtual="/inc/body-header.asp" -->
<div class="container">

<section id="s_1" class="clearfix">
    <h1 class="heading">Bootstrap Datepicker</h1>
    
    <div class="row">
        <div class="col-md-6">	


<div class="form-group clearfix">
    <label for="FechaI" class="col-sm-2 control-label">Per&iacute;odo de:</label>
    <div class="col-sm-4"> 
        <input type="text" name="FechaI" id="FechaI" value="<%= f_desde %>" maxlength="10" class="form-control">
    </div>
    <label for="FechaF" class="col-sm-2 control-label">hasta:</label>
    <div class="col-sm-4">
        <input type="text" name="FechaF" id="FechaF" value="<%= f_hasta %>" maxlength="10" class="form-control">
    </div>
</div>

        </div>
        <div class="col-md-6">

<p><label for="valor">f_desde: </label><input type="text" id="f_desde" name="f_desde" value="x"></p>
<p><label for="valor">f_hasta: </label><input type="text" id="f_hasta" name="f_hasta" value="x"></p>


<p class="informa" id="informa" style="background:#CCC;">x</p>
<p class="informa" style="background:#CCC;">y</p>
        
        </div>
        
    </div>
    
    <div class="row">
        <div class="col-md-12">

<p>&nbsp;</p>
<hr>
<p>&nbsp;</p>
<p>&nbsp;</p>
<p>&nbsp;</p>


        </div>
    </div>
    
</section>

</div>
<!--#include virtual="/inc/body-footer.asp" -->
</body>
</html>

