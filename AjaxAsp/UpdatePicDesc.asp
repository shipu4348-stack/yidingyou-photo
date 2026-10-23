<!--#include virtual="/Incs/SysCode.asp"-->
<% Response.ContentType = "text/html; charset=gb2312" %>
<%
	UserName=request.cookies("1dy")("UserName")
	if Not GetIsNull(UserName) then
		dim pid,pdesc
		pid=CheckNumeric(Request("picId"))
		pdesc=Checkstr(Request("picName"))
		if pid<>0 and Not GetIsNull(UserName) then
			conn.execute("update [Liu_Pic] set Pdesc='"&pdesc&"' where pid="&pid&" and kuser='"&UserName&"'")
			response.Write "<ajaxok>"
		else
			response.Write "<ajaxno>"
		end if
	end if	
%>