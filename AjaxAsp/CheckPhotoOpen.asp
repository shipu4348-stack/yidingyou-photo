<!--#include virtual="/incs/model.asp"-->
<% Response.ContentType = "text/html; charset=gb2312" %>
<%
call stopsql()
session.Timeout=10
UserName=trim(request.QueryString("kname"))
kid=request.QueryString("kid")
pwd=trim(request.QueryString("pwd"))
set rs=server.CreateObject("adodb.recordset")
rs.open "select top 1 [IsOpen],[Password] from [Liu_Folder] where kuser='"&UserName&"' and kid="&kid&" and Password='"&pwd&"'",conn,1,1
if not rs.eof or not rs.bof then
	if session("1dyName")="" then
		session("1dyName")=kid
	else
		session("1dyName")=session("1dyName")&","&kid
	end if
response.Write(escape("³É¹¦"))
else
response.Write(escape("´íÎó"))
end if
rs.close
set rs=nothing

%>
