<!--#include file="check.asp"-->
<html>

<head>
<title>后台管理</title>
<base target="main">
<style type="text/css">
body         { font-style: normal; font-variant: normal; font-weight: normal; font-size: 9pt; 
               font-family: 宋体; margin: 0px }
table        { border-style: none; border-width: 0px }
td           { font-style: normal; font-variant: normal; font-weight: normal; font-size: 12px; 
               font-family: 宋体 }
img          { vertical-align: bottom; border-style: none; border-width: 0px }
a            { font-style: normal; font-variant: normal; font-weight: normal; font-size: 12px; 
               font-family: 宋体; color: #000000; text-decoration: none }
a:hover      { color: #005774; text-decoration: underline }
.sec_menu    { overflow: hidden; background-color: #D6DFF7; background-repeat: repeat; 
               background-attachment: scroll; border-left: 1px solid white; 
               border-right: 1px solid white; border-bottom: 1px solid white; 
               background-position: 0% }
.menu_title  {  }
.menu_title span { position: relative; top: 2px; left: 8px; color: #005774; font-weight: bold }
.menu_title2 {  }
.menu_title2 span { position: relative; top: 2px; left: 8px; color: #005774; font-weight: bold }
</style>
 <SCRIPT language=javascript1.2>
function showsubmenu(sid)
{
whichEl = eval("submenu" + sid);
if (whichEl.style.display == "none")
{
eval("submenu" + sid + ".style.display=\"\";");
}
else
{
eval("submenu" + sid + ".style.display=\"none\";");
}
}
</SCRIPT>


<%

REM 管理栏目设置
dim menu(10,24)
menu(0,0)="ManageNotice,【公告管理】"
menu(1,0)="ManageHelp,【帮助管理】"
menu(2,0)="ManageUser,【用户管理】"
menu(3,0)="ManageCombo,【套餐管理】"
menu(4,0)="ManagePay,【缴费开通】"
menu(5,0)="ManageAD,【广告管理】"
menu(6,0)="ManageServer,【服务与支持】"
menu(7,0)="ManageBadInfo,【不良信息】"
menu(8,0)="ManageAdmin,【管理账号】"
menu(9,0)="system,【网站配置】"

'---------------------------------------------公告管理
'***************
menu(0,1)="NoticeAdd,<a href='Admin_notice.asp?action=add'>公告添加</a>"
menu(0,2)="NoticeManage,<a href='Admin_notice.asp'>公告管理</a>"

'---------------------------------------------帮助信息管理
'***************
menu(1,1)="helpAdd,<a href='Admin_help.asp?action=add'>帮助添加</a>"
menu(1,2)="helpManage,<a href='Admin_help.asp'>帮助管理</a>"
menu(1,3)="affairsAdd,<a href='Admin_affairs.asp?action=add'>大事记添加</a>"
menu(1,4)="affairsManage,<a href='Admin_affairs.asp'>大事记管理</a>"

'---------------------------------------------用户管理
'***************
menu(2,1)="UserManage,<a href='Admin_user.asp'>用户管理</a>"
menu(2,2)="DataManage,<a href='Admin_data_reload.asp'>数据更新</a>"
 
'---------------------------------------------续费管理
'***************
'menu(2,1)="RenewManage,<a href='retain.asp'>续费管理</a>"


'---------------------------------------------套餐管理
'***************
menu(3,1)="ComboManage,<a href='admin_combo.asp'>套餐管理</a>"

'---------------------------------------------缴费开通
'***************
menu(4,1)="Pay,<a href='admin_user.asp?yjf=0'>缴费开通</a>"
menu(4,2)="Pay,<a href='admin_pic.asp'>用户图片管理</a>"

'---------------------------------------------广告管理
'***************
menu(5,1)="ADadd,<a href='admin_ad.asp?action=add'>广告添加</a>"
menu(5,2)="ADManage,<a href='admin_ad.asp'>广告管理</a>"
menu(5,3)="ADUpload,<a href='Admin_upfilelist.asp'>附件管理</a>"
menu(5,4)="ADManage,<a href='admin_js.asp'>调用代码</a>"
'---------------------------------------------服务与支持
'***************
menu(6,1)="Server,<a href='admin_Message.ASP'>服务与支持</a>"


'---------------------------------------------不良信息
'***************
menu(7,1)="BadInfo,<a href='admin_badinfo.asp'>不良信息</a>"
 
'----------------------管理账号
menu(8,1)="adminAdd,<a href=admin_admin.asp?action=add>管理员添加</a>"
menu(8,2)="admin,<a href=admin_admin.asp>管理员管理</a>"
menu(8,3)="editPass,<a href=admin_admin.asp?action=myedit&admin="&session("admin")&">修改我的密码</a>"
'----------------------网站配置
menu(9,1)="system,<a href=admin_info.asp?action=edit&id=1>注册协议</a>"
menu(9,2)="system,<a href=admin_info.asp?action=edit&id=3>关于我们</a>"
menu(9,3)="serviceManage,<a href=admin_service.asp>客服管理</a>"
menu(9,4)="serviceManage,<a href=admin_config.asp>网站配置</a>"
menu(9,5)="serverManage,<a href=admin_server.asp>分站管理</a>" 
 
%>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
 
</head>

<body bgcolor="#005774" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">
 
<table width="100%" cellpadding="0" cellspacing="0" border="0" align="left">
<tr>
<td valign="top">
<table cellpadding="0" cellspacing="0" width="158" align="center">
<tr>
<td height="42" valign="bottom"><img src="images/title.gif" width="158" height="38"></td>
</tr>
</table>
<table cellpadding="0" cellspacing="0" width="158" align="center">
<tr>
          <td height="25" class="menu_title" onMouseOver="this.className='menu_title2';" onMouseOut="this.className='menu_title';"
background="images/title_bg_quit.gif"><span><a href="admin_main.asp"><b>管理首页</b></a> 
            | <a href="admin_login.asp?action=logout"
target="_top"><b>退出</b></a></span></td>
</tr>
</table>
<table width="100%" border="3" cellpadding="2" cellspacing="2">
<tr>
<td>
<div align="center">
<font color="#FFFFFF"><b>欢迎您：<%=Session("admin")%></b></font>
</div>
</td>
<td>
<div align="center">
<font color="#FFFFFF"></font>
</div>
</td>
</tr>
</table>
<%
	dim j,i
	dim tmpmenu
	dim menuname
	dim menurl
for i=0 to ubound(menu,1)
'response.Write(ubound(menu,1))
'response.End()

 	if isempty(menu(i,0)) then exit for
 dim ktemp
	    ktemp=split(menu(i,0),",")
		'Response.Write(temp(0))
		'Response.Write(temp(1))
		'Response.end
		if instr(session("flag"),ktemp(0))>0 then
		
%>

<table cellpadding="0" cellspacing="0" width="158" align="center">
<tr>
          <td height="25" class="menu_title" style="cursor:pointer;" onMouseOver="this.className='menu_title2';" onMouseOut="this.className='menu_title';"
background="images/admin_left_<%=i+1%>.gif" id="menuTitle1" onClick="showsubmenu(<%=i%>)"><span><%=ktemp(1)%></span></td>
</tr>
<tr>
<td style="display:" id="submenu<%=i%>">
<div class="sec_menu" style="width:158">
<table cellpadding="0" cellspacing="0" align="center" width="135">
	<%
	for j=1 to ubound(menu,2)
	if isempty(menu(i,j)) then exit for
 dim temp
	    temp=split(menu(i,j),",")
		'Response.Write(temp(0))
		'Response.Write(temp(1))
		'Response.end
		if instr(session("flag"),temp(0))>0 then
		%>
<tr>
<td height="20"><%=temp(1)%>
 	 </td>
</tr><%
 		end if
  next
	'判断栏目结束end if语句
%>
</table>


</div>
<div style="width:158">
<table cellpadding="0" cellspacing="0" align="center" width="135">
<tr>
<td height="10"></td>
</tr>
</table>
</div>
</td>
</tr>
</table>
<%
 		end if
 	
%>

<%next%>

<div style="width:158">
<table cellpadding="0" cellspacing="0" width="158" align="left">
<tr>
          <td height="25" class="menu_title" onMouseOver="this.className='menu_title2';" onMouseOut="this.className='menu_title';"
background="images/admin_left_9.gif" id="menuTitle1"><span>版权所有</span></td>
</tr>
<tr>
<td>
<div class="sec_menu" style="width:158">
<table cellpadding="0" cellspacing="0" align="center" width="135">
<tr>
<td height="20">&nbsp;<br>
<br>
版权所有：1DY.CC<br>
 
<br>
</td>
</tr>
</table>
 </div>
</td>
</tr>
</table>
</div>

</td>
</tr>
</table>

</body>

