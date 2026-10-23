function writeflash(FlashVars)
{
	var fstr="<object classid='clsid:d27cdb6e-ae6d-11cf-96b8-444553540000' codebase='http://fpdownload.macromedia.com/pub/shockwave/cabs/flash/swflash.cab#version=8,0,0,0' width='510' height='270' id='fileUpload' align='middle'>";
	fstr=fstr+"<param name='allowScriptAccess' value='sameDomain' />";
	fstr=fstr+"<param name='movie' value='fileUpload.swf' />";
	fstr=fstr+"<param name='quality' value='high'/>";
	fstr=fstr+"<param name='wmode' value='transparent'>";
	fstr=fstr+"<PARAM NAME=FlashVars VALUE='uploadPage=uploadftp.asp?a=1"+FlashVars+"'>";
	fstr=fstr+"<embed src='fileUpload.swf' FlashVars='uploadPage=uploadftp.asp?a=1"+FlashVars+"' quality='high' wmode='transparent' width='510' height='270' name='fileUpload' align='middle' allowScriptAccess='sameDomain' type='application/x-shockwave-flash' pluginspage='http://www.macromedia.com/go/getflashplayer' />";
	fstr=fstr+"</object>";
	document.getElementById("flash").innerHTML=fstr;
}
function writefaceflash()
{
	var fstr="<object classid='clsid:d27cdb6e-ae6d-11cf-96b8-444553540000' codebase='http://fpdownload.macromedia.com/pub/shockwave/cabs/flash/swflash.cab#version=8,0,0,0' width='340' height='160' id='makepic' align='middle'>";
	fstr=fstr+"<param name='allowScriptAccess' value='sameDomain' />";
	fstr=fstr+"<param name='movie' value='photo.swf' />";
	fstr=fstr+"<param name='quality' value='high'/>";
	fstr=fstr+"<param name='wmode' value='transparent'>";
	fstr=fstr+"<embed src='photo.swf' quality='high' width='250' height='180' name='makepic' align='middle' swliveconnect='true' allowscriptaccess='always' type='application/x-shockwave-flash' pluginspage='http://www.macromedia.com/go/getflashplayer' />";
	fstr=fstr+"</object>";
	document.getElementById("flash").innerHTML=fstr;
}