<!--#include virtual="/incs/model.asp"-->
<% Response.ContentType = "text/html; charset=gb2312" %>
<%
	Server.ScriptTimeOut =999999
	call stopsql()
	Pid=int(request.QueryString("Pid"))
	UserName=trim(request.QueryString("kname"))
	set Fso=New DmFso	
	MainURL="http://"&request.ServerVariables("Server_Name")	
	set rs=server.CreateObject("adodb.recordset")
	sql="select top 1 [Purl],[PhotoPic],[Psize],[Pdate] from [Liu_Pic] where pid="&pid&" and  kuser='"&UserName&"'"
	rs.open sql,conn,1,1	
	if not rs.eof or not rs.bof then
		response.Write("<div id='PhotoMenuList3'>")
		response.Write("<span>"&FormatDateTime(rs("Pdate"),2)&"</span>")
		response.Write("<span>"&Fso.FormatFileSize(rs("Psize"))&"</span>")
		response.Write("</div>")
		response.Write("<div id='PhotoMenuList2'>")
		response.Write("<a href='"&MainURL&rs("Purl")&"' hidefocus='hidefocus' target='_blank'>"&escape("查看原图")&"</a><a href='"&MainURL&rs("Purl")&"' hidefocus='hidefocus' target='_blank'>"&escape("下载此照片")&"</a><a href='javascript:void(0)' hidefocus='hidefocus' onclick='copylink("""&MainURL&rs("Purl")&""")'>"&escape("复制此照片地址")&"</a>")
		response.Write("</div>")
	end if
	rs.close
	set rs=nothing
	conn.close
	set conn=nothing
	set Fso=nothing
%>