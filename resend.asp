<!--#include file="./incs/SysCode.asp"-->
<%
if request("action")="add" then
	sender=request.form("accept")
	accept=request.form("sender")
	title=request.form("title")
	Content=Replace(Request.Form("content"),"’","’’")
	if Content="" then
		response.write "<script language=javascript>alert('回复内容不能为空！');history.back();</script>"
		response.End
	end if
	
	set rs=server.CreateObject("adodb.recordset")
	rs.open "select * from [Liu_Message]",conn,1,3
	rs.addnew
	rs("sendname")=sender
	rs("accetpname")=accept
	rs("sendtitle")=title
	rs("sendcontent")=Content
	rs.update
	rs.close
	set rs=nothing
	response.write "<script language=javascript>alert('回复成功！');window.location.href='accept.asp';</script>"
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
<%
	id=cint(request.QueryString("id"))
	set rs=server.CreateObject("adodb.recordset")
	rs.open "select * from [Liu_Message] where id="&id&"",conn,1,1
%>
<FORM name="mainform" action="resend.asp?action=add" method="POST">
<input type="hidden" name="sender" value="<%=rs("sendname")%>" />
<input type="hidden" name="accept" value="<%=rs("accetpname")%>" />
<input type="hidden" name="title" value="Re:<%=rs("sendtitle")%>" />
<table width="100%" border="0" cellpadding="0" cellspacing="0">
  <tr>
    <td height="40" valign="bottom" background="images/0018.gif" class="em">主题:<%=rs("sendtitle")%></td>
  </tr>
</table>
<table width="100%" border="0" cellspacing="0" cellpadding="0">
<tr><td style="padding:10px;" colspan="2"><%=rs("sendcontent")%></td></tr>
  <tr>
    <td style="padding:10px;">回复内容:</td>
	<td>
	<textarea name="content" style="width:300px; height:100px; overflow-y:hidden"></textarea>
</td>
  </tr>
   <tr>
    <td height="1" bgcolor="#e1e1e1"></td>
  </tr> <tr>  
    <td style="padding-left:15px; height:60px;"><input name="button2" value="回复" type="submit" class="btnt3" /> </td>
</tr>

</table>
<form>
</body>
</html>