<!DOCTYPE html>
<html>
<head>
	<title>fancyBox - Fancy jQuery Lightbox Alternative | Demonstration</title>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
    
    <script src="/js/jquery.js"></script>

	<!-- Add mousewheel plugin (this is optional) -->
    <script src="/lib/fancyBox/jquery.mousewheel-3.0.6.pack.js" type="text/javascript"></script>

	<!-- Add fancyBox main JS and CSS files -->
	<script src="/lib/fancyBox/jquery.fancybox.js?v=2.1.5" type="text/javascript"></script>
	<link href="/lib/fancyBox/jquery.fancybox.css?v=2.1.5" media="screen" rel="stylesheet" type="text/css" />

	<!-- Add Button helper (this is optional) -->
	<link href="/lib/fancyBox/helpers/jquery.fancybox-buttons.css?v=1.0.5" rel="stylesheet" type="text/css" />
	<script src="/lib/fancyBox/helpers/jquery.fancybox-buttons.js?v=1.0.5" type="text/javascript"></script>

	<!-- Add Thumbnail helper (this is optional) -->
	<link href="/lib/fancyBox/helpers/jquery.fancybox-thumbs.css?v=1.0.7" rel="stylesheet" type="text/css" />
	<script src="/lib/fancyBox/helpers/jquery.fancybox-thumbs.js?v=1.0.7" type="text/javascript"></script>

	<!-- Add Media helper (this is optional) -->
	<script src="/lib/fancyBox/helpers/jquery.fancybox-media.js?v=1.0.6" type="text/javascript"></script>

<script type="text/javascript">
$(document).ready(function() {
	 
	$("#fancybox-manual-c").click(function() {
		$.fancybox.open([
			{
				href : '1_b.jpg',
				title : 'My title'
			}, {
				href : '2_b.jpg',
				title : '2nd title'
			}, {
				href : '3_b.jpg'
			}
		], {
			helpers : {
				thumbs : {
					width: 75,
					height: 50
				}
			}
		});
	});

});
</script>
</head>
<body>
	<h1>fancyBox</h1>

	<p>This is a demonstration. More information and examples: <a href="https://fancyapps.com/fancybox/">www.fancyapps.com/fancybox/</a></p>
    
	<h3>Open manually</h3>
	<p><a id="fancybox-manual-c" href="javascript:;">Open gallery</a></p>

	<p>
		Photo Credit: Instagrammer @whitjohns
	</p>
</body>
</html>