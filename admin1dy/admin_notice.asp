  <!--#include file="conn.asp"-->
  <!--#include file="check.asp"-->
 <%
	dim action
	dim totalpage,maxperpage,totalrecords,i,currentpage
	action=request("action")
	 
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<title>公告管理页面</title>
 <link rel="stylesheet" type="text/css" href="images/Admin_Style.Css">

<style type="text/css">
<!--
.STYLE2 {color: #FFFFFF}
-->
</style>
<script type="text/javascript" src="../fckeditor/fckeditor.js"></script> 
<script type="text/javascript" src="js/site.js"></script> 

</head> 

<body leftmargin="0" topmargin="0">
  

 
<%
select case action
  case "add"
    call add() 
  case "addsave"
    call addsave()
  case "edit"
    call edit()
  case "editsave"
    call editsave()
  case "del"
    call del()
	case "istop"
    call istop()
	case "notop"
    call notop()
  case else
    call main()
end select

sub add()
 'newsAdd 公告添加
if not checkflag("NoticeAdd") then
  getshow "对不起，您没有【公告添加】的权限！",""
end if
response.expires=0
%>
<br>
<form action="?action=addsave" method="post" name="add" id="add">
  <table width="750" border="0" align="center" cellpadding="0" cellspacing="1" bgcolor="#CCCCCC" class="border1">
    <tr align="center" onMouseOut="this.style.backgroundColor=''" onMouseOver="this.style.backgroundColor='#BFDFFF'" class="tdbg"> 
      <td height="25" colspan="2" bgcolor="#EFEBEF" class="title"><font class="tfont">公 告 - 添 加</font></td>
    </tr>
	<tr onMouseOut="this.style.backgroundColor=''" onMouseOver="this.style.backgroundColor='#BFDFFF'" class="tdbg">
	  <td width="23%" height="25" align="center" class="tdbg">显示位置：</td>
	  <td width="77%" height="25" class="tdbg">用户中心
	    <input name="kind" type="checkbox" id="kind" value="1"  >
        滚动公告
        <input name="kind" type="checkbox" id="kind" value="2"  > 
        置顶：
	    <input name="istop" type="checkbox" id="istop" value="1">
	    </td>
    </tr>
	<tr onMouseOut="this.style.backgroundColor=''" onMouseOver="this.style.backgroundColor='#BFDFFF'" class="tdbg">
      <td height="25" align="center" class="tdbg"><span >公告标题</span>：</td>
      <td height="25" class="tdbg"> <input name="title" type="text" size="50" maxlength="50" class="input"></td>
    </tr>
    <tr onMouseOut="this.style.backgroundColor=''" onMouseOver="this.style.backgroundColor='#BFDFFF'" class="tdbg"> 
      <td height="25" colspan="2" align="center" class="tdbg"> 
       <input type="hidden" id="FCKeditor1" name="FCKeditor1" value="" style="display:none" /><input type="hidden" id="FCKeditor1___Config" value="SkinPath=/fckeditor/editor/skins/office2003/" style="display:none" /><iframe id="FCKeditor1___Frame" src="/fckeditor/editor/fckeditor.html?InstanceName=FCKeditor1&amp;Toolbar=ydy" width="100%" height="400" frameborder="0" scrolling="no"></iframe></td>
    </tr>
   
    <tr onMouseOut="this.style.backgroundColor=''" onMouseOver="this.style.backgroundColor='#BFDFFF'" class="tdbg"> 
      <td height="30" colspan="2" align="center" class="tdbg"> <input name="Submit" type="submit" class="button" value=" 确定添加 ">
        　 
        <input name="Submit2" type="reset" class="button" value=" 重新填写 "> </td>
    </tr>
  </table>
</form>
<%
end sub

sub addsave()
dim title,content,istop,kind,adduser
title=funstr(trim(request.form("title")))
content=trim(request.form("FCKeditor1"))
istop=funstr(request.form("istop"))
kind=funstr(request.form("kind"))
adduser=funstr(request.form("adduser"))

if istop<>"1" then istop="0"
if content="" then
  getshow  "请输入公告内容",""
end if

 
  
set rs=rsfun("select * from ydy_notice where id is null",3)
rs.addnew()
rs("title")=title
rs("content")=content
rs("istop")=istop
rs("kind")=kind
rs("classType")=1
rs("adduser")=session("admin")
rs.update
rs.close
getshow  "添加公告成功！","admin_notice.asp?action=add"

end sub

sub istop()
 
id=funstr(Trim(Request.QueryString("id")))
if not isinteger(id) then
getshow "对不起，请指定要编辑的公告！",""
end if

conn.execute("update  ydy_notice set istop=1  where id="&id)
getdiv  "置顶公告成功！","admin_notice.asp","istop"

end sub

sub notop()
 
id=funstr(Trim(Request.QueryString("id")))
if not isinteger(id) then
getshow "对不起，请指定要编辑的公告！",""
end if

conn.execute("update  ydy_notice set istop=0  where id="&id)
getdiv  "取消置顶成功！","admin_notice.asp","notop"

end sub


sub edit()

dim id

id=request("id")
if not isinteger(id) then
getshow "对不起，请指定要编辑的公告！",""
end if

set rs=rsfun("select * from ydy_notice where id="&id,1)
if rs.bof and rs.eof then
getshow "找不到公告！",""
end if
content=server.HTMLEncode(rs("content"))'
%>
<br>
<form action="?action=editsave" method="post" name="edit" id="edit">
  <table width="750" border="0" align="center" cellpadding="0" cellspacing="1" bgcolor="#CCCCCC" class="border1">
    <tr align="center" bgcolor="#EFEBEF" > 
      <td height="25" colspan="2" class="title"><span class="STYLE2">公 告 - 编辑</span></td>
    </tr>
    <tr bgcolor="#FFFFFF">
      <td width="23%" height="25" align="center" class="tdbg">显示位置：</td>
      <td width="77%" height="25" class="tdbg"> 
      用户中心：
        <input name="kind" type="checkbox" id="kind" value="1" <%if instr(rs("kind"),"1")>0 then rw "checked" end if%>> 
        滚动公告：
            <input name="kind" type="checkbox" id="kind" value="2" <%if instr(rs("kind"),"2")>0 then rw "checked" end if%>>
置顶 ：
<input name="istop2" type="checkbox" id="istop2" value="1" <%if rs("istop")="1" then rw " checked"%>></td>
    </tr>
    <tr bgcolor="#FFFFFF">
      <td height="25" align="center" class="tdbg">公告标题：</td>
      <td height="25" class="tdbg"><input name="title" type="text" class="input" value="<%=rs("title")%>" size="50" maxlength="50"></td>
    </tr>
    <tr bgcolor="#FFFFFF"> 
      <td height="25" colspan="2" align="center" class="tdbg">  
	  
	    <input type="hidden" id="FCKeditor1" name="FCKeditor1" value="<%=content%>"  style="display:none" /> 
	    <input type="hidden" id="FCKeditor1___Config"  value="SkinPath=/fckeditor/editor/skins/office2003/" style="display:none" />
	    <iframe id="FCKeditor1___Frame" src="/fckeditor/editor/fckeditor.html?InstanceName=FCKeditor1&amp;Toolbar=ydy" width="100%" height="400" frameborder="0" scrolling="no"></iframe> 
		
	 
	  
	  </td>
    </tr>
   
    <tr bgcolor="#FFFFFF"> 
      <td height="30" colspan="2" align="center" class="tdbg"> <input name="Submit" type="submit" class="button" value=" 确定编辑 ">
        　 
        <input name="Submit2" type="reset" class="button" value=" 重新填写 "> <input name="id" type="hidden" id="id" value="<%=id%>">      </td>
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
  getshow "对不起，请指定要编辑的公告！",""
end if

dim title,content,istop,kind,adduser
title=funstr(trim(request.form("title")))
content=trim(request.form("FCKeditor1"))
istop=funstr(request.form("istop"))
kind=funstr(request.form("kind"))
adduser=funstr(request.form("adduser"))
if istop<>"1" then istop="0"


if content="" then
 getshow "请输入公告内容",""
end if
 

set rs=rsfun("select * from ydy_notice where id="&id,3)
 if rs.bof and rs.eof then
	getshow "找不到要编辑的公告！",""
		else
			rs("title")=title
			rs("content")=content
			rs("istop")=istop
			rs("kind")=kind
			rs("classType")=1
			rs("adduser")=session("admin")
		  rs.update
end if

rs.close
set rs=nothing
getshow "编辑公告成功！","admin_notice.asp"

end sub


sub main()
 'news 公告管理
if not checkflag("NoticeManage") then
  getshow "对不起，您没有【公告管理】的权限！",""
end if
response.expires=0
currentpage=request("page")
if not isinteger(currentpage) then
  currentpage=1
else
  currentpage=clng(currentpage)
end if

maxperpage=40
totalrecords=0
totalpage=1
i=1
dim af(1)
af(0)="1,用户中心"
af(1)="2,滚动广告"
       
kind=Trim(Request.QueryString("kind"))
FileName="admin_Notice.asp?Action="&Action&""

strFileName=FileName & "&kind="&replay&""

kindstr="<font color=blue>全部</font>"

sql="select * from ydy_notice where id<>0  "

if kind<>"" then
		 sql=sql&" and  charindex('"&kind&"',kind)>0"
		 'if kind="1" then 
'		 kindstr=kindstr&"用户中心" 
'		 else
'		 kindstr=kindstr&"滚动公告" 
'		 end if
  end if
 
sql=sql&" and classType=1 order by id desc"
set rs=rsfun(sql,1)


%><table width="100%" border="0" align="center" cellpadding="2" cellspacing="1" class="border">
  <tr class="title"> 
    <td  > <table width="100%" border="0" align="center" cellpadding="0" cellspacing="0">
  <tr> 
    <td height="22" style="color:#FFFFFF">.:: 您可以在这里进行[套餐管理]相关操作</td>
    <td width="200" height="22" align="right">
	 
    </td>
  </tr>
</table>
	
	</td>
  </tr>
</table> 

  <center><font size="+3">套餐管理</font></center>
<br>
<br><table width="99%" border="0" align="center" cellpadding="2" cellspacing="1" class="border1">
  <tr class="title">
    <td  ><table width="100%" border="0" align="center" cellpadding="0" cellspacing="0">
      <form name="form1" method="post" action=""><tr>
        <td height="22" style="color:#FFFFFF">  查看方式：<a href="admin_Notice.asp" class="STYLE2">全部问题</a> <a href="admin_notice.asp?kind=1" class="STYLE2">用户中心</a> <a href="admin_notice.asp?kind=2" class="STYLE2">滚动公告</a> <a href="admin_Message.asp?yjf=0"></a>
          </label>
          </td>
        </tr></form>
    </table></td>
  </tr>
  <tr class="title">
    <td class="tdbg"  style="color:black;" >您现在选择的查看方式是：<%= kindstr %> </td>
  </tr>
</table>
<br>
  <div style="position: absolute; width: 100%; height: 100%; z-index: 1; left: 0px; top: 0px; background-color:black;filter:alpha(opacity=70);opacity:0.7; display:none;" id="fugai_layout">
&nbsp;<iframe src="javascript:false" style="position:absolute;visibility:visible;top:0px; left:-1px; width:100%; height:100%; z-index:2; filter='progid:DXImageTransform.Microsoft.Alpha(style=0,opacity=0)';"></iframe></div>

<div id="comadd" style=" position: absolute;z-index: 100; border: 0px solid #333333;  display: none;">

</div><div id="comedit" style=" position: absolute;z-index: 100; border: 0px solid #333333;  display: none;">
 
</div>
<%

dim content
if not(rs.bof and rs.eof) then
  rs.pagesize=maxperpage
  rs.absolutepage=currentpage
  totalpage=rs.pagecount
  totalrecords=rs.recordcount %>

<table width="99%" border="0" align="center" cellpadding="2" cellspacing="1"   class="border1">
  <tr align="center" bgcolor="#EFEBEF">
    
    <td width="84" class="title">显示位置</td>
    <td width="330" height="25" class="title"><span class="STYLE2">公告内容</span></td>
    <td width="67" height="25" class="title"><span class="STYLE2">添加日期</span></td>
	<td width="60" class="title">状态</td>
    <td width="67" height="25" class="title"><span class="STYLE2">操　作</span></td>
  </tr>
  <%do until rs.eof or i>maxperpage
	title=rs("title")
	content=rs("content")
	content=replace(content,chr(13),"<br>")
	content=replace(content," ","&nbsp;")
	%>
  <tr onMouseOut="this.style.backgroundColor=''" onMouseOver="this.style.backgroundColor='#BFDFFF'" class="tdbg">
    
    <td  ><%dim i,j,temp
	   
	  for i=0 to ubound(af)
	    temp=split(af(i),",")
		response.write "<input type='checkbox' value='"&temp(0)&"' name='kind'"
		if instr(rs("kind"),temp(0))>0 then
		  response.write " checked"
		end if
		response.write ">"&temp(1)&""
	 
	  next
	 %></td>
    <td height="23"><%=title%>&nbsp;</td>
    <td height="23">&nbsp;<%=formatdatetime(rs("intime"),2)%></td>
	<td  ><%if rs("istop")="1" then
	 fcolor "red","顶" 
	 else
	  rw "顶"
	 end if
	 %></td>
    <td height="23" align="center"> <% If rs("istop")="1"then 
	ctype="notop" 
	cname="<font color=green>撤顶</font>"
	else
	ctype="istop" 
	cname="<font color=black>置顶</font>"
	end if 
	 %><a href="javascript:showIframe('comedit','admin_notice.asp?action=<%= ctype %>&id=<%=rs("id")%>','56','500')" ><%= cname %></a> 
	<%=getlink("编辑","?action=edit&id="&rs("id")&"","") %> 
      <a href="?action=del&id=<%=rs("id")%>" title="删除公告..." onClick="javascript:if(confirm('是否真的要删除公告吗？\n\n系统提示：删除后不可恢复！')){return true;}else{return false;}">删除</a></td>
  </tr>
  <%rs.movenext
   i=i+1
   loop
  %> 
  
  <%if totalrecords>0 then  %>
 	<%call showpage("admin_notice.asp",totalrecords,maxperpage,true,true,"个【公告】信息")
 	 %> 
   <% End If %>

</table>
 
<%
rs.close
set rs=nothing
 
else
 %> <br>
<br>

   <table width="100%" border="0" cellpadding="0" cellspacing="1" bgcolor="#CCCCCC" class="border1">
  <tr align="center" class="title"> 
    <td width="100%" height="23"  align="center"> <% rw("暂无公告信息") %></td>
  
  </tr>
</table>

<%
  end if
%>

<%
end sub

sub del()

dim id:id=request("id")

if not isinteger(id) then
getshow "请指定要删除的公告！",""
end if
 
conn.execute("delete  ydy_notice where id="&id)
 
getshow "删除公告成功！","admin_notice.asp"

end sub
%>
</body>
</html>
