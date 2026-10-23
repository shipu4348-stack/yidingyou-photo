var xmlHttpP,xmlHttpF,xmlHttpD,xmlHttpM,xmlHttpPI,xmlHttpO,Pid,xmlHttpPL,xmlHttpPN;
var _SelectedID,SelectedID,arrImg,arrPid,temp,_Pid,kname,_Kname,ImgArray,PicurlList,PicItems,items;
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
//--------------------------------------------------
//显示相册名称
function updatePhotoName()
{
	if (xmlHttpPN.readyState < 4) {
   		document.getElementById("PhotoName").innerHTML="<img src=images/loader.gif> Loading........";
  	}
	if (xmlHttpPN.readyState == 4) {
    var response = unescape(xmlHttpPN.responseText);
	//alert(response);
     if (response.indexOf("不")>=0)
    {    
		alert(response);
		window.location="index.asp";
	}
	else if(response.indexOf("返回")>=0)
	{
		window.location.href='photo.asp?kname='+_kname;
	}
	else
	{
    	document.getElementById("PhotoName").innerHTML=response;
	}
  } 
}

function ShowPhotoName(kname,kid,pid)
{
	_kname=kname;
	 
	xmlHttpPN=GetXmlHttpObject()
	var url = "ajaxasp/ShowPhotoName.asp?kname="+kname+"&kid="+kid+"&pid="+pid+"&rand="+Math.random();
   // window.clipboardData.setData("Text",url);
    xmlHttpPN.open("GET", url, true);
    xmlHttpPN.onreadystatechange = updatePhotoName;
    xmlHttpPN.send(null);  
    return true;
}
//------------------------------------------------------------------------------
//读取描述信息
function updateShowPicInfo()
{
  if (xmlHttpD.readyState < 4) 
  {
   document.getElementById("viewInfo").innerHTML="<img src=images/loader.gif> Loading......";
  }
  if (xmlHttpD.readyState == 4) 
  {
    var response = unescape(xmlHttpD.responseText); 
    document.getElementById("viewInfo").innerHTML=response;
  }   
}

function ShowPicInfo(kname,Pid)
{ 
 
	xmlHttpD=GetXmlHttpObject()
    var url = "ajaxasp/showPicinfo.asp?kname="+kname+"&Pid=" + Pid + "&rand="+Math.random();
    //window.clipboardData.setData("Text",url);
    xmlHttpD.open("GET", url, true);
    xmlHttpD.onreadystatechange = updateShowPicInfo;
    xmlHttpD.send(null);  
    return true;
}
//--------------------------------------------------------------------------------------
//------------------------------------------------------------------------------
//读取属性信息
function updatePicProOther()
{
  if (xmlHttpF.readyState < 4) 
  {
   document.getElementById("PhotoOther").innerHTML="<img src=images/loader.gif> Loading......";
  }
  if (xmlHttpF.readyState == 4) 
  {
    var response = unescape(xmlHttpF.responseText);   
    document.getElementById("PhotoOther").innerHTML=response;
  }   
}

function PicProOther(kname,Pid)
{ 
 
	xmlHttpF=GetXmlHttpObject();
    var url = "ajaxasp/picproOther.asp?kname="+kname+"&Pid=" + Pid + "&rand="+Math.random();
    //window.clipboardData.setData("Text",url);
    xmlHttpF.open("GET", url, true);
    xmlHttpF.onreadystatechange = updatePicProOther;
    xmlHttpF.send(null);  
    return true;
}
//--------------------------------------------------------------------------------------
//读取图片列表
function updatePicListOther() 
{
  if (xmlHttpP.readyState < 4){
   document.getElementById("List1_1").innerHTML="<img src=images/loader.gif> Loading......";
  }
  if (xmlHttpP.readyState == 4){
    var response = unescape(xmlHttpP.responseText);
	if (response!=""){	
		var List=response.split("|");
		var ImgList="";
		for(var i=0;i<List.length;i++)
		{
			ImgList+=mycarousel_getItemHTML(List[i]);
		}		
		document.getElementById("List1_1").innerHTML="<ul>"+ImgList+"</ul>";
	}
  }   
}

function mycarousel_getItemHTML(item)
{
    return item;
};



function PicListOther(kname,kid)
{
 
	xmlHttpP=GetXmlHttpObject();
    var url = "ajaxasp/piclistother.asp?kname="+kname+"&kid=" + kid ;
    //window.clipboardData.setData("Text",url);
    xmlHttpP.open("GET", url, true);
    xmlHttpP.onreadystatechange = updatePicListOther;
    xmlHttpP.send(null);  
    return true;
}
//-------------------------------------------------------
//读取图片数组列表以及索引ID
function updatePicArrayList() 
{
  if (xmlHttpPI.readyState == 4) 
  {
    var response = unescape(xmlHttpPI.responseText);
	//alert(response);
	  var PicArrayListStr=response.split("|");  
	  arrImg=PicArrayListStr[1];
	  _arrImg=arrImg.split(",");
	  imgs=new Array();
	  for(var i=0;i<_arrImg.length;i++)
	  {
		  imgs.push(_arrImg[i]);
	   }
	   arrPid=PicArrayListStr[2];
	   _arrPid=arrPid.split(",");
	   arrPid=new Array();
	   for(var i=0;i<_arrPid.length;i++)
	   {
			arrPid.push(_arrPid[i]);   
		}
	  SelectedID=PicArrayListStr[0];
  }   
}

function PicArrayList(kname,kid,pid)
{
	
 
	xmlHttpPI=GetXmlHttpObject();
    var url = "ajaxasp/PicArrayListOther.asp?kname="+kname+"&kid="+ kid +"&Pid="+pid;
	//window.clipboardData.setData("Text",url);
    xmlHttpPI.open("GET", url, false);
    xmlHttpPI.onreadystatechange = updatePicArrayList;
    xmlHttpPI.send(null);  
    return true;
}
//--------------------------------------------------------------------------------------
//修改相册描述
function updateModifyPicDesc() 
{
  if (xmlHttpM.readyState < 4) 
  {
   //document.getElementById("viewInfo").innerHTML="<img src=images/loader.gif> Loading......";
  }
  if (xmlHttpM.readyState == 4)
  {
    var response = unescape(xmlHttpM.responseText);
	//alert(response);
    if (response.indexOf("超时")==0)
    {    
		alert("超时");
		var hrefs;
		hrefs=window.location.href;
		window.location.href=hrefs;
	}
    else if(response.indexOf("成功")>=0)
	{
		ShowPicInfo(_Kname,_Pid);
	}
	else
	{
		ShowPicInfo(_Kname,_Pid);
	}
  }   
}

function ModifyPicDesc(kname,Pid,Pdesc)
{
 
	xmlHttpM=GetXmlHttpObject();
	_Pid=Pid;
	_Kname=kname;
    var url = "ajaxasp/ModifyPicPdesc.asp?Pid=" + Pid + "&Pdesc="+ Pdesc+"&rand="+Math.random();
    //window.clipboardData.setData("Text",url);
    xmlHttpM.open("GET", url, true);
    xmlHttpM.onreadystatechange = updateModifyPicDesc;
    xmlHttpM.send(null);
    return true;
}
//-------------------------------------------------------
function ComfireInfo()
{
	var Pid=document.getElementById("pid");
	var Kuser=document.getElementById("kuser");
	var Pdesc=document.getElementById("infoname");
	if(Pdesc.value=="")
	{
		alert('图片描述不能为空!');
		return;
	}
	else
	{
		ModifyPicDesc(Kuser.value,Pid.value,Pdesc.value);
	}
}

function CancleInfo()
{
	var obj1=document.getElementById("photoinfo2");
	var obj2=document.getElementById("phototext");
	if(obj1.style.display=="" && obj2.style.display=="none")
	{
		obj1.style.display="none";
		obj2.style.display="";
	}
	else
	{
		obj1.style.display="";
		obj2.style.display="none";		
	}
}

function copylink(url)
{
	window.clipboardData.setData("Text",url);
	alert("网络地址已拷贝到剪贴板，可以使用粘贴或Ctrl+V调用。\n\n"+url);
}