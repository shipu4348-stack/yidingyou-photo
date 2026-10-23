<!--#include virtual="/incs/model.asp"-->
<% Response.ContentType = "text/html; charset=gb2312" %>
<%
	Pid=int(request.QueryString("Pid"))
	Kid=int(request.QueryString("Kid"))
	UserName=trim(request.QueryString("kname"))
	set rs=server.CreateObject("adodb.recordset")
	sql="select [Pid],[purl],[kid] from [Liu_Pic] where kid="&kid&" and  kuser='"&UserName&"' order by Pid desc"
	rs.open sql,conn,1,1	
	if not rs.eof or not rs.bof then
		rsCount=rs.recordcount
		dim SelectedId
		dim SavePic
		dim Spid
		SavePic=""
		for i=0 to rsCount-1
			if int(Pid)=rs("Pid") then
				SelectedId=i
			end if
			if i<>rsCount-1 then
				Spid=Spid&rs("Pid")&","
			else
				Spid=Spid&rs("Pid")
			end if
			if i<>rsCount-1 then
				SavePic=SavePic&rs("purl")&","
			else
				SavePic=SavePic&rs("purl")
			end if
		rs.movenext
		next
	end if
	rs.close
	set rs=nothing
	response.Write(SelectedId&"|"&SavePic&"|"&Spid)
%>