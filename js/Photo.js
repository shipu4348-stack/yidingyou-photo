var xmlHttp,xmlHttpPI,xmlHttpP,xmlHttpB,xmlHttpIs,xmlHttpO,xmlHttpM,xmlHttpC,currentpage,content,PageNum,_kname,_kid;
currentpage=1;
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

function ComfireJuBao()
{
	var Content=document.getElementById("Buling");
	if(Content.value=="")
	{
		alert('举报内容不能为空!');
		return;
	}
	else
	{
		ModifyJuBao(Content.value);
	}
}

//---------------------------------------------------------------------------------------
function updateShowPhotoPass() {
  if (xmlHttpC.readyState == 4) {
    var response = unescape(xmlHttpC.responseText);
	//alert(response);
	JuBao('CheckOpen');
	document.getElementById("CheckPhotoOpen").innerHTML=response;
  } 
}
//显示输入密码
function ShowPhotoPass(kname,kid)
{
	xmlHttpC=GetXmlHttpObject();
    var url = "ajaxasp/ShowPhotoPass.asp?kname="+kname+"&kid="+kid+"&rand="+Math.random();
    //window.clipboardData.setData("Text",url);
    xmlHttpC.open("GET", url, true);
    xmlHttpC.onreadystatechange = updateShowPhotoPass;
    xmlHttpC.send(null);  
    return true;
}
//-----------------------------------------------------------------------------------------------------

//---------------------------------------------------------------------------------------
function updateCheckPhotoPass() {
  if (xmlHttpC.readyState == 4) {
    var response = unescape(xmlHttpC.responseText);
	//alert(response);
	if(response.indexOf("成功")>=0)
	{
		JuBao('CheckOpen');
		window.location.href='PhotoPic.asp?kname='+_kname+'&kid='+_kid+''
	}
	else if(response.indexOf("错误")>=0)
	{
		alert('密码错误!');
	}
  } 
}
//更新权限
function CheckPhotoPass(kname,kid)
{
	var PassWord=document.getElementById("Pwd3").value;
	if(PassWord=="")
	{
		alert('密码不能为空!');
		return;
	}
	_kname=kname;
	_kid=kid;
 
	xmlHttpC=GetXmlHttpObject();
    var url = "ajaxasp/CheckPhotoOpen.asp?kname="+kname+"&kid="+kid+"&pwd="+PassWord+"&rand="+Math.random();
    //window.clipboardData.setData("Text",url);
    xmlHttpC.open("GET", url, true);
    xmlHttpC.onreadystatechange = updateCheckPhotoPass;
    xmlHttpC.send(null);  
    return true;
}
//-----------------------------------------------------------------------------------------------------

//---------------------------------------------------------------------------------------
function updateModifyPhotoOpen() {
  if (xmlHttpM.readyState == 4) {
    var response = unescape(xmlHttpM.responseText);
	if(response.indexOf("成功")>=0){
	ShowPhoto(_kname,1);
	ShowPhotoPage(_kname,1);
	JuBao('SetOpen');
	}
	else if(response.indexOf("同名")>=0){
		alert("有同名目录在，请重新填写!");
		return;
		}
  } 
}
//更新权限
function ModifyPhotoOpen(kname,kid)
{    
	var photoname=document.getElementById("PhotoName2").value;
	var IsOpen;
	var Open=document.all.Open;
	for(var i=0;i< Open.length;i++)
	{
		if(Open[i].checked)
		{
			IsOpen=Open[i].value;
		}
	}
	var PassWord=document.getElementById("pw2").value;
	_kname=kname
	 
	xmlHttpM=GetXmlHttpObject()
    var url = "ajaxasp/ModifyPhotoOpen.asp?kname="+kname+"&kid="+kid+"&photoname="+photoname+"&isOpen="+IsOpen+"&pwd="+PassWord+"&rand="+Math.random();
    //window.clipboardData.setData("Text",url);
    xmlHttpM.open("GET", url, true);
    xmlHttpM.onreadystatechange = updateModifyPhotoOpen;
    xmlHttpM.send(null);  
    return true;
}
//-----------------------------------------------------------------------------------------------------
//---------------------------------------------------------------------------------------
function updateShowPhotoOpen() {
  if (xmlHttpO.readyState == 4) {
    var response = unescape(xmlHttpO.responseText);
	JuBao('SetOpen');
	document.getElementById("ShowPhotoOpen").innerHTML=response;
  } 
}
//设置访问权限
function ShowPhotoOpen(kname,kid)
{
   xmlHttpO=GetXmlHttpObject();
    var url = "ajaxasp/showPhotoOpen.asp?kname="+kname+"&kid="+kid+"&rand="+Math.random();
    //window.clipboardData.setData("Text",url);
    xmlHttpO.open("GET", url, true);
    xmlHttpO.onreadystatechange = updateShowPhotoOpen;
    xmlHttpO.send(null);  
    return true;
}
//-----------------------------------------------------------------------------------------------------
//---------------------------------------------------------------------------------------
function updateModifyJuBao() {
  if (xmlHttpB.readyState == 4) {
    var response = unescape(xmlHttpB.responseText);
     if (response.indexOf("超时")==0)
    {    
		alert("超时");
		window.location="index.asp";
	}
	else if(response.indexOf("成功")>=0)
	{
		alert("举报成功,谢谢支持!");
	}
		JuBao('JuBao');
  } 
}
//提交不良信息
function ModifyJuBao(content)
{
    
	xmlHttpB=GetXmlHttpObject();
    currentpage=currentpage;
    var url = "ajaxasp/Jubao.asp?content="+content+"&rand="+Math.random();
    //window.clipboardData.setData("Text",url);
    xmlHttpB.open("GET", url, true);
    xmlHttpB.onreadystatechange = updateModifyJuBao;
    xmlHttpB.send(null);  
    return true;
}
//-----------------------------------------------------------------------------------------------------
//判断用户是否存在
function updateIsPay() {
  if (xmlHttpIs.readyState == 4) {
    var response = unescape(xmlHttpIs.responseText);
     if (response.indexOf("不")>=0)
    {    
		alert(response);
		window.close();
	}
	else if(response.indexOf("未")>=0)
	{
		document.getElementById('fugai_layout').style.display='';
		document.getElementById('login0').style.display='';
		document.getElementById('login0').style.left=(document.documentElement.clientWidth/2)-(document.getElementById('login0').offsetWidth/2)+'px';
		document.getElementById('login0').style.top=(document.documentElement.clientHeight/2)-(document.getElementById('login0').offsetHeight/2)+'px';
	}
  } 
}

function IsPay(kname)
{
 
	xmlHttpIs=GetXmlHttpObject();
    var url = "ajaxasp/IsPhotoAdd.asp?kname="+kname+"&rand="+Math.random();
    //window.clipboardData.setData("Text",url);
    xmlHttpIs.open("GET", url, true);
    xmlHttpIs.onreadystatechange = updateIsPay;
    xmlHttpIs.send(null);
    return true;
}
//-----------------------------------------------------------------------------------------------------
//显示相册列表
function updatePage() {
  if (xmlHttp.readyState < 4) {
   document.getElementById("Photo").innerHTML="<img src=images/loader.gif> Loading........";
  }
  if (xmlHttp.readyState == 4) {
    var response = unescape(xmlHttp.responseText);
    document.getElementById("Photo").innerHTML=response;
  } 
}

function ShowPhoto(kname,currentpage)
{
     
	xmlHttp=GetXmlHttpObject();
    var url = "ajaxasp/ShowPhoto.asp?kname="+kname+"&currentpage="+currentpage+"&rand="+Math.random();
    //window.clipboardData.setData("Text",url);
    xmlHttp.open("GET", url, true);
    xmlHttp.onreadystatechange = updatePage;
    xmlHttp.send(null);  
    return true;
}
//----------------------------------------------------------------------------------------------
//分页
function updatePageInfo() {
  if (xmlHttpPI.readyState < 4) {
   document.getElementById("pageinfotop").innerHTML="<img src=../images/loader.gif> Loading......";
   document.getElementById("pageinfobottom").innerHTML="<img src=../images/loader.gif> Loading......";
  }
  if (xmlHttpPI.readyState == 4) {
    var response = unescape(xmlHttpPI.responseText);
	//alert(response);
    document.getElementById("pageinfotop").innerHTML=response;
	document.getElementById("pageinfobottom").innerHTML=response;
  }   
}
//分页函数
function ShowPhotoPage(kname,currentpage)
{
  	xmlHttpPI=GetXmlHttpObject();
    var url = "ajaxasp/Photopage.asp?kname="+kname+"&currentpage="+currentpage+"&rand="+Math.random();
	//window.clipboardData.setData("Text",url);
    xmlHttpPI.open("GET", url, true);
    xmlHttpPI.onreadystatechange = updatePageInfo;
    xmlHttpPI.send(null);  
    return true;
}
//----------------------------------------------------------------------------------------------
//改变分页
function changepageinfo(kname,currentpage,pagecount)
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
		PageNum+="<a href='javascript:void(0)' hideFocus='true' class='Checkbg' onclick='ShowPhoto(\""+kname+"\","+i+");changepageinfo(\""+kname+"\"," +i+ ","+pagecount+");'>"+i+"</a>";
	}
	else
	{
		PageNum+="<a href='javascript:void(0)' hideFocus='true' class='num' onclick='ShowPhoto(\""+kname+"\","+i+");changepageinfo(\""+kname+"\"," +i+ ","+pagecount+");'>"+i+"</a>";
	}
}
PageNum+="</div>";
content="";
	if(pagecount>0)
	{
		if(currentpage==1 && currentpage==pagecount)
		{
			content=content+"<li><a>上一页</a></li><li><a href='javascript:void(0)' hideFocus='true' onblur='ShowPageNum(this);' onclick='ShowPageNum(this);' hidefocus='hidefocus' class='Pagebg'>"+currentpage+"/"+pagecount+"</a>"+PageNum+"</li><li><a>下一页</a></li>";
		}
		else if(currentpage==1 && currentpage<pagecount)
		{
			content=content+"<li><a>上一页</a></li><li><a onclick='ShowPageNum(this);' hidefocus='hidefocus' class='Pagebg'>"+currentpage+"/"+pagecount+"</a>"+PageNum+"</li><li><a href='javascript:void(0)' hideFocus='true' onblur='ShowPageNum(this);' onclick='ShowPhoto(\""+kname+"\","+(currentpage+1)+");changepageinfo(\""+kname+"\"," +(currentpage+1)+ ","+pagecount+");'>下一页</a></li>";
		}
		else if(currentpage>1 && currentpage<pagecount)
		{
			content=content+"<li><a href='javascript:void(0)' hideFocus='true' onclick='ShowPhoto(\""+kname+"\","+(currentpage-1)+");changepageinfo(\""+kname+"\"," +(currentpage-1)+ ","+pagecount+");'>上一页</a></li><li><a href='javascript:void(0)' hideFocus='true' onblur='ShowPageNum(this);' onclick='ShowPageNum(this);' class='Pagebg'>"+currentpage+"/"+pagecount+"</a>"+PageNum+"</li><li><a href='javascript:void(0)' hideFocus='true' onclick='ShowPhoto(\""+kname+"\","+(currentpage+1)+");changepageinfo(\""+kname+"\"," +(currentpage+1)+ ","+pagecount+");'>下一页</a></li>";
		}
		else
		{
			content=content+"<li><a href='javascript:void(0)' hideFocus='true' onclick='ShowPhoto(\""+kname+"\","+(currentpage-1)+");changepageinfo(\""+kname+"\"," +(currentpage-1)+ ","+pagecount+");'>上一页</a></li><li><a href='javascript:void(0)' hideFocus='true' onblur='ShowPageNum(this);' onclick='ShowPageNum(this);' class='Pagebg'>"+currentpage+"/"+pagecount+"</a>"+PageNum+"</li><li><a>下一页</a></li>";
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

function showSetOpen(ObjId)
{
	var Obj=document.getElementById(ObjId);
	if(Obj.style.display=="")
		Obj.style.display="none";
	else
		Obj.style.display="";
}

function ShowOpen(ObjId1,ObjId2)
{
	var Obj1=document.getElementById(ObjId1);
	var Obj2=document.getElementById(ObjId2);
	if(Obj2.style.display==""){
		Obj2.style.display="none";
		Obj1.innerHTML="<a href='javascript:void(0)'>访问权限设置:</a>";
	}
	else{
		Obj2.style.display="";
		Obj1.innerHTML="<a href='javascript:void(0)'>取消访问权设置</a>";
	}
}

function showPassword(ObjId3,ObjId4)
{
	var Obj3=document.getElementById(ObjId3);
	var Obj4=document.getElementById(ObjId4);
	Obj3.style.display="";
	Obj4.disabled="true";
}
function closePassword(ObjId3,ObjId4)
{
	var Obj3=document.getElementById(ObjId3);
	var Obj4=document.getElementById(ObjId4);
	Obj3.style.display="none";
	Obj4.disabled="";
}
function IsDisabled()
{
	var pw1=document.getElementById('pw1');
	var pw2=document.getElementById('pw2');
	var Obj4=document.getElementById('PwOk');
	if(pw1.value==pw2.value)
	{
		Obj4.disabled="";
	}
	else
	{
		Obj4.disabled="true";
	}
}


function ResizeImage(image,width,height,obj)
{
	var Img=new Image();
	Img.src=image.src;
	var w = Img.width;
	var h = Img.height;
	
	if(w/h>= 120/152){
		if(w>120){
			 image.width=width;
			 image.height = parseInt(h*(width/w));
		 }else{
			 image.width=Img.width;
			 image.height=Img.height;
		}
	}
	else{
		if(h>152){
			image.width = parseInt(w*(height/h));
			image.height = height;
		}
		else{
			image.width=Img.width;
			image.height=Img.height;
		}
	}
	 document.getElementById(obj).style.display="";
}

function ViewPhoto(kname,kid)
{
	window.location.href='PhotoPic.asp?kname='+kname+'&Kid='+kid;
}
function JuBao(Obj2)
{
	var obj=document.getElementById("JuBao_layout");
	obj.style.height=document.body.scrollHeight;
	var obj2=document.getElementById(Obj2);
	if (obj.style.display=="none")
	{
		obj.style.display="";
		obj2.style.left=(document.documentElement.clientWidth-parseInt(obj2.style.width))/2+'px';
		obj2.style.top=(document.documentElement.clientHeight-parseInt(obj2.style.height))/2+'px';
		document.getElementById("Buliang").value="";
		obj2.style.display="";
	}
	else
	{
		obj.style.display="none"
		obj2.style.display="none";
	}
}