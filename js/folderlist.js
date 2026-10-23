var xmlHttp,xmlHttpS,temp,xmlHttpC,xmlHttpCF,xmlHttpM,xmlHttpPI,xmlHttpD,xmlHttpPWD,Pkid,upid,Pupid,Kname,manager,currentpage,Pcurrentpage;
currentpage=1;
temp=0;

function isLegal(str){
var IsLegal=false;
if(str >= '0' && str <= '9')IsLegal=true;
if(str >= 'a' && str <= 'z')IsLegal=true;
if(str >= 'A' && str <= 'Z')IsLegal=true;
if(str == '_')IsLegal=true;
var reg = /^[\u4e00-\u9fa5]+$/i;
if (reg.test(str))IsLegal=true;
return IsLegal;
}

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
//浏览目录
function ShowFolder(upid,currentpage){
	xmlHttp=GetXmlHttpObject();
    currentpage=currentpage;
    var url = "ajaxasp/showfolder.asp?upid="+upid+"&currentpage="+currentpage+"&rand="+Math.random();
    //window.clipboardData.setData("Text",url);
    xmlHttp.open("GET", url, true);
    xmlHttp.onreadystatechange = updatePage;
    xmlHttp.send(null);  
    return true;
}

function updatePage() {
  if (xmlHttp.readyState < 4) {
   document.getElementById("folderlist").innerHTML="<img src=images/loader.gif> Loading........";
  }
  if (xmlHttp.readyState == 4 && xmlHttp.status==200) {
    var response = unescape(xmlHttp.responseText);
	//alert(response);
     if (response.indexOf("超时")==0)
    {    
		alert("超时");
		window.location="index.asp";
	}
    document.getElementById("folderlist").innerHTML=response;
  
  } 
}

function updateDelFolder(){
  if (xmlHttpD.readyState < 4){
   document.getElementById("folderlist").innerHTML="<img src=images/loader.gif> Loading........";
  }
  if (xmlHttpD.readyState == 4  && xmlHttpD.status==200)  {
    var response = unescape(xmlHttpD.responseText);
	//alert(response);
     if (response.indexOf("超时")>=0){    
		alert("超时");
		window.location="index.asp";
	  }else if(response.indexOf("成功")>=0){
		top.document.getElementById("usesize").innerHTML=response.substr(2,100)
		top.document.getElementById("fugai_layout").style.display="none";
		top.document.getElementById("delinfo").style.display="none";
		window.open("folderlist.asp","_self","");
	}
  }
}
//删除文件夹
function DeleteFolder(kid){
	Pkid=kid;
	
    if(top.document.body.scrollHeight>top.document.body.clientHeight){
    	top.document.getElementById("fugai_layout").style.height=top.document.body.scrollHeight;
    }
    else{
    	top.document.getElementById("fugai_layout").style.height=top.document.body.clientHeight;
    }
    top.document.getElementById("fugai_layout").style.width=top.document.body.scrollWidth;
    top.document.getElementById("fugai_layout").style.display="block";

    if(confirm('此操作将删除该目录下所有文件夹及文件并不能恢复！\n\n 确认删除吗？'))
	{    
		var objProgress = top.document.getElementById("delinfo");
		objProgress.style.top = top.document.body.scrollTop+(top.document.body.clientHeight-top.document.getElementById("delinfo").offsetHeight)/2-100;
		objProgress.style.left = top.document.body.scrollLeft+(top.document.body.clientWidth-top.document.getElementById("delinfo").offsetWidth)/2-150;
		objProgress.style.display="block";
		xmlHttpD=GetXmlHttpObject();
		var url = "ajaxasp/deletefolder.asp?kid="+kid+"&rand="+Math.random();
		//window.clipboardData.setData("Text",url);
		xmlHttpD.open("GET", url, true);
		xmlHttpD.onreadystatechange = updateDelFolder;
		xmlHttpD.send(null); 
    } 
    else
    {
    	top.document.getElementById("fugai_layout").style.display="none";
    }
    return true;
    
}
//设为一级目录
var _kid
function changefirstfolder(kid){
		if(top.document.body.scrollHeight>top.document.body.clientHeight){
			top.document.getElementById("fugai_layout").style.height=top.document.body.scrollHeight;
		}
		else{
			top.document.getElementById("fugai_layout").style.height=top.document.body.clientHeight;
		}
		top.document.getElementById("fugai_layout").style.width=top.document.body.scrollWidth;
		top.document.getElementById("fugai_layout").style.display="block";
	
		if(confirm('此操作将该目录设为一级目录！\n\n 确认操作吗？'))
		{ 
			xmlHttpCR=GetXmlHttpObject();
			_kid=kid;
			var url = "ajaxasp/changefirstfolder.asp?kid="+_kid+"&rand="+Math.random();
			//window.clipboardData.setData("Text",url);
			xmlHttpCR.open("GET", url, true);
			xmlHttpCR.onreadystatechange = updatePagechangefirst;
			xmlHttpCR.send(null);  
			return true;
		}
		else{
			top.document.getElementById("fugai_layout").style.display="none";
			}
	}
function updatePagechangefirst(){
		if(xmlHttpCR.readyState==4 && xmlHttpCR.status==200)
		{
			var response=unescape(xmlHttpCR.responseText);
			if (response.indexOf("超时")==0){			
				alert("超时");
				window.location="index.asp";
			}else if(response.indexOf("成功")==0){
				HiddenDiv(_kid)
				}else if(response.indexOf("错误")==0){
					alert("错误的参数!");					
				}
			top.document.getElementById("fugai_layout").style.display="none";
 		
		}
	}
function HiddenDiv(id)
{
	var obj=document.getElementById("forder_"+id);
	obj.style.display="none";
}
//显示快速文件夹浏览
function showExpressfolder(id,upid){
	if(document.getElementById(id).style.display=="block"){
		document.getElementById(id).style.display="none"
	}else{
		document.getElementById(id).style.display="block";
		ShowFolder2(upid);
	}
}

function ShowFolder2(upid){
	xmlHttp=GetXmlHttpObject();
    currentpage=currentpage;
    var url = "ajaxasp/showExpressfolder.asp";
    //window.clipboardData.setData("Text",url);
    xmlHttp.open("GET", url, true);
    xmlHttp.onreadystatechange = updatePage2;
    xmlHttp.send(null);  
    return true;
}

function updatePage2() {
  if (xmlHttp.readyState < 4) {
   document.getElementById("folderlist").innerHTML="<img src=images/loader.gif> Loading........";
  }
  if (xmlHttp.readyState == 4 && xmlHttp.status==200) {
    var response = unescape(xmlHttp.responseText);
	//alert(response);
    if (response.indexOf("超时")==0){    
		alert("超时");
		window.location="index.asp";
	}
    document.getElementById("folderlist").innerHTML=response;
 
  } 
}
//
function showsubfolder(id){
if(document.getElementById(id).style.display=="block")
{
document.getElementById(id).style.display="none"
}
else
{
document.getElementById(id).style.display="block";
}
}
//
//读了目录深度
function updateCurrentFolder() {
  if (xmlHttpC.readyState < 4) {
   document.getElementById("CurrentFolder").innerHTML="<img src=images/loader.gif> Loading......";
  }
  if (xmlHttpC.readyState == 4 && xmlHttpC.status==200) {
    var response = unescape(xmlHttpC.responseText);
     //alert(response);
     if (response.indexOf("超时")>0){    
		alert("超时");
		window.location="index.asp";
	}
    document.getElementById("CurrentFolder").innerHTML=response;
    
  }   
}
//
function CurrentFolder(kid,klevel){
	xmlHttpC=GetXmlHttpObject();
    var url = "ajaxasp/currentfolder.asp?kid="+kid+"&klevel="+klevel+"&rand="+Math.random();
	//window.clipboardData.setData("Text",url);
    xmlHttpC.open("GET", url, true);
    xmlHttpC.onreadystatechange = updateCurrentFolder;
    xmlHttpC.send(null);  
    return true;
}
//
//建立新目录
function createmyfolder(kname,upid,klevel,kpath){
	xmlHttpCF=GetXmlHttpObject();
    Pupid=upid;	
    var url = "ajaxasp/creatfolder.asp?kname=" +escape(kname) +"&kpath="+escape(kpath)+"&upid="+upid+"&klevel="+klevel+"&rand="+Math.random();
    //window.clipboardData.setData("Text",url);
    xmlHttpCF.open("GET", url, true);
    xmlHttpCF.onreadystatechange = updateCreateFolder;
    xmlHttpCF.send(null); 
    return true;
}

function updateCreateFolder() {
  if (xmlHttpCF.readyState < 4) {
   document.createfolder.create.value="正在创建";
   document.createfolder.create.disabled=true;
  }
  if (xmlHttpCF.readyState == 4 && xmlHttpCF.status==200) {
    var response = unescape(xmlHttpCF.responseText);
    //alert(response);
    if (response.indexOf("超时")>=0){    
		alert("超时");
		window.location="index.asp";
	}
    else if (response.indexOf("同名")>=0){
		document.createfolder.create.value="创建";
		document.createfolder.create.disabled=false;
		alert("呀哈~不行~有同名目录存在！~~");
    }
    else if(response.indexOf("成功")>=0){
		document.createfolder.create.value="创建";
		document.createfolder.create.disabled=false;
		ShowFolder(Pupid,1);
		PageInfo(Pupid,1);
		alert("哈~目录建立成功！~~");
 
    }
	else{		
		document.createfolder.create.value="创建";
		document.createfolder.create.disabled=false;
		ShowFolder(Pupid,1);
		PageInfo(Pupid,1);
		alert('目录创建失败');
	}
  }   
}
//设定为相册
function setPhoto(kid,upid,currentpage)
{
//	if(top.document.body.scrollHeight>top.document.body.clientHeight){
//	top.document.getElementById("fugai_layout").style.height=top.document.body.scrollHeight;
//	}else{
//	top.document.getElementById("fugai_layout").style.height=top.document.body.clientHeight;
//	}
//	top.document.getElementById("fugai_layout").style.width=top.document.body.scrollWidth;
//	top.document.getElementById("fugai_layout").style.display="block";	
//	var objProgress = top.document.getElementById("setphoto");
//	objProgress.style.top = top.document.body.scrollTop+(top.document.body.clientHeight-top.document.getElementById("setphoto").offsetHeight)/2-100;
//	objProgress.style.left = top.document.body.scrollLeft+(top.document.body.clientWidth-top.document.getElementById("setphoto").offsetWidth)/2-150;
//	objProgress.style.display="block";	
	
	xmlHttpS=GetXmlHttpObject();
	Pkid=kid;
	Pupid=upid;
	Pcurrentpage=currentpage
	var url="ajaxasp/setPhoto.asp?kid="+Pkid+"&rand="+Math.random();
	//window.clipboardData.setData("Text",url);
	xmlHttpS.open("GET", url, true);	
    xmlHttpS.onreadystatechange = updateSetPhoto; 
    xmlHttpS.send(null);
    return true;
}
//
function updateSetPhoto()
{
  if (xmlHttpS.readyState == 4 && xmlHttpS.status==200) {
    var response = unescape(xmlHttpS.responseText);
	//alert(response);
     if (response.indexOf("超时")>=0)
    {    
    	alert("超时");
    	window.location="index.asp";
	}
    else if(response.indexOf("设置成功")>=0)
    {	
		ShowFolder(Pupid,Pcurrentpage);
		PageInfo(Pupid,Pcurrentpage);
//		top.document.getElementById("usesize").innerHTML=response.substr(4,100);
//		top.document.getElementById("fugai_layout").style.display="none";
//		top.document.getElementById("setphoto").style.display="none";
		alert("设置成功！~~");		
    }
	else if(response.indexOf("取消成功")>=0)
    {	
		ShowFolder(Pupid,Pcurrentpage);
		PageInfo(Pupid,Pcurrentpage);
//		top.document.getElementById("usesize").innerHTML=response.substr(4,100);
//		top.document.getElementById("fugai_layout").style.display="none";
//		top.document.getElementById("setphoto").style.display="none";
		alert("取消设置！~~");
    }
  }
}


function DisplayProgressBar(xmlPath){
		var xmlDoc = new ActiveXObject("Msxml2.DOMDocument.3.0");
		xmlDoc.async = false;
		xmlDoc.load(xmlPath);
		if (xmlDoc.parseError.errorCode!=0){
			var error = xmlDoc.parseError;
			var timer=setTimeout("DisplayProgressBar('" + xmlPath + "')",500);
			return;
		}
		var root = xmlDoc.documentElement;   //根节点
		percent = root.childNodes(2).text;
		top.document.getElementById("ProgressPercent1").innerHTML  = percent + "%";
		if(percent==100){
			clearInterval(timer);
		}else{
			var timer=setTimeout("DisplayProgressBar('" + xmlPath + "')",500);
		}
	}
//修改目录名
function modfoldername(kid,kname,klevel){
	Pkid=kid;
	Kname=kname;
	if(isLegal(kname)){
		xmlHttpM=GetXmlHttpObject();		
		document.getElementById("Div"+Pkid).value="正在修改";
		var url = "ajaxasp/modfolder.asp?kid="+kid+"&kname="+escape(kname)+"&klevel="+klevel+"&rand="+Math.random();
		window.clipboardData.setData("Text",url);
		xmlHttpM.open("GET", url, true);
		xmlHttpM.onreadystatechange = updateModFolder;    
		xmlHttpM.send(null);  
		return true;
	}else{
		alert('请勿输入非法字符！');
		document.getElementById("K"+Pkid).style.display="block";
		document.getElementById("inputK"+Pkid).style.display="none";
		document.getElementById("modbK"+Pkid).style.display="none";
		document.getElementById("divK"+Pkid).style.display="block";
		}
}


function updateModFolder() {
  if (xmlHttpM.readyState < 4) {
   document.getElementById("Div"+Pkid).value="正在修改";
   document.getElementById("Div"+Pkid).disabled=true;
  }
  if (xmlHttpM.readyState == 4) {
	document.getElementById("Div"+Pkid).value="修改";
	document.getElementById("Div"+Pkid).disabled=false;
    var response = unescape(xmlHttpM.responseText);
     //alert(response);
     if (response.indexOf("超时")>=0){    
    	alert("超时");
    	window.location="index.asp";
	}
    else if (response.indexOf("同名")>=0){
		alert("呀哈~不行~有同名目录存在！~~");
    }
	 else if (response.indexOf("非法")>=0){
		alert("做人要后道！~~");
    }
    else if(response.indexOf("成功")>=0)
    {
    	alert("哈~目录修改成功！~~");
		document.getElementById("K"+Pkid).innerHTML="<img src='images/0040.gif' width='16' height='14' align='absmiddle' />"+Kname;
		document.getElementById("K"+Pkid).style.display="block";
		document.getElementById("inputK"+Pkid).style.display="none";
		document.getElementById("modbK"+Pkid).style.display="none";
		document.getElementById("divK"+Pkid).style.display="block";
 
		}
  }   
}

function updatePageInfo(){
  if (xmlHttpPI.readyState < 4) {
   document.getElementById("PageInfobottom").innerHTML="<img src=images/loader.gif> Loading......";
  }
  if (xmlHttpPI.readyState == 4 && xmlHttpPI.status==200) {
    var response = xmlHttpPI.responseText;
    if (response.indexOf("超时")>0)
    {    
    alert("超时");
    window.location="index.asp";
	}
    document.getElementById("PageInfobottom").innerHTML=response;
     
  }   
}
//分页函数
function PageInfo(upid,currentpage){
	xmlHttpPI=GetXmlHttpObject();
    var url = "ajaxasp/folderpage.asp?upid=" + upid + "&currentpage="+currentpage+"&rand="+Math.random();
    xmlHttpPI.open("GET", url, true);
    xmlHttpPI.onreadystatechange = updatePageInfo;
    xmlHttpPI.send(null);  
    return true;
}
//搜索
function updatesearch() {
  if (xmlHttpP.readyState < 4) {
   document.getElementById("PicList").innerHTML="<img src=images/loader.gif> Loading......";
  }
  if (xmlHttpP.readyState == 4 && xmlHttpP.status==200) {
    var response = unescape(xmlHttpP.responseText);
    if (response.indexOf("超时")>0){    
		alert("超时");
		window.location="index.asp";
	}
    document.getElementById("PicList").innerHTML=response;    
  }   
}

function search(content,currentpage){
	xmlHttpP=GetXmlHttpObject();
    var url = "ajaxasp/searchpic.asp?content=" + escape(content)+"&rand="+Math.random();
    //window.clipboardData.setData("Text",url);
    xmlHttpP.open("GET", url, true);
    xmlHttpP.onreadystatechange = updatesearch;
    xmlHttpP.send(null); 
    return true;
    
}
//分页
function changepageinfo(currentpage,pagecount,kid){
document.getElementById("folderlist").innerHTML="<img src=images/loader.gif> Loading......";
content="<table width=96% ><tr><td align=right><div class='PageInfo'>";
	if(pagecount>0)
	{
		if(currentpage!=1)
		{
		content=content+"<span  onclick=temp=0;ShowFolder("+ kid + ","+(currentpage-1)+");changepageinfo(" +(currentpage-1)+ ","+pagecount+ "," + kid +");><a href='#'><</a></span>";
		}
		else
		{
		content=content+"<span class='disabled'><</span>";
		}
	}
	
if(pagecount<13)
{
  for(i=1;i<=pagecount;i++)
  {
    if(currentpage==i)
     {
     content=content+"<span class='current'>" +i+"</span>";
     }
    else
     {
     content=content+"<span  onclick=temp=0;ShowFolder("+ kid + ","+i+");changepageinfo(" +i+ ","+pagecount+ "," + kid +");><a href='#'>" +i+ "</a></span>";
     }
  }

}
else
{
if(currentpage<6)
{
  for(i=1;i<=6;i++)
  {
    if(currentpage==i)
     {
     content=content+"<span class='current'>" +i+"</span>";
     }
    else
     {
     content=content+"<span  onclick=temp=0;ShowFolder("+ kid + ","+i+");changepageinfo(" +i+ ","+pagecount+ "," + kid +");><a href='#'>" +i+ "</a></span>";
     }
  }
  //alert(content);
  content=content+"..."
  for(i=pagecount-2;i<=pagecount;i++)
  {
    //alert(i);
     content=content+"<span  onclick=temp=0;ShowFolder("+ kid + ","+i+");changepageinfo(" +i+ ","+pagecount+ "," + kid +");><a href='#'>" +i+ "</a></span>";
  }
}
else if((pagecount-currentpage)<6)
{
  //alert("tail");
  for(i=1;i<=2;i++)
  {
     content=content+"<span  onclick=temp=0;ShowFolder("+ kid + ","+i+");changepageinfo(" +i+ ","+pagecount+ "," + kid +");><a href='#'>" +i+ "</a></span>";
  }
  content=content+"...";
  for(i=pagecount-6;i<=pagecount;i++)
  {
    if(currentpage==i)
     {
     content=content+"<span class='current'>" +i+"</span>";
     }
    else
     {
     content=content+"<span  onclick=temp=0;ShowFolder("+ kid + ","+i+");changepageinfo(" +i+ ","+pagecount+ "," + kid +");><a href='#'>" +i+ "</a></span>";
     }
  }

}
else
{
  for(i=1;i<=2;i++)
  {
     content=content+"<span  onclick=temp=0;ShowFolder("+ kid + ","+i+");changepageinfo(" +i+ ","+pagecount+ "," + kid +");><a href='#'>" +i+ "</a></span>";
  }
  content=content+"...";
  for(i=currentpage-2;i<=currentpage+2;i++)
  {
    if(currentpage==i)
     {
     content=content+"<span class='current'>" +i+"</span>";
     }
    else
     {
     content=content+"<span  onclick=temp=0;ShowFolder("+ kid + ","+i+");changepageinfo(" +i+ ","+pagecount+ "," + kid +");><a href='#'>" +i+ "</a></span>";
     }
  }
  content=content + "..."
  for(i=pagecount-2;i<=pagecount;i++)
  {
     content=content+"<span onclick=temp=0;ShowFolder("+ kid + ","+i+");changepageinfo(" +i+ ","+pagecount+ "," + kid +");><a href='#'>" +i+ "</a></span>";
  }

}
}
	if(pagecount>0)
	{
		if(currentpage!=pagecount)
		{
		content=content+"<span  onclick=temp=0;ShowFolder("+ kid + ","+(currentpage+1)+");changepageinfo(" +(currentpage+1)+ ","+pagecount+ "," + kid +");><a href='#'>></a></span>";
		}
		else
		{
		content=content+"<span class='disabled'>></span>";
		}
	}
  content=content+"</div></td></tr></table>";
  document.getElementById("PageInfobottom").innerHTML=content;
}