	<% 

    set rsData = Server.CreateObject("ADODB.Recordset")
    set rsData2 = Server.CreateObject("ADODB.Recordset")
    set rsData3 = Server.CreateObject("ADODB.Recordset")
    set rsData4 = Server.CreateObject("ADODB.Recordset")
    localidad=""
    dim yearx
    yearx=2020
    sql_m2="SELECT SUM(METROS_CUADRADOS) as MetrosCuad FROM dirs_w_OPS where ( ID_TIPO_OPERACION=1 OR ID_TIPO_OPERACION=2 ) AND seccion LIKE '%oficinas%' and web_es<>0 and ID_PAIS=1 and  FECHA_OPERACION BETWEEN '" & yearx & "0101' AND '" & yearx & "1231' "
    sql_eu="SELECT COUNT(id) as Nro_Ops FROM C_OPERACIONES where ( ID_TIPO_OPERACION=1 OR ID_TIPO_OPERACION=2 ) AND seccion LIKE '%oficinas%' and pw_es<>0 and ID_PAIS=1 and  FECHA_OPERACION BETWEEN '" & yearx & "0101' AND '" & yearx & "1231'"
    
    if localidad="" then
        sqlw = sqlw & " AND id_pais = 1"
    else
    
        sqlw = sqlw & " AND "
        if localidad = "madrid" then
            sqlw = sqlw & "id_provincia = 2"
        elseif localidad = "barcelona" then
            sqlw = sqlw & "id_provincia = 3"
        elseif localidad = "londres" then
            sqlw = sqlw & "id_provincia = 60"
        else
            sqlw = sqlw & "localidad = '" & localidad & "'"
        end if
    end if
    
    sql_m21="SELECT SUM(METROS_CUADRADOS) as MetrosCuad FROM dirs_w_OPS where ( ID_TIPO_OPERACION=2 ) AND seccion LIKE '%oficinas%' and web_es<>0 and ID_PAIS=1 and  FECHA_OPERACION BETWEEN '" & yearx & "0101' AND '" & yearx & "1231' "
    sql_eu1="SELECT COUNT(id) as Nro_Ops FROM C_OPERACIONES where ( ID_TIPO_OPERACION=2 ) AND seccion LIKE '%oficinas%' and pw_es<>0 and ID_PAIS=1 and  FECHA_OPERACION BETWEEN '" & yearx & "0101' AND '" & yearx & "1231'"
    sql_m22="SELECT SUM(METROS_CUADRADOS) as MetrosCuad FROM dirs_w_OPS where ( ID_TIPO_OPERACION=1) AND seccion LIKE '%oficinas%' and web_es<>0 and ID_PAIS=1 and  FECHA_OPERACION BETWEEN '" & yearx & "0101' AND '" & yearx & "1231' "
    sql_eu2="SELECT COUNT(id) as Nro_Ops FROM C_OPERACIONES where ( ID_TIPO_OPERACION=1 ) AND seccion LIKE '%oficinas%' and pw_es<>0 and ID_PAIS=1 and  FECHA_OPERACION BETWEEN '" & yearx & "0101' AND '" & yearx & "1231'"
     
    
        rsData.open sql_m21, session("connPW")
        rsData2.open sql_eu1, session("connPW")
        rsData3.open sql_m22, session("connPW")
        rsData4.open sql_eu2, session("connPW")
        Nro_Ops1=rsData2("Nro_Ops") 
        Nro_Ops2=rsData4("Nro_Ops") 
' = rsData("MetrosCuad") 

    %>
<script>var dato01=<%=Nro_Ops1 %>;</script>
<script>var dato02=<%=Nro_Ops2 %>;</script>
<%
    rsData.close
    rsData2.close
    rsData3.close
    rsData4.close
    %>
    
    <meta charset="UTF-8">
<script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.9.3/Chart.min.js" integrity="sha512-s+xg36jbIujB2S2VKfpGmlC3T5V2TF3lY48DX7u2r9XzGzgPsa6wTpOQA7J9iffvdeBN0q9tKzRxVxw1JviZPg==" crossorigin="anonymous"></script>
<script src="/informe_takeup/utils.js" ></script>
    
	<div id="canvas-holder" style="width:400px">
		<canvas id="chart-area"></canvas>
	</div>

<script>
    window.chartColors = {
	red: 'rgb(255, 99, 132)',
	orange: 'rgb(255, 159, 64)',
	yellow: 'rgb(255, 205, 86)',
	green: 'rgb(75, 192, 192)',
	blue: 'rgb(54, 162, 235)',
	purple: 'rgb(153, 102, 255)',
	grey: 'rgb(201, 203, 207)',
	teal: 'rgb(99, 175, 188)',
	cyan: 'rgb(0, 114, 150)',
	aquam: 'rgb(0, 160, 174)',
	verdi: 'rgb(0, 196, 176)',
    dusty: 'rgb(0, 149, 169)',
	seag: 'rgb(133, 216, 220)',
	seaf: 'rgb(38, 202, 211)',
	jungle: 'rgb(1, 148, 130)',
    celeste: 'rgb(80, 133, 139)',
    color1: 'rgb(32, 176, 168)',
	color2: 'rgb(83, 180, 129)',
	color3: 'rgb(66, 145, 175)',
	color4: 'rgb(12, 136, 128)'
};
</script>
        <script>
          
		var randomScalingFactor = function() {
			return Math.round(Math.random() * 100);
		};

		var config = {
			type: 'doughnut',
			data: {
				datasets: [{
					data: [
                    dato01,
					dato02,
					],
					backgroundColor: [
						window.chartColors.color2,
						window.chartColors.color4,
					],
					label: 'Dataset 1'
				}],
				labels: [
					'Alquiler',
					'Ocup. Prop.'
				]
			},
			options: {
				responsive: true,
				legend: {
					position: 'top',
				},
				title: {
					display: true,
					text: 'TakeUp España 2020 (ops)',
                    fontFamily: 'sans-serif',
                    fontSize: 16,
                    fontColor: window.chartColors.color3
				},
				animation: {
					animateScale: true,
					animateRotate: true
				},
                layout: {
                    padding: {
                        left: -160,
                        right: 0,
                        top: -10,
                        bottom: 0
                    }
                }
			}
		};

		window.onload = function() {
			var ctxd = document.getElementById('chart-area').getContext('2d');
			window.myDoughnut = new Chart(ctxd, config);
		};

		document.getElementById('randomizeData').addEventListener('click', function() {
			config.data.datasets.forEach(function(dataset) {
				dataset.data = dataset.data.map(function() {
					return randomScalingFactor();
				});
			});

			window.myDoughnut.update();
		});

		var colorNames = Object.keys(window.chartColors);
		document.getElementById('addDataset').addEventListener('click', function() {
			var newDataset = {
				backgroundColor: [],
				data: [],
				label: 'New dataset ' + config.data.datasets.length,
			};

			for (var index = 0; index < config.data.labels.length; ++index) {
				newDataset.data.push(randomScalingFactor());

				var colorName = colorNames[index % colorNames.length];
				var newColor = window.chartColors[colorName];
				newDataset.backgroundColor.push(newColor);
			}

			config.data.datasets.push(newDataset);
			window.myDoughnut.update();
		});

		document.getElementById('addData').addEventListener('click', function() {
			if (config.data.datasets.length > 0) {
				config.data.labels.push('data #' + config.data.labels.length);

				var colorName = colorNames[config.data.datasets[0].data.length % colorNames.length];
				var newColor = window.chartColors[colorName];

				config.data.datasets.forEach(function(dataset) {
					dataset.data.push(randomScalingFactor());
					dataset.backgroundColor.push(newColor);
				});

				window.myDoughnut.update();
			}
		});

		document.getElementById('removeDataset').addEventListener('click', function() {
			config.data.datasets.splice(0, 1);
			window.myDoughnut.update();
		});

		document.getElementById('removeData').addEventListener('click', function() {
			config.data.labels.splice(-1, 1); // remove the label first

			config.data.datasets.forEach(function(dataset) {
				dataset.data.pop();
				dataset.backgroundColor.pop();
			});

			window.myDoughnut.update();
		});

		document.getElementById('changeCircleSize').addEventListener('click', function() {
			if (window.myDoughnut.options.circumference === Math.PI) {
				window.myDoughnut.options.circumference = 2 * Math.PI;
				window.myDoughnut.options.rotation = -Math.PI / 2;
			} else {
				window.myDoughnut.options.circumference = Math.PI;
				window.myDoughnut.options.rotation = -Math.PI;
			}

			window.myDoughnut.update();
		});
	</script>