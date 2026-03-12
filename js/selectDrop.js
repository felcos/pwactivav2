jQuery.fn.extend({
 	
	fnSelectDrop: function(color) {
		this.each(function() {
			$this=jQuery(this);
			
			jQuery(this).css("background-color", color);
			
			if ($this.find("ul.dropdown-menu li").length<1) {
				//console.log("construir ul.dropdown-menu");
				var opts = $this.find("select > option");
				opts.each(function(ii, opt) {
					var li = "<li data-value='" + $(this).val() + "'";
					
					if ($(this).data("min")) { li = li + " data-min='" + $(this).data("min") + "'" }
					if ($(this).data("max")) { li = li + " data-max='" + $(this).data("max") + "'" }
					
					if ($(this).prop("selected")) {li = li + "class='active'"}
					
					li = li + "><a href='#'> "+ $(this).text() + "</a></li>";
					
					$this.find("ul.dropdown-menu").append(li);
				});
				
			}
			
			var opt = $this.find("option:selected");
			var texto = opt.text();
			$this.find(".dropdown-txt").text(texto);
			//console.log(opt.val());
			
			
			if ($(window).width()>=767) {
				// tablet/escritorio
				$this.find("select").addClass("hide");
				$this.find("ul.dropdown-menu").removeClass("hide");
			} else {
				// movil
				$this.find("select").removeClass("hide");
				$this.find(".dropdown-menu").addClass("hide");
			}
			
			
			$this.find(".dropdown-menu li").on("click",function(e) {
				var _selectDrop = $(this).closest(".selectDrop");
				e.preventDefault(e);
				
				var ejemplo = _selectDrop.data("example");
				var valor = $(this).data("value");
				var texto = $(this).text();
				//console.log("li", valor);
				
				$(this).closest(".dropdown-menu").children("li").removeClass("active");
				$(this).addClass("active");
				
				var opts = _selectDrop.find("select > option");
				opts.each(function(ii, elto) {
					if ($(elto).val()==valor) {
						$(elto).prop("selected", true);
					} else {
						$(elto).prop("selected", false);
					}
                });
				
				_selectDrop.find(".dropdown-txt").text(texto);
				_selectDrop.find("select").change();
				
			});
			
			
			$this.find("select").change(function() {
				var _selectDrop = $(this).parent();
				var activa = $(this).find("option:selected");
				
				var ejemplo = _selectDrop.data("example");
				var valor = activa.val();
				var texto = activa.text();
				//console.log("select", valor);
				
				var lis = _selectDrop.find(".dropdown-menu li")
				lis.each(function(ii, li) {
					if ($(li).data("value")==valor) {
						$(li).addClass("active")
					} else {
						$(li).removeClass("active")
					}
                });
				_selectDrop.find(".dropdown-txt").text(texto);
				
			});
			
			
			$this.on("mouseenter",function(){
				$(this).addClass("focus");
			});
			$this.on("mouseleave",function(){
				$(this).removeClass("focus");
			});	
			
		});	// :each
		
	}		// :function	
});			// :extend



$(document).ready(function(){
	
	

})

$(window).on("resize", function(){ 
	//console.log("resize");
	$(".selectDrop").fnSelectDrop("yellow");
});