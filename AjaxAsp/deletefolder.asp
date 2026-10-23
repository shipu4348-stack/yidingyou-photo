<!--#include virtual="/Incs/SysCode.asp"-->
<% Response.ContentType = "text/html; charset=gb2312" %>
<%
	server.ScriptTimeout=99999
	if Not checklogin then
		response.Write(escape("超时"))
		response.End()
	end if
	Dim kid,FolderSize
	kid=CheckNumeric(request("kid"))
	DeletePic(kid)
	DeleteFolder(kid)
	DeleteFile(kid)
	DeleteSelfFolder(kid)
	response.Write(escape("成功"))
	FolderSize=DBGetValue("Liu_User","UsedBytes"," UserName='"&UserName&"' ")
	response.Write FormatFileSize(FolderSize)
	
	Function DeleteSelfFolder(id)
		Dim Rs,Sql,Path,Fso
		Set Fso=New DmFso
		Set Rs=Server.CreateObject("Adodb.recordset")
		Sql="Select kid,kname,kpath from[Liu_Folder] where kid="&id&" and kuser='"&UserName&"'"
		Rs.open Sql,conn,1,3
		if Not (Rs.eof and Rs.bof) then
		do while not Rs.eof
			Path=CreatFolder&Rs("kpath")&Rs("kname")
			if Fso.CheckFolder(Path) then		
				if Fso.DelFolder(Path) then
					rs.delete
				end if
			else
					rs.delete
			end if
		rs.movenext
		loop
		end if
		Rs.close
		Set Rs=nothing
		set Fso=nothing		
	End Function
	
	Function DeleteFolder(id)
		Dim Rs,Sql,Fso,Rs2,Sql2,Path2
		Path=""
		Path2=""
		Set Fso=New DmFso
		Set Rs=Server.CreateObject("Adodb.recordset")
		Sql="Select kid,kname,kpath from [Liu_Folder] where upid="&id&" and kuser='"&UserName&"'"
		Rs.open Sql,conn,1,3
		if Not (Rs.eof and Rs.bof) then
		do while not Rs.eof	
			DeleteFolder(rs("kid"))	
			Path2=CreatFolder&Rs("kpath")&Rs("kname")	
			if Fso.CheckFolder(Path2) then	
				if Fso.DelFolder(Path2) then
					rs.delete
				end if	
			else'文件夹不存在则直接删除记录
					rs.delete
			end if
		rs.movenext
		loop
		end if
		Rs.close
		Set Rs=nothing
		set Fso=nothing		
	End Function
	
	Function DeletePic(id)
		Dim Rs,Sql,Path,Fso,Rs2,Sql2
		Path=""
		Path2=""
		Set Fso=New DmFso
		Set Rs=Server.CreateObject("Adodb.recordset")
		Sql="Select kid,kname,kpath from[Liu_Folder] where upid="&id&" and kuser='"&UserName&"'"
 		Rs.open Sql,conn,1,3
		if Not (Rs.eof and Rs.bof) then
		do while not Rs.eof	
			DeletePic(rs("kid"))			
			Path=CreatFolder&Rs("kpath")&Rs("kname")&"/"			
			Set Rs2=Server.CreateObject("Adodb.recordset")
			  Sql2="Select [kid],[Purl],[Pthurl],[PhotoUrl],[Psize] from [Liu_pic] where kid="&Rs("kid")&" and kuser='"&UserName&"'"
				Rs2.open Sql2,conn,1,3
					if Not (Rs2.eof and Rs2.bof) then
						do while not Rs2.eof				
							if Not GetIsNull(rs2("Purl")) and Not GetIsNull(rs2("Pthurl")) and Not GetIsNull(rs2("PhotoUrl")) then
								if Fso.CheckFile(Path&rs2("Purl")) or Fso.CheckFile(Path&rs2("Pthurl")) or Fso.CheckFile(Path&rs2("PhotoUrl")) then'删除操作：检查文件是否存在
								  if Fso.DelFile(Path&rs2("Purl")) and Fso.DelFile(Path&rs2("Pthurl")) and Fso.DelFile(Path&rs2("PhotoUrl")) then '删除操作：删除文件
 									  if rs2("kid")<>0 then							
										  conn.execute("update [Liu_Folder] set kcount=kcount-1 where kid="&rs2("kid")&" and kuser='"&UserName&"'")
									  end if
									  conn.execute("update [Liu_User] set UsedBytes=UsedBytes-"&cdbl(CheckNumeric(rs2("Psize")))&",ResBytes=ResBytes+"&cdbl(CheckNumeric(rs2("Psize")))&" where UserName='"&UserName&"'")					
									  Rs2.delete
								  end if
							    else'不存在则只删除记录
 								  	  if rs2("kid")<>0 then							
										  conn.execute("update [Liu_Folder] set kcount=kcount-1 where kid="&rs2("kid")&" and kuser='"&UserName&"'")
									  end if
									  conn.execute("update [Liu_User] set UsedBytes=UsedBytes-"&cdbl(CheckNumeric(rs2("Psize")))&",ResBytes=ResBytes+"&cdbl(CheckNumeric(rs2("Psize")))&" where UserName='"&UserName&"'")					
									  Rs2.delete
								  end if
							  
							end if
						rs2.movenext
						loop
					end if
				Rs2.close
			Set Rs2=nothing			
		rs.movenext
		loop
		end if
		Rs.close
		Set Rs=nothing
		set Fso=nothing		
	End Function
	
'	Function DeleteFolder(id)
'		Dim Rs,Sql,Path,Fso
'		Set Fso=New DmFso
'		Set Rs=Server.CreateObject("Adodb.recordset")
'		Sql="Select kid,kname,kpath from[Liu_Folder] where upid="&id&" and kuser='"&UserName&"'"
'		Rs.open Sql,conn,1,3
'		if Not (Rs.eof and Rs.bof) then
'		do while not Rs.eof			
'			DeleteFolder(rs("kid"))
'			DeleteFile(rs("kid"))
'			Path=CreatFolder&Rs("kpath")&Rs("kname")
'			if Fso.DelFolder(Path) then
'				rs.delete
'			end if
'		rs.movenext
'		loop
'		end if
'		Rs.close
'		Set Rs=nothing
'		set Fso=nothing		
'	End Function
	
	Function DeleteFile(id)
		Dim Rs,Sql,kpath,kname,Path,Fso
		kpath=DBGetValue("Liu_Folder","kpath","kid="&id&"  and kuser='"&UserName&"'")
		kname=DBGetValue("Liu_Folder","kname","kid="&id&"  and kuser='"&UserName&"'")
		Path=CreatFolder&kpath&kname&"/"
		Set Fso=New DmFso
		Set Rs=Server.CreateObject("Adodb.recordset")
		Sql="Select [kid],[Purl],[Pthurl],[PhotoUrl],[Psize] from [Liu_pic] where kid="&id&" and kuser='"&UserName&"'"
		Rs.open Sql,conn,1,3
		if Not (Rs.eof and Rs.bof) then
		do while not Rs.eof
			if Not GetIsNull(rs("Purl")) and Not GetIsNull(rs("Pthurl")) and Not GetIsNull(rs("PhotoUrl")) then
			
			'删除操作：检查文件是否存在
			if Fso.CheckFile(Path&rs("Purl")) or Fso.CheckFile(Path&rs("Pthurl")) or Fso.CheckFile(Path&rs("PhotoUrl")) then
 				
				 '删除操作：删除文件
					if Fso.DelFile(Path&rs("Purl")) and Fso.DelFile(Path&rs("Pthurl")) and Fso.DelFile(Path&rs("PhotoUrl")) then 
 						if rs("kid")<>0 then
							conn.execute("update [Liu_Folder] set kcount=kcount-1 where kid="&rs("kid")&" and kuser='"&UserName&"'")
						end if
						conn.execute("update [Liu_User] set UsedBytes=UsedBytes-"&cdbl(CheckNumeric(rs("Psize")))&",ResBytes=ResBytes+"&cdbl(CheckNumeric(rs("Psize")))&" where UserName='"&UserName&"'")					
						rs.delete
					end if
					
 			else
			'不存在则只删除记录
 						if rs("kid")<>0 then
							  conn.execute("update [Liu_Folder] set kcount=kcount-1 where kid="&rs("kid")&" and kuser='"&UserName&"'")
						end if
						er.rw rs("Psize")
						conn.execute("update [Liu_User] set UsedBytes=UsedBytes-"&cdbl(CheckNumeric(rs("Psize")))&",ResBytes=ResBytes+"&cdbl(CheckNumeric(rs("Psize")))&" where UserName='"&UserName&"'")					
						rs.delete
					end if
				
			end if
		rs.movenext
		loop
		end if
		Rs.close
		Set Rs=nothing
		set Fso=nothing
	End Function
%>