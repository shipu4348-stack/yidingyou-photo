 <!--#include file="Conn.asp"-->
<!--#include file="check.asp" -->
<html>

<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<meta name="GENERATOR" content="Microsoft FrontPage 4.0">
<meta name="ProgId" content="FrontPage.Editor.Document">
<title>管理首页</title>
<link rel="stylesheet" type="text/css" href="images/Admin_Style.Css">
 
 <body leftmargin="0" topmargin="0">
<table width="100%" border="0" align="center" cellpadding="2" cellspacing="1" class="border">
  <tr class="title">
    <td height="22"  align="center"><strong><a href="javascript:this.location.reload()"></a></strong></td>
    <td width="767" height="22"  align="center"><div align="left"><strong>.:: 欢迎光临 后台管理界面</strong></div></td>
    <td width="47"  align="center"><strong><a href="javascript:this.location.reload()"><img src="images/refresh.gif" alt="刷新" width="40"
height="12" border="0"></a></strong></td>
  </tr>
  <tr class="tdbg">
    <td width="143" height="30" ><strong>管理导航：</strong></td>
    <td colspan="2"><b>欢迎管理员：<font color="#FF0000"><%=Session("admin")%></font> 使用本系统</b></td>
  </tr>
  <tr class="tdbg">
    <td height="30" ><a href="../index.asp" target="_blank">快速访问网站首页</a></td>
    <td colspan="2">  </td>
  </tr>
  
</table>
 
</body>

</html>
