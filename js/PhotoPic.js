var xmlHttp,xmlHttpPI,xmlHttpP,xmlHttpPN,currentpage,content,PageNum,_kname;
currentpage=1;
temp=0;

var Speed_1 = 10; //速度(毫秒)
var Space_1 = 10; //每次移动(px)
var PageHeight_1 = 120*4; //翻页宽度
var fill_1 = 0; //整体移位
var MoveLock_1 = false;
var MoveTimeObj_1;
var MoveWay_1="right";
var _Space_1=0;
function GetObj(objName)
{
	if(document.getElementById)
	{
		return eval('document.getElementById("'+objName+'")')
	}
	else 
	{
		return eval('document.all.'+objName)
	}
}

function ISL_GoUp_1()
{
	if(MoveLock_1)return ;
	MoveLock_1=true;
	_Space=0;
	ISL_ScrUp_1();
	MoveTimeObj_1=setInterval('ISL_ScrUp_1();',Speed_1);
	GetObj('ISLBottom').onclick=ISL_GoDown_1;
}

function ISL_ScrUp_1()
{
	_Space=_Space+Space_1
	if (_Space==480)
	{
		_Space_1=0;
		MoveLock_1=false;
		clearInterval(MoveTimeObj_1);
	}
	if(GetObj('ISL_Cont_1').scrollTop<=0)
	{
		GetObj('ISL_Cont_1').scrollTop=0;
		GetObj('ISLTop').onclick="";
		clearInterval(MoveTimeObj_1);
		MoveLock_1=false;
	}
	else
	{
		GetObj('ISLTop').onclick=ISL_GoUp_1;
	}
	GetObj('ISL_Cont_1').scrollTop-=Space_1
}

function ISL_GoDown_1(){
	if(MoveLock_1)return ;
	MoveLock_1=true;
	_Space=0;
	ISL_ScrDown_1();
	MoveTimeObj_1=setInterval('ISL_ScrDown_1()',Speed_1);
	GetObj('ISLTop').onclick=ISL_GoUp_1;
}

function ISL_ScrDown_1()
{
	_Space=_Space+Space_1
	if (_Space==480)
	{
		_Space_1=0;
		MoveLock_1=false;
		clearInterval(MoveTimeObj_1);
	}
	if(GetObj('ISL_Cont_1').scrollTop>=GetObj('List1_1').scrollHeight-480)
	{
		GetObj('ISL_Cont_1').scrollTop=GetObj('List1_1').scrollHeight-480;
		GetObj('ISLBottom').onclick="";
		clearInterval(MoveTimeObj_1);
		MoveLock_1=false;
	}
	else
	{
		GetObj('ISLBottom').onclick=ISL_GoDown_1;
	}
	GetObj('ISL_Cont_1').scrollTop+=Space_1
}

function PhotoInit(Select)
{
	if(Select>=0)
		GetObj('ISL_Cont_1').scrollTop=(Select-1)*120;
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



 

//--------------------------------------------------
//显示相册名称
function updatePhotoName()
{
	if (xmlHttpPN.readyState < 4) {
   		document.getElementById("Phototitle").innerHTML="<img src=images/loader.gif> Loading........";
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
		document.getElementById("Phototitle").innerHTML=response;
	}
  } 
}

function ShowPhotoName(kname,kid)
{
	 
	xmlHttpPN=GetXmlHttpObject()
	_kname=kname;
	 var url = "ajaxasp/ShowPhotoName.asp?kname="+kname+"&kid="+kid+"&rand="+Math.random();
    //window.clipboardData.setData("Text",url);
    xmlHttpPN.open("GET", url, true);
    xmlHttpPN.onreadystatechange = updatePhotoName;
    xmlHttpPN.send(null);  
    return true;
}
//--------------------------------------------------------------
//显示相册列表
function updatePage() {
  if (xmlHttp.readyState < 4) {
   document.getElementById("PhotoPicList").innerHTML="<img src=images/loader.gif> Loading........";
  }
  if (xmlHttp.readyState == 4) {
    var response = unescape(xmlHttp.responseText);
	//alert(response);
    document.getElementById("PhotoPicList").innerHTML=response;
  } 
}

function ShowPicList(kname,kid,currentpage)
{
   
	xmlHttp=GetXmlHttpObject()
    currentpage=currentpage;
    var url = "ajaxasp/ShowPicList.asp?kname="+kname+"&kid="+kid+"&currentpage="+currentpage+"&rand="+Math.random();
    //window.clipboardData.setData("Text",url);
    xmlHttp.open("GET", url, true);
    xmlHttp.onreadystatechange = updatePage;
    xmlHttp.send(null);  
    return true;
}
//--------------------------------------------------------
//显示图片
function updatePhotoPic() 
{
  if (xmlHttpP.readyState < 4) {
   document.getElementById("List1_1").innerHTML="<img src=images/loader.gif> Loading........";
  }
  if (xmlHttpP.readyState == 4) {
    var response = unescape(xmlHttpP.responseText);
	//alert(response);
	document.getElementById("List1_1").innerHTML=response;
  } 
}

function ShowPhotoPic(kname,kid)
{
    xmlHttpP=GetXmlHttpObject()
    var url = "ajaxasp/ShowPhotoList.asp?kname="+kname+"&kid="+kid+"&rand="+Math.random();
    //window.clipboardData.setData("Text",url);
    xmlHttpP.open("GET", url, true);
    xmlHttpP.onreadystatechange = updatePhotoPic;
    xmlHttpP.send(null);
    return true;
}
//-----------------------------------------------------------------
//分页
function updatePageInfo() {
  if (xmlHttpPI.readyState < 4) {
   document.getElementById("pageinfotop").innerHTML="<img src=../images/loader.gif> Loading......";
   document.getElementById("pageinfobottom").innerHTML="<img src=../images/loader.gif> Loading......";
  }
  if (xmlHttpPI.readyState == 4) {
    var response = unescape(xmlHttpPI.responseText);
    document.getElementById("pageinfotop").innerHTML=response;
	document.getElementById("pageinfobottom").innerHTML=response;
  }   
}

function ShowPicPage(kname,kid,currentpage){
  
	xmlHttpPI=GetXmlHttpObject()
    var url = "ajaxasp/PicListpage.asp?kname="+kname+"&kid="+kid+"&currentpage="+currentpage+"&rand="+Math.random();
	//window.clipboardData.setData("Text",url);
    xmlHttpPI.open("GET", url, true);
    xmlHttpPI.onreadystatechange = updatePageInfo;
    xmlHttpPI.send(null);  
    return true;
}
//--------------------------------------------------------------------
//改变分页
function changepageinfo(kname,kid,currentpage,pagecount)
{
document.getElementById("pageinfotop").innerHTML="<img src=images/loader.gif> Loading......";
document.getElementById("pageinfobottom").innerHTML="<img src=images/loader.gif> Loading......";
PageNum="";
if(pagecount>6)
{
PageNum+="<div id='PageListPic' style='display:none; height:108px;'>";
}
else
{
PageNum+="<div id='PageListPic' style='display:none;'>";	
}
for(var i=1;i<=pagecount;i++)
{
	if (i==currentpage)
	{
		PageNum+="<a href='javascript:void(0)' class='Checkbg' onclick='ShowPicList(\""+kname+"\","+kid+","+i+");changepageinfo(\""+kname+"\","+kid+"," +i+ ","+pagecount+");'>"+i+"</a>";
	}
	else
	{
		PageNum+="<a href='javascript:void(0)' class='num' onclick='ShowPicList(\""+kname+"\","+kid+","+i+");changepageinfo(\""+kname+"\","+kid+"," +i+ ","+pagecount+");'>"+i+"</a>";
	}
}
PageNum+="</div>";
content="";
	if(pagecount>0)
	{
		if(currentpage==1 && currentpage==pagecount)
		{
			content=content+"<li><a>上一页</a></li><li><a href='javascript:void(0)' onclick='ShowPageNum(this);' hidefocus='hidefocus' class='Pagebg'>"+currentpage+"/"+pagecount+"</a>"+PageNum+"</li><li><a>下一页</a></li>";
		}
		else if(currentpage==1 && currentpage<pagecount)
		{
			content=content+"<li><a>上一页</a></li><li><a href='javascript:void(0)' onclick='ShowPageNum(this);' hidefocus='hidefocus' class='Pagebg'>"+currentpage+"/"+pagecount+"</a>"+PageNum+"</li><li><a href='javascript:void(0)' onclick='ShowPicList(\""+kname+"\","+kid+","+(currentpage+1)+");changepageinfo(\""+kname+"\","+kid+"," +(currentpage+1)+ ","+pagecount+");'>下一页</a></li>";
		}
		else if(currentpage>1 && currentpage<pagecount)
		{
			content=content+"<li><a href='javascript:void(0)' onclick='ShowPicList(\""+kname+"\","+kid+","+(currentpage-1)+");changepageinfo(\""+kname+"\","+kid+"," +(currentpage-1)+ ","+pagecount+");'>上一页</a></li><li><a href='javascript:void(0)' onclick='ShowPageNum(this);' hidefocus='hidefocus' class='Pagebg'>"+currentpage+"/"+pagecount+"</a>"+PageNum+"</li><li><a href='javascript:void(0)' onclick='ShowPicList(\""+kname+"\","+kid+","+(currentpage+1)+");changepageinfo(\""+kname+"\","+kid+"," +(currentpage+1)+ ","+pagecount+");'>下一页</a></li>";
		}
		else
		{
			content=content+"<li><a href='javascript:void(0)' onclick='ShowPicList(\""+kname+"\","+kid+","+(currentpage-1)+");changepageinfo(\""+kname+"\","+kid+","+(currentpage-1)+","+pagecount+");'>上一页</a></li><li><a href='javascript:void(0)' onclick='ShowPageNum(this);' hidefocus='hidefocus' class='Pagebg'>"+currentpage+"/"+pagecount+"</a>"+PageNum+"</li><li><a>下一页</a></li>";
		}
	}
  document.getElementById("pageinfotop").innerHTML=content;
  document.getElementById("pageinfobottom").innerHTML=content;
  
}

function ShowPageNum(oThis)
{
	var PagePobj=oThis.parentNode;
	var Pageobj=PagePobj.childNodes[1];
	if(Pageobj.style.display=="")
	{
		Pageobj.style.display="none"
		oThis.className='Pagebg';
	}
	else
	{
		Pageobj.style.display=""
		oThis.className='check';
	}
}

function ResizeImage(image,width,height)
{
	var w = image.width;
	var h = image.height;
	if(w>width && w>h)
	{
	 image.width=width;
	 image.height = parseInt(h*(width/w));
	 }
	if(h>height && h>w)
	{
	 image.width = parseInt(w*(height/h));
	 image.height = height;
	 }
}

function ChangePhoto(id)
{
	var obj=document.getElementById("List1_1").getElementsByTagName("A");
	for(var i=0;i<obj.length;i++)
	{
		if(obj[i].id==id)
		{
			obj[i].className="plCheck";
		}
		else
		{
			obj[i].className="pl";
		}
	}
}