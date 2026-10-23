<!--#include file="incs/sysCode.asp"-->
<%
call stopsql
id=cint(request.QueryString("html_id"))
set rs=server.CreateObject("adodb.recordset")
rs.open "select top 1 [CodeUrl] from [Liu_Code] where CodeId="&id&"",conn,1,1
	if not rs.eof or not rs.bof then
		CodeUrl=rs("CodeUrl")	
	end if
rs.close
set rs=nothing
set Fso=New DmFso
if Fso.CheckFile(CreatHtml&"/"&CodeUrl) then
	Content=Fso.ReadFile(CreatHtml&"/"&CodeUrl)
end if
set Fso=Nothing
response.Write Content
%>
