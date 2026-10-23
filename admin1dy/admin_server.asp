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
<title>分站管理页面</title>
 <link rel="stylesheet" type="text/css" href="images/Admin_Style.Css">

<style type="text/css">
<!--
.STYLE2 {color: #FFFFFF}
-->
</style>
<script type="text/javascript" src="js/site.js"></script> 
<script language="JavaScript">
 // var XSSspRefURL = window.location.href._encodeHTML();
   var XSSspRefURL =window.location.href;
  	function writestr(str)
	{
	document.getElementById("strid").innerHTML=str;
	}
 	</script>
    <script type="text/ecmascript" >
function divclose(divname){
parent.document.getElementById(divname).style.display='none';
parent.document.getElementById('fugai_layout').style.display='none';
}
</script>
</head> 

<body   topmargin="0" leftmargin="0" rightmargin="0" bottommargin="0">

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
  case else
    call main()
end select

sub add()
 'newsAdd 分站添加
if not checkflag("ComboManage") then
  getshow "对不起，您没有【分站添加】的权限！",""
end if
response.expires=0
%>
 
  <form action="?action=addsave" method="post" name="add" id="add">
  <table width="501" border="0" align="center" cellpadding="0" cellspacing="1" bgcolor="#CCCCCC" class="border1">
    <tr align="center" onMouseOut="this.style.backgroundColor=''" onMouseOver="this.style.backgroundColor='#BFDFFF'" class="tdbg"> 
      <td width="94%" height="25" bgcolor="#EFEBEF" class="title"><font class="tfont">分 站 - 添 加</font></td>
      <td width="6%" align="right" bgcolor="#EFEBEF" class="title"><a href="#" onClick="closedivc('comadd')"><img style="cursor:hand;" onClick="divclose('comadd');" src="images/close.gif"  border="0" /></a></td>
      
    </tr>
	<tr onMouseOut="this.style.backgroundColor=''" onMouseOver="this.style.backgroundColor='#BFDFFF'" class="tdbg">
	  <td height="25" colspan="2" align="left" class="tdbg">分站名称：
        <input name="sname" type="text" class="input" id="sname" value="" size="10" maxlength="20" >
分站编号：
<input name="sid" type="text" class="input" id="sid" value="" size="5" maxlength="7" onKeyUp="value=value.replace(/[^\d]/g,'')">使用空间：
<input name="allsize" type="text" class="input" id="allsize" value="0" size="5" maxlength="7" onKeyUp="value=value.replace(/[^\d]/g,'')">使用人数：
<input name="alluser" type="text" class="input" id="alluser" value="0" size="5" maxlength="7" onKeyUp="value=value.replace(/[^\d]/g,'')">
      <br>
      是否注册：
      <input name="isreg" type="radio" value="1" >
      是<input name="isreg" type="radio" value="0" checked>否
     是否默认：<input name="istop" type="radio" value="1" checked>是<input name="istop" type="radio" value="0" >否 
      <input name="Submit" type="submit" class="button" value=" 确定编辑 ">
      </td>
    </tr>
  
  </table>
</form>
 
<%
end sub

sub addsave()
dim sname,sid,allsize,alluser,isreg,istop
sname=funstr(trim(request.form("sname")))
sid=trim(request.form("sid"))
allsize=funstr(request.form("allsize"))
alluser=funstr(request.form("alluser"))
isreg=funstr(request.form("isreg"))
istop=funstr(request.form("istop"))
 

if sname="" then
  getshow  "请输入分站名称",""
end if

if sid="" then
  getshow  "请输入分站编号",""
end if

 if istop=1 then 
conn.execute("update  liu_server set istop=0 ")
end if
  
set rs=rsfun("select * from liu_server where id is null",3)
rs.addnew()
rs("sname")=sname
rs("sid")=sid
rs("allsize")=allsize
rs("alluser")=alluser
rs("isreg")=isreg
rs("istop")=istop 
rs.update
rs.close
getdiv "添加分站成功！","","addcombo"   

end sub

sub edit()

dim id,currentpage

id=request("id")
currentpage=cint(Request("page"))
if not isinteger(id) then
getshow "对不起，请指定要编辑的分站！",""
end if

set rs=rsfun("select * from liu_server where id="&id,1)
if rs.bof and rs.eof then
getshow "找不到分站！",""
end if
 
%>

 <form action="?action=editsave&page=<%=currentpage%>" method="post" name="edit" id="edit">
  <table width="500" border="0" align="center" cellpadding="0" cellspacing="1" bgcolor="#CCCCCC" class="border1">
    <tr align="center" bgcolor="#EFEBEF" > 
      <td width="468" height="25" class="title"><span class="STYLE2">分 站 - 编辑</span></td>
      <td width="27" class="title"><img style="cursor:hand;" onClick="divclose('comedit');" src="images/close.gif"  border="0" /></td>
    </tr>
    <tr bgcolor="#FFFFFF">
      <td height="25" colspan="2" align="left" class="tdbg">分站名称：
        <input name="sname" type="text" class="input" id="sname" value="<%=rs("sname")%>" size="10" maxlength="20" >
分站编号：
<input name="sid" type="text" class="input" id="sid" value="<%=rs("sid")%>" size="5" maxlength="7" onKeyUp="value=value.replace(/[^\d]/g,'')">使用空间：
<input name="allsize" type="text" class="input" id="allsize" value="<%=rs("allsize")%>" size="5" maxlength="7" onKeyUp="value=value.replace(/[^\d]/g,'')">使用人数：
<input name="alluser" type="text" class="input" id="alluser" value="<%=rs("alluser")%>" size="5" maxlength="7" onKeyUp="value=value.replace(/[^\d]/g,'')">
      <br>
      是否注册：
      <input name="isreg" type="radio" value="1" <% If rs("isreg")=1 Then %>checked<% End If %>>
      是<input name="isreg" type="radio" value="0" <% If rs("isreg")=0 Then %>checked<% End If %>>否
     是否默认：<input name="istop" type="radio" value="1" <% If rs("istop")=1 Then %>checked<% End If %>>是<input name="istop" type="radio" value="0" <% If rs("istop")=0 Then %>checked<% End If %>>否 <input name="id" type="hidden" id="id" value="<%=id%>"> 
      <input name="Submit" type="submit" class="button" value=" 确定编辑 ">
      <br></td>
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
  getshow "对不起，请指定要编辑的分站！",""
end if

dim sname,sid,allsize,alluser,isreg,istop
sname=funstr(trim(request.form("sname")))
sid=trim(request.form("sid"))
allsize=funstr(request.form("allsize"))
alluser=funstr(request.form("alluser"))
isreg=funstr(request.form("isreg"))
istop=funstr(request.form("istop"))
 

if sname="" then
  getshow  "请输入分站名称",""
end if

if sid="" then
  getshow  "请输入分站编号",""
end if
if istop=1 then 
conn.execute("update  liu_server set istop=0 ")
end if

  set rs=rsfun("select * from liu_server where id="&id,3)
 if rs.bof and rs.eof then
	getshow "找不到要编辑的分站！",""
		else
			rs("sname")=sname
			rs("sid")=sid
			rs("allsize")=allsize
			rs("alluser")=alluser
			rs("isreg")=isreg
			rs("istop")=istop
 		  rs.update
end if
rs.close
set rs=nothing



getdiv "修改分站成功","admin_server.asp?page="&currentpage&"","editok"
 end sub


sub main()
 'news 分站管理
if not checkflag("ComboManage") then
  getshow "对不起，您没有【分站管理】的权限！",""
end if



response.expires=0
currentpage=request("page")
kind=funstr(request("kind"))
comkind=funstr(request("comkind"))
orderby=funstr(request("orderby"))
if not isinteger(currentpage) then
  currentpage=1
else
  currentpage=clng(currentpage)
end if

maxperpage=30
totalrecords=0
totalpage=1
i=1



FileName="admin_server.asp?Action="&Action&""

strFileName=FileName & "&orderby=" & orderby&"&kind="&kind


sql="select * from liu_server where id<>0 "

if comkind<>"" then
sql=sql&"and comkind="&comkind&""
end if

if orderby="" then
     orderby="id"
 end if

 if kind<>"desc" and kind<>"asc" or isnull(kind) then 
 kind="desc" 
 end if
 
 sql=sql&" order by "&orderby&" "&kind&""
 
 set rs=rsfun(sql,1)
dim content
if not(rs.bof and rs.eof) then
  rs.pagesize=maxperpage
  rs.absolutepage=currentpage
  totalpage=rs.pagecount
  totalrecords=rs.recordcount %>
  
<div style="position: absolute; width: 100%; height: 100%; z-index: 1; left: 0px; top: 0px; background-color:black;filter:alpha(opacity=70);opacity:0.7; display:none;" id="fugai_layout">
&nbsp;<iframe src="javascript:false" style="position:absolute;visibility:visible;top:0px; left:-1px; width:100%; height:100%; z-index:2; filter='progid:DXImageTransform.Microsoft.Alpha(style=0,opacity=0)';"></iframe></div>

<div id="comadd" style=" position: absolute;z-index: 100; border: 0px solid #333333;  display: none;">

</div><div id="comedit" style=" position: absolute;z-index: 100; border: 0px solid #333333;  display: none;">
 
</div>
  
<table width="100%" border="0" align="center" cellpadding="2" cellspacing="1" class="border">
  <tr class="title"> 
    <td  > <table width="100%" border="0" align="center" cellpadding="0" cellspacing="0">
  <tr> 
    <td height="22" style="color:#FFFFFF">.:: 您可以在这里进行[分站管理]相关操作</td>
    <td width="200" height="22" align="right">
	 
    </td>
  </tr>
</table>
	
	</td>
  </tr>
</table> 

  <center><font size="+3">分站管理</font></center>

<br>
<br>
  
<table width="100%" border="0" align="center" cellpadding="0" cellspacing="1"   class="border1">
  <tr align="center" bgcolor="#EFEBEF">
    
    <td width="7%" height="25" class="title">&nbsp;</td>
    <td height="25" colspan="6" class="title">&nbsp;&nbsp;<a href="javascript:showIframe('comadd','admin_server.asp?action=add','78','502')" style="color:red;">添加分站</a> &nbsp;    </td>
    <td width="16%" height="25" class="title"><span class="STYLE2">操　作</span></td>
  </tr>  <tr onMouseOut="this.style.backgroundColor=''" onMouseOver="this.style.backgroundColor='#BFDFFF'" class="tdbg">
    <td>ID<a  href="?orderby=id&kind=desc">&uarr;</a><a href="?orderby=id&kind=asc">&darr;</a></td>
    <td width="11%" height="23">分站名</td>
    <td width="12%">分站编号</td>
    <td width="10%">注册状态</td>
    <td width="12%">默认注册</td>
    <td width="14%">使用空间</td>
    <td width="18%">被使用人数 排序<a  href="?orderby=usenum&kind=desc">↑</a><a href="?orderby=usenum&kind=asc">↓</a></td>
    <td height="23" align="center">&nbsp;</td>
  </tr>
  <%
  color=""
  do until rs.eof or i>maxperpage
 
	 
 	%>

  <tr onMouseOut="this.style.backgroundColor=''" onMouseOver="this.style.backgroundColor='#BFDFFF'" class="tdbg">
    
    <td><%=rs("id")%></td>
    <td height="23" style="color:#<%= color %>"><%=rs("sname")%></td>
    <td><%=rs("sid")%></td>
    <td><%if rs("isreg")=1 then 
	   	rw "<span style=""color:blue"">允许注册</span>"
	  else
	 	 rw "不允许注册"
	  end if
 	%></td>
    <td><%if rs("istop")=1 then 
	   	rw "<span style=""color:blue"">默认</span>"
	  else
	 	 rw "非默认"
	  end if
 	%></td>
    <td><%=rs("allsize")%></td>
    <td><%=rs("alluser")%>个</td>
    <td height="23" align="center"><a href="javascript:showIframe('comedit','admin_server.asp?action=edit&id=<%=rs("id")%>&page=<%=currentpage%>','76','500')" style="color:red;">编辑</a> 
    <a href="?action=del&id=<%=rs("id")%>" title="删除分站..." onClick="javascript:if(confirm('是否真的要删除分站吗？\n\n系统提示：删除后不可恢复！')){return true;}else{return false;}">删除</a></td>
  </tr>
  <%rs.movenext
   i=i+1
   loop
  %> 
  
  <%if totalrecords>0 then  %>
 	<%call showpage(strFileName,totalrecords,maxperpage,true,true,"个【分站】信息")
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
    <td width="100%" height="23"  align="center"> <% rw("暂无分站信息") %></td>
  
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
getshow "请指定要删除的分站！",""
end if
 
conn.execute("delete  liu_server where id="&id)
 
getshow "删除分站成功！","admin_server.asp"

end sub
%>

 

 

</body>
</html>
