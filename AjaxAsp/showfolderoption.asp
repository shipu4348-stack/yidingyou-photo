<!--#include virtual="/incs/SysCode.asp"-->
<% Response.ContentType = "text/html; charset=gb2312" %>
<%
	Dim TempStr,kid,upid,kindtype,SelectStr
	if Not checklogin then
		response.Write(escape("超时"))
		response.End()
	end if
	kid=CheckNumeric(request("kid"))
	kindtype=Checkstr(request("kindtype"))
	upid=0 	
	TempStr=""
	if kindtype="pic" then
		SelectStr="ChangerOptionKind(this.options[this.selectedIndex].value);"
	elseif kindtype="upload" then
		SelectStr="ChangeConfig();"
	end if
	TempStr=TempStr&"<select style='width=120px;' name='kind' id='kind' onchange='"&SelectStr&"'>"
	if kid=0 then
		TempStr=TempStr&"<option value='0' selected >"&"根目录"&"</option>"
	else
		TempStr=TempStr&"<option value='0'>"&"根目录"&"</option>"
	end if
		TempStr=TempStr&folderoption(upid,kid)
	TempStr=TempStr&"</select>"
	response.Write  TempStr

	function folderoption(upid,kid)
		dim TempStr
   		set rsf=server.CreateObject("adodb.recordset")
 		sqlf="select  * from [Liu_Folder] where upid="&upid&" and Kuser='"&UserName&"'   order by kid asc"
 		rsf.open sqlf,conn,1,1
		if not (rsf.eof and rsf.bof) then
			do while not rsf.eof				
				tag=""
				for i=1 to rsf("klevel")
					tag=tag&"&nbsp;+"
				next			
				if kid=rsf("kid") then
					TempStr=TempStr&"<option value='"&rsf("kid")&"' selected >"&tag&rsf("kname")&"</option>"
				else
					TempStr=TempStr&"<option value='"&rsf("kid")&"'>"&tag&rsf("kname")&"</option>"
				end if
 				TempStr=TempStr&folderoption(rsf("kid"),kid)
			rsf.movenext			
			loop		 
		end if
		rsf.close
		set rsf=nothing
		folderoption=Tempstr
	end function
	
%>