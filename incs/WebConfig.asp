<%
set rs=server.CreateObject("adodb.recordset")
Sql="select top 1 [MarkPlace],[MarkFontStr],[MarkFontColor],[MarkFont],[MarkFontSize],[MarkFontBold],[MarkPicClarity],[MarkPicColor],[MarkPic],[SysNotic],[SysDisplayType],[SysPageCount],[SysViewType],[SysUpLoadType] from [Liu_User] where username='"&UserName&"'"
rs.open Sql,conn,1,1
if Not (rs.eof and rs.bof) then
MarkPlace=rs("MarkPlace")
MarkFontStr=rs("MarkFontStr")
MarkFontColor=rs("MarkFontColor")
MarkFont=rs("MarkFont")
MarkFontSize=rs("MarkFontSize")
MarkFontBold=rs("MarkFontBold")
MarkPicClarity=rs("MarkPicClarity")
MarkPicColor=rs("MarkPicColor")
MarkPic=rs("MarkPic")
SysNotic=rs("SysNotic")
SysDisplayType=rs("SysDisplayType")
SysPageCount=rs("SysPageCount")
SysViewType=rs("SysViewType")
SysUpLoadType=rs("SysUpLoadType")
end if
rs.close
set rs=nothing
%>