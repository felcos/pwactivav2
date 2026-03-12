<div id="infobar">
    <div id="infobar-content"><!--#include virtual="/quotas.asp" --></div>
	<a href="javascript:void(0);" class="close-infobar"></a>
</div>
<style>
#infobar {
    position: absolute;
    top: 0;
    left: 0;
    z-index: 3000;
    /*
	background: #444444;
    color:#999999;
	*/
	background: #FFF;
	
    border-top: 5px solid #333333;
    width: 100%;
    padding: 20px 0 35px 0;
    display: none;
    border-bottom:5px solid #444444;
}

/*
#infobar .widget h3 {
	border-bottom: 1px solid #555555;
	color: #ffffff;
	padding: 0 0 5px 0;
	margin: 0 0 20px 0;
}

#infobar a{
	color:#999999;
}

#infobar a:hover{
	color:#ffffff;
}
*/
      
.close-infobar {
    position: absolute;
    bottom: -40px;
    right: 0;
    width: 0px;
    height: 0px;
    border-style: solid;
    border-width: 0 40px 40px 0;
    border-color: transparent #444444 transparent transparent;
    z-index: 999;
}

.close-infobar:after {
    content: '';
    width: 40px;
    height: 40px;
    display: block;
    position: absolute;
    top: 0;
    right: -40px;
    background: url(/img/toggle.png) no-repeat 0px 0px;
}

#infobar .close-infobar.open { }

.close-infobar.open:after {
    content: '';
    width: 40px;
    height: 40px;
    display: block;
    position: absolute;
    top: 0;
    right: -40px;
    background: url(/img/toggle.png) no-repeat -40px 0px;
}

/*
#infobar .no-widgets {
    color: #aaaaaa;
    margin-bottom:-15px;
    text-align: center;
}
*/

</style>
<script type="text/javascript" src="/lib/easing/jquery.easing.1.3.js"></script>
<script>
$(document).ready(function() {
    var infostate = 'close';
	var infobarheight = $('#infobar').height() + 62;
	
	$('.close-infobar').click(function() {
		if(infostate == 'close'){
			$('#infobar').show().animate({ top : 0 }, 220, 'easeOutQuad');
			$(this).addClass('open');
			infostate = 'open';
		}
		else if(infostate == 'open'){
			$('#infobar').show().animate({ top : -infobarheight }, 220, 'easeOutQuad');
			$(this).removeClass('open');
			infostate = 'close';
		}
		return false;
	});
	
	$('#infobar').css({'top' : -infobarheight}).fadeIn('fast');
	
	$(window).resize(function() {
		infobarheight = $('#infobar').height() + 62;
		$('#infobar').css({'top' : -infobarheight}).show();
		$('.close-infobar').removeClass('open');
		infostate = 'close';
  	});
	
});
</script>