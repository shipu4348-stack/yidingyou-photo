<!--#include virtual="/incs/model.asp"-->
<% Response.ContentType = "text/html; charset=gb2312" %>
<%
UserName=trim(request.QueryString("kname"))
set rs=server.CreateObject("adodb.recordset")
rs.open "select top 1 [username],[yjf],[jfrq] from [Liu_User] where username='"&UserName&"'",conn,1,1
if rs.eof or rs.bof then
	response.Write(escape("相册地址不存在!"))
else
	if datediff("d",date(),rs("jfrq"))<=0 then
		response.Write(escape("未付费!"))		
	end if
end if
rs.close
set rs=nothing
%>