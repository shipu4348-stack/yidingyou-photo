<!--#include file="./incs/SysCode.asp"-->

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
<title>服务与支持</title>
<link rel="stylesheet" type="text/css" media="all" href="css/setting.css" />
<link rel="stylesheet" type="text/css" media="all" href="css/common.css" />
</head>

<body>

<table width="100%" border="0" cellpadding="0" cellspacing="0">
  <tr>
    <td height="40" valign="bottom" background="images/0018.gif" class="em">服务与支持</td>
  </tr>
</table>
<table width="100%" border="0" cellspacing="0" cellpadding="0">
<tr>
    <td height="1" bgcolor="#e1e1e1" colspan="2"></td>
  </tr>
</table>
<table width="100%" border="0" cellspacing="0" cellpadding="0">
<%
	id=request.QueryString("id")
	set rs=server.CreateObject("adodb.recordset")
	rs.open "select * from GuestMessage where id="&id&"",conn,1,1	
	replay=rs("replay")
	
%>
<tr><td bgcolor="#fafafa" class="dirnotice" style="background-image:none;"><%=rs("addtime")%>&nbsp;来自于:<%=rs("username")%></tr>
<tr><td bgcolor="#fafafa" class="itemlist"><b>标题:<%=rs("question")%></b></td></tr>
<tr><td bgcolor="#fafafa" class="itemlist"><%=rs("content")%></td></tr>
<%
	 
	rs.close
	set rs=nothing	
%>

<% 
set rss=server.CreateObject("adodb.recordset")
	rss.open "select * from GuestMessage where parentid="&id&"",conn,1,1	
 
     listnum=rss.recordcount
 	If not(Rss.Bof And Rss.Eof) Then
 
	
	  
	  for i=1 to listnum
	  isadmin=rss("isadmin")
	    if isadmin="1" then 
 	  levename="<font color=red>管理员</font>"
	  else
	  levename="用户"
	  end if
  %>

<tr><td bgcolor="#fafafa" class="dirnotice" style="background-image:none;"><%=rss("addtime")%>来自于<%= levename %>:<%=rss("username")%></td></tr>
<tr><td bgcolor="#fafafa" class="itemlist"><%=rss("content")%></td></tr>
 
<%
      rss.movenext
	 next
	 
	 else
 %>
 <tr><td bgcolor="#fafafa" class="itemlist" colspan="2">等待管理员处理</td></tr>

<%
	End If
	Rss.Close
	Set Rss=Nothing  
	if isadmin = "1" then 
	 conn.execute("update GuestMessage set isadmin=3 where id="&id&"")
    end if
	 %>


</table>

<table width="100%" border="0" cellspacing="0" cellpadding="0">
<tr>
    <td height="1" bgcolor="#e1e1e1" colspan="2"></td>
  </tr>
  </table>
  <% If replay<>1  Then %>
  <FORM name="mainform" action="message.asp?action=add&kind=1" method="POST">

<table width="100%" border="0" cellspacing="0" cellpadding="0">
<tr>
    <td height="1" bgcolor="#e1e1e1" colspan="2"></td>
  </tr>
  <tr>
    <td class="dirnotice" colspan="2">提示：如有不明白问题可以继续提问。</td>
  </tr>
  <tr>
    <td height="1" bgcolor="#e1e1e1" colspan="2"></td>
  </tr>
  <tr>
    <td  bgcolor="#fafafa" class="itemlist">问题标题： </td><td>
    <input name="html_name" type="text" class="text" id="textfield" size="40" maxlength="30" /></td>
  </tr>
  <tr>
    <td style="padding:10px;">问题内容</td><td>
	<textarea name="html_content" style="width:300px; height:100px; overflow-y:hidden"></textarea>
</td>
  </tr>
   <tr>
    <td height="1" bgcolor="#e1e1e1"></td>
  </tr> <tr>  
    <td style="padding-left:15px; height:60px;">
 <input name="parentid" type="hidden" value="<%=id%>">

<input name="button2" value="提交" type="submit" class="btnt3" /> </td>
</tr>

</table>

<form> 
<% End If %>

</body>
</html>
<%
	if request("action")="del" then
		id=cint(request.QueryString("html_id"))
		conn.execute("delete from guestmessage where id="&id&"")
		response.write "<script language=javascript>alert('删除成功！');window.location.href='message.asp';</script>"
		response.End
	end if
%>