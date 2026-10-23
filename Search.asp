<!--#include file="./incs/SysCode.asp"-->
<%
	Key=Checkstr(request.Form("search_content"))
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
<title>文件浏览</title>
<link rel="stylesheet" type="text/css" media="all" href="css/common.css" />
<link rel="stylesheet" type="text/css" media="all" href="css/brobox.css" />
<link rel="stylesheet" type="text/css" media="all" href="css/opbutton.css" />
<link rel="stylesheet" type="text/css" media="all" href="css/slidepop.css" />
<script src="js/showpiclist.js" type="text/javascript"></script>
<script type="text/javascript" src="js/showpic.js"></script>
<script type="text/javascript" src="js/function.js"></script>

</head>
<body  style="background-color:#FFFFFF; color:#000000;">

<div class="brotypeTag">
<ul class="tagUl">
<li class="onTag"><strong>文件搜索</strong></li>
</ul>
</div>

<table width="100%" border="0" cellspacing="0" cellpadding="0">
<tr><td height="8"></td></tr>
<tr><td class="cuttentfolder"><div id=CurrentFolder>搜索条件：文件名或文件描述中包含 "<font color=red><%=Key%></font>"</div></td></tr>
<tr><td height="1" bgcolor="#e1e1e1"></td></tr>
</table>

<form name=pics method="post">
<input type=hidden name="upid" value="-1">
<input type=hidden name="kid" value="-1">
<table width="100%" border="0" cellspacing="0" cellpadding="0">

<tr><td width="50" class="bornav"><input type="checkbox" name="chkAll2" onclick="CheckAll(this.form,this);" /> 全选 </td>
<td width=5></td>
<td><div id="operations"><span class="userbutton"><a href="javascript:copyall(pics);" class="xcopy">批量复制</a></span></div></td>
<td></td>
</tr>
</table> 
<div id="box">
<div class="align">
<span id="PicList"></span>
<div class="clear"></div>
</div>
</div>
<table width="100%" border="0" cellspacing="0" cellpadding="0">
<tr>
<td width="50" class="bornav"><input type="checkbox" name="chkAll1" onclick="CheckAll(this.form,this);" /> 全选 </td>
<td width=5></td>
<td><div id="operations"><span class="userbutton"><a href="javascript:copyall(pics);" class="xcopy">批量复制</a></span></div></td>
<td></td>
</tr>
</table>
</form>
<script>
search("<%=Key%>");
</script>

</body>
</html>
