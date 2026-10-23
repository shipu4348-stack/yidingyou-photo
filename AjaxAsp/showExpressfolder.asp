<!--#include virtual="/incs/syscode.asp"-->
<% Response.ContentType = "text/html; charset=gb2312" %>
<%
	if Not checklogin then
		response.Write(escape("³¬Ê±"))
		response.End()
	end if
	Dim TempStr,kname,kupid
	TempStr=""
	TempStr=TempStr&"<table align=right class=folderlist_table >"
	set rss=server.CreateObject("adodb.recordset")
	rss.open "select [kid],[Kname],[kcount],[klevel] from [Liu_Folder] where upid=0 and kuser='"&UserName&"'",conn,1,1
	if Not (rss.eof and rss.bof) then
		do while not rss.eof
		kname=""
		if len(rss("Kname"))>8 then
			kname=left(rss("Kname"),8)&"..."
		else
			kname=rss("Kname")
		end if
		kupid=DBGetNum("Liu_Folder","kid",0," where upid="&rss("kid")&" and kuser='"&UserName&"'")
		if kupid<=0 then					
			TempStr=TempStr&"<tr><td class=folderlist_td><a target='tx8_mainbody' title='"&escape(rss("kname"))&"' href=main.asp?type=1&kid="&rss("kid")&">-&nbsp;"&escape(kname)&"("&rss("kcount")&")</a></td></tr>"
		else
			TempStr=TempStr&"<tr><td class=folderlist_td><a target='tx8_mainbody' title='"&escape(rss("kname"))&"' href=main.asp?type=1&kid="&rss("kid")&">+&nbsp;"&escape(kname)&"("&rss("kcount")&")</a></td></tr>"
		end if
		rss.movenext
		loop
	end if
	rss.close
	set rss=nothing
	TempStr=TempStr&"</td></tr>"
	response.Write TempStr
%>