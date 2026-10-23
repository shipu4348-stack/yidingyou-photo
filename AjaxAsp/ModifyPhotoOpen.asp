<!--#include virtual="/incs/model.asp"-->
<% Response.ContentType = "text/html; charset=gb2312" %>
<%
call stopsql()
UserName=trim(request.QueryString("kname"))
kid=int(request.QueryString("kid"))
photoname=trim(request.QueryString("photoname"))
isOpen=cint(request.QueryString("isOpen"))
pwd=trim(request.QueryString("pwd"))
set rsname=server.CreateObject("adodb.recordset")
rsname.open "select [kname] from [Liu_Folder] where kname='"&photoname&"' and kuser='"&UserName&"' and kid<>"&kid&"",conn,1,1
if rsname.eof or rsname.bof then
	set rs=server.CreateObject("adodb.recordset")
	rs.open "select top 1 [kname],[IsOpen],[Password] from [Liu_Folder] where kuser='"&UserName&"' and kid="&kid&"",conn,1,3
	rs("IsOpen")=isOpen
	rs("kname")=photoname
	if isOpen=1 then
	rs("Password")=pwd
	end if
	rs.update
	rs.close
	set rs=nothing
	response.Write(escape("成功"))
else
	response.Write(escape("同名"))
end if
rsname.close
set rsname=nothing
%>
