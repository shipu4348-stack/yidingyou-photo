var temp,xmlHttpO,xmlHttp,xmlHttpM;
temp=0;

function GetXmlHttpObject()
{
	var xmlHttp=null;
	try
	  {
	  // Firefox, Opera 8.0+, Safari
	  xmlHttp=new XMLHttpRequest();
	  }
	catch (e)
	  {
	  // Internet Explorer
	  try
		{
		xmlHttp=new ActiveXObject("Msxml2.XMLHTTP");
		}
	  catch (e)
		{
		xmlHttp=new ActiveXObject("Microsoft.XMLHTTP");
		}
	  }
	return xmlHttp;
}

function updateOption() {
  if (xmlHttpO.readyState < 4) {
   document.getElementById("FolderOption").innerHTML="Loading......";
  }
  if (xmlHttpO.readyState == 4  && xmlHttpO.status==200) {
    var response = unescape(xmlHttpO.responseText);
    if (response.indexOf("超时")==0){    
		alert(response);
		window.location="index.asp";
	}
    document.getElementById("FolderOption").innerHTML=response;
   
  }   
}

function FolderOption(kid){
	xmlHttpO=GetXmlHttpObject();
    var url = "ajaxasp/showfolderoption.asp?kindtype=pic&kid=" + kid +"&rand="+Math.random();
    //window.clipboardData.setData("Text",url);
    xmlHttpO.open("GET", url, true);
    xmlHttpO.onreadystatechange = updateOption;
    xmlHttpO.send(null);  
    return true;
}

function updateOption2() {
  if (xmlHttpI.readyState < 4) {
   document.getElementById("FolderOption").innerHTML="Loading......";
  }
  if (xmlHttpI.readyState == 4 && xmlHttpI.status==200) {
    var response = unescape(xmlHttpI.responseText);
    if (response.indexOf("超时")==0){    
		alert(response);
		window.location="index.asp";
	}
    document.getElementById("FolderOption").innerHTML=response;
  
  }   
}

function FolderOption2(kid){
	xmlHttpI=GetXmlHttpObject();
    var url = "ajaxasp/showfolderoption.asp?kindtype=upload&kid=" + kid +"&rand="+Math.random();
    //window.clipboardData.setData("Text",url);
    xmlHttpI.open("GET", url, true);
    xmlHttpI.onreadystatechange = updateOption2;
    xmlHttpI.send(null);  
    return true;
}

function updateShowLogo() {
  if (xmlHttp.readyState == 4 && xmlHttp.status==200) {
    var response = unescape(xmlHttp.responseText);
    if (response.indexOf("超时")>=0){    
		alert("超时");
		window.location="index.asp";
	}else if(response.indexOf("错误")>=0){
		document.getElementById('mark').style.display='none';
		alert('请设置水印图片及参数!');
		window.location.href='setMark.asp';
	}else{
    	document.getElementById("showlogo").innerHTML=response;
     }
  }   
}

function ShowLogo(){
	xmlHttp=GetXmlHttpObject();
    var url = "ajaxasp/showlogo.asp?rand="+Math.random();
    //window.clipboardData.setData("Text",url);
    xmlHttp.open("GET", url, true);
    xmlHttp.onreadystatechange = updateShowLogo;
    xmlHttp.send(null);
    return true;
}

function updateShowMark(){
  if (xmlHttpM.readyState == 4 && xmlHttpM.status==200) {
    var response = unescape(xmlHttpM.responseText);
	//alert(response);
    if (response.indexOf("超时")>=0){    
		alert("超时");
		window.location="index.asp";
	}else if(response.indexOf("错误")>=0){
		alert('请设置文字水印内容!');
		window.location.href='setMark.asp';
	}
  }   
}


function ShowMark(){
	xmlHttpM=GetXmlHttpObject();
    var url = "ajaxasp/showMark.asp?rand="+Math.random();
    //window.clipboardData.setData("Text",url);
    xmlHttpM.open("GET", url, true);
    xmlHttpM.onreadystatechange = updateShowMark;
    xmlHttpM.send(null);
    return true;
}

function ResizeImage(image,width,height)
{
var w = image.width;
var h = image.height;
if(w>width && w>h){
 image.width=width;
 image.height = parseInt(h*(width/w));
 }
if(h>height && h>w){
 image.width = parseInt(w*(height/h));
 image.height = height;
 }
}
