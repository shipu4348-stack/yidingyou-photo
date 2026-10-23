<!--#include virtual="/incs/SysCode.asp"-->
<% Response.ContentType = "text/html; charset=gb2312" %>
<%
	if Not checklogin then
		response.Write(escape("超时"))
		response.End()
	end if
	Kid=CheckNumeric(request("kid"))
	set rs=server.CreateObject("adodb.recordset")
	rs.open "select top 1 [IsPhoto] from [Liu_Folder] where kid="&Kid&"",conn,1,3
	if not rs.eof or not rs.bof then
		if rs("IsPhoto")=0 then
		  rs("IsPhoto")=1
		  rs.update
		  response.Write(escape("设置成功"))
		else
		  rs("IsPhoto")=0
		  rs.update
		  response.Write(escape("取消成功"))						
		end if
	end if
	rs.close
	set rs=nothing
%>