<!--#include file="./incs/SysCode.asp"-->
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<meta http-equiv="x-ua-compatible" content="ie=7" />
<title>登陆首页</title>
<link rel="stylesheet" type="text/css" media="all" href="css/common.css" />

 
<script>
<%
'response.Write "var xmlPath=""/xmltemp/"&username&RandName&".xml"""
%>
</script>
<script type="text/javascript">
	//function fugai(){
//	if(top.document.body.scrollHeight>top.document.body.clientHeight)
//	{
//		top.document.getElementById("fugai_layout").style.height=top.document.body.scrollHeight;
//	}
//	else
//	{
//		top.document.getElementById("fugai_layout").style.height=top.document.body.clientHeight;
//	}
//	top.document.getElementById("fugai_layout").style.width=top.document.body.scrollWidth;
//	top.document.getElementById("fugai_layout").style.display="block";
//	}
//	
//	
//	var xmlHttp;
//	function GetXmlHttpObject()
//	{
//		var xmlHttp=null;
//		try
//		  {
//		  // Firefox, Opera 8.0+, Safari
//		  xmlHttp=new XMLHttpRequest();
//		  }
//		catch (e)
//		  {
//		  // Internet Explorer
//		  try
//			{
//			xmlHttp=new ActiveXObject("Msxml2.XMLHTTP");
//			}
//		  catch (e)
//			{
//			xmlHttp=new ActiveXObject("Microsoft.XMLHTTP");
//			}
//		  }
//		return xmlHttp;
//	}
//
//	var percent;
//	percent=0;
//	 
//	 
//	function ReadTempPic()
//	{		
//		if(confirm('在FTP文件夹里发现有新的图片！\n\n是否现在导入1DY图库？')) 
//		{
//			var objProgress = top.document.getElementById("daorupic");
//	objProgress.style.top = top.document.body.scrollTop+(top.document.body.clientHeight-top.document.getElementById("daorupic").offsetHeight)/2-100;
//	objProgress.style.left = top.document.body.scrollLeft+(top.document.body.clientWidth-top.document.getElementById("daorupic").offsetWidth)/2-150;
//	objProgress.style.display="block";
//			
//			 xmlHttpRD=GetXmlHttpObject();
//			var url = "ajaxasp/ReadTemp.asp?XmlPath="+xmlPath+"&Rand="+Math.random();
//			//window.clipboardData.setData("Text",url);
//			xmlHttpRD.open("GET", url, true);
//			xmlHttpRD.onreadystatechange = updateReadTemp;
//			xmlHttpRD.send(null);		
//		}
//		else
//		{
//			top.document.getElementById("fugai_layout").style.display="none";
//		}
//	}
//	function updateReadTemp()
//	{
//		  var timer=setTimeout("DisplayProgressBar('" + xmlPath + "')",500);
//		  if (xmlHttpRD.readyState == 4) {
//			var response = unescape(xmlHttpRD.responseText);
//			if (response.indexOf("超时")==0)
//			{    
//				alert("超时");
//				window.location="index.asp";
//			}
//			else if(response.indexOf("成功")>=0)
//			{
//				top.document.getElementById("fugai_layout").style.display="none";
//				top.document.getElementById("daorupic").style.display="none";			
//				top.document.getElementById("usesize").innerHTML=response.substr(2,100);
//				window.open("maininfo.asp","_self","");
//			}
//		  }
//	}
//	
//	function DisplayProgressBar(xmlPath){
//		var xmlDoc = new ActiveXObject("Msxml2.DOMDocument.3.0");
//		xmlDoc.async = false;
//		xmlDoc.load(xmlPath);
//		if (xmlDoc.parseError.errorCode!=0){
//			var error = xmlDoc.parseError;
//			var timer=setTimeout("DisplayProgressBar('" + xmlPath + "')",1000);
//			return;
//		}
//		var root = xmlDoc.documentElement;   //根节点
//		percent = root.childNodes(2).text;
//		top.document.getElementById("ProgressPercent").innerHTML  = percent + "%";
//		if(percent==100){
//			clearInterval(timer);
//		}else{
//			var timer=setTimeout("DisplayProgressBar('" + xmlPath + "')",1000);
//		}
//	}	
</script>
</head>
<body>
<table width="100%" border="0" cellpadding="0" cellspacing="0"><tr><td height=59 valign="bottom" background="images/0018.gif"><table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td>&nbsp; &nbsp;<font class="uhello"><em><script src="js/hello.js" type="text/javascript"></script></em><%=request.cookies("1dy")("UserName")%></font>&nbsp; [ <a href="pay.asp" target="_top">快捷续费</a>，<a href="pay.asp" target="_top">扩容升级</a> ]</td>
    <td align="right"><table width="200" border="0" cellspacing="0" cellpadding="0">
      <tr>
        <td align="center">已用比例:<%=bili%>%</td>
        <td align="left" class="cap" valign="top"><img src="images/0009.gif" width="<%=bili%>" height="13" /></td>
        <td width="10">　</td>
      </tr>
    </table></td>
  </tr>
  <tr>
    <td height="26">&nbsp; &nbsp; <img src="images/0007.gif" width="16" height="12" align="absmiddle" /> &nbsp;<span class="STYLE1">[无限通]<%=FolderCountSize%>/￥<%=jiage%>/
	<%if fflx=1 then
	 response.write "年"
	 elseif fflx=2 then
	 response.write "月"
	 end if
	 %></span></td>
    <td align="right" class="STYLE1"><script src="js/date.js" type="text/javascript"></script> &nbsp;</td>
  </tr>
</table></td></tr>
  <tr>
    <td height="1" bgcolor="#c6c6c6"></td>
  </tr>
  </table>

<table width="100%" border="0" cellspacing="0" cellpadding="0" style="margin-top:10px;">
<tr>
<td width="370" valign="top" style="padding-left:25px; padding-right:15px;">
<table border="0" cellpadding="0" cellspacing="0" width="350">
<tr>
<td class="tabon" id="tabmmm01" style="cursor:hand;padding:6px; width:80px;" align="center">用户公告</td>
<td class="taboff" align="center">&nbsp;</td>
<td class="taboff" align="center">&nbsp;</td>
<td class="taboff" style="border-right: 1px solid #e3e3e3;" align="center">&nbsp;</td></tr>
<tr><td height="202" colspan="6" class="tdbody" align="center" valign="top">
<div id="cmmm01"><!-- inc01 start -->
<table width="100%" border="0" cellspacing="0" cellpadding="0" background="images/0077.gif">
<% 
	dim i
	i=69
	set rs=server.CreateObject("adodb.recordset")
	rs.open "select top 6 * from ydy_notice where classType=1 order by istop desc,id desc",conn,1,1
	if rs.eof or rs.bof then
		response.Write "<tr><td style='background:url(images/0069.gif) no-repeat 3px 5px; line-height:24px; padding-left:22px; ' align='left'>暂无公告</td></tr>"
	else
		ftile=""	
		do while not rs.eof
		if rs("istop")="1" then 
		ftile="<font color=red>置顶</font>&nbsp;&nbsp;&nbsp;"
		end if
		response.Write "<tr><td style='background:url(images/00"&i&".gif) no-repeat 3px 5px; line-height:24px; padding-left:22px; ' align='left'>"&ftile&"<a href='note_show.asp?id="&rs("id")&"' target='_blank'>"&rs("title")&"</a></td></tr>"
		rs.movenext
		ftile=""
		i=i+1
		loop		
	end if
	rs.close
	set rs=nothing
%>
</table>
<!-- inc01 over --></div>

</td></tr>
</table>
<br />
<table width="350" border="0" cellspacing="0" cellpadding="0" style="border: 1px solid #c2c2c2; background-color:#f5f5f5; padding:6px;">
  <tr>
    <td align="center">
	<script src="js.asp?num=1&ltype=7&kind=Pic&width=336&height=100&css_td=bbb&css_pic=mainpic&hnum=1"></script>
	</td>
  </tr>
</table>
</td>
    <td width="18"><img src="images/0060.gif" width="1" height="367" /></td>
    <td valign="top">  
<%
	dim pic,link,text
	set rs=server.CreateObject("adodb.recordset")
	sql="select top 5 [sitename],[siteurl],[logourl] from ydy_ad where ltype=6 order by id desc"
	rs.open sql,conn,1,1
	if rs.eof or rs.bof then
		response.Write "暂无此位置广告"
	else
		do while not rs.eof
			pic=pic&rs("logourl")&"|"
			link=link&rs("siteurl")&"|"
			text=text&rs("sitename")&"|"
		rs.movenext
		loop
		rs.close
		set rs=nothing
	end if
	img=left(pic,len(pic)-1)
	url=left(link,len(link)-1)
	text=left(text,len(text)-1)
%>
<div id="ff1dy" style="width:290px;height:230px;overflow:hidden;background:#000;"></div>
<script type="text/javascript">
(function(){
var pics="<%=img%>",links="<%=url%>",texts="<%=text%>";
var box=document.getElementById("ff1dy");
if(!pics){box.innerHTML="\u6682\u65e0\u6b64\u4f4d\u7f6e\u5e7f\u544a";return;}
var pArr=pics.split("|"),lArr=links.split("|"),tArr=texts.split("|");
var idx=0,timer=null;
function render(){
var html="";
for(var i=0;i<pArr.length;i++){
var op=(i==idx)?"block":"none";
var lk=lArr[i];if(lk=='#'||lk==''){html+='<span title="'+tArr[i]+'" style="display:'+op+';width:290px;height:230px;line-height:230px;text-align:center;background:#000;"><img src="'+pArr[i]+'" style="max-width:290px;max-height:230px;vertical-align:middle;border:0;" alt="'+tArr[i]+'"/></span>';}else{html+='<a href="'+lk+'" target="_blank" title="'+tArr[i]+'" style="display:'+op+';width:290px;height:230px;line-height:230px;text-align:center;background:#000;"><img src="'+pArr[i]+'" style="max-width:290px;max-height:230px;vertical-align:middle;border:0;" alt="'+tArr[i]+'"/></a>';}
}
box.innerHTML=html;
}
function next(){idx=(idx+1)%pArr.length;render();}
timer=setInterval(next,4000);
box.onmouseover=function(){clearInterval(timer);timer=null;};
box.onmouseout=function(){if(!timer)timer=setInterval(next,4000);};
render();
})();
</script>

<br /><br />
<table width="290" border="0" cellspacing="0" cellpadding="0" style="border: 1px solid #c2c2c2; background-color:#f5f5f5; padding:6px;">
<tr>
<td align="center">
<script src="js.asp?num=1&ltype=8&kind=Pic&width=336&height=100&css_td=bbb&css_pic=mainpic&hnum=1"></script>
</td>
</tr>
</table>
</td>
</tr>
</table>
<%
'dim FolderTempSize
'set fso=new dmfso
 	'FolderTempSize=fso.GetFolderInfo(CreatTemp,7)'Ftp所占空间大小
'set fso=nothing

'if FolderTempSize>0 then
%>
<script language='javascript'>
//window.onload=function(){
//	ReadTempPic();
//	}
</script>
<%
'else
if Request.Cookies("1dy")("yjf")=0 and workday<=0 then
	call tixing(0)
elseif workday<10 and Request.Cookies("1dy")("yjf")=1 then
	call tixing(1)
elseif Request.Cookies("1dy")("yjf")=2  then
	call tixing(3)
elseif daxiao>SysNotic  then
	call tixing(2)
elseif Request.Cookies("1dy")("yjf")=0 and workday>0 then
	call tixing(4)
elseif Request.Cookies("1dy")("yjf")=1 then
	call tixing(5)
end if
'end if
sub Tixing(id)
	if Not GetIsNull(Request.Cookies("1dy")("fate")) and Request.Cookies("1dy")("fate")=0 then
		response.Cookies("1dy")("fate")=1
		response.Write "<script language='javascript'>"
		response.Write "fugai();"
		'response.Write "top.document.getElementById('fugai_layout').style.display='';"
		response.Write "top.document.getElementById('login"&id&"').style.display='';"
		response.Write "top.document.getElementById('login"&id&"').style.left=(top.document.body.clientWidth/2)-(top.document.getElementById('login"&id&"').offsetWidth/2)+'px';"
		response.Write "top.document.getElementById('login"&id&"').style.top=(top.document.body.clientHeight/2)-(top.document.getElementById('login"&id&"').offsetHeight/2)+'px';"
		response.write "</script>"		
	end if
end sub
%>
 
</body>
</html>
