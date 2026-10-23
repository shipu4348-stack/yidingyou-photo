 <!--#include file="Conn.asp"-->
<!--#include file="check.asp" -->
 <%
'ad 广告管理
if not checkflag("AD") then
  getshow  "对不起，您没有【管理广告】的权限！",""
end if

dim action
action=request("action")
 
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<title>广告管理相关</title>
<script language=javascript src="mouse_up.js"></script>
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

 <center><font size="+3">网站前台信息</font></center>

<%
select case action
  case "edit"
    call edit()
  case "editsave"
    call editsave()
end select
%> 
<br>
<%

sub edit()
dim id
id=request("id")
if not isinteger(id) then
getshow  "对不起，请指定要编辑的内容！",""
end if

set rs=conn.execute("select top 1 [id],[title],[content] from ydy_info where id="&id)
if rs.bof and rs.eof then
getshow  "找不到内容！",""
end if 
%>
   
<br>
<form action="?action=editsave" method="post" name="edit" id="edit">
  <table width="98%" border="0" align="center" cellpadding="0" cellspacing="1" bgcolor="#CCCCCC" class="border1">
    <tr align="center"  class="title" > 
      <td height="25" colspan="3">  内容编辑 </td>
    </tr>
    <tr bgcolor="#FFFFFF"> 
      <td width="15%" height="25" align="center" class="tdbg">项目名称：</td>
      <td width="85%" height="25" class="tdbg"><input name="infoname" type="text" class="input" id="infoname" value="<%=rs("title")%>" readonly size="40"></td>
    </tr>
    <tr bgcolor="#FFFFFF"> 
      <td height="25" align="center" class="tdbg">项目内容：</td>
      <td height="25" class="tdbg">
      	<input type="hidden" id="FCKeditor1" name="FCKeditor1" value="<%=server.HTMLEncode(rs("content"))%>"  style="display:none" /> 
	    <input type="hidden" id="FCKeditor1___Config"  value="SkinPath=/fckeditor/editor/skins/office2003/" style="display:none" />
	    <iframe id="FCKeditor1___Frame" src="/fckeditor/editor/fckeditor.html?InstanceName=FCKeditor1&amp;Toolbar=ydy" width="100%" height="500" frameborder="0" scrolling="no"></iframe> 
      </td>
    </tr>
    <tr bgcolor="#FFFFFF"> 
      <td height="30" colspan="3" align="center" class="tdbg"> 
        <input name="Submit" type="submit" class="button" value=" 确定编辑 ">        　 
        <input name="Submit2" type="reset" class="button" value=" 重新填写 ">
      <input name="id" type="hidden" id="id" value="<%=id%>"> </td>
    </tr>
  </table>
</form>
<%
rs.close
set rs=nothing
end sub

sub editsave()

dim id:id=request("id")
if not isinteger(id) then
getshow  "对不起，请指定要编辑的内容！",""
end if

dim infoname,content
infoname=funstr(trim(request.form("infoname")))
content=request.form("FCKeditor1")

if content="" then
getshow  "内容不能为空！","" 
end if

set rs=server.createobject("adodb.recordset")
sql="select top 1 [content] from ydy_info where id="&id
rs.open sql,conn,1,3

if rs.bof and rs.eof then
getshow  "找不到要编辑的内容！","" 
else
 rs("content")=content	
 rs.update
end if

rs.close
set rs=nothing
getshow  "修改成功！","admin_info.asp?action=edit&id="&id 

end sub
%>
</body>
</html>

