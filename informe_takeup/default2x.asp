<meta charset="UTF-8">
<script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.9.3/Chart.min.js" integrity="sha512-s+xg36jbIujB2S2VKfpGmlC3T5V2TF3lY48DX7u2r9XzGzgPsa6wTpOQA7J9iffvdeBN0q9tKzRxVxw1JviZPg==" crossorigin="anonymous"></script>
<script src="/informe_takeup/utils.js" ></script>
<div class="contenedorgr">
</div>

<style>
	canvas {
		-moz-user-select: none;
		-webkit-user-select: none;
		-ms-user-select: none;
	}
	.chart-contenedorgr {
		width: 840px;
		margin-left: 40px;
		margin-right: 40px;
		margin-bottom: 40px;
	}
	.contenedorgr {
		width: 840px;
		display: flex;
		flex-direction: row;
		flex-wrap: wrap;
		justify-content: center;
        background-image: url("/informe_takeup/fondo20.png");
		background-repeat: no-repeat;
	}
    </style>
	
	



<script>


    let bcnDATA = Array(36);
    let madDATA = Array(36);
    let yearDATA = Array(36);

    bcnDATA[	0	]=	7,80	;
bcnDATA[	1	]=	9,00	;
bcnDATA[	2	]=	10,80	;
bcnDATA[	3	]=	15,00	;
bcnDATA[	4	]=	19,25	;
bcnDATA[	5	]=	22,50	;
bcnDATA[	6	]=	25,85	;
bcnDATA[	7	]=	29,45	;
bcnDATA[	8	]=	21,35	;
bcnDATA[	9	]=	15,75	;
bcnDATA[	10	]=	13,25	;
bcnDATA[	11	]=	11,50	;
bcnDATA[	12	]=	13,85	;
bcnDATA[	13	]=	14,50	;
bcnDATA[	14	]=	20,25	;
bcnDATA[	15	]=	24,00	;
bcnDATA[	16	]=	27,00	;
bcnDATA[	17	]=	25,00	;
bcnDATA[	18	]=	22,85	;
bcnDATA[	19	]=	24,00	;
bcnDATA[	20	]=	24,00	;
bcnDATA[	21	]=	25,00	;
bcnDATA[	22	]=	27,50	;
bcnDATA[	23	]=	25,00	;
bcnDATA[	24	]=	22,00	;
bcnDATA[	25	]=	20,00	;
bcnDATA[	26	]=	19,00	;
bcnDATA[	27	]=	18,00	;
bcnDATA[	28	]=	17,75	;
bcnDATA[	29	]=	18,00	;
bcnDATA[	30	]=	19,00	;
bcnDATA[	31	]=	21,00	;
bcnDATA[	32	]=	22,25	;
bcnDATA[	33	]=	24,50	;
bcnDATA[	34	]=	26,85	;
bcnDATA[	35	]=	28,50	;
				;
				;
madDATA[	0	]=	9,6	;
madDATA[	1	]=	13,25	;
madDATA[	2	]=	15	;
madDATA[	3	]=	20	;
madDATA[	4	]=	25,5	;
madDATA[	5	]=	31,55	;
madDATA[	6	]=	33	;
madDATA[	7	]=	20,24	;
madDATA[	8	]=	16,25	;
madDATA[	9	]=	15	;
madDATA[	10	]=	15	;
madDATA[	11	]=	16,25	;
madDATA[	12	]=	17,45	;
madDATA[	13	]=	19,85	;
madDATA[	14	]=	27	;
madDATA[	15	]=	36	;
madDATA[	16	]=	34,5	;
madDATA[	17	]=	30,85	;
madDATA[	18	]=	26,7	;
madDATA[	19	]=	25,5	;
madDATA[	20	]=	27,25	;
madDATA[	21	]=	38	;
madDATA[	22	]=	40	;
madDATA[	23	]=	32	;
madDATA[	24	]=	28,5	;
madDATA[	25	]=	26,75	;
madDATA[	26	]=	25,75	;
madDATA[	27	]=	24,5	;
madDATA[	28	]=	26	;
madDATA[	29	]=	25,5	;
madDATA[	30	]=	27	;
madDATA[	31	]=	28,45	;
madDATA[	32	]=	30,75	;
madDATA[	33	]=	32,125	;
madDATA[	34	]=	35,75	;
madDATA[	35	]=	35,875	;
				;
				;
				;
yearDATA[	0	]=	1985	;
yearDATA[	1	]=	1986	;
yearDATA[	2	]=	1987	;
yearDATA[	3	]=	1988	;
yearDATA[	4	]=	1989	;
yearDATA[	5	]=	1990	;
yearDATA[	6	]=	1991	;
yearDATA[	7	]=	1992	;
yearDATA[	8	]=	1993	;
yearDATA[	9	]=	1994	;
yearDATA[	10	]=	1995	;
yearDATA[	11	]=	1996	;
yearDATA[	12	]=	1997	;
yearDATA[	13	]=	1998	;
yearDATA[	14	]=	1999	;
yearDATA[	15	]=	2000	;
yearDATA[	16	]=	2001	;
yearDATA[	17	]=	2002	;
yearDATA[	18	]=	2003	;
yearDATA[	19	]=	2004	;
yearDATA[	20	]=	2005	;
yearDATA[	21	]=	2006	;
yearDATA[	22	]=	2007	;
yearDATA[	23	]=	2008	;
yearDATA[	24	]=	2009	;
yearDATA[	25	]=	2010	;
yearDATA[	26	]=	2011	;
yearDATA[	27	]=	2012	;
yearDATA[	28	]=	2013	;
yearDATA[	29	]=	2014	;
yearDATA[	30	]=	2015	;
yearDATA[	31	]=	2016	;
yearDATA[	32	]=	2017	;
yearDATA[	33	]=	2018	;
yearDATA[	34	]=	2019	;
yearDATA[	35	]=	2020	;
yearDATA[	36	]=	2021	;

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
	color4: 'rgb(12, 136, 128)',
	pw_naranja: 'rgb(234, 103, 32)',
    pw_naranja_claro: 'rgb(237, 165, 125)',
    pw_naranja_oscuro: 'rgb(201, 88, 27)',
	pw_azul_oscuro: 'rgb(126, 173, 201)',
	pw_azul_claro: 'rgb(199, 218, 231)',
};

function createConfig(position) {
			return {
            type: 'line',
            data: {
                labels: yearDATA,
         
                datasets: [{
                    label: 'Barcelona',
                    borderColor: window.chartColors.pw_naranja,
                    backgroundColor: window.chartColors.pw_naranja,
                    data: bcnDATA,
                    fill: false,
					pointRadius: 0,
					lineTension: 0,
                }, {
                    label: 'Madrid',
                    borderColor: window.chartColors.pw_azul_oscuro,
                    backgroundColor: window.chartColors.pw_azul_oscuro,
                    data: madDATA,
                    fill: false,
					pointRadius: 0,
					lineTension: 0,
					
                }]
            },

            options: {
                responsive: true,
                title: {
                    display: true,
                    text: 'Mercado de Oficinas - Renta Prime ',
                    fontFamily: 'sans-serif',
                    fontSize: 21,
                    fontColor: window.chartColors.pw_naranja

                },
                tooltips: {
                    position: position,
                    mode: 'index',
                    intersect: false,
                },
                legend: {
                display: true,
                position: 'top',
				scales: { xAxes: [{ scaleLabel: { display: true, labelString: 'probability' } }] }
                },
				scales: {
					xAxes: [{
						display: true,
						ticks: {
							autoSkip: false, 
							maxRotation: 90, 
							minRotation: 90,
							fontColor: window.chartColors.pw_azul_claro
						}}],
					yAxes: [{
						display: true,
						beginAtZero: true,
						ticks: {
							autoSkip: false, 
							beginAtZero: true,
							fontColor: window.chartColors.pw_azul_claro
						}
					}]
				}
            }
        }};


window.onload = function() {
			var container = document.querySelector('.contenedorgr');

		//  ['average', 'nearest'].forEach(function(position) {
            [ 'nearest'].forEach(function(position) {            
				var div = document.createElement('div');
				div.classList.add('chart-contenedorgr');

				var canvas = document.createElement('canvas');
				div.appendChild(canvas);
				container.appendChild(div);

				var ctx = canvas.getContext('2d');
				var config = createConfig(position);
				new Chart(ctx, config);
			});
		};
</script>
