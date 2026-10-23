<!--#include file="./incs/SysCode.asp"-->
<%
if request("action")="add" then
	Content=Replace(Request.Form("html_content"),"’","’’")
	if Content="" then
		response.write "<script language=javascript>alert('没内容你举报啥呀！');history.back();</script>"
		response.End
	end if
	
	set rs=server.CreateObject("adodb.recordset")
	rs.open "select [nameuser],[content],[PostTime] from [ydy_buliang]",conn,1,3
	rs.addnew
	rs("nameuser")=request.cookies("1dy")("UserName")
	rs("content")=Content
	rs("PostTime")=now()
	rs.update
	rs.close
	set rs=nothing
	response.write "<script language=javascript>alert('举报成功,等待管理员受理！');window.location.href='buliang.asp';</script>"
	response.End
end if
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
<title>不良信息</title>
<link rel="stylesheet" type="text/css" media="all" href="css/setting.css" />
</head>

<body>

<FORM name="mainform" action="buliang.asp?action=add" method="POST">
<table width="100%" border="0" cellpadding="0" cellspacing="0">
  <tr>
    <td height="40" valign="bottom" background="images/0018.gif" class="em">举报不良信息</td>
  </tr>
</table>
<table width="100%" border="0" cellspacing="0" cellpadding="0">

<tr>
    <td height="1" bgcolor="#e1e1e1" colspan="2"></td>
  </tr>
  <tr>
    <td class="dirnotice" colspan="2">提示：举报不良信息必需为真实,如不真实将对举报都处罚。</td>
  </tr>
  <tr>
    <td height="1" bgcolor="#e1e1e1" colspan="2"></td>
  </tr>
  <tr>
    <td width="14%" style="padding:10px;" valign="top">不良信息地址:</td>
	<td width="86%" style="padding:5px;">
	<textarea name="html_content" class="text"></textarea>
</td>
  </tr>
   <tr>
    <td height="1" bgcolor="#e1e1e1" colspan="2"></td>
  </tr> <tr>  
    <td style="padding-left:15px; height:60px;" colspan="2"><input name="button2" value="我要举报" type="submit" class="btnt3" /> </td>
</tr>

</table>
<form>
</body>
</html>