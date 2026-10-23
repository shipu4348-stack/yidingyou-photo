<!--#include file="./incs/SysCode.asp"-->
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
<title>信息</title>
<link rel="stylesheet" type="text/css" media="all" href="css/setting.css" />
</head>

<body>
<%
	id=cint(request.QueryString("id"))
	set rs=server.CreateObject("adodb.recordset")
	rs.open "select * from [Liu_Message] where id="&id&"",conn,1,1
%>
<table width="100%" border="0" cellpadding="0" cellspacing="0">
  <tr>
    <td height="40" valign="bottom" background="images/0018.gif" class="em">主题:<%=rs("sendtitle")%></td>
  </tr>
</table>
<table width="100%" border="0" cellspacing="0" cellpadding="0">
<tr><td style="padding:10px;" colspan="2"><%=rs("sendcontent")%></td></tr>
   <tr>
    <td height="1" bgcolor="#e1e1e1"></td>
  </tr>
</table>
<%
	rs.close
	set rs=nothing
%>
</body>
</html>