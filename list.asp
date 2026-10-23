<!--#include file="./incs/SysCode.asp"-->
<%
kid=CheckNumeric(request("kid"))
klevel=CheckNumeric(request("klevel"))
upid=CheckNumeric(request("upid"))
types=CheckNumeric(request("type"))
currentpage=CheckNumeric(request("currentpage"))
if currentpage=0 then currentpage=1
%>
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

<script src="js/showpiclist.js" type="text/javascript"></script>
<script src="js/showpic.js" type="text/javascript"></script>
<script language="javascript" src="js/overtip.js"></script>
<script type="text/javascript" src="js/function.js"></script>

</head>
<body  style="background-color:#FFFFFF; color:#000000;">

<div class="brotypeTag">
<ul class="tagUl">
<li><a id="viewhref" href="main.asp?type=1">缩略图浏览</a></li>
<li class="onTag"><strong>列表浏览</strong></li>
<li><a href="top50.asp">最新上传50</a></li>
<%if SysUpLoadType=0 then%>
<li style="width:140px;"><a href="upsimp.asp?kid=<%=kid%>">上传文件到该目录</a></li>
<%elseif SysUpLoadType=1 then%>
<li style="width:140px;"><a href="upftp.asp?kid=<%=kid%>">上传文件到该目录</a></li>
<%end if%>
</ul>
</div>

<table width="100%" border="0" cellspacing="0" cellpadding="0">
<tr><td height="8"></td></tr>
<tr><td class="cuttentfolder"><div id=CurrentFolder></div></td></tr>
<tr><td height="1" bgcolor="#e1e1e1"></td></tr>
</table>
<form name=pics method="post">

<table width="100%" border="0" cellspacing="0" cellpadding="0">

<input type=hidden name="upid" value="<%=upid%>">
<input type=hidden name="kid" value="<%=kid%>">
<tr>
<td width="50" class="bornav"><input type="checkbox" name="chkAll3" onclick="CheckAll(this.form,this);" /> 全选 </td>
<td width=50><span id="FolderOptiontop"></span>&nbsp;</td>
<td><div id="operations"><span class="userbutton"><a href="javascript:removeall(pics,2,<%=klevel%>);" class="remove">批量转移</a></span><span class="userbutton"><a href="javascript:deleteall(pics,2,<%=klevel%>);" class="delete">批量删除</a></span> <span class="userbutton"><a href="javascript:copyall(pics);" class="xcopy">批量复制</a></span></div></td>
<td><div id="PageInfotop"></div></td>
</tr>
</table>
<table class="dirlist">
<tr>
<th width="50"><div>&nbsp; 类型</div></th>
<th width=30%><div>文件名/文件夹名</div></th>
<th width=18%><div>占用空间/文件数</div></th>
<th width=18%><div>上传日期</div></th>
<th><div>操作</div></th>
</tr></table>

<div id="FolderList">
<table class="dirlist1">
<%
	set rs=server.CreateObject("adodb.recordset")
	rs.open "select [kid],[kname],[kcount] from [Liu_Folder] where upid="&kid&" and kuser='"&UserName&"' order by kid asc",conn,1,1
	if not rs.eof or not rs.bof then
	do while not rs.eof
%>
<tr onMouseOver='this.bgColor="#eef5ff"' onMouseOut='this.bgColor="#FFFFFF"'>
<td width="50"><input disabled type="checkbox" name="checkbox3" id="checkbox3" /> 
<img src="images/0040.gif" width="16" height="14" align="absmiddle" />
</td>
<td width=30%><a href="list.asp?type=2&kid=<%=rs("kid")%>"><%=left(rs("kname"),18)%></a></td>
<td width=18%>文件<%=rs("kcount")%>个</td>
<td width=18%>-</td>
<td><a href="list.asp?type=2&kid=<%=rs("kid")%>">进文件夹</a></td>
</tr>
<%
	rs.movenext
	loop
	end if
	rs.close
	set rs=nothing
%>
</table>
</div>

<div id="PicList"></div>
<div id="piccontent"></div>


<table width="100%" border="0" cellspacing="0" cellpadding="0">
<tr><td height="1" bgcolor="#e1e1e1" colspan="4"></td></tr>
<tr>
<td width="50" class="bornav"><input type="checkbox" name="chkAll1" onclick="CheckAll(this.form,this);" /> 全选 </td>
<td width=50><span id="FolderOptionbottom"></span>&nbsp;</td>
<td><div id="operations"><span class="userbutton"><a href="javascript:removeall(pics,2,<%=klevel%>);" class="remove">批量转移</a></span><span class="userbutton"><a href="javascript:deleteall(pics,2,<%=klevel%>);" class="delete">批量删除</a></span> <span class="userbutton"><a href="javascript:copyall(pics);" class="xcopy">批量复制</a></span></div></td>
<td><div id="PageInfobottom"></div></td>
</tr>
<input name="kindtext" id="kindtext" type="hidden" value="<%=kid%>" />

</table>
</form>

<script>
CurrentFolder(<%=kid%>,<%=klevel%>,<%=upid%>,3);
PageInfo(<%=kid%>,<%=currentpage%>,<%=types%>);
FolderOption(<%=upid%>);
PicList(<%=kid%>,<%=currentpage%>,<%=types%>);

</script>

</body>
</html>
