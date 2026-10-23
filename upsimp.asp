<!--#include file="incs/syscode.asp"-->
<%
Dim kid
kid=CheckNumeric(request("kid"))
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
<title>普通上传</title>
<link rel="stylesheet" type="text/css" media="all" href="css/common.css" />
<script type="text/javascript" src="js/upload.js"></script>
<script type="text/javascript" src="js/function.js"></script>
<script type="text/javascript">
function showmark(){
    document.getElementById('mark').style.display = "";
}
function closemark(){
    document.getElementById('mark').style.display = "none";
}
function setid(){
	str='';
	var objFrms=document.upload;
	
	if(!objFrms.no.value)
	objFrms.no.value=1;
	upnum=objFrms.no.value;
	for(i=1;i<=objFrms.no.value;i++)
	{
	
	  str+='<div class="selectitem" style="padding-top:3px;"><b>'+i+'</b>文件描述 '
	  str+='<input type="text" class="text" name="title'+i+'" value="文件'+i+'" size="41" maxlength="30"></div>';
	  str+=' <div class="selectitem">上传命名规则 <input type="radio" name="shortpath'+i+'" value="0"';
	 if(objFrms.shortpath1[0].checked)
	 {
	 	str+=' checked ';
	 }
	 str+=' > 系统重命名（推荐）';
	 str+=' <input type="radio" name="shortpath'+i+'" value="2" style=" height: 19; width:19;" class="input2"';
	 if(objFrms.shortpath1[1].checked)
	 {
	 	str+=' checked';
	 }
		str+=' > 保持原文件名不变</div>';
		str+='<div class="selectitem" style="background-color:#fafafa;"><b>'+i+'</b>文件选择 ';
		str+='<input type ="File" style="width:300px; height:22px;" class="text" name=AttachFile'+i+'><span id="info'+i+'"></span></div>';
	}
	document.getElementById("upid").innerHTML=str+'';
 }
</script>

<script language="javascript">
function chkFrm(){
  var upnum=0;
  var upcount=0;
  var objFrm=document.upload;
  
  var exts="jpg;gif;png;bmp";

  var filename;
  var tempstr="";
  var obj;
  var errornum=0;
   
  for (var i=0;i<objFrm.elements.length;i++)
  {
	  var e = objFrm.elements[i];
	  if (e.name!="")
	  {
		  if(e.name.indexOf("AttachFile")>=0)
		  {
			filename=e.value;
			tempstr=tempstr+filename;
			if(exts.indexOf(filename.toLowerCase().substr(filename.length-3,3))<0)
			{
				document.getElementById("info"+e.name.substr(10,1)).innerHTML="&nbsp; <font color=red>错误：现允许上传文件类型为jpg;gif;png;bmp！</font>";
				errornum=errornum+1;
		    }
		    else
		    {
			   document.getElementById("info"+e.name.substr(10,1)).innerHTML="";
		    }
			upnum+=1;
	      }		  
       }
  }

  if(tempstr=="")
  {
	   alert("请选择一个文件");
	   objFrm.AttachFile1.focus();
	   return false;
  }

  if(errornum>0)
  {
  	return false;
  }
  else
  {
  	objFrm.no.value=upnum;
	objFrm.upbt.disabled=false;
    objFrm.action = "upload.asp";
    objFrm.submit();
	 if(top.document.body.scrollHeight>top.document.body.clientHeight)
    {
    top.document.getElementById("fugai_layout").style.height=top.document.body.scrollHeight;
	top.document.getElementById("showmessage").style.top=(top.document.body.scrollHeight/2)-(top.document.getElementById("showmessage").offsetHeight/2)+'px';
    }
    else
    {
    top.document.getElementById("fugai_layout").style.height=top.document.body.clientHeight;
	top.document.getElementById("showmessage").style.top=(top.document.body.clientHeight/2)-(top.document.getElementById("showmessage").offsetHeight/2)+'px';
    }
    top.document.getElementById("fugai_layout").style.width=top.document.body.scrollWidth;
    top.document.getElementById("fugai_layout").style.display="block";
	top.document.getElementById("showmessage").style.left=(top.document.body.scrollWidth/2)-(top.document.getElementById("showmessage").offsetWidth/2)+"px";
    top.document.getElementById("showmessage").style.display="block";
  }
    return true;
}
</script>
</head>

<body onload="FolderOption(<%=kid%>);">
<div class="brotypeTag">
<ul class="tagUl">
<li class="onTag"><b>普通上传</b></li>
<li><a href="upftp.asp">批量上传</a></li>
</ul>
</div>

<br />
<form name="upload" method="POST" target="_self" action="upload.asp" ENCTYPE="multipart/form-data">
<table width="100%" border="0" cellspacing="0" cellpadding="0">
    <tr>
    <td height="32" background="images/0025.gif"><span class="itemlist"><b>可选上传设置</b></span></td>
  </tr>
<tr>
    <td bgcolor="#fafafa" class="itemlist" >选择存放目录
 <span id="FolderOption"></span><input type='hidden' id='kindtext' value=''>&nbsp; <img src="images/0026.gif" width="14" height="14" /></td>
  </tr>
    <tr>
    <td bgcolor="#fafafa" class="itemlist">该组描述设置 
	<input name="grouptitle" type="text" class="text" id="textfield" size="40" maxlength="30" />&nbsp;&nbsp;  <img src="images/0026.gif" width="14" height="14" /></td>
  </tr>
   <tr>
    <td class="itemlist">是否强行覆盖
      <input name="overall" type="radio" id="radio" value="1" checked />
		否
	  <input type="radio" name="overall" id="radio2" value="ON" />
		是（慎用）
		</td>
  </tr>
      <tr>
    <td class="itemlist">上传水印设置
<input onclick="javascript:closemark();" type="radio" name="shuiyinset" id="shuiyinset1" checked value="1">不使用水印 <input onclick="javascript:closemark();ShowMark();" type="radio" name="shuiyinset" id="shuiyinset2" value="0">使用文字水印 <input onclick="javascript:showmark();ShowLogo();" type="radio" id="shuiyinset3" name="shuiyinset" value="2">使用图片水印
  <img src="images/0026.gif" width="14" height="14" /></td></tr>
   </table>
   <table width="100%" border="0" cellspacing="0" cellpadding="0" id="mark" style="DISPLAY: none">
    <tr>
    <td class="itemlist">水印图片设置
 	<span id=showlogo></span>
 	<img src="images/0026.gif" width="14" height="14" /></td>
  </tr></table>
<table width="100%" border="0" cellspacing="0" cellpadding="0">
 
    <tr>
    <td height="32" background="images/0025.gif"><span class="itemlist"><b>必选上传设置</b> <font color="#9cb8db">( 建议上传图片类型为JPG,GIF,PNG，不建议使用BMP类型 )</font></span>
</td>
  </tr>
   <tr>
     <td bgcolor="#fafafa" class="itemlist">设定上传数量
       <input name="no" id="no" type="text" class="text" size="2" maxlength="1"  onkeyup="this.value=this.value.replace(/\D/g,'')" value="3" />
       <input type="button" value="设定数量" class="btnt2" onClick="setid();" /></td>
   </tr>
<tr>
<td id="upid">  
<div class="selectitem"><b>1</b>文件描述 <input name="title1" type="text" class="text" id="textfield2" value="文件1" size="41" maxlength="30" /></div>    
<div class="selectitem">上传命名规则 <input name="shortpath1" type="radio" id="radio3" value="0" checked /> 系统重命名（推荐）
<input type="radio" name="shortpath1" id="radio4" value="2" />
保持原文件名不变 </div>
<div class="selectitem" style="background-color:#fafafa;"><b>1</b>文件选择 <input type="File" name="AttachFile1" style="width:300px; height:22px;" class="text"  /><span id="info1"></span></div>
</td></tr>
<tr>
<td height="1" bgcolor="#CBCBCB"></td>
</tr>
<tr>
    <td class="subitem"><input id="upbt" name="upbt" type="button" value="上传" class="btnt2" onclick="return chkFrm();" />&nbsp;&nbsp;
	<input type="reset" value="恢复为默认" class="btnt6" /></td>
  </tr>
</table>
</form>
</body>
</html>