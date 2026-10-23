<!--#include virtual="/incs/SysCode.asp"-->
<% Response.ContentType = "text/html; charset=gb2312" %>
<%
	if Not checklogin then
		response.Write(escape("超时"))
		response.End()
	end if
	Dim kid,kname,klevel,NewPath,OldPath
	kid=CheckNumeric(request("kid"))
	kname=unescape(Checkstr(request("kname")))
	klevel=CheckNumeric(request("klevel"))
	
	set rs=server.CreateObject("adodb.recordset")
	rs.open "select top 1 [kname] from [Liu_Folder] where kname='"&kname&"' and kuser='"&UserName&"' and klevel="&klevel&"",conn,1,1
	if not (rs.eof and rs.bof) then
		response.Write(escape("同名"))
	else
		set rs2=server.CreateObject("adodb.recordset")
		rs2.open "select top 1 [kid],[kname],[kpath] from [Liu_Folder] where kid="&kid&" and kuser='"&UserName&"' and klevel="&klevel&"",conn,1,3
		if not (rs2.eof and rs2.bof) then
		OldPath=CreatFolder&rs2("kpath")&rs2("kname")
		NewPath=CreatFolder&rs2("kpath")&kname
		Set Fso=New DmFso
			if Fso.CheckFolder(OldPath) then
				if Fso.CopyFolder(OldPath,NewPath) then
					if Fso.CheckFolder(NewPath) and Fso.DelFolder(OldPath) then
						conn.execute("update [Liu_Folder] set kname='"&kname&"' where kid="&kid&" and kuser='"&UserName&"' and klevel="&klevel&"")
						UpdatePathDir Rs2("kid"),rs2("kpath")&kname&"/"
						response.Write(escape("成功"))
					end if
				end if
			end if
		Set Fso=Nothing			
		end if
		rs2.close
		set rs2=nothing
	end if
	rs.close
	set rs=nothing
	
	function UpdatePathDir(id,kpath)
		Set Rsu=Server.CreateObject("Adodb.recordset")
		Rsu.open "select [kid],[kname],[kpath] from [Liu_Folder] where upid="&id&" and kuser='"&UserName&"'",conn,1,3
		if Not (Rsu.eof and Rsu.bof) then
			do while not Rsu.eof				
				conn.execute("update [Liu_Folder] set kpath='"&kpath&"' where kid="&Rsu("kid")&" and kuser='"&UserName&"'")
				UpdatePathDir Rsu("kid"),kpath&Rsu("kname")&"/"	
			Rsu.MoveNext
			loop
		end if
		Rsu.close
		Set Rsu=nothing
	end function
%>