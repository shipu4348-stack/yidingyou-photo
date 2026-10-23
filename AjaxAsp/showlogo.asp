<!--#include virtual="/incs/conn.asp"-->
<% Response.ContentType = "text/html; charset=gb2312" %>
<!--#include virtual="/incs/webConfig.asp"-->
<%
	kid=int(request.QueryString("kid"))
	if request.cookies("1dy")("UserName")="" then
		response.Write(escape("³¬Ê±"))
	else
		yhm=request.cookies("1dy")("UserName")
		if MarkPic<>"" and MarkPicClarity<>"" then
		response.Write("<img src='../user/"&yhm&"/pic/"&MarkPic&"' onLoad='ResizeImage(this,50,50)'>")
		else
		response.Write(escape("´íÎó"))
		end if
	end if	
%>