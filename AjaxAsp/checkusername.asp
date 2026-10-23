<!--#include virtual="/incs/conn.asp"-->
<% Response.ContentType = "text/html; charset=gb2312" %>
<%
	uname=cstr(request.QueryString("username"))
	set rs=server.CreateObject("adodb.recordset")
	rs.open "select [username] from [Liu_User] where username='"&uname&"'",conn,1,1
	if rs.eof and rs.bof then
		response.Write escape("不存在")
	else
		response.Write escape("已存在")
	end if
	rs.close
	set rs=nothing
%>