<!--#include file="incs/model.asp"-->
<%
	yhm=request.QueryString("username")
	if yhm<>"" then
		set rs=server.createobject("adodb.recordset")
		rs.open "select [username],[question] from [Liu_User] where username='"&yhm&"'",conn,1,1
		if rs.eof and rs.bof then
			response.write(escape("Î´"))
		else
			question=rs("question")
			rs.close
			set rs=nothing
			response.write(escape(question))	
		end if
	else
		response.Write (escape("¿Õ"))
	end if
%>