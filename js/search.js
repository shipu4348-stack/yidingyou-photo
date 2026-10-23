
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





function updatesearch() {
  if (xmlHttpP.readyState < 4) {
   document.getElementById("PicList").innerHTML="<img src=images/loader.gif> Loading......";
  }
  if (xmlHttpP.readyState == 4) {
    var response = unescape(xmlHttpP.responseText);
    if (response.indexOf("超时")>0)
    {
    
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

function updatePageInfo() {
  if (xmlHttpPI.readyState < 4) {
   document.getElementById("PageInfotop").innerHTML="<img src=images/loader.gif> Loading......";
   document.getElementById("PageInfobottom").innerHTML="<img src=images/loader.gif> Loading......";
   
  }
  if (xmlHttpPI.readyState == 4) {
    //alert("update pic list");
    var response = xmlHttpPI.responseText;
    if (response.indexOf("超时")>0)
    {
    
    alert("超时");
    window.location="default.asp";
	}
    
    document.getElementById("PageInfotop").innerHTML=response;
    document.getElementById("PageInfobottom").innerHTML=response;
     if(top.tx8_mainbody.document.body.scrollHeight>=temp)
    {
    temp=top.tx8_mainbody.document.body.scrollHeight;
    }
    
  }   
}

function PageInfo(content){
 
	 xmlHttpPI=GetXmlHttpObject();
    var url = "ajax_asp/search_pageinfo.asp?content=" +content;
    xmlHttpPI.open("GET", url, true);
    //window.clipboardData.setData("Text",url);
    xmlHttpPI.onreadystatechange = updatePageInfo;
    xmlHttpPI.send(null);  
    return true;
}

function updateOption() {
  if (xmlHttpO.readyState < 4) {
   document.getElementById("FolderOptiontop").innerHTML="Loading......";
   document.getElementById("FolderOptionbottom").innerHTML="Loading......";
  }
  if (xmlHttpO.readyState == 4) {
    var response = xmlHttpO.responseText;
    if (response.indexOf("超时")>=0)
    {    
    alert("超时");
    window.location="default.asp";
	}
    document.getElementById("FolderOptiontop").innerHTML=response;
    document.getElementById("FolderOptionbottom").innerHTML=response;
     
  }   
}

function FolderOption(kid,name){
 
	xmlHttpO=GetXmlHttpObject();
    var url = "ajax_asp/showfolderoption.asp?kid=" + kid +"&name="+name;
    xmlHttpO.open("GET", url, true);
    xmlHttpO.onreadystatechange = updateOption;
    xmlHttpO.send(null);  
    return true;
}

function changepageinfo(currentpage,pagecount,kid,type)
{
var tempstr;
Mycurrentpage=currentpage;
tempstr=document.getElementById("viewhref").href
document.getElementById("viewhref").href=tempstr.substr(0,tempstr.indexOf("currentpage=")+12)+currentpage;
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
     //alert(content); 
     }
  }

}
else
{
if(currentpage<5)
{
  //alert("head");
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
  //alert(content);
  content=content+"..."
  for(i=pagecount-2;i<=pagecount;i++)
  {
    //alert(i);
     content=content+"<span  onclick='temp=0;PicList(" + kid+ ","+i+","+type+");changepageinfo(" +i+ ","+pagecount+ "," + kid +","+type+");'><a href='#'>" +i+ "</a></span>";
  }
}
else if((pagecount-currentpage)<4)
{
  //alert("tail");
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
  //alert("middle");
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


function updatelxop() {
  if (xmlHttpL.readyState == 4) {
    //alert("update pic list");
    var response = xmlHttpL.responseText;
    if (response.indexOf("超时")>0)
    {
    
    alert("超时");
    window.location="default.asp";
	}
    document.getElementById("X"+Pid).innerHTML=response;
   
    //alert("P"+top.tx8_mainbody.document.body.scrollHeight);
    //alert(response);
  }   
}

function lxop(type,op,pid){
 
	xmlHttpL=GetXmlHttpObject();
    var url = "ajax_asp/lxop.asp?type=" + type +"&op="+op+"&pid="+pid;
    Pid=pid;
    //window.clipboardData.setData("Text",url);
    xmlHttpL.open("GET", url, true);
    xmlHttpL.onreadystatechange = updatelxop;
    xmlHttpL.send(null);  
    return true;
}

function updatelxopPl() {
  if (xmlHttpPL.readyState == 4) {
    var response = xmlHttpPL.responseText;
    if (response.indexOf("超时")>0)
    {
    
    alert("超时");
    window.location="default.asp";
	}
    document.getElementById("pllxresult").innerHTML=response;
    //alert(lxids);
    for(i=0;i<lxidnum;i++)
    {
    //alert(lxids[i]);
    document.getElementById("X"+lxids[i]).innerHTML=document.getElementById("temp"+i).innerHTML;
    }
    //alert(response);
  }   
}

function lxopPl(pids,type,kid){
  
	xmlHttpPL=GetXmlHttpObject();
    var url = "ajax_asp/lxoppl.asp?pids="+pids+"&type="+type+"&kid="+kid;
    //window.clipboardData.setData("Text",url);
    xmlHttpPL.open("GET", url, true);
    xmlHttpPL.onreadystatechange = updatelxopPl;
    xmlHttpPL.send(null);  
    return true;
}

function updateDelAllFiles() {
  if (xmlHttpDA.readyState == 4) {
    //alert("update pic list");
    var response = unescape(xmlHttpDA.responseText);
    if (response.indexOf("超时")>0)
    {    
    alert("超时");
    window.location="default.asp";
	}    
    if (response.indexOf("main.asp")>=0)
    {
		alert(klevels);
    top.document.getElementById("usesize").innerHTML=response.substr(8,100)
    window.open("main.asp?upid="+Pupid+"&kid="+Pkid+"&currentpage="+Mycurrentpage,"_self","");
    }
    if (response.indexOf("list.asp")>=0)
    {
    top.document.getElementById("usesize").innerHTML=response.substr(8,100);
    window.open("list.asp?upid="+Pupid+"&kid="+Pkid+"&currentpage="+Mycurrentpage,"_self","");
    }
    if (response.indexOf("sear.asp")>=0)
    {
    top.document.getElementById("usesize").innerHTML=response.substr(8,100);
    top.document.search.submit();
    }
    if (response.indexOf("top5.asp")>=0)
    {
    top.document.getElementById("usesize").innerHTML=response.substr(8,100);
    window.open("top50.asp","_self","");
    }
    if (response.indexOf("pdel.asp")>=0)
    {
    top.document.getElementById("usesize").innerHTML=response.substr(8,100);
    del_search_num=del_search_num-1;
    }
  }   
}

function DelAllFiles(pids,type,kid,upid){
   if(confirm('此操作将删除所选文件并不能恢复！\n\n确认删除吗？')) 
   {
     
	xmlHttpDA=GetXmlHttpObject();
    Pkid=kid;
    Pupid=upid;
    var url = "ajax_asp/delallfiles.asp?pids="+pids+"&type="+type+"&kid="+kid;
    //window.clipboardData.setData("Text",url);
    xmlHttpDA.open("GET", url, true);
    xmlHttpDA.onreadystatechange = updateDelAllFiles;
    xmlHttpDA.send(null);
    } 
    return true;
}

function DelAllsearch(pids,type,kid,upid){
   
 
	xmlHttpDA=GetXmlHttpObject();
    Pkid=kid;
    Pupid=upid;
    var url = "ajaxasp/delallfiles.asp?pids="+pids+"&type="+type+"&kid="+kid+"&rand="+Math.random();
    //window.clipboardData.setData("Text",url);
    xmlHttpDA.open("GET", url, true);
    xmlHttpDA.onreadystatechange = updateDelAllFiles;
    xmlHttpDA.send(null);
    return true;
}


function updateRMAllFiles() {
  if (xmlHttpRM.readyState == 4) {
    //alert("update pic list");
    var response = xmlHttpRM.responseText;
    if (response.indexOf("超时")>0)
    {
    
    alert("超时");
    window.location="default.asp";
	}
    
    if (response.indexOf("main.asp")>=0)
    {
    
   window.open("main.asp?upid="+Pupid+"&kid="+Pkid+"&currentpage="+Mycurrentpage,"_self","");
    }
    if (response.indexOf("list.asp")>=0)
    {
    window.open("list.asp?upid="+Pupid+"&kid="+Pkid+"&currentpage="+Mycurrentpage,"_self","");
    }
    //alert(response);
  }   
}

function RMAllFiles(pids,type,kid,upid,newkid){
   xmlHttpRM=GetXmlHttpObject();
    Pkid=kid;
    Pupid=upid;
    var url = "ajax_asp/removeallfiles.asp?newkid="+newkid+"&pids="+pids+"&type="+type+"&kid="+kid;
    //window.clipboardData.setData("Text",url);
    xmlHttpRM.open("GET", url, true);
    xmlHttpRM.onreadystatechange = updateRMAllFiles;
    xmlHttpRM.send(null);  
    return true;
}


