<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <title>jQuery autoComplete Plugin</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    
    <!-- link rel="stylesheet" href="demo.css" -->
    <link rel="stylesheet" href="jquery.auto-complete.css">
    
	<script src="/js/jquery.min.js"></script>
    <script src="jquery.auto-complete.js"></script>
</head>
<body>
<h1>pixbay Autocomplete</h1>

<p><input id="demo-01" autofocus type="text" name="q" placeholder="Programming languages ..."></p>
<p><input id="demo-02" autofocus type="text" name="q" placeholder="Country or language code ..."></p>
<hr>
<p>Ajax data</p>
<p><input id="demo-03" autofocus type="text" name="q" placeholder="Programming languages ..."></p>

<script>
$(function(){
	$('#demo-01').autoComplete({
		minChars: 1,
		source: function(term, suggest){
			term = term.toLowerCase();
			var choices = ['ActionScript', 'AppleScript', 'Asp', 'Assembly', 'BASIC', 'Batch', 'C', 'C++', 'CSS', 'Clojure', 'COBOL', 'ColdFusion', 'Erlang', 'Fortran', 'Groovy', 'Haskell', 'HTML', 'Java', 'JavaScript', 'Lisp', 'Perl', 'PHP', 'PowerShell', 'Python', 'Ruby', 'Scala', 'Scheme', 'SQL', 'TeX', 'XML'];
			var suggestions = [];
			for (i=0;i<choices.length;i++)
				if (~choices[i].toLowerCase().indexOf(term)) suggestions.push(choices[i]);
			suggest(suggestions);
		}
	});
	$('#demo-02').autoComplete({
		minChars: 0,
		source: function(term, suggest){
			term = term.toLowerCase();
			var choices = [['Australia', 'au'], ['Austria', 'at'], ['Brasil', 'br'], ['Bulgaria', 'bg'], ['Canada', 'ca'], ['China', 'cn'], ['Czech Republic', 'cz'], ['Denmark', 'dk'], ['Finland', 'fi'], ['France', 'fr'], ['Germany', 'de'], ['Hungary', 'hu'], ['India', 'in'], ['Italy', 'it'], ['Japan', 'ja'], ['Netherlands', 'nl'], ['Norway', 'no'], ['Portugal', 'pt'], ['Romania', 'ro'], ['Russia', 'ru'], ['Spain', 'es'], ['Swiss', 'ch'], ['Turkey', 'tr'], ['USA', 'us']];
			var suggestions = [];
			for (i=0;i<choices.length;i++)
				if (~(choices[i][0]+' '+choices[i][1]).toLowerCase().indexOf(term)) suggestions.push(choices[i]);
			suggest(suggestions);
		},
		renderItem: function (item, search){
			var re = new RegExp("(" + search.split(' ').join('|') + ")", "gi");
			return '<div class="autocomplete-suggestion" data-langname="'+item[0]+'" data-lang="'+item[1]+'" data-val="'+search+'"><img src="img/'+item[1]+'.png"> '+item[0].replace(re, "<b>$1</b>")+'</div>';
		},
		onSelect: function(e, term, item){
			console.log('Item "'+item.data('langname')+' ('+item.data('lang')+')" selected by '+(e.type == 'keydown' ? 'pressing enter' : 'mouse click')+'.');
			$('#demo-02').val(item.data('langname')+' ('+item.data('lang')+')');
		}
	});
	
	$('#demo-03').autoComplete({
		minChars: 1,
		source: function(term, suggest){
			$.getJSON('/lib/autocomplete-pixabay/data.asp', { q: term }, function(data){ response(data); });
			
		}
	});
});
</script>
</body>
</html>
