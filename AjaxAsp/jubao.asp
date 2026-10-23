<!--#include virtual="/incs/model.asp"-->
<% Response.ContentType = "text/html; charset=gb2312" %>
<%
call stopsql()
Content=trim(request.QueryString("content"))
if request.cookies("1dy")("UserName")="" then
	response.Write(escape("³¬Ê±"))
else
	UserName=request.cookies("1dy")("UserName")	
	set rs=server.CreateObject("adodb.recordset")
	sql="select [nameuser],[content],[PostTime] from [ydy_buliang] "
	rs.open sql,conn,1,3
	rs.addnew
	rs("nameuser")=UserName
	rs("content")=Content
	rs("PostTime")=now()
	rs.update
	rs.close
	set rs=nothing
	conn.close
	set conn=nothing
	response.Write(escape("³É¹¦"))
end if
%>