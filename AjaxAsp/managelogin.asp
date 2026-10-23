<!--#include virtual="/incs/model.asp"-->
<% Response.ContentType = "text/html; charset=gb2312" %>
<%
username=Replace(Request.QueryString("username"),"’","’’")
if session("admin")="" or username="" then
	response.Write "<script>alert('非法访问');location.href='/index.asp';</script>"
	response.End()
else
	set rs=server.CreateObject("adodb.recordset")
	sql="select top 1 [id],[tcid],[yjf],[username] from [Liu_User] where username='"&username&"'"
	rs.open sql,conn,1,1
	if not (rs.eof and rs.bof) then
		Response.Cookies("1dy")("UserID")=rs("id")
		Response.Cookies("1dy")("UserName")=rs("username")
		Response.Cookies("1dy")("yjf")=rs("yjf")
		Response.Cookies("1dy")("tcid")=rs("tcid")
		Response.Cookies("1dy")("fate")=0
		Response.Cookies("1dy").Expires=date+1
		response.Redirect "/home.asp"
	else
		response.Write "<script>alert('非法访问');location.href='/index.asp';</script>"
		response.End()				
	end if
	rs.close
	set rs=nothing
end if
%>