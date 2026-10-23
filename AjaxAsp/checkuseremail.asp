<!--#include virtual="/incs/conn.asp"-->
<% Response.ContentType = "text/html; charset=gb2312" %>
<%
	mail=cstr(request.QueryString("email"))
	set rs=server.CreateObject("adodb.recordset")
	rs.open "select [email] from [Liu_User] where email='"&mail&"'",conn,1,1
	if rs.eof or rs.bof then
		response.Write escape("不存在")
	else
		response.Write escape("已存在")		
	end if
	rs.close
	set rs=nothing
%>