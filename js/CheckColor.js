function gID(str){return (document.getElementById(str))?document.getElementById(str):false;}

function refreshimg()
{
	document.all.getcode.src='Images/GetCode.asp';
}

function check_in(o,name,str){
	if(o[name]){
		if(o[name].value==""){
			if(str!=""){
				alert("请填写"+str);
				if(o[name].style.display!="none")o[name].focus();
				return false;
			}
		};
	}else{
		alert("[ "+name+" ]不存在！");return false;
	};
	return true;
}

function checklogin(o){
	if(!check_in(o,"UserName","用户名")){return false;};
	if(!check_in(o,"PassWord","密码")){return false;};
	if(!check_in(o,"CheckCode","验证码")){return false;};
}

function showlink(){
	if (gID("slink").style.display="none"){
			gID("slink").style.display="";
		}
}

function hiddenlink(){
	gID("slink").style.display="none";
}

function CheckAll(form) {  
	for (var i=0;i<form.elements.length;i++)  {  
		var e = form.elements[i];  
		if (e.name != 'chkall')  
		e.checked = true
	}  
}
function CheckCel(form) {
	for (var i=0;i<form.elements.length;i++){
		var e = form.elements[i];
		if (e.name != 'chkall')
                e.checked = false
	}
}
function CheckSel(form) {
	for (var i=0;i<form.elements.length;i++){
		var e = form.elements[i];
		if (e.name != 'chkall')
		e.checked=!e.checked;
	}
}

function getOffsetTop(elm) {
	var mOffsetTop = elm.offsetTop;
	var mOffsetParent = elm.offsetParent;
	while(mOffsetParent){
		mOffsetTop += mOffsetParent.offsetTop;
		mOffsetParent = mOffsetParent.offsetParent;
	}
	return mOffsetTop;
}
function getOffsetLeft(elm) {
	var mOffsetLeft = elm.offsetLeft;
	var mOffsetParent = elm.offsetParent;
	while(mOffsetParent) {
		mOffsetLeft += mOffsetParent.offsetLeft;
		mOffsetParent = mOffsetParent.offsetParent;
	}
	return mOffsetLeft;
}

function GetColor(img_val,input_val)
{
	var PaletteLeft,PaletteTop
	var obj = document.getElementById("colorPalette");
	ColorImg = img_val;
	ColorValue = document.getElementById(input_val);	
	if (obj){
		PaletteLeft = getOffsetLeft(ColorImg)
		PaletteTop = (getOffsetTop(ColorImg) + ColorImg.offsetHeight)
		if (PaletteLeft+250 > parseInt(document.body.clientWidth)) PaletteLeft = parseInt(event.clientX)-260;
		obj.style.left = PaletteLeft + "px";
		obj.style.top = PaletteTop + "px";
		if (obj.style.visibility=="hidden")
		{
			obj.style.visibility="visible";
		}else {
			obj.style.visibility="hidden";
		}
	}
}
function setColor(color)
{
	if(ColorImg.id=="FontColorShow"&&color=="#") color='#000000';
	if(ColorImg.id=="FontBgColorShow"&&color=="#") color='#FFFFFF';
	if (ColorValue){ColorValue.value = '#'+color.substr(1);}
	if (ColorImg && color.length>1){
		ColorImg.src='Images/setcolor.gif';
		ColorImg.style.backgroundColor = color;
	}else if(color=='#'){ ColorImg.src='Images/nocolor.gif';}
	document.getElementById("colorPalette").style.visibility="hidden";
}

//插入上传附件
function addUploadItem(type,path,memberDown){
	var EditType=""
	try{
	  var oEditor = parent.FCKeditorAPI.GetInstance('Content')
	  EditType="FCkEditor"
	  var hrefLen=location.href.lastIndexOf("/")
	  var Fhref=location.href.substr(0,hrefLen+1)
      path=path
	}
	catch(e){
	  EditType="UBBEditor"
	}
	type=type.toLowerCase()
 	 switch(type){
 	  case 'gif':
        if (EditType=="UBBEditor"){parent.document.forms[0].Message.value+='[img]'+path+'[/img]\n'}
        else{oEditor.InsertHtml('<img src="'+path+'" alt=""/>')}
 	  	break;
 	  case 'jpg':
        if (EditType=="UBBEditor"){parent.document.forms[0].Message.value+='[img]'+path+'[/img]\n'}
        else{oEditor.InsertHtml('<img src="'+path+'" alt=""/>')}
 	  	break;
 	  case 'png':
        if (EditType=="UBBEditor"){parent.document.forms[0].Message.value+='[img]'+path+'[/img]\n'}
        else{oEditor.InsertHtml('<img src="'+path+'" alt=""/>')}
 	  	break;
 	  case 'bmp':
        if (EditType=="UBBEditor"){parent.document.forms[0].Message.value+='[img]'+path+'[/img]\n'}
        else{oEditor.InsertHtml('<img src="'+path+'" alt=""/>')}
 	  	break;
 	  case 'jpeg':
        if (EditType=="UBBEditor"){parent.document.forms[0].Message.value+='[img]'+path+'[/img]\n'}
        else{oEditor.InsertHtml('<img src="'+path+'" alt=""/>')}
 	  	break;
 	  case 'mp3':
        if (EditType=="UBBEditor"){parent.document.forms[0].Message.value+='[wma]'+path+'[/wma]\n'}
        else{oEditor.InsertHtml('<object classid="CLSID:22d6f312-b0f6-11d0-94ab-0080c74c7e95"  id="MediaPlayer" width="450" height="70"><param name=""howStatusBar" value="-1"><param name="AutoStart" value="False"><param name="Filename" value="'+path+'"></object>')}
 	  	break;
 	  case 'wma':
        if (EditType=="UBBEditor"){parent.document.forms[0].Message.value+='[wma]'+path+'[/wma]\n'}
        else{oEditor.InsertHtml('<object classid="CLSID:22d6f312-b0f6-11d0-94ab-0080c74c7e95"  id="MediaPlayer" width="450" height="70"><param name=""howStatusBar" value="-1"><param name="AutoStart" value="False"><param name="Filename" value="'+path+'"></object>')}
 	  	break;
 	  case 'rm':
        if (EditType=="UBBEditor"){parent.document.forms[0].Message.value+='[rm]'+path+'[/rm]\n'}
        else{oEditor.InsertHtml('<object classid="clsid:CFCDAA03-8BE4-11cf-B84B-0020AFBBCCFA" width="400" height="300"><param name="SRC" value="'+path+'" /><param name="CONTROLS" VALUE="ImageWindow" /><param name="CONSOLE" value="one" /><param name="AUTOSTART" value="true" /><embed src="'+path+'" nojava="true" controls="ImageWindow" console="one" width="400" height="300"></object><br/><object classid="clsid:CFCDAA03-8BE4-11cf-B84B-0020AFBBCCFA" width="400" height="32" /><param name="CONTROLS" value="StatusBar" /><param name="AUTOSTART" value="true" /><param name="CONSOLE" value="one" /><embed src="'+path+'" nojava="true" controls="StatusBar" console="one" width="400" height="24" /></object><br/><object classid="clsid:CFCDAA03-8BE4-11cf-B84B-0020AFBBCCFA" width="400" height="32" /><param name="CONTROLS" value="ControlPanel" /><param name="AUTOSTART" value="true" /><param name="CONSOLE" value="one" /><embed src="'+path+'" nojava="true" controls="ControlPanel" console="one" width="400" height="24" autostart="true" loop="false" /></object>')}
 	  	break;
 	  case 'rmvb':
        if (EditType=="UBBEditor"){parent.document.forms[0].Message.value+='[rm]'+path+'[/rm]\n'}
        else{oEditor.InsertHtml('<object classid="clsid:CFCDAA03-8BE4-11cf-B84B-0020AFBBCCFA" width="400" height="300"><param name="SRC" value="'+path+'" /><param name="CONTROLS" VALUE="ImageWindow" /><param name="CONSOLE" value="one" /><param name="AUTOSTART" value="true" /><embed src="'+path+'" nojava="true" controls="ImageWindow" console="one" width="400" height="300"></object><br/><object classid="clsid:CFCDAA03-8BE4-11cf-B84B-0020AFBBCCFA" width="400" height="32" /><param name="CONTROLS" value="StatusBar" /><param name="AUTOSTART" value="true" /><param name="CONSOLE" value="one" /><embed src="'+path+'" nojava="true" controls="StatusBar" console="one" width="400" height="24" /></object><br/><object classid="clsid:CFCDAA03-8BE4-11cf-B84B-0020AFBBCCFA" width="400" height="32" /><param name="CONTROLS" value="ControlPanel" /><param name="AUTOSTART" value="true" /><param name="CONSOLE" value="one" /><embed src="'+path+'" nojava="true" controls="ControlPanel" console="one" width="400" height="24" autostart="true" loop="false" /></object>')}
 	  	break;
 	  case 'ra':
        if (EditType=="UBBEditor"){parent.document.forms[0].Message.value+='[ra]'+path+'[/ra]\n'}
        else{oEditor.InsertHtml('<object classid="clsid:CFCDAA03-8BE4-11CF-B84B-0020AFBBCCFA" id="RAOCX" width="450" height="60"><param name="_ExtentX" value="6694"><param name="_ExtentY" value="1588"><param name="AUTOSTART" value="true"><param name="SHUFFLE" value="0"><param name="PREFETCH" value="0"><param name="NOLABELS" value="0"><param name="SRC" value="'+path+'"><param name="CONTROLS" value="StatusBar,ControlPanel"><param name="LOOP" value="0"><param name="NUMLOOP" value="0"><param name="CENTER" value="0"><param name="MAINTAINASPECT" value="0"><param name="BACKGROUNDCOLOR" value="#000000"><embed src="'+path+'" width="450" autostart="true" height="60"></embed></object>')}
 	  	break;
 	  case 'asf':
        if (EditType=="UBBEditor"){parent.document.forms[0].Message.value+='[wmv]'+path+'[/wmv]\n'}
        else{oEditor.InsertHtml('<object classid="clsid:22D6F312-B0F6-11D0-94AB-0080C74C7E95" codebase="http://activex.microsoft.com/activex/controls/mplayer/en/nsmp2inf.cab#Version=6,0,02,902" type="application/x-oleobject" standby="Loading..." width="400" height="300"><param name="FileName" VALUE="'+path+'" /><param name="ShowStatusBar" value="-1" /><param name="AutoStart" value="true" /><embed type="application/x-mplayer2" pluginspage="http://www.microsoft.com/Windows/MediaPlayer/" src="'+path+'" autostart="true" width="400" height="300" /></object>')}
 	  	break;
 	  case 'avi':
        if (EditType=="UBBEditor"){parent.document.forms[0].Message.value+='[wmv]'+path+'[/wmv]\n'}
        else{oEditor.InsertHtml('<object classid="clsid:22D6F312-B0F6-11D0-94AB-0080C74C7E95" codebase="http://activex.microsoft.com/activex/controls/mplayer/en/nsmp2inf.cab#Version=6,0,02,902" type="application/x-oleobject" standby="Loading..." width="400" height="300"><param name="FileName" VALUE="'+path+'" /><param name="ShowStatusBar" value="-1" /><param name="AutoStart" value="true" /><embed type="application/x-mplayer2" pluginspage="http://www.microsoft.com/Windows/MediaPlayer/" src="'+path+'" autostart="true" width="400" height="300" /></object>')}
 	  	break;
 	  case 'wmv':
        if (EditType=="UBBEditor"){parent.document.forms[0].Message.value+='[wmv]'+path+'[/wmv]\n'}
        else{oEditor.InsertHtml('<object classid="clsid:22D6F312-B0F6-11D0-94AB-0080C74C7E95" codebase="http://activex.microsoft.com/activex/controls/mplayer/en/nsmp2inf.cab#Version=6,0,02,902" type="application/x-oleobject" standby="Loading..." width="400" height="300"><param name="FileName" VALUE="'+path+'" /><param name="ShowStatusBar" value="-1" /><param name="AutoStart" value="true" /><embed type="application/x-mplayer2" pluginspage="http://www.microsoft.com/Windows/MediaPlayer/" src="'+path+'" autostart="true" width="400" height="300" /></object>')}
 	  	break;
 	  case 'swf':
        if (EditType=="UBBEditor"){parent.document.forms[0].Message.value+='[swf]'+path+'[/swf]\n'}
        else{oEditor.InsertHtml('<object codebase="http://download.macromedia.com/pub/shockwave/cabs/flash/swflash.cab#version=7,0,0,0" classid="clsid:D27CDB6E-AE6D-11cf-96B8-444553540000" width="400" height="300"><param name="movie" value="'+path+'" /><param name="quality" value="high" /><param name="AllowScriptAccess" value="never" /><embed src="'+path+'" quality="high" pluginspage="http://www.macromedia.com/go/getflashplayer" type="application/x-shockwave-flash" width="400" height="300" /></object>')}
 	  	break;
 	  default :
        if (EditType=="UBBEditor"){
        if (memberDown==1)
	         {parent.document.forms[0].Message.value+='[mDown='+path+']点击下载此文件[/mDown]\n'}
         else
	         {parent.document.forms[0].Message.value+='[down='+path+']点击下载此文件[/down]\n'}
        }
        else{oEditor.InsertHtml('<a href="'+path+'"><img border="0" src="../../images/download.gif" alt="" style="margin:0px 2px -4px 0px"/>点击下载此文件</a>')}
        break;
     }
}

function addOption(pos,strName,strvalue)
{
    var objSelect = parent.addnew.PicSelect;
	if (objSelect){
		var objOption = new Option(strName,strvalue);
		if (pos == -1 & pos > objSelect.options.length) {
		   objSelect.options[objSelect.options.length] = objOption;
		}else{
		   objSelect.add(objOption, pos);
		}
		   objSelect.value=strvalue;
	}
}