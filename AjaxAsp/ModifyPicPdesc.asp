<!--#include virtual="/incs/model.asp"-->
<% Response.ContentType = "text/html; charset=gb2312" %>
<%
call stopsql()
Pid=int(request.QueryString("Pid"))
Pdesc=trim(request.QueryString("Pdesc"))
if request.cookies("1dy")("UserName")="" then
	response.Write(escape("³¬Ê±"))
else
	UserName=request.cookies("1dy")("UserName")	
	set rs=server.CreateObject("adodb.recordset")
	sql="select top 1 [Pdesc] from [Liu_Pic] where pid="&pid&" and  kuser='"&UserName&"'"
	rs.open sql,conn,1,3	
	if not rs.eof or not rs.bof then
		rs("Pdesc")=Pdesc
		rs.update
		response.Write(escape("³É¹¦"))
	else
		response.Write(escape("Ê§°Ü"))
	end if
	rs.close
	set rs=nothing
	conn.close
	set conn=nothing
end if
%>