<!--#include virtual="/Incs/SysCode.asp"-->
<% Response.ContentType = "text/html; charset=gb2312" %>
<%
	server.ScriptTimeout=99999
	if Not checklogin then
		response.Write(escape("超时"))
		response.End()
	end if
	Dim kid,pids,types,kpath,UploadPath,kname
	kid=CheckNumeric(request("kid"))
	pids=Checkstr(request("pids"))
	types=CheckNumeric(request("type"))
	 
	Set Fso=New DmFso
 
	set rs=server.CreateObject("adodb.recordset")
	rs.open "select [Pid],[kid],[Purl],[Pthurl],[PhotoUrl],[Psize] from [Liu_Pic] where Pid in ("&pids&") and kuser='"&UserName&"'",conn,1,3
	if not (rs.eof and rs.bof) then
		do while not rs.eof
			if rs("kid")=0 then
				UploadPath=CreatFolder&"/"
			else
				kpath=DBGetValue("Liu_Folder","kpath","kid="&rs("kid")&"  and kuser='"&UserName&"'")
				kname=DBGetValue("Liu_Folder","kname","kid="&rs("kid")&"  and kuser='"&UserName&"'")
				UploadPath=CreatFolder&kpath&kname&"/"
			end if
		 
			if Not GetIsNull(rs("Purl")) and Not  GetIsNull(rs("Pthurl")) and Not GetIsNull(rs("PhotoUrl")) then'数据库中的值全部不为空
				if Fso.CheckFile(UploadPath&rs("Purl")) or Fso.CheckFile(UploadPath&rs("Pthurl")) or Fso.CheckFile(UploadPath&rs("PhotoUrl")) then
				 
					if Fso.DelFile(UploadPath&rs("Purl")) or Fso.DelFile(UploadPath&rs("Pthurl")) or Fso.DelFile(UploadPath&rs("PhotoUrl")) then'	Fso.DelFile(UploadPath&rs("PhotoPic"))
						if rs("kid")<>0 then
							conn.execute("update [Liu_Folder] set kcount=kcount-1 where kid="&rs("kid")&"")
						end if
						conn.execute("update [Liu_User] set UsedBytes=UsedBytes-"&cdbl(CheckNumeric(rs("Psize")))&",ResBytes=ResBytes+"&cdbl(CheckNumeric(rs("Psize")))&" where UserName='"&UserName&"'")					
						rs.delete
						end if
					
					else
						if rs("kid")<>0 then
							conn.execute("update [Liu_Folder] set kcount=kcount-1 where kid="&rs("kid")&"")
						end if
						conn.execute("update [Liu_User] set UsedBytes=UsedBytes-"&cdbl(CheckNumeric(rs("Psize")))&",ResBytes=ResBytes+"&cdbl(CheckNumeric(rs("Psize")))&" where UserName='"&UserName&"'")					
						rs.delete
					end if
					
				end if
		rs.movenext
		loop
	end if
	rs.close
	set rs=nothing		
	if types=1 then
		response.Write("main.asp")
	elseif types=2 then
		response.Write("list.asp")
	elseif types=4 or types=6 then
		response.Write("top5.asp")
	end if
	set Fso=nothing
	FolderSize=DBGetValue("Liu_User","UsedBytes"," UserName='"&UserName&"'")
	response.Write FormatFileSize(FolderSize)
	
%>