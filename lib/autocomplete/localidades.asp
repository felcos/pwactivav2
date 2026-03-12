

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01//EN" "https://www.w3.org/TR/html4/strict.dtd">
<html>
<head>

<title>jQuery Autocomplete Plugin</title>
<script type="text/javascript" src="/lib/autocomplete/lib/jquery.js"></script>
<script type='text/javascript' src='/lib/autocomplete/lib/jquery.bgiframe.min.js'></script>
<script type='text/javascript' src='/lib/autocomplete/lib/jquery.ajaxQueue.js'></script>
<script type='text/javascript' src='/lib/autocomplete/lib/thickbox-compressed.js'></script>
<script type='text/javascript' src='/lib/autocomplete/jquery.autocomplete.js'></script>
<script type='text/javascript' src='/lib/autocomplete/demo/localdata.js'></script>
<link rel="stylesheet" type="text/css" href="/lib/autocomplete/demo/main.css" />
<link rel="stylesheet" type="text/css" href="/lib/autocomplete/autocomplete_foldy.css" />
<link rel="stylesheet" type="text/css" href="/lib/autocomplete/lib/thickbox.css" />
	
<script type="text/javascript">
$().ready(function() {

	function log(event, data, formatted) {
		$("<li>").html( !data ? "No match!" : "Selected: " + formatted).appendTo("#result");
	}
	
	function formatItem(row) {
		return row[0] + " (<strong>id: " + row[1] + "</strong>)";
	}
	function formatResult(row) {
		return row[0].replace(/(<.+?>)/gi, '');
	}
	
	$("#singleBirdRemote").autocomplete("/jp/autocomplete/demo/search_localidades.asp", {
		width: 260,
		selectFirst: false
	});
	$("#suggest14").autocomplete(cities, {
		matchContains: true,
		minChars: 0
	});
	
	$("#imageSearch").autocomplete("images.php", {
		width: 320,
		max: 4,
		highlight: false,
		scroll: true,
		scrollHeight: 300,
		formatItem: function(data, i, n, value) {
			return "<img src='images/" + value + "'/> " + value.split(".")[0];
		},
		formatResult: function(data, value) {
			return value.split(".")[0];
		}
	});
	
	$(":text, textarea").result(log).next().click(function() {
		$(this).prev().search();
	});
	
	$("#singleBirdRemote").result(function(event, data, formatted) {
		if (data)
			$(this).parent().next().find("input").val(data[1]);
	});
	
	$("#suggest4").result(function(event, data, formatted) {
		var hidden = $(this).parent().next().find(">:input");
		hidden.val( (hidden.val() ? hidden.val() + ";" : hidden.val()) + data[1]);
	});
	
    $("#suggest15").autocomplete(cities, { scroll: true } );	
	
});

</script>
	
</head>

<body>

<h1>Localidades</h1>

<div id="content">
	
	<form autocomplete="off">
		<p>
			<label>Single Bird (remote):</label>
			<input type="text" id="singleBirdRemote" />
			<input type="button" value="Get Value" />
		</p>
		<p>

		</p>
		<p>
			<label>Single City (contains):</label>
			<input type="text" id="suggest14" />
			<input type="button" value="Get Value" />
		</p>		
		<input type="submit" value="Submit" />
	</form>
	
	<p>
		<a href="#TB_inline?height=155&width=400&inlineId=modalWindow" class="thickbox">Click here for an autocomplete inside a thickbox window.</a> (this should work even if it is beyond the fold)
	</p>		
	
	<div id="modalWindow" style="display: none;">
                <p>
                        <label>E-Mail (local):</label>
                        <input type="text" id="thickboxEmail" />
                        <input type="button" value="Get Value" />
                </p>
		</div>
			
<h3>Result:</h3>
<ol id="result"></ol>

</div>

</body>
</html>
