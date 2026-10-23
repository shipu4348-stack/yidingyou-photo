<% Response.ContentType = "text/html; charset=gb2312" %>
<%
	verifyCode=cstr(trim(request.QueryString("verify")))
	if cstr(session("getcode"))<>"" then	
		if cstr(session("getcode"))=verifyCode then
			response.Write escape("ÕýÈ·")
		else
			response.Write escape("´íÎó")
		end if
	else
		response.Write escape("³¬Ê±")
	end if
%>