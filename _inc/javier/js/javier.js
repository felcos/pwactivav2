jQuery.fn.extend({  
    fnSelectDrop: function(color) {        	
        this.each(function() { 
		  $this=jQuery(this);
            jQuery(this).css("background-color", color);


			if  ($(window).width()>=767)  {     /* tablet/escritorio */
			
				if($this.find("ul.dropdown-menu li").length<1){ // .find(ul.dropdown-menu li)  //  IMPORTANTE:  crea elemento en ul.dropdown-menu LI de forma automatica (se podría hacer manual y quitar esta parte)
						$this.find("select >option").each(function(){	                   // ("#pais02 > option")
						$this.find("ul.dropdown-menu").append("<li><a href='#'> "+ $(this).text() + "</a></li>");
							 });		
						$this.find(".dropdown-menu li a").on("click",function(e){
								   e.preventDefault(e);
								  $this.find(".dropdown-txt").text($(this).text());    ///#paisDrop .paisNombre
								  $this.find("input[type='hidden']").val($(this).text());  /* envia valor a traves del campo oculto*/ 
							   });
					 }
					$this.find("select").addClass("hide");                   //$("#pais02")// 
					$this.find("ul.dropdown-menu").removeClass("hide");
				} else {                 /* movil */

					$this.find("select").removeClass("hide");             //$("#pais02")
					$this.find(".dropdown-menu").addClass("hide");
			}
		$this.find("select").change(function(){           //$("#pais02")
				var _selectDrop= $(this).parent();
				_selectDrop.find(".dropdown-txt").text($(this).find("option:selected").text());  //#paisDrop .paisNombre
				_selectDrop.find("input[type='hidden']").val($(this).val());  /* envia valor a traves del campo oculto #pais*/
				});			
			
	$this.on("mouseenter",function(){    //selectDrop para hacer el efecto over (movil)
		$(this).addClass("focus");
	});
	$this.on("mouseleave",function(){
		$(this).removeClass("focus");
	});	
			
			           
        });  // :each
    }    // :function
});     // :extend