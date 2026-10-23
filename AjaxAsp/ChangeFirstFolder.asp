<!--#include virtual="/incs/conn.asp"-->
<% Response.ContentType = "text/html; charset=gb2312" %>
<%
	kid=cint(request.QueryString("kid"))
	if request.cookies("1dy")("UserName")="" then
		response.Write(escape("³¬Ê±"))
	else
		countkid=conn.execute("select count(*) from [Liu_Folder] where kid="&kid)(0)
		if countkid=1 then
			conn.execute("update [Liu_Folder] set upid=-1,klevel=1 where kid="&kid)
			response.Write(escape("³É¹¦"))
		else
			response.Write(escape("´íÎó"))
		end if		
	end if
	
%>