<!--#include virtual="/incs/SysCode.asp"-->
<% Response.ContentType = "text/html; charset=gb2312" %>
<%
	if Not checklogin then
		response.Write(escape("超时"))
		response.End()
	end if
	Dim upid,klevel,kname,Fso,Rs
	upid=CheckNumeric(request("upid"))'父类ID
	klevel=CheckNumeric(request("klevel"))'目录深度
	kname=unescape(Checkstr(request("kname")))'目录名称
	kpath=unescape(Checkstr(request("kpath")))'目录路径
	if kpath<>"/" then
		kpath=kpath&"/"
	end if	
	set rs=server.CreateObject("adodb.recordset")
	rs.open "select top 1 [kname] from [Liu_Folder] where kname='"&kname&"' and kuser='"&UserName&"' and klevel="&klevel&"",conn,1,1
	if not (rs.eof and rs.bof) then
		response.Write(escape("同名"))
	else	
		Set Fso=New DmFso
		if Not GetIsNull(CreatFolder) and Fso.CheckFolder(CreatFolder) then		
			if Not Fso.CheckFolder(CreatFolder&kpath&kname) then
				Fso.CreateFolder(CreatFolder&kpath&kname)			
				conn.execute("insert into [Liu_Folder] ([kname],[kpath],[upid],[klevel],[kuser]) values('"&kname&"','"&kpath&"',"&upid&","&klevel&",'"&UserName&"')")
				response.Write(escape("成功"))
			end if
		end if
		Set Fso=Nothing	
	end if
	rs.close
	set rs=nothing
%>