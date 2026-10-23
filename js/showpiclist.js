var xmlHttpP,xmlHttpF,xmlHttpC,xmlHttpPI,TotalHeight,temp,content,xmlHttpO,Pkid,xmlHttpL,Pid,xmlHttpPL,Mycurrentpage,xmlHttpDA,Pupid,xmlHttpRM;
temp=0;
//alert(temp);
Mycurrentpage=1;

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

function updateFolderList() {
  if (xmlHttpF.readyState < 4) {
  	 document.getElementById("FolderList").innerHTML="<img src=images/loader.gif> Loading......";
  }
  if (xmlHttpF.readyState == 4  && xmlHttpF.status==200) {
    var response = xmlHttpF.responseText;    
    document.getElementById("FolderList").innerHTML=response;
    if (response.indexOf("超时")==0){    
		alert("超时");
		window.location="index.asp";
	}
 
  }   
}

function FolderList(klevel,kid,upid,type){    
	xmlHttpF=GetXmlHttpObject();
    Pkid=kid;
    var url = "ajaxasp/folderlist.asp?klevel=" + klevel + "&kid=" +kid +"&upid="+upid+"&type="+type;
    //window.clipboardData.setData("Text",url);
    xmlHttpF.open("GET", url, true);
    xmlHttpF.onreadystatechange = updateFolderList;
    xmlHttpF.send(null);  
    return true;
}

function updateCurrentFolder() {
  if (xmlHttpC.readyState < 4) {
   document.getElementById("CurrentFolder").innerHTML="<img src=images/loader.gif> Loading......";
  }
  if (xmlHttpC.readyState == 4 && xmlHttpC.status==200) {
    var response = unescape(xmlHttpC.responseText);
	//alert(response);
     if (response.indexOf("超时")==0){    
    alert("超时");
    window.location="index.asp";
	}
    document.getElementById("CurrentFolder").innerHTML=response;
 
  }   
}
function CurrentFolder(kid,type){
	xmlHttpC=GetXmlHttpObject();
    var url = "ajaxasp/currentfolder.asp?kid=" +kid +"&type="+type+"&rand="+Math.random();
	//window.clipboardData.setData("Text",url);
    xmlHttpC.open("GET", url, true);
    xmlHttpC.onreadystatechange = updateCurrentFolder;
    xmlHttpC.send(null);  
    return true;
}



function updatePicList() {
  if (xmlHttpP.readyState < 4) {
   document.getElementById("PicList").innerHTML="<img src=images/loader.gif> Loading......";
  }
  if (xmlHttpP.readyState == 4  && xmlHttpP.status==200) {
    var response = unescape(xmlHttpP.responseText);
	//alert(response);
    if (response.indexOf("超时")==0){
		alert("超时");
		window.location="index.asp";
	}
    document.getElementById("PicList").innerHTML=response;
  
  }   
}

function PicList(kid,currentpage,type){
	xmlHttpP=GetXmlHttpObject();
    var url = "ajaxasp/piclist.asp?kid=" + kid + "&currentpage="+currentpage+"&type="+type+"&rand="+Math.random();
    //window.clipboardData.setData("Text",url);
    xmlHttpP.open("GET", url, true);
    xmlHttpP.onreadystatechange = updatePicList;
    xmlHttpP.send(null);  
    return true;
}

//-------------------------------------------------------
//显示前50条
function updateTopList() {
  if (xmlHttpP.readyState < 4) {
   document.getElementById("PicList").innerHTML="<img src=images/loader.gif> Loading......";
  }
  if (xmlHttpP.readyState == 4 && xmlHttpP.status==200) {
    var response = unescape(xmlHttpP.responseText);
	//alert(response);
    if (response.indexOf("超时")==0){    
		alert("超时");
		window.location="index.asp";
	}
    document.getElementById("PicList").innerHTML=response;
   
  }   
}

function ShowTopList(){
	xmlHttpP=GetXmlHttpObject();
    var url = "ajaxasp/Toplist.asp?&rand="+Math.random();
    //window.clipboardData.setData("Text",url);
    xmlHttpP.open("GET", url, true);
    xmlHttpP.onreadystatechange = updateTopList;
    xmlHttpP.send(null);  
    return true;
}

function updatePageInfo() {
  if (xmlHttpPI.readyState < 4) {
   document.getElementById("PageInfotop").innerHTML="<img src=images/loader.gif> Loading......";
   document.getElementById("PageInfobottom").innerHTML="<img src=images/loader.gif> Loading......";
   
  }
  if (xmlHttpPI.readyState == 4 && xmlHttpPI.status==200) {
    var response = unescape(xmlHttpPI.responseText);
   // alert(response);
	if (response.indexOf("超时")==0){
		alert("超时");
		window.location="index.asp";
	}
    document.getElementById("PageInfotop").innerHTML=response;
    document.getElementById("PageInfobottom").innerHTML=response;
    if(top.tx8_mainbody.document.body.scrollHeight>=temp){
    temp=top.tx8_mainbody.document.body.scrollHeight;
    }
  }   
}

function PageInfo(kid,currentpage,type){
	xmlHttpPI=GetXmlHttpObject();
    var url = "ajaxasp/pageinfo.asp?kid=" + kid + "&currentpage="+currentpage+"&type="+type+"&rand="+Math.random();
	//window.clipboardData.setData("Text",url);
    xmlHttpPI.open("GET", url, true);
    xmlHttpPI.onreadystatechange = updatePageInfo;
    xmlHttpPI.send(null);  
    return true;
}

function updateOption() {
  if (xmlHttpO.readyState < 4) {
   document.getElementById("FolderOptiontop").innerHTML="Loading......";
   document.getElementById("FolderOptionbottom").innerHTML="Loading......";
  }
  if (xmlHttpO.readyState == 4 && xmlHttpO.status==200) {
    var response = unescape(xmlHttpO.responseText);
    if (response.indexOf("超时")==0){    
		alert("超时");
		window.location="index.asp";
	}
    document.getElementById("FolderOptiontop").innerHTML=response;
    document.getElementById("FolderOptionbottom").innerHTML=response;
   
  }   
}

function FolderOption(kid){
	xmlHttpO=GetXmlHttpObject();
    var url = "ajaxasp/showfolderoption.asp?kindtype=pic&kid=" + kid +"&rand="+Math.random();
    xmlHttpO.open("GET", url, true);
    xmlHttpO.onreadystatechange = updateOption;
    xmlHttpO.send(null);  
    return true;
}

function changepageinfo(currentpage,pagecount,kid,type)
{
var tempstr;
Mycurrentpage=currentpage;
document.getElementById("PicList").innerHTML="<img src=images/loader.gif> Loading......";
content="<table width=96% ><tr><td align=right><div class='PageInfo'>";
if(pagecount>0)
{
if(currentpage!=1)
{
content=content+"<span  onclick='temp=0;PicList(" + kid+ ","+(currentpage-1)+","+type+");changepageinfo(" +(currentpage-1)+ ","+pagecount+ "," + kid +","+ type +");'><a href='#'><</a></span>";
}
else
{
content=content+"<span class='disabled'><</span>";
}
}
if(pagecount<10)
{
  
  
  for(i=1;i<=pagecount;i++)
  {
    if(currentpage==i)
     {
     content=content+"<span class='current'>" +i+"</span>";
     }
    else
     {
     content=content+"<span  onclick='temp=0;PicList(" + kid+ ","+i+","+ type +");changepageinfo(" +i+ ","+pagecount+ "," + kid +","+type+");'><a href='#'>" +i+ "</a></span>";
     }
  }

}
else
{
if(currentpage<5)
{
  for(i=1;i<=5;i++)
  {
    if(currentpage==i)
     {
     content=content+"<span class='current'>" +i+"</span>";
     }
    else
     {
     content=content+"<span  onclick='temp=0;PicList(" + kid+ ","+i+","+type+");changepageinfo(" +i+ ","+pagecount+ "," + kid +","+type+");'><a href='#'>" +i+ "</a></span>";
     }
  }
  content=content+"..."
  for(i=pagecount-2;i<=pagecount;i++)
  {
     content=content+"<span  onclick='temp=0;PicList(" + kid+ ","+i+","+type+");changepageinfo(" +i+ ","+pagecount+ "," + kid +","+type+");'><a href='#'>" +i+ "</a></span>";
  }
}
else if((pagecount-currentpage)<4)
{
  for(i=1;i<=2;i++)
  {
     content=content+"<span  onclick='temp=0;PicList(" + kid+ ","+i+","+type+");changepageinfo(" +i+ ","+pagecount+ "," + kid +","+type+");'><a href='#'>" +i+ "</a></span>";
  }
  content=content+"...";
  for(i=pagecount-4;i<=pagecount;i++)
  {
    if(currentpage==i)
     {
     content=content+"<span class='current'>" +i+"</span>";
     }
    else
     {
     content=content+"<span  onclick='temp=0;PicList(" + kid+ ","+i+","+type+");changepageinfo(" +i+ ","+pagecount+ "," + kid +","+type+");'><a href='#'>" +i+ "</a></span>";
     }
  }

}
else
{
  for(i=1;i<=2;i++)
  {
     content=content+"<span  onclick='temp=0;PicList(" + kid+ ","+i+","+type+");changepageinfo(" +i+ ","+pagecount+ "," + kid +","+type+");'><a href='#'>" +i+ "</a></span>";
  }
  content=content+"...";
  for(i=currentpage-1;i<=currentpage+1;i++)
  {
    if(currentpage==i)
     {
     content=content+"<span class='current'>" +i+"</span>";
     }
    else
     {
     content=content+"<span  onclick='temp=0;PicList(" + kid+ ","+i+","+type+");changepageinfo(" +i+ ","+pagecount+ "," + kid +","+type+");'><a href='#'>" +i+ "</a></span>";
     }
  }
  content=content + "..."
  for(i=pagecount-1;i<=pagecount;i++)
  {
     content=content+"<span onclick='temp=0;PicList(" + kid+ ","+i+","+type+");changepageinfo(" +i+ ","+pagecount+ "," + kid +","+type+");'><a href='#'>" +i+ "</a></span>";
  }
}
}
if(pagecount>0)
{
if(currentpage!=pagecount)
{
content=content+"<span  onclick='temp=0;PicList(" + kid+ ","+(currentpage+1)+","+type+");changepageinfo(" +(currentpage+1)+ ","+pagecount+ "," + kid +","+type+");'><a href='#'>></a></span>";
}
else
{
content=content+"<span class='disabled'>></span>";
}
}
  content=content+"</div></td></tr></table>";
  document.getElementById("PageInfotop").innerHTML=content;
  document.getElementById("PageInfobottom").innerHTML=content;
}


function CheckAll(form,obj)
  {
  if(obj.Name=="chkAll1")
  {
  form.chkAll2.checked=obj.checked;
  }
  else
  {
  form.chkAll1.checked=obj.checked;
  }
  for (var i=0;i<form.elements.length;i++)
    {
    var e = form.elements[i];
    if (e.Name!="")
       e.checked = obj.checked;
    }
   //alert(form.pid.value);
  }

function updateDelAllFiles() {
  if (xmlHttpDA.readyState == 4 && xmlHttpDA.status==200) {
    var response = unescape(xmlHttpDA.responseText);
    //alert(response);
    if (response.indexOf("超时")==0){    
		alert("超时");
		window.location="index.asp";
	}
	top.document.getElementById("fugai_layout").style.display="none";
	top.document.getElementById("delinfo").style.display="none";
    if (response.indexOf("main.asp")>=0)
    {
		top.document.getElementById("usesize").innerHTML=response.substr(8,100)
		window.open("main.asp?upid="+Pupid+"&kid="+Pkid+"&type="+Ptype+"&currentpage="+Mycurrentpage+"&klevel="+Pklevel,"_self","");
    }
    if (response.indexOf("list.asp")>=0)
    {
		top.document.getElementById("usesize").innerHTML=response.substr(8,100);
		window.open("list.asp?upid="+Pupid+"&kid="+Pkid+"&type="+Ptype+"&currentpage="+Mycurrentpage+"&klevel="+Pklevel,"_self","");
    }
	if (response.indexOf("top5.asp")>=0)
    {
		top.document.getElementById("usesize").innerHTML=response.substr(8,100);
		window.open("top50.asp","_self","");
    }
    //alert(response);
  }   
}

function DelAllFiles(pids,type,klevel,kid,upid,op){
 
    if (op==1) 
	{
		if(top.document.body.scrollHeight>top.document.body.clientHeight)
		{
		top.document.getElementById("fugai_layout").style.height=top.document.body.scrollHeight;
		}
		else
		{
		top.document.getElementById("fugai_layout").style.height=top.document.body.clientHeight;
		}
		top.document.getElementById("fugai_layout").style.width=top.document.body.scrollWidth;
		top.document.getElementById("fugai_layout").style.display="block";

		if(confirm('此操作将删除所选文件并不能恢复！\n\n确认删除吗？')) 
		{
	
		var objProgress = top.document.getElementById("delinfo");
		objProgress.style.top = top.document.body.scrollTop+(top.document.body.clientHeight-top.document.getElementById("delinfo").offsetHeight)/2-100;
		objProgress.style.left = top.document.body.scrollLeft+(top.document.body.clientWidth-top.document.getElementById("delinfo").offsetWidth)/2-150;
		objProgress.style.display="block";
	
		xmlHttpDA=GetXmlHttpObject();
		Pkid=kid;
		Pupid=upid;
		Ptype=type
		Pklevel=klevel
		var url = "ajaxasp/delallfiles.asp?pids="+pids+"&type="+type+"&kid="+kid+"&rand="+Math.random();
		//window.clipboardData.setData("Text",url);
		xmlHttpDA.open("GET", url, true);
		xmlHttpDA.onreadystatechange = updateDelAllFiles;
		xmlHttpDA.send(null);	
		} 
		else
		{
			top.document.getElementById("fugai_layout").style.display="none";
		}
    }
    else
    {
		if(confirm('此操作将删除所选文件并不能恢复！\n\n确认删除吗？'))
		{
			xmlHttpDA=GetXmlHttpObject();
			Pkid=kid;
			Pupid=upid;
			Ptype=type
			Pklevel=klevel;
			var url = "ajaxasp/delallfiles.asp?pids="+pids+"&type="+type+"&kid="+kid+"&rand="+Math.random();
			//window.clipboardData.setData("Text",url);
			xmlHttpDA.open("GET", url, true);
			xmlHttpDA.onreadystatechange = updateDelAllFiles;
			xmlHttpDA.send(null);
    	}
    }
    return true;
}

function updateRMAllFiles() {
  if (xmlHttpRM.readyState == 4 && xmlHttpRM.status==200) {
    var response = unescape(xmlHttpRM.responseText);
    //alert(response);
    if (response.indexOf("超时")==0){
		alert("超时");
		window.location="index.asp";
	}
    if (response.indexOf("main.asp")>=0)
    {    
   		window.open("main.asp?kid="+Pkid+"&type="+Ptype+"&currentpage="+Mycurrentpage,"_self","");
		alert("图片移动成功！");
    }
    if (response.indexOf("list.asp")>=0)
    {
    	window.open("list.asp?kid="+Pkid+"&type="+Ptype+"&currentpage="+Mycurrentpage,"_self","");
		alert("图片移动成功！");
    }
  }
}

function RMAllFiles(klevel,pids,type,kid,upid,newkid){
	xmlHttpRM=GetXmlHttpObject();
    Pkid=kid;
    Pupid=upid;
	Ptype=type
	Pklevel=klevel;
    var url = "ajaxasp/removeallfiles.asp?newkid="+newkid+"&pids="+pids+"&type="+type+"&kid="+kid;
    //window.clipboardData.setData("Text",url);
    xmlHttpRM.open("GET", url, true);
    xmlHttpRM.onreadystatechange = updateRMAllFiles;
    xmlHttpRM.send(null);  
    return true;
}

function updatesearch() {
  if (xmlHttpP.readyState < 4){
   document.getElementById("PicList").innerHTML="<img src=images/loader.gif> Loading......";
  }
  if (xmlHttpP.readyState == 4 && xmlHttpP.status==200) {
    var response = unescape(xmlHttpP.responseText);
    if (response.indexOf("超时")>0){
		alert("超时");
		window.location="default.asp";
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