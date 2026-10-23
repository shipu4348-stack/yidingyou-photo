<!--#include file="Conn.asp"-->
<!--#include file="md5.asp" -->
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<title>管理员登陆</title>
  <link href="Admin_Style.Css" rel="stylesheet" type="text/css">
 
 </head>
  <Script Language="JavaScript"  >
  function SetFocus()
{
if (document.login.admin.value=="")
	document.login.admin.focus();
else
	document.login.admin.select();
}

  if(self!=top) { // 被嵌在框架里的情况
    top.location=self.location;
   }
 // if(opener) { // 被window.opne()函数弹出的情况
  //  opener.location.replace(self.location);
   // self.close();
   //}
  if(window.dialogArguments) { // 被window.showModalDialog()等弹出模态窗口的情况
    window.dialogArguments.location.replace(self.location);
    self.close();
   }
   </script>
<body bgcolor="#799AE1" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">
<%

dim action:action=request("action")
if action="chk" then
  '管理登陆
 dim admin,password
 
 admin=checkstr(trim(request.form("admin")))
 password=checkstr(trim(request.form("password")))
 
 if admin="" or password="" then
   getshow "请输入登陆帐号或登陆密码！",""
 end if
 
 set rs=rsfun("select * from ydy_admin where admin='"&admin&"'",3)
  if rs.bof and rs.eof then
   getshow "对不起，您的帐号或密码有误！",""
 elseif rs("password")<>md5(password,"long") then
   getshow  "对不起，您的帐号或密码有误！","" 
 elseif rs("islock") then
   getshow  "对不起，您的帐号处于锁定状态，请和管理员联系！","" 
 else
   '登陆成功
   
   rs("logins")=rs("logins")+1  '登陆数加１
   rs("lastlogin")=now()  '最后登陆
   rs("lastip")=request.servervariables("remote_addr")  '写入最后登陆ＩＰ
   session("flag")=rs("flag")  '管理员帐号
   session("adminname")=admin
   session("admin")=admin
   session("dj")=rs("rate")
   session("showflag")="0"&rs("rate")&""
   rs.update
 
 
  rs.close
  set rs=nothing
  reurl "admin_index.asp"
   %>
  
  <p>&nbsp;</p>
<p>&nbsp;</p>
<p>&nbsp;</p>
<p>&nbsp;</p>
 
<% End If %>

<%
elseif action="logout" then
  
   '退出登陆
   session("admin")=""
   session("flag")=""
   
   getshow "您已经成功退出管理，确定返回首页","../index.asp" 
else
 '登陆界面
%>
 

<p>&nbsp;</p>
<p>&nbsp;</p>
<p>&nbsp;</p>
<p>&nbsp;</p>
<form action="admin_login.asp?action=chk" method="post" name="login" id="login">
  <table width="300" border="0" align="center" cellpadding="2" cellspacing="1" class="border1">
    <tr align="center"  > 
      <td height="23" colspan="2" bgcolor="#EFEBEF" class="title"><span class="STYLE1">管理员登陆</span></td>
    </tr>
    <tr onMouseOut="this.style.backgroundColor=''" onMouseOver="this.style.backgroundColor='#BFDFFF'" class="tdbg"> 
      <td width="73" height="30" align="center" >登陆帐号：</td>
      <td width="224" height="30" >&nbsp; 
        <input name="admin" type="text" class="input" id="admin" size="25"></td>
    </tr>
    <tr onMouseOut="this.style.backgroundColor=''" onMouseOver="this.style.backgroundColor='#BFDFFF'" class="tdbg"> 
      <td height="30" align="center" >登陆密码：</td>
      <td height="30" >&nbsp; 
        <input name="password" type="password" class="input" id="password" size="25"></td>
    </tr>
    <tr align="center" onMouseOut="this.style.backgroundColor=''" onMouseOver="this.style.backgroundColor='#BFDFFF'" class="tdbg"> 
      <td height="30" colspan="2" > 
        <input name="Submit" type="submit" class="button" value=" 登 陆 ">
        <font color="#FF0000">如果您不是管理员请离开这里！</font> </td>
    </tr>
  </table>
</form>
<%end if%>
<script language="JavaScript" type="text/JavaScript">
SetFocus(); 
</script>
<p>&nbsp;</p>
</body>
</html>
