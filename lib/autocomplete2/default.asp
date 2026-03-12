<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "https://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="https://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Documento sin título</title>
<script type="text/javascript" src="/js/jquery.min.js"></script>
<script type="text/javascript" src="/lib/autocomplete2/jquery.autocomplete.js"></script>
<link rel="stylesheet" type="text/css" href="/lib/autocomplete2/styles.css"/>

</head>

<body>
<h2 style="clear:both;" id="demo">Demo</h2>
<p>Ajax autosuggest sample (start typing country name):</p>
<form class="form" action="" onsubmit="alert('Submit Form Event'); return false;">
<div id="selection"></div>
<input type="text" name="q" id="query" class="textbox">
<div style="padding:5px;"><label><input type="checkbox" onclick="this.checked ? a1.disable() : a1.enable();"> Disable Autocomplete</label></div>
</form>
<hr />

<p>Local(no ajax) autosuggest sample (start typing month name):</p>

<form class="form" action="" onsubmit="alert('Submit Form Event'); return false;">
        <input type="text" name="q" id="months" class="textbox">
        <div style="padding:5px;">
         Suggest: 
         <label><input type="radio" name="Suggest" value="Month" onclick="InitMonths();" style="vertical-align:middle;" checked="checked"> Month</label> &nbsp;&nbsp;
         <label><input type="radio" name="Suggest" value="Weekday" onclick="InitWeekdays();" style="vertical-align:middle;"> Weekday</label>
        </div>
      </form>

</body>
</html>
 
<script type="text/javascript">
	var a1;
	var a2;

/*
  function InitMonths() {
    a2.setOptions({ lookup: 'January,February,March,April,May,June,July,August,September,October,November,December'.split(',') });
  }

  function InitWeekdays() {
    a2.setOptions({ lookup: 'Sunday,Monday,Tuesday,Wednesday,Thursday,Friday,Saturday'.split(',') });
  }
*/
  jQuery(function() {

    var onAutocompleteSelect = function(value, data) {
      //$('#selection').html('<img src="\/global\/flags\/small\/' + data + '.png" alt="" \/> ' + value);
	  $('#selection').html(value + ' (' + data + ')');
      //alert(data);
    }

    var options = {
      serviceUrl: '/lib/autocomplete2/data.asp',
      width: 300,
      delimiter: /(,|;)\s*/,
      onSelect: onAutocompleteSelect,
      deferRequestBy: 0, //miliseconds
      params: { country: 'Yes' },
      noCache: false //set to true, to disable caching
    };

    a1 = $('#query').autocomplete(options);

    a2 = $('#months').autocomplete({
      width: 300,
      delimiter: /(,|;)\s*/,
      lookup: 'January,February,March,April,May,June,July,August,September,October,November,December'.split(',')
    });
	
  });
</script>
