<!--#include file="Conn.asp"-->
<!--#include file="check.asp" -->
<!--#include file="md5.asp"-->
<%
 dim action,af(25)
action=request("action")
af(0)="ManageNotice,【公告管理】"
af(1)="NoticeAdd,公告添加"
af(2)="NoticeManage,公告管理"

af(3)="ManageUser,【用户管理】"
af(4)="UserManage,用户管理"
af(5)="DataManage,数据更新"

af(6)="ManageCombo,【套餐管理】"
af(7)="ComboManage,套餐管理"
 
af(8)="ManagePay,【缴费开通】"
af(9)="Pay,缴费开通"


af(10)="ManageAD,【广告管理】"
af(11)="ADadd,广告添加"
af(12)="ADManage,广告管理"
af(13)="ADUpload,附件管理"
af(14)="ADManage,调用代码"

af(15)="ManageServer,【服务与支持】"
af(16)="Server,服务与支持"

af(17)="ManageBadInfo,【不良信息】"
af(18)="BadInfo,不良信息"
af(19)="ManageAdmin,【管理账号】"
af(20)="adminAdd,管理员添加"
af(21)="admin,管理员管理"
af(22)="editPass,修改我的密码"
af(23)="system,【网站配置】"
af(24)="serviceManage,客服管理"
af(25)="serverManage,客服管理"
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<title>管理员管理</title>
<script language=javascript src="mouse_up.js"></script>
<link rel="stylesheet" type="text/css" href="images/Admin_Style.Css">

<script language=javascript>
<!--
function CheckAll(form)  {
  for (var i=0;i<form.elements.length;i++)    {
    var e = form.elements[i];
    if (e.name != 'chkall')       
	 e.checked = form.chkall.checked; 
   }
  }
-->
</script>
<style type="text/css">
<!--
.STYLE2 {color: #FFFFFF}
-->
</style>
</head>
 <body bgcolor="#FFFFCC" text="#000000" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">

<table width="100%" border="0" align="center" cellpadding="2" cellspacing="1" class="border">
  <tr class="title"> 
    <td  > <table width="100%" border="0" align="center" cellpadding="0" cellspacing="0">
  <tr> 
    <td height="22" style="color:#FFFFFF">.:: 您可以在这里进行[管理员管理]相关操作</td>
    <td width="200" height="22" align="right">
	 
    </td>
  </tr>
</table>
	
	</td>
  </tr>
</table> 
 
<br>

<%
select case action
  case "edit"
   call adminedit()
  case "saveedit"
   call saveedit()
  case "myedit"
   call myedit()
  case "savemyedit"
   call savemyedit()
  case "del"
   call del()
  case "add"
   call add()
  case "addsave"
   call addsave()
  case else
   call main()
end select

conn.close
set conn=nothing

sub main()

'11 管理员管理
if not checkflag("admin") then
  getshow "对不起，您没有【管理员管理】的权限！","" 
end if
response.expires=0

set rs=conn.execute("select * from ydy_admin")
%>
<form name="form1" method="post" action="">
  <table width="83%" border="0" align="center" cellpadding="0" cellspacing="1" bgcolor="#CCCCCC" class="border1">
    <tr bgcolor="#EFEBEF">
      <td height="23" colspan="7" align="center" class="title"><span class="STYLE2">系统管理员帐号列表</span> 　[<a href="?action=add" class="STYLE2">添加一个新帐号</a>]</td>
    </tr>
    <tr bgcolor="#FFFFFF">
      <td width="4%" height="23" align="center" class="tdbg">ID</td>
      <td width="12%" height="23" align="center" class="tdbg">登陆帐号</td>
      <td width="7%" height="23" align="center" class="tdbg">登陆次数</td>
      <td width="26%" height="23" align="center" class="tdbg">最后登陆</td>
      <td width="14%" height="23" align="center" class="tdbg">最后登陆IP</td>
      <td width="6%" height="23" align="center" class="tdbg">状态</td>
      <td width="11%" height="23" align="center" class="tdbg">操　作</td>
    </tr>
    <%
if rs.bof and rs.eof then
%>
    <tr bgcolor="#FFFFFF" class="tdbg">
      <td height="23" colspan="7" align="center"><font color="#FF0000">还没有任何管理员帐号！</font>　　<a href="?action=add">请先添加</a></td>
    </tr>
    <%
else
do until rs.eof
%>
    <tr bgcolor="#FFFFFF">
      <td height="23" class="tdbg">&nbsp;<%=rs("id")%></td>
      <td height="23" class="tdbg">&nbsp;<a href="?action=edit&admin=<%=rs("admin")%>" title="编辑管理员：<%=rs("admin")%>"><%=rs("admin")%></a></td>
      <td height="23" class="tdbg">&nbsp;<b><%=rs("logins")%></b></td>
      <td height="23" class="tdbg">&nbsp;<b><%=rs("lastlogin")%></b></td>
      <td height="23" class="tdbg">&nbsp;<b><%=rs("lastip")%></b></td>
      <td height="23" align="center" class="tdbg"><%
	  if rs("islock") then
	    response.write "<font color=red>锁定</font>"
	  else
	    response.write "正常"
	  end if%>
      </td>
      <td height="23" align="center" class="tdbg"><a href="?action=edit&admin=<%=rs("admin")%>" title="编辑管理员：<%=rs("admin")%>">编辑</a>　<a href="?action=del&id=<%=rs("id")%>" title="删除管理员：<%=rs("admin")%>" onClick="javascript:if(confirm('是否真的要删除管理员：<%=rs("admin")%>？\n\n系统提示：删除后不可恢复')){return true;}else{return false;}">删除</a></td>
    </tr>
    <%
rs.movenext
loop
end if
rs.close
set rs=nothing
%>
  </table>
  <br>
  <br>
</form>
<%end sub

sub adminedit()

'04 管理员管理
if not checkflag("admin") then
 getshow "对不起，您没有【管理员管理】的权限！",""
end if

dim admin
admin=checkstr(session("admin"))
if admin="" then
  getshow "对不起，请指定要编辑的管理员帐号！","" 
  response.end
end if
if session("dj")="1" then admin=checkstr(request("admin")) 

set rs=server.createobject("adodb.recordset")
sql="select * from ydy_admin where admin='"&admin&"'"
rs.open sql,conn,1,1
if rs.bof and rs.eof then
  getshow "对不起，找不到您要编辑的管理员帐号信息！","" 
  response.end
end if
%>
<form action="?action=saveedit" method="post" name="adminedit" id="adminedit">
  <table width="500" border="0" align="center" cellpadding="4" cellspacing="1" bgcolor="#CCCCCC" class="border1">
    <tr align="center" bgcolor="#EFEBEF" > 
      <td colspan="2" class="title"><span class="STYLE2">编 辑 管 理 员</span></td>
    </tr>
    <tr bgcolor="#FFFFFF"> 
      <td width="116" height="22" align="right" class="tdbg">登陆帐号：</td>
      <td width="365" class="tdbg"> 
        <input name="admind" type="text" disabled class="input" id="admind" value="<%=rs("admin")%>">
        * </td>
    </tr>
	<tr bgcolor="#FFFFFF">
      <td height="22" align="right" class="tdbg">用户等级：</td>
      <td class="tdbg">  
  <select name="dj" id="dj">
  <option value="1" <%if rs("rate")="1" then  Response.Write("selected")%>>管理员</option>
  <option value="2" <%if rs("rate")="2" then  Response.Write("selected")%>>编辑人员</option>
</select>
      *</td>
    </tr>
    <tr bgcolor="#FFFFFF"> 
      <td height="22" align="right" class="tdbg">登陆密码：</td>
      <td class="tdbg"> 
        <input name="password" type="password" class="input" id="password" value="<%=rs("password")%>">
        *!-如果不想修改请保持原样-&gt;</td>
    </tr>
    <tr bgcolor="#FFFFFF"> 
      <td height="22" align="right" class="tdbg">管理权限：</td>
      <td class="tdbg"><table border=0 cellspacing=0 cellpadding=0><tr>
        <%dim i,j,temp
	  j=1
	  for i=0 to ubound(af)
	    temp=split(af(i),",")
 
		response.write "<td height=20 width='33%'><input type='checkbox' value='"&temp(0)&"' name='flag'"
		if instr(rs("flag"),temp(0))>0 then
		  response.write " checked"
		end if
		response.write ">"&temp(1)&"</td>"
		if j mod 3=0 then response.write "</tr><tr>"
		j=j+1
	  next
	 %>
	 </tr></table>
        <input name="chkall" type="checkbox" id="chkall3" onClick="CheckAll(this.form)" value=""> 
        &nbsp;<font color="#FF0000">全　　选</font> </td>
    </tr>
    <tr bgcolor="#FFFFFF"> 
      <td height="22" align="right" class="tdbg">帐号状态：</td>
      <td class="tdbg">&nbsp; 
        <input type="radio" name="islock" value="true" <%if rs("islock") then response.write " checked"%>>
        锁定　
        <input type="radio" name="islock" value="false" <%if not rs("islock") then response.write " checked"%>>
        正常</td>
    </tr>
    <tr bgcolor="#FFFFFF"> 
      <td colspan="2" align="center" class="tdbg"> 
        <input name="Submit" type="submit" class="button" value=" 确 定 编 辑"> 
        <input type="hidden" name="action" value="saveedit"> <input name="admin" type="hidden" id="admin" value="<%=rs("admin")%>">      </td>
    </tr>
  </table>
</form>
<%
rs.close
set rs=nothing
end sub

sub myedit()

'05 修改我的密码
if not checkflag("admin") then
  getshow "对不起，您没有【修改密码】的权限！","" 
end if

dim admin
admin=checkstr(session("adminname"))
if admin="" then
getshow "对不起，请指定要编辑的管理员帐号！","" 
  response.end
end if

set rs=server.createobject("adodb.recordset")
sql="select * from ydy_admin where admin='"&admin&"'"
rs.open sql,conn,1,1
if rs.bof and rs.eof then
 getshow "对不起，找不到您要编辑的管理员帐号信息！","" 
  response.end
end if
%>
<form action="?action=savemyedit" method="post" name="myedit" id="myedit">
  <table width="500" border="0" align="center" cellpadding="4" cellspacing="1" bgcolor="#CCCCCC" class="border1">
    <tr align="center" bgcolor="#EFEBEF" > 
      <td colspan="2" class="title"><span class="STYLE2">修 改 我 的 登 陆 密 码</span></td>
    </tr>
    <tr bgcolor="#FFFFFF"> 
      <td width="116" height="22" align="right" class="tdbg">登陆帐号：</td>
      <td width="365" class="tdbg"> 
        <input name="admind" type="text" disabled class="input" id="admind" value="<%=rs("admin")%>">
        * </td>
    </tr>
		<tr bgcolor="#FFFFFF"> 
      <td width="116" height="22" align="right" class="tdbg">用户等级：</td>
      <td width="365" class="tdbg"> 
       <%if rs("rate")="1" then  Response.Write("管理员")%>
    <%if rs("rate")="2" then  Response.Write("编辑人员")%>
         * </td>
    </tr>
    
    <tr bgcolor="#FFFFFF"> 
      <td height="22" align="right" class="tdbg">登陆密码：</td>
      <td class="tdbg"> 
        <input name="password" type="password" class="input" id="password" value="<%=rs("password")%>">
        *!-如果不想修改请保持原样-&gt;</td>
    </tr>
   <%if    session("dj")="1" then%>
    <tr bgcolor="#FFFFFF"> 
      <td height="22" align="right" class="tdbg">管理权限：</td>
      <td class="tdbg"> <table border=0 cellspacing=0 cellpadding=0><tr>
        <%dim i,j,temp
	  j=1
	  for i=0 to ubound(af)
	    temp=split(af(i),",")
		response.write "<td height=20 width='33%'><input type='checkbox' value='"&temp(0)&"' name='flag'"
		if instr(rs("flag"),temp(0))>0 then
		  response.write " checked"
		end if
		response.write " disabled>"&temp(1)&"</td>"
		if j mod 3=0 then response.write "</tr><tr>"
		j=j+1
	  next
	 %>
	 </tr></table>
        <input name="chkall" type="checkbox" id="chkall" onClick="CheckAll(this.form)" value="" disabled> 
        &nbsp;<font color="#FF0000">全　　选</font> </td>
    </tr>
	<%end if%>
    <tr bgcolor="#FFFFFF"> 
      <td height="22" align="right" class="tdbg">帐号状态：</td>
      <td class="tdbg">&nbsp; 
        <input type="radio" name="islock" value="true" <%if rs("islock") then response.write " checked"%> disabled>
        锁定　
        <input type="radio" name="islock" value="false" <%if not rs("islock") then response.write " checked"%> disabled>
        正常</td>
    </tr>
    <tr bgcolor="#FFFFFF"> 
      <td colspan="2" align="center" class="tdbg"> 
        <input name="Submit" type="submit" class="button" value=" 确 定 编 辑"> 
        <input type="hidden" name="action" value="saveedit"> <input name="admin" type="hidden" id="admin" value="<%=rs("admin")%>">      </td>
    </tr>
  </table>
</form>
<%
rs.close
set rs=nothing
end sub

sub saveedit()

'04 管理员管理
if not checkflag("admin") then
  getshow "对不起，您没有【管理员管理】的权限！","" 
end if

 dim admin,password,flag,islock
 admin=checkstr(trim(request("admin")))
 password=checkstr(trim(request("password")))
 flag=request("flag")
 dj=request("dj")
 islock=request("islock")

 set rs=server.createobject("adodb.recordset")
 sql="select * from ydy_admin where admin='"&admin&"'"
 rs.open sql,conn,1,3
 
 if rs.bof and rs.eof then
    getshow "对不起，没有找到相关管理员帐号的资料.","" 
 else
   if rs("password")<>password then '修改了密码
     rs("password")=md5(password,"long")
   end if
   rs("flag")=flag

   rs("rate")=dj
   rs("islock")=islock
   rs.update
   if session("flag")<>flag  then   
   session("flag")=flag
 	    response.Write "<script language='javascript'>window.parent.left.location.reload()</script>"
	end if
		 getshow "恭喜您，成功的编辑了管理员："&admin&"的信息！","admin_admin.asp?admin="&admin&"" 
   end if
  rs.close
  set rs=nothing

end sub
 
sub savemyedit()

'05 修改我的密码
if not checkflag("admin") then
   getshow "对不起，您没有【修改密码】的权限！","" 
end if


 dim admin,password
  admin=checkstr(trim(request("admin")))
 password=checkstr(trim(request("password")))

 set rs=server.createobject("adodb.recordset")
 sql="select * from ydy_admin where admin='"&admin&"'"
 rs.open sql,conn,1,3
 
 if rs.bof and rs.eof then
   getshow "对不起，没有找到相关管理员帐号的资料！","" 
 else
   if rs("password")<>password then '修改了密码
     rs("password")=md5(password,"long")
   end if
  
   rs.update
   getshow "恭喜您，修改登陆密码成功！","admin_admin.asp?action=myedit&admin="&admin&""
  end if
  rs.close
  set rs=nothing

end sub

sub add()

'04 管理员管理
if not checkflag("adminAdd") then
 getshow "对不起，您没有【管理员添加】的权限！","" 
end if 

%>
<form action="?action=addsave" method="post" name="add" id="add">
  <table width="500" border="0" align="center" cellpadding="4" cellspacing="1" bgcolor="#CCCCCC" class="border1">
    <tr align="center" bgcolor="#EFEBEF" > 
      <td height="23" colspan="2" class="title"><span class="STYLE2">添 加 管 理 员</span></td>
    </tr>
    <tr bgcolor="#FFFFFF"> 
      <td width="116" height="22" align="right" class="tdbg">登陆帐号：</td>
      <td width="365" class="tdbg"> 
        <input type="text" name="admin" class="input">
        * </td>
    </tr>
	<tr bgcolor="#FFFFFF"> 
      <td height="22" align="right" class="tdbg">登陆密码：</td>
      <td class="tdbg"> 
        <input type="password" name="password" class="input">
        * </td>
    </tr>
    <tr bgcolor="#FFFFFF">
      <td height="22" align="right" class="tdbg">用户等级：</td>
      <td class="tdbg"> <select name="dj" id="dj">
  <option value="1" selected>管理员</option>
  <option value="2">编辑人员</option>
 
</select></td>
    </tr>
    <tr bgcolor="#FFFFFF"> 
      <td height="22" align="right" class="tdbg">管理权限：</td>
      <td class="tdbg"><table border=0 cellspacing=0 cellpadding=0><tr>
        <%dim i,j,temp
	  j=1
	  for i=0 to ubound(af)
	    temp=split(af(i),",")
		response.write "<td height=20 width='33%'><input type='checkbox' value='"&temp(0)&"' name='flag'>"&temp(1)&"</td>"
		if j mod 3=0 then response.write "</tr><tr>"
		j=j+1
	  next
	 %>
	 </tr></table>
        <input name="chkall" type="checkbox" id="chkall" onClick="CheckAll(this.form)" value="">
        &nbsp;<font color="#FF0000">全　　选</font> </td>
    </tr>
    <tr bgcolor="#FFFFFF"> 
      <td colspan="2" align="center" class="tdbg"> 
      <input name="Submit2" type="submit" class="button" value="确 定 添 加">      </td>
    </tr>
  </table>
</form>
<%
end sub

sub addsave()

'04 管理员管理
if not checkflag("admin") then
 getshow "对不起，您没有【管理员管理】的权限！","" 
end if

 dim admin,password,flag
 admin=checkstr(trim(request("admin")))
  password=checkstr(trim(request("password")))
 dj=checkstr(trim(request("dj")))
 flag=request("flag")
 
 set rs=server.createobject("adodb.recordset")
 sql="select * from ydy_admin where admin='"&admin&"'"
 rs.open sql,conn,1,3
 
 if rs.bof and rs.eof then
   rs.addnew()
   rs("admin")=admin
    rs("password")=md5(password,"long")
   rs("flag")=flag
   rs("rate")=dj
   rs.update
 getshow "添加管理员成功！","admin_admin.asp" 
 else
  getshow  "此管理帐号已经存在了！","" 
 end if
 rs.close
 set rs=nothing
end sub

sub del()

'04 管理员管理
if not checkflag("admin") then
  getshow "对不起，您没有【管理员管理】的权限！","" 
end if

 dim id
 id=request("id")
 if not isinteger(id) then 
  getshow "系统提示：请正确指定要删除管理员帐号！","" 
 end if
 
 '删除管理员帐号
 sql="delete from ydy_admin where id="&id
 conn.execute(sql)
 
 
getshow "系统提示：删除管理员帐号成功！","admin_admin.asp" 
end sub
%>

</body>
</html>
