<!--#include file="./incs/SysCode.asp"-->
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
<title>个人喜好设置</title>
<link rel="stylesheet" type="text/css" media="all" href="css/setting.css" />

</head>
<body>
<%
Dim Action 
Action=Request("Action")
If Action="" Then
%>
<table width="100%" border="0" cellpadding="0" cellspacing="0">
  <tr>
    <td height="40" valign="bottom" background="images/0018.gif" class="em">系统设置</td>
  </tr>
  <tr>
    <td height="1" bgcolor="#c6c6c6"></td>
  </tr>
</table>
<ul id="sets_nav">
  <li id="first" class="inpos"><a href="setsys.asp">个人喜好设置</a></li>
  <li><a href="setmark.asp">水印设置</a></li>
  <li><a href="setacinfo.asp">帐户信息</a></li>
  <li><a href="setpass.asp">密码修改</a></li>
  <li><a href="setoth.asp">帮助中心</a></li>
</ul>
<br />
<table width="100%" border="0" cellspacing="0" cellpadding="0">
<form action="setsys.asp?action=save" method="post" target="UPresult">
  <tr>
    <td height="1" bgcolor="#e1e1e1"></td>
  </tr>
    <tr>
    <td bgcolor="#fafafa" class="itemlist">登录容量使用比例提醒 <img src="images/0026.gif" width="14" height="14" /></td>
  </tr>
  <tr>
    <td class="itemlist">
<input type="radio" name="notice" id="radio" <%If SysNotic=50 Then response.Write("checked")%> value="50" />50% 
<input type="radio" name="notice" id="radio2" <%If SysNotic=80 Then response.Write("checked")%> value="80"  />80% 
<input type="radio" name="notice" id="radio3" <%If SysNotic=90 Then response.Write("checked")%> value="90"  />90% 
<input type="radio" name="notice" id="radio4" <%If SysNotic=95 Then response.Write("checked")%> value="95"  />95% 
<input type="radio" name="notice" id="radio5" <%If SysNotic=100 Then response.Write("checked")%> value="100" />不提醒</td>
  </tr>
    <tr>
      <td height="1" bgcolor="#e1e1e1"></td>
  </tr>
  <tr>
    <td bgcolor="#fafafa" class="itemlist">缩略图浏览方式浏览下标选项 <img src="images/0026.gif" width="14" height="14" /></td>
  </tr>
    <tr>
    <td class="itemlist"><input type="radio" name="displaytype" id="radio" <%If SysDisplayType=0 Then response.Write("checked")%> value="0"/>
      文件名下标 
        <input type="radio" name="displaytype" id="radio2" <%If SysDisplayType=1 Then response.Write("checked")%> value="1"  />
文件描述下标</td>
  </tr>
      <tr>
    <td height="1" bgcolor="#e1e1e1"></td>
  </tr>
      <tr>
    <td bgcolor="#fafafa" class="itemlist">每页显示文件数量 <img src="images/0026.gif" width="14" height="14" /></td>
  </tr>
    <tr>
    <td class="itemlist">
<input type="radio" name="pagecount" id="radio" value="15" <%If SysPageCount=15 Then response.Write("checked")%>  />15条 
<input type="radio" name="pagecount" id="radio" value="30" <%If SysPageCount=30 Then response.Write("checked")%>  />30条 
<input type="radio" name="pagecount" id="radio2" value="50" <%If SysPageCount=50 Then response.Write("checked")%> />50条 
<input type="radio" name="pagecount" id="radio3" value="60" <%If SysPageCount=60 Then response.Write("checked")%> />60条 
<input type="radio" name="pagecount" id="radio4" value="80" <%If SysPageCount=80 Then response.Write("checked")%>  />80条 
<input type="radio" name="pagecount" id="radio5" value="100" <%If SysPageCount=100 Then response.Write("checked")%>  />100条</td>
  </tr>
      <tr>
    <td height="1" bgcolor="#e1e1e1"></td>
  </tr>
      <tr>
    <td bgcolor="#fafafa" class="itemlist">默认文件浏览模式 <img src="images/0026.gif" width="14" height="14" /></td>
  </tr>
    <tr>
    <td class="itemlist">
<input type="radio" name="viewtype" id="radio" value="0" <%If SysViewType=0 Then response.Write("checked")%> />
      缩略图浏览
<input type="radio" name="viewtype" id="radio" value="1"  <%If SysViewType=1 Then response.Write("checked")%> />
      列表浏览 
<input type="radio" name="viewtype" id="radio" value="2" <%If SysViewType=2 Then response.Write("checked")%>  />
最新上传50
        </td>
  </tr>
      <tr>
    <td height="1" bgcolor="#e1e1e1"></td>
  </tr>
      <tr>
    <td bgcolor="#fafafa" class="itemlist">默认上传方式 <img src="images/0026.gif" width="14" height="14" /></td>
  </tr>
    <tr>
    <td class="itemlist">
<input type="radio" name="uploadtype" id="radio" value="0"  <%If SysUpLoadType=0 Then response.Write("checked")%> />普通上传
<input type="radio" name="uploadtype" id="radio" value="1" <%If SysUpLoadType=1 Then response.Write("checked")%> />批量上传
        </td>
  </tr>
      <tr>
     <td height="1" bgcolor="#e1e1e1"></td>
  </tr>
<tr>
    <td class="subitem">
	<input type="submit" value="保存" class="btnt2"  /> &nbsp;		
	<input type="reset" value="恢复为默认" class="btnt6" /></td>
  </tr>
</form>
</table>
<%
Else
	SysNotic=request.Form("notice")
	SysDisplayType=request.Form("displaytype")
	SysPageCount=request.Form("pagecount")
	SysViewType=request.Form("viewtype")
	SysUpLoadType=request.Form("uploadtype")
	set rs=server.CreateObject("adodb.recordset")
	rs.open "select top 1 [SysNotic],[SysDisplayType],[SysPageCount],[SysViewType],[SysUpLoadType] from [Liu_User] where username='"&request.cookies("1dy")("UserName")&"'",conn,1,3
		rs("SysNotic")=SysNotic
		rs("SysDisplayType")=SysDisplayType
		rs("SysPageCount")=SysPageCount
		rs("SysViewType")=SysViewType
		rs("SysUpLoadType")=SysUpLoadType
		rs.update
	rs.close
	set rs=nothing
	response.Write "<script>alert('保存信息成功！');location.href='setsys.asp';</script>"
End If
%>
</body>
</html>
