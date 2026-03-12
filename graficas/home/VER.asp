<!--#include virtual="/inc/js.asp" -->
<link class="include" rel="stylesheet" type="text/css" href="/lib/jqplot/jquery.jqplot.min.css" />
<!--[if lt IE 9]><script language="javascript" type="text/javascript" src="/lib/jqplot/excanvas.min.js"></script><![endif]-->
<script class="include" type="text/javascript" src="/lib/jqplot/jquery.jqplot.min.js"></script>

<script class="include" language="javascript" type="text/javascript" src="/lib/jqplot/plugins/jqplot.barRenderer.min.js"></script>
<script class="include" language="javascript" type="text/javascript" src="/lib/jqplot/plugins/jqplot.categoryAxisRenderer.min.js"></script>
<script class="include" language="javascript" type="text/javascript" src="/lib/jqplot/plugins/jqplot.pointLabels.min.js"></script>
<script type="text/javascript" src="/lib/jqplot/plugins/jqplot.canvasTextRenderer.min.js"></script>
<script type="text/javascript" src="/lib/jqplot/plugins/jqplot.canvasAxisLabelRenderer.min.js"></script>
<style type="text/css">
.note {
    font-size: 0.8em;
}
.jqplot-yaxis-tick {
  white-space: nowrap;
}
.jqplot-title {
    font-size: 1.8em;
}
.graf_next, .graf_prev {
  margin-top: 120px;
  width: 82px;
  height: 82px;
  color: #232222;
  background: #d4d8d8;
  text-align: center;
  font: 400 72px/80px 'Arial';
  cursor: pointer;
  border-radius: 41px;
  -webkit-transition: 0.3s color ease;
  transition: 0.3s color ease;
  z-index: 10;
}

.graf_next:hover, .graf_prev:hover {
  color: #F47C04;
}

.graf_next:before {
  padding-left: 10px;
  content: '>';
}
.graf_prev:before {
  padding-right: 10px;
  content: '<';
}
</style>
<!--#include virtual="/graficas/home/graficas.asp" -->

<a class="graf_prev" href="#">anterior</a> &nbsp; | &nbsp; <%= actual %> &nbsp; | &nbsp;  <a class="graf_next" href="#">siguiente</a>



