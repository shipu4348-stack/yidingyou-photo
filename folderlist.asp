<!--#include file="./incs/SysCode.asp"-->
<%
dim upid,klevel,kpath
upid=CheckNumeric(request("upid"))
klevel=CheckNumeric(request("klevel"))
kpath=Checkstr(request("kpath"))
if GetIsNull(kpath) then kpath="/"
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
<meta http-equiv="x-ua-compatible" content="ie=7" />
<title>文件夹管理</title>
<link rel="stylesheet" type="text/css" media="all" href="css/common.css" />
<script type="text/javascript" src="js/folderlist.js"></script>
<script type="text/javascript">
function changefoldername(kid,kname)
{
	alert('改名将导致外链的图片无法访问,请谨慎操作！');
	document.getElementById("inputK"+kid).style.display="block";
	document.getElementById("k"+kid).style.display="none";
	document.getElementById("modbk"+kid).style.display="block";
	document.getElementById("divk"+kid).style.display="none";
}

function cancelchangefoldername(kid)
{
	document.getElementById("inputk"+kid).style.display="none";
	document.getElementById("k"+kid).style.display="block";
	document.getElementById("modbk"+kid).style.display="none";
	document.getElementById("divk"+kid).style.display="block";
}

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

function checkCF(){
	var _obj=document.createfolder;
	if (_obj.kname.value == "" ){
		alert("大小也得给个名呀！");
		_obj.kname.focus();
	}else{
		if(isLegal(_obj.kname.value)){
			createmyfolder(_obj.kname.value,_obj.upid.value,_obj.klevel.value,_obj.kpath.value);
		}else{
			alert('请勿使用非法字符！');
			_obj.kname.value="";
			_obj.kname.focus();
			}
	}
}
</script>
</head>
<body onload="CurrentFolder(<%=upid%>,<%=klevel%>);ShowFolder(<%=upid%>,1);PageInfo(<%=upid%>,1)">

<table width="100%" border="0" cellpadding="0" cellspacing="0">
  <tr>
    <td height="40" valign="bottom" background="images/0018.gif" class="emm">文件夹管理</td>
  </tr>
</table>
<table width="100%" border="0" cellspacing="0" cellpadding="0">
<tr>
    <td height="1" colspan="2" bgcolor="#e1e1e1"></td>
  </tr>
  <tr><td colspan="2" class="dirnotice">注意：一定呦创建的文件夹为虚拟文件夹，相当于分类，不是真实的文件夹，因此不同的文件夹内的文件也不能重名。</td></tr>
  <tr>
    <td height="1" colspan="2" bgcolor="#e1e1e1"></td>
  </tr>
<tr>  
    <td class="makdir"><div id=CurrentFolder></div></td>
	<form name="createfolder" method="post"> 
    <td>文件夹操作	   
	<input name="kname" type="text" class="makdir" id="textfield" size="30" maxlength="30" />
	&nbsp;
	<input type="hidden" name="upid" value="<%=upid%>">
	<input type="hidden" name="klevel" value="<%=klevel%>">
    <input type="hidden" name="kpath" value="<%=kpath%>">
	<input name="create" type="button" value="创建" class="btnt2" onclick="checkCF();" />
	&nbsp;
	<input type="button" value="查找" class="btnt2" />	
</td>
</form>
</tr>
</table>
<div id="folderlist"></div>
  <table width="100%" height=40 border="0" cellspacing="0" cellpadding="0">
    <tr>
      <td align="right"><div id="PageInfobottom"></div></td>
    </tr>
  </table>
</body>
</html>