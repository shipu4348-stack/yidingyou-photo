<!--#include virtual="/incs/conn.asp"-->
<% Response.ContentType = "text/html; charset=gb2312" %>
<!--#include virtual="/incs/webConfig.asp"-->
<%
	if request.cookies("1dy")("UserName")="" then
		response.Write(escape("³¬Ê±"))
	else
		if IsNull(MarkFontStr) or IsNull(MarkFont) or IsNull(MarkFontSize) then
			response.Write(escape("´íÎó"))		
		end if
	end if
%>