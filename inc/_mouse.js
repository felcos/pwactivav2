if (Modernizr.touchevents) {
	console.log("touchevents.-")
} else {
	function anular()		{return false};
	document.oncontextmenu=anular;
	document.ondragstart=anular;
	document.onselectstart=anular;
	//	//document.onmousedown=anular;
	
	function derecha(e)		{
		if (navigator.appName == 'Netscape' && (e.which == 3 || e.which == 2)) {
			//alert('Property Web S.L.')
			return false;
			}
		else if (navigator.appName == 'Microsoft Internet Explorer' && (event.button == 2)) {
			//alert('Property Web S.L.')
			}
	}
	document.onmousedown=derecha;
}