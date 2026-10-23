<!--#include file="incs/syscode.asp"-->
<%
Dim kid
kid=CheckNumeric(request("kid"))
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
<title>批量上传</title>
<link rel="stylesheet" type="text/css" media="all" href="css/common.css" />
<script type="text/javascript" src="js/upload.js"></script>
<script type="text/javascript" src="js/function.js"></script>
<script type="text/javascript">
var rowCount = 5;
var maxRows = 64;

function getNameType(){
	if(document.getElementById('shortpath2').checked) return '2';
	return '0';
}

function syncNameType(){
	var v = getNameType();
	for(var i=1;i<=rowCount;i++){
		var e = document.getElementsByName('shortpath'+i)[0];
		if(e) e.value = v;
	}
}

function addRows(n){
	if(rowCount>=maxRows){ alert('一次最多上传'+maxRows+'个文件！'); return; }
	var c = document.getElementById('filelist');
	for(var j=0;j<n;j++){
		rowCount++;
		if(rowCount>maxRows){ rowCount=maxRows; alert('一次最多上传'+maxRows+'个文件！'); return; }
		var div = document.createElement('div');
		div.className = 'selectitem';
		div.innerHTML = '<b>'+rowCount+'</b> 文件描述 <input type="text" class="text" name="title'+rowCount+'" value="文件'+rowCount+'" size="30" maxlength="30" /> 文件选择 <input type="file" class="text" style="width:280px;" name="AttachFile'+rowCount+'" />';
		var sp = document.createElement('input');
		sp.type = 'hidden';
		sp.name = 'shortpath'+rowCount;
		sp.value = getNameType();
		div.appendChild(sp);
		c.appendChild(div);
	}
	document.upload.no.value = rowCount;
}

function enableAll(){
	for(var i=1;i<=rowCount;i++){
		var f = document.getElementsByName('AttachFile'+i)[0]; if(f) f.disabled = false;
		var t = document.getElementsByName('title'+i)[0]; if(t) t.disabled = false;
		var s = document.getElementsByName('shortpath'+i)[0]; if(s) s.disabled = false;
	}
}

function chkFrm(){
	var exts = "jpg;gif;png;bmp";
	var filled = 0;
	for(var i=1;i<=rowCount;i++){
		var f = document.getElementsByName('AttachFile'+i)[0];
		if(!f) continue;
		if(f.value == ''){
			f.disabled = true;
			var t = document.getElementsByName('title'+i)[0]; if(t) t.disabled = true;
			var s = document.getElementsByName('shortpath'+i)[0]; if(s) s.disabled = true;
		}else{
			var fn = f.value.toLowerCase();
			if(exts.indexOf(fn.substr(fn.length-3,3))<0){
				alert('第'+i+'个文件格式不允许，只能上传 jpg;gif;png;bmp 格式的图片！');
				enableAll();
				return false;
			}
			filled++;
		}
	}
	if(filled==0){
		alert('请至少选择一个文件');
		enableAll();
		return false;
	}
	document.upload.no.value = rowCount;
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
	return true;
}
</script>
</head>
<body onload="FolderOption(<%=kid%>);">
<div class="brotypeTag">
<ul class="tagUl">
<li><a href="upsimp.asp">普通上传</a></li>
<li class="onTag"><b>批量上传</b></li>
</ul>
</div>
<br />
<form name="upload" method="POST" action="upload.asp" ENCTYPE="multipart/form-data" onsubmit="return chkFrm();">
<input type="hidden" name="no" value="5" />
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
	<input name="grouptitle" type="text" class="text" id="grouptitle" size="40" maxlength="30" />&nbsp;&nbsp;  <img src="images/0026.gif" width="14" height="14" /></td>
  </tr>
    <tr>
    <td class="itemlist">
    		上传命名规则
			<input type="radio" name="namesel" onclick="syncNameType();" id="shortpath1" style="height: 19; width: 19" class="input2" checked>
			使用系统重命名(推荐)
			<input type="radio" name="namesel" onclick="syncNameType();" id="shortpath2" style=" height: 19; width:19;" class="input2" >
			保持原文件名不变</td>
</tr>
   <tr>
    <td class="itemlist">是否强行覆盖
      <input name="overall" type="radio" id="radio1" value="1" checked />否
	  <input type="radio" name="overall" id="radio2" value="2" />是（慎用）
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
 	<span id="previewImage"></span><img src="images/0026.gif" width="14" height="14" /></td>
  </tr></table>
<table width="100%" border="0" cellspacing="0" cellpadding="0">
    <tr>
    <td height="32" background="images/0025.gif">
    <span class="itemlist" ><b>上传文件</b> <font color="#9cb8db">( 批量选择本地图片，可多行一起上传 )</font></span>
</td>
  </tr>
  <tr>
  <td id="filelist" class="itemlist">
<div class="selectitem"><b>1</b> 文件描述 <input type="text" class="text" name="title1" value="文件1" size="30" maxlength="30" /> 文件选择 <input type="file" class="text" style="width:280px;" name="AttachFile1" /><input type="hidden" name="shortpath1" value="0" /></div>
<div class="selectitem"><b>2</b> 文件描述 <input type="text" class="text" name="title2" value="文件2" size="30" maxlength="30" /> 文件选择 <input type="file" class="text" style="width:280px;" name="AttachFile2" /><input type="hidden" name="shortpath2" value="0" /></div>
<div class="selectitem"><b>3</b> 文件描述 <input type="text" class="text" name="title3" value="文件3" size="30" maxlength="30" /> 文件选择 <input type="file" class="text" style="width:280px;" name="AttachFile3" /><input type="hidden" name="shortpath3" value="0" /></div>
<div class="selectitem"><b>4</b> 文件描述 <input type="text" class="text" name="title4" value="文件4" size="30" maxlength="30" /> 文件选择 <input type="file" class="text" style="width:280px;" name="AttachFile4" /><input type="hidden" name="shortpath4" value="0" /></div>
<div class="selectitem"><b>5</b> 文件描述 <input type="text" class="text" name="title5" value="文件5" size="30" maxlength="30" /> 文件选择 <input type="file" class="text" style="width:280px;" name="AttachFile5" /><input type="hidden" name="shortpath5" value="0" /></div>
  </td>
  </tr>
  <tr>
    <td class="itemlist">
	<input type="button" value="再加5行" class="btnt2" onclick="addRows(5);" />&nbsp;&nbsp;
	<font color="red">提示：单次最多上传64个文件；如上传图片尺寸大于1600*1600系统将自动将图片压缩到1600，若不希望压缩请使用普通上传。</font>
	</td>
  </tr>
<tr>
<td height="1" bgcolor="#CBCBCB"></td>
</tr>
<tr>
    <td class="subitem"><input id="upbt" name="upbt" type="submit" value="上传" class="btnt2" />&nbsp;&nbsp;
	<input type="reset" value="恢复为默认" class="btnt6" /></td>
  </tr>
</table>
</form>
</body>
</html>
