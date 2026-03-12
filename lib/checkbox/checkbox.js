/* Super Simple Fancy Checkbox Plugin @Dave Macaulay, 2013 https://davemacaulay.com/jquery-simple-checkbox-replacement-jquery-simplecheckbox-js/ */
(function( $ ) {
	$.fn.simpleCheckbox = function(options) {
		var defaults = {
			newElementClass: "tog",
			activeElementClass: "on"
          };
		var options = $.extend(defaults, options);
		this.each(function() {
			//Assign the current checkbox to obj
			var obj = $(this);
			var target_checkbox = obj;
			
			var clases = options.newElementClass;
			//console.log(clases);
			if (obj.data("id")) {
				//console.log(obj.data("id"));
				clases = clases  + ' ' + obj.data("id");
			};
			//console.log(clases);
			
			//Create new element to be styled
			var newObj = $("<div/>", {
			    "id": "#" + obj.attr("id"),
			    "class": clases,	//options.newElementClass,
			    "style": "display: block;"
			}).insertAfter(this);
			//console.log(this );
			//Make sure pre-checked boxes are rendered as checked
			if(obj.is(":checked")) {
				newObj.addClass(options.activeElementClass);
			}
			//obj.hide(); 	>>	pasado a CSS	//Hide original checkbox
			//Labels can be painful, let's fix that
			if($("[for=" + obj.attr("id") + "]").length) {

				var label = $("[for=" + obj.attr("id") + "]");
				label.click(function() {
					newObj.trigger("click"); //Force the label to fire our element
					return false;
				});
			}
			//Attach a click handler
			newObj.click(function() {
				//Assign current clicked object
				var obj = $(this);
				//Check the current state of the checkbox
				if(obj.hasClass(options.activeElementClass)) {
					obj.removeClass(options.activeElementClass);
					$(obj.attr("id")).attr("checked",false);
				} else {
					obj.addClass(options.activeElementClass);
					$(obj.attr("id")).attr("checked",true);
				}
				//Kill the click function
				
				if (target_checkbox.closest("form").attr("action")) {
					
					var frm_url = target_checkbox.closest("form").attr("action");
					var frm_data = "set=" + target_checkbox.attr("name") + "&val=";
						
					if ( target_checkbox.is(":checked") ) {
						target_checkbox.removeProp("checked");
						frm_data = frm_data + target_checkbox.val();
						
					} else {
						target_checkbox.prop("checked","checked");
						
					};
					
					$.ajax({
						type: "get",
						url: frm_url,
						data: frm_data,
						success: function(recibe) {
							var data = JSON.parse(recibe);
							
							//location.reload();
							
							console.log( data.initial_value, data.request, data.value );
						}
					});


					
				};
				
				return false;
				
			});
		});
	};
})(jQuery);

$(document).ready(function(){ 

// replace checkboxes with Toggles
$("input:checkbox").simpleCheckbox();

});// end document.ready