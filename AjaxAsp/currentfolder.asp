<!--#include virtual="/incs/SysCode.asp"-->
<% Response.ContentType = "text/html; charset=gb2312" %>
<%
	if Not checklogin then
		response.Write(escape("超时"))
		response.End()
	end if	
	kid=CheckNumeric(request("kid"))
	klevel=CheckNumeric(request("klevel"))
	types=CheckNumeric(request("type"))
	if types=1 then
		url="main.asp?type=1"
	elseif types=2 then			
		url="list.asp?type=2"
	else
		url="folderlist.asp"
	end if
	Dim TempStr
	TempStr=""		
	TempStr=TempStr&"&nbsp;"&escape("你所在的位置:")&"&nbsp;&gt;&nbsp;<a href='"&url&"'><font color='#2b82e9'>"&escape("根目录")&"</font></a>"&currentfolder(kid,kid)
	response.Write TempStr		
		
	function currentfolder(id,kid)
		Dim TempStr:TempStr=""
		Set Rsu=Server.CreateObject("Adodb.recordset")
		Rsu.open "select top 1 [kid],[kname],[kpath],[klevel],[kcount],[upid] from [Liu_Folder] where kid="&id&" and kuser='"&UserName&"'",conn,1,3
		if Not (Rsu.eof and Rsu.bof) then
			if Rsu("upid")>0 then
				TempStr=TempStr&currentfolder(Rsu("upid"),kid)
			end if
			if Rsu("kid")<>kid then
				if types>0 then
					TempStr=TempStr&"<a href="""&url&"&kid="&Rsu("kid")&""">&nbsp;&gt;&nbsp;<font color='#2b82e9'>"&escape(Rsu("kname"))&"</font>("&Rsu("kcount")&")</a>"
				else
					TempStr=TempStr&"<a href="""&url&"?upid="&Rsu("kid")&"&klevel="&Rsu("klevel")+1&"&kpath="&escape(Rsu("kpath")&Rsu("kname"))&""">&nbsp;&gt;&nbsp;<font color='#2b82e9'>"&escape(Rsu("kname"))&"</font>("&Rsu("kcount")&")</a>"
				end if
			else
				TempStr=TempStr&"&nbsp;&gt;&nbsp;"&escape(Rsu("kname"))&"("&Rsu("kcount")&")"
			end if			
		end if
		Rsu.close
		Set Rsu=nothing
		currentfolder=TempStr
	end function
%>