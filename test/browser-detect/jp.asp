<!doctype html>
<html lang="en">
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
<title>Browser Detection with JavaScript</title>
<!--link href="presentation-only.css" rel="stylesheet"-->
<script src="/lib/detect/detect.min.js"></script>
<script src="/js/jquery.min.js"></script>
<!--[if lt IE 9]>
<script src="https://html5shiv.googlecode.com/svn/trunk/html5.js"></script>
<![endif]-->
<script>
var browserDetect = {
	init: function () {
		$(".button").click(function () {
			// Feature detection: Check if navigator.userAgent exists
			if (typeof navigator.userAgent === "undefined") {
				browserDetect.showInfo("navigator.userAgent no est&aacute; disponible en tu navegador.");
				
			} else if ($(this).attr("id") === "navigator-obj") {
				browserDetect.navigatorObj();
				
			} else {
				browserDetect.detectJS();
				
			}
		});
	},
	
	// Display navigator.userAgent string in the message area
	navigatorObj: function () {
		browserDetect.showInfo(navigator.userAgent);
	},
	
	detectJS: function () {
		b = detect.parse(navigator.userAgent);
		// Display the Detect.js parsed properties in the message area
		browserDetect.showInfo(
			"Your browser is " + b.browser.name + "</br>" +
			"Your device type is " + b.device.type + "</br>" +
			"Your operating system is " + b.os.name + "</br>"
		);
	},
	
	// Update message area with the string argument
	showInfo: function (m) {
		$("#message-area").html(m);
	}
}

// Call browserDetect object when DOM is ready 
jQuery(document).ready(browserDetect.init);
</script>

</head>
<body>
<div class="container"> 
    <header class="header">
        <h1>Browser Detection with JavaScript</h1>
        <p class="sub">Dos t&eacute;cnicas para obtener el navegador y el sistema operativo.</p>
        <nav class="nav">
        	<p><a href="https://sixrevisions.com/javascript/browser-detection-javascript/">Ver tutorial</a></p>
        </nav>
    </header>
    
    <section class="section">
        <h2 class="sub">M&eacute;todo de detecci&oacute;n</h2>
        <p>
        <a class="button" id="navigator-obj" href="#message-area">Navigator.userAgent</a> 
        <a class="button b" id="detect-js" href="#message-area">Detect.js</a>
        </p>
    </section>
    
    <section id="message-area" class="section message">
    	<noscript>JavaScript no est&aacute; disponible en tu navegador. El script no funciona.</noscript>
	</section>
</div>
</body>
</html>