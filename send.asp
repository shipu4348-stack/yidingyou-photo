<!--#include file="./incs/SysCode.asp"-->
<%
if request("action")="add" then
	accept=request.form("acceptname")
	newsname=Replace(Request.Form("title"),"’","’’")
	Content=Replace(Request.Form("content"),"’","’’")
	if accept="" then
		response.write "<script language=javascript>alert('收件人不能为空！');history.back();</script>"
		response.End
	end if
	if newsname="" then
		response.write "<script language=javascript>alert('标题不能为空！');history.back();</script>"
		response.End
	end if
	if Content="" then
		response.write "<script language=javascript>alert('内容不能为空！');history.back();</script>"
		response.End
	end if
	set rs2=server.CreateObject("adodb.recordset")
	rs2.open "select * from [Liu_User] where username='"&accept&"'",conn,1,1
	if not rs2.eof and not rs2.bof then
		set rs=server.CreateObject("adodb.recordset")
		rs.open "select * from [Liu_Message]",conn,1,3
		rs.addnew
		rs("sendname")=request.cookies("1dy")("UserName")
		rs("accetpname")=accept
		rs("sendtitle")=newsname
		rs("sendcontent")=Content
		rs.update
		rs.close
		set rs=nothing
		response.write "<script language=javascript>alert('发送成功！');window.location.href='send.asp';</script>"
		response.End
	else
		response.write "<script language=javascript>alert('收件人不存在！');history.back();</script>"
	end if
	rs2.close
	set rs2=nothing
end if
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
<title>服务与支持</title>
<link rel="stylesheet" type="text/css" media="all" href="css/setting.css" />
<link rel="stylesheet" type="text/css" media="all" href="css/common.css" />
</head>

<body>

<FORM name="mainform" action="send.asp?action=add" method="POST">
<table width="100%" border="0" cellpadding="0" cellspacing="0">
  <tr>
    <td height="40" valign="bottom" background="images/0018.gif" class="em">发送短消息</td>
  </tr>
</table>
<table width="100%" border="0" cellspacing="0" cellpadding="0">

<tr>
    <td height="1" bgcolor="#e1e1e1" colspan="2"></td>
  </tr>
  <tr>
    <td class="dirnotice" colspan="2">提示：知道对方的账号可给对方发送短消息!</td>
  </tr>
  <tr>
    <td height="1" bgcolor="#e1e1e1" colspan="2"></td>
  </tr>
    <tr>
    <td  bgcolor="#fafafa" class="itemlist">收件人： </td><td>
    <input name="acceptname" type="text" class="text" id="textfield" size="40" maxlength="30" /></td>
  </tr>
  <tr>
    <td  bgcolor="#fafafa" class="itemlist">标题： </td><td>
    <input name="title" type="text" class="text" id="textfield" size="40" maxlength="30" /></td>
  </tr>
  <tr>
    <td style="padding:10px;">内容</td><td>
	<textarea name="content" style="width:300px; height:100px; overflow-y:hidden"></textarea>
</td>
  </tr>
   <tr>
    <td height="1" bgcolor="#e1e1e1"></td>
  </tr> <tr>  
    <td style="padding-left:15px; height:60px;"><input name="button2" value="提交" type="submit" class="btnt3" /> </td>
</tr>

</table>
<form>
</body>
</html>