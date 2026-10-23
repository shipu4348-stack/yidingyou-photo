<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
<meta http-equiv="x-ua-compatible" content="ie=7" />
<title>文件浏览</title>
<link rel="stylesheet" type="text/css" media="all" href="css/common.css" />
<link rel="stylesheet" type="text/css" media="all" href="css/brobox.css" />
<link rel="stylesheet" type="text/css" media="all" href="css/opbutton.css" />
<link rel="stylesheet" type="text/css" media="all" href="css/slidepop.css" />
<script src="js/search.js" type="text/javascript"></script>
<script src="js/showpiclist.js" type="text/javascript"></script>
<script type="text/javascript" src="js/showpic.js"></script>
<script type="text/javascript" src="js/function.js"></script>

</head>
<body  style="background-color:#FFFFFF; color:#000000;">

<div class="brotypeTag">
<ul class="tagUl">
<li><a href="main.asp?type=1">缩略图浏览</a></li>
<li><a href="list.asp?type=2">列表浏览</a></li>
<li class="onTag"><strong>最新上传50</strong></li>
<%if SysUpLoadType=0 then%>
<li style="width:140px;"><a href="upsimp.asp">上传文件到该目录</a></li>
<%elseif SysUpLoadType=1 then%>
<li style="width:140px;"><a href="upftp.asp">上传文件到该目录</a></li>
<%end if%>
</ul>
</div>
<form name=pics method="post">
<input type=hidden name="upid" value="0">
<input type=hidden name="kid" value="0">
<table width="100%" border="0" cellspacing="0" cellpadding="0">

<tr><td width="50" class="bornav"><input type="checkbox" name="chkAll2" onclick="CheckAll(this.form,this);" /> 全选 </td>
<td width=5></td>
<td><div id="operations"><span class="userbutton"><a href="javascript:DelSearchAll(pics,6);"  class="delete">批量删除</a></span> <span class="userbutton"><a href="javascript:copyall(pics);" class="xcopy">批量复制</a></span></div></td>
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
<td><div id="operations"><span class="userbutton"><a href="javascript:DelSearchAll(pics,6);" class="delete">批量删除</a></span> <span class="userbutton"><a href="javascript:copyall(pics);" class="xcopy">批量复制</a></span></div></td>
<td></td>
</tr>
</table>
</form>
<script>
ShowTopList();
</script>
</body>
</html>
