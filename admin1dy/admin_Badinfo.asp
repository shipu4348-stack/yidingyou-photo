 <!--#include file="Conn.asp"-->
<!--#include file="check.asp" -->
 <%
'ad 广告管理
if not checkflag("AD") then
  getshow  "对不起，您没有【管理广告】的权限！",""
end if


dim action
dim totalpage,maxperpage,totalrecords,i,currentpage
action=request("action")
 
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<title>不良信息</title>
<link rel="stylesheet" type="text/css" href="imageS/Admin_Style.Css">
</head>

<body leftmargin="5" topmargin="0">
<table width="100%" border="0" align="center" cellpadding="2" cellspacing="1" class="border">
  <tr class="title"> 
    <td  > <table width="100%" border="0" align="center" cellpadding="0" cellspacing="0">
  <tr> 
    <td height="22" style="color:#FFFFFF">.:: 您可以在这里进行相关操作</td>
    <td width="200" height="22" align="right">
	 
    </td>
  </tr>
</table>
	
	</td>
  </tr>
</table>

 <center><font size="+3">不良信息</font></center>

<%
select case action
  case "del"
    call del()
  case else
    call main()
end select

sub main()

response.expires=0
currentpage=request("page")
if not isinteger(currentpage) then
  currentpage=1
else
  currentpage=clng(currentpage)
end if

maxperpage=15
totalrecords=0
totalpage=1
i=1

set rs=server.createobject("adodb.recordset")
 
sql="select [id],[nameuser],[content],[PostTime] from ydy_buliang where id<>0 order by id desc"
rs.open sql,conn,1,1

if not(rs.bof and rs.eof) then
  rs.pagesize=maxperpage
  rs.absolutepage=currentpage
  totalpage=rs.pagecount
  totalrecords=rs.recordcount
   
%>
 

<table width="100%" border="0" cellpadding="0" cellspacing="1" bgcolor="#CCCCCC" class="border1">
  <tr align="center" class="title"> 
    <td width="4%" height="23" >ID</td>
    <td width="17%" height="23" >举报人用户名</td>
    <td width="28%" height="23"  >举报地址</td>
    <td width="28%" height="23"  >举报时间</td>
    <td width="15%" height="23" >操　作</td>
  </tr>
  <%do until rs.eof or i>maxperpage%>
  <tr bgcolor="#FFFFFF"> 
    <td height="23" class="tdbg">&nbsp;<%=rs("id")%></td>
    <td height="23" class="tdbg">&nbsp;<%=rs("nameuser")%></td>
    <td height="23" class="tdbg">&nbsp;<%=rs("content")%></td>
    <td height="23" class="tdbg">&nbsp;<%=rs("PostTime")%></td>
    <td height="23" align="center" class="tdbg">
      <a href="?action=del&id=<%=rs("id")%>" title="删除信息..." onClick="javascript:if(confirm('确定删除吗？\n\n系统提示：删除后不可恢复！')){return true;}else{return false;}">删除</a></td>
  </tr>
  <%rs.movenext
   i=i+1
   loop
  %>
  <tr bgcolor="#FFFFFF"> 
    <td height="23" colspan="6" class="tdbg"> 
    <%if totalrecords>0 then call showpage("admin_Badinfo.asp",totalrecords,maxperpage,true,true,"条信息")%>    </td>
  </tr>
</table>
<%
else
%>
<table width="100%" border="0" cellpadding="0" cellspacing="1" bgcolor="#CCCCCC" class="border1">
  <tr align="center" class="title"> 
    <td  height="23"  colspan="4" >暂时没有信息</td> 
  </tr>
  </table>
<%
end if
rs.close
set rs=nothing
end sub

sub del()

dim id:id=request("id")

if not isinteger(id) then
getshow  "请指定要删除的信息！","" 
end if

conn.execute("delete  ydy_buliang where id="&id)

getshow  "删除信息成功！","admin_Badinfo.asp"

end sub
%>
</body>
</html>

