<!--#include virtual="/incs/model.asp"-->
<% Response.ContentType = "text/html; charset=gb2312" %>
<%
	call stopsql()
	kid=int(request.QueryString("kid"))
	UserName=trim(request.QueryString("kname"))
	Pid=int(request.QueryString("pid"))
	Message=""
	set rs=server.CreateObject("adodb.recordset")
	sql="select top 1 [kid],[kname],[IsOpen] from [Liu_Folder] where IsPhoto=1 and kid="&kid&" and  kuser='"&UserName&"'"
	rs.open sql,conn,1,1	
	if not rs.eof or not rs.bof then
		'if request.cookies("1dy")("UserName")<>UserName then
		if rs("IsOpen")<>0 and  request.cookies("1dy")("UserName")<>UserName and instr(session("1dyName"),rs("kid"))=0 then
			Message="返回"
		else	
			Message="<a href='PhotoPic.asp?kname="&UserName&"&Kid="&kid&"'>"&trim(rs("kname"))&"</a>"
			if Pid<>0 then
				set rss=server.CreateObject("adodb.recordset")
				sql="select top 1 [pid] from [Liu_Pic] where pid="&Pid&" and kid="&kid&" and  kuser='"&UserName&"'"
				rss.open sql,conn,1,1	
				if rss.eof or rss.bof then
					Message="图片地址不存在!"
				end if
				rss.close
				set rss=nothing		
			end if
		end if
	else
		Message="相册地址不存在!"
	end if
	rs.close
	set rs=nothing	
	conn.close
	set conn=nothing
	response.Write(escape(Message))
%>