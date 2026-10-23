<!--#include virtual="/Incs/SysCode.asp"-->
<% Response.ContentType = "text/html; charset=gb2312" %>
<%
	if Not checklogin then
		response.Write(escape("³¬Ê±"))
		response.End()
	end if
	Dim newkid,kid,pids,types,oldpath,newpath
	newkid=CheckNumeric(request("newkid"))
	kid=CheckNumeric(request("kid"))
	pids=Checkstr(request("pids"))
	types=CheckNumeric(request("type"))
	if kid=0 and newkid>0 then
		newkpath=DBGetValue("Liu_Folder","kpath"," kid="&newkid&" and kuser='"&UserName&"'")
		newkname=DBGetValue("Liu_Folder","kname"," kid="&newkid&" and kuser='"&UserName&"'")
		OldPath=CreatFolder&"/"
		NewPath=CreatFolder&newkpath&newkname&"/"
	elseif kid>0 and newkid=0 then
		oldkpath=DBGetValue("Liu_Folder","kpath"," kid="&kid&" and kuser='"&UserName&"'")
		oldkname=DBGetValue("Liu_Folder","kname"," kid="&kid&" and kuser='"&UserName&"'")		
		OldPath=CreatFolder&oldkpath&oldkname&"/"
		NewPath=CreatFolder&"/"
	elseif kid>0 and newkid>0 then
		oldkpath=DBGetValue("Liu_Folder","kpath"," kid="&kid&" and kuser='"&UserName&"'")
		oldkname=DBGetValue("Liu_Folder","kname"," kid="&kid&" and kuser='"&UserName&"'")
		newkpath=DBGetValue("Liu_Folder","kpath"," kid="&newkid&" and kuser='"&UserName&"'")
		newkname=DBGetValue("Liu_Folder","kname"," kid="&newkid&" and kuser='"&UserName&"'")
		OldPath=CreatFolder&oldkpath&oldkname&"/"
		NewPath=CreatFolder&newkpath&newkname&"/"
	else
		if types=1 then
			response.Write("main.asp")
			response.End()
		elseif types=2 then
			response.Write("list.asp")
			response.End()
		end if
	end if
	
	Set Fso=New DmFso
	set rs=server.CreateObject("adodb.recordset")
	rs.open "select [Pid],[kid],[Purl],[Pthurl],[PhotoUrl] from [Liu_Pic] where Pid in ("&pids&") and kuser='"&UserName&"'",conn,1,3
	if not (rs.eof and rs.bof) then
		do while not rs.eof
			if Not GetIsNull(rs("Purl")) and Not  GetIsNull(rs("Pthurl")) and Not GetIsNull(rs("PhotoUrl")) then
				if Fso.MoveFile(OldPath&rs("Purl"),NewPath&rs("Purl")) and Fso.MoveFile(OldPath&rs("Pthurl"),NewPath&rs("Pthurl")) and Fso.MoveFile(OldPath&rs("PhotoUrl"),NewPath&rs("PhotoUrl")) then'	Fso.MoveFile(oldkpath&rs("PhotoPic"),NewPath)
					if newkid<>0 then
						conn.execute("update [Liu_Folder] set kcount=kcount+1 where kid="&newkid&"")
					end if
					if kid<>0 then
						conn.execute("update [Liu_Folder] set kcount=kcount-1 where kid="&kid&"")
					end if
					rs("kid")=newkid
					rs.update
				end if
			end if
		rs.movenext
		loop
	end if
	rs.close
	set rs=nothing
	set Fso=nothing
	if types=1 then
		response.Write("main.asp")
		response.End()
	elseif types=2 then
		response.Write("list.asp")
		response.End()
	end if
	
%>