<!DOCTYPE html>
<html xmlns="https://www.w3.org/1999/xhtml">
<head>
    <title>DevBridge Autocomplete Demo</title>
    <link href="/lib/autocomplete-devbridge/autocomplete.css" rel="stylesheet" />
    <script type="text/javascript" src="/js/jquery.min.js"></script>
    <script type="text/javascript" src="/lib/autocomplete-devbridge/scripts/jquery.mockjax.js"></script>
    <script type="text/javascript" src="/lib/autocomplete-devbridge/jquery.autocomplete.js"></script>
    
</head>
<body>
    <div class="container">
        <h1>Ajax Autocomplete Demo</h1>

        <h2>Ajax Lookup</h2>
        <p>Type country name in english:</p>
        <div>
            <input type="text" name="country" id="autocomplete-ajax" style="z-index: 2; background: transparent;"/>
            <input type="text" name="country" id="autocomplete-ajax-x" disabled="disabled" style="color: #CCC; background: transparent; z-index: 1;"/>
        </div>
        <div id="selction-ajax"></div>
        
        
    </div>
    
    <hr style="clear:both;">
    
    <div style="width: 50%; clear: both;">
        <h2>Dynamic Width</h2>
        <p>Type country name in english:</p>
        <div>
            <input type="text" name="country" id="autocomplete-dynamic" style="width: 100%;"/>
        </div>
    </div>
 
<script type="text/javascript" src="scripts/countries.js"></script>
<script type="text/javascript">
$(function () {
    'use strict';

    var countriesArray = $.map(countries, function (value, key) { return { value: value, data: key }; });
	
    // Setup jQuery ajax mock:
    $.mockjax({
        url: '*',
        responseTime: 100,
        response: function (settings) {
            var query = settings.data.query,
                queryLowerCase = query.toLowerCase(),
                re = new RegExp('\\b' + $.Autocomplete.utils.escapeRegExChars(queryLowerCase), 'gi'),
                suggestions = $.grep(countriesArray, function (country) {
                     // return country.value.toLowerCase().indexOf(queryLowerCase) === 0;
                    return re.test(country.value);
                }),
                response = {
                    query: query,
                    suggestions: suggestions
                };

            this.responseText = JSON.stringify(response);
        }
    });
	
	
    // Initialize ajax autocomplete:
    $('#autocomplete-ajax').autocomplete({
        serviceUrl: '/lib/autocomplete-devbridge/data.asp',
        // lookup: countriesArray,
        lookupFilter: function(suggestion, originalQuery, queryLowerCase) {
            var re = new RegExp('\\b' + $.Autocomplete.utils.escapeRegExChars(queryLowerCase), 'gi');
            return re.test(suggestion.value);
        },
        onSelect: function(suggestion) {
            $('#selction-ajax').html('You selected: ' + suggestion.value + ', ' + suggestion.data);
        },
        onHint: function (hint) {
            $('#autocomplete-ajax-x').val(hint);
        },
        onInvalidateSelection: function() {
            $('#selction-ajax').html('You selected: none');
        }
    });
	
    // Initialize autocomplete with custom appendTo:
    $('#autocomplete-dynamic').autocomplete({
        lookup: countriesArray
    });
});
</script>
</body>
</html>
