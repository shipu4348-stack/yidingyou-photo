<!--#include file="./incs/SysCode.asp"-->
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
<title>帐户信息</title>
<link rel="stylesheet" type="text/css" media="all" href="css/setting.css" />
</head>

<body>

<table width="100%" border="0" cellpadding="0" cellspacing="0">
  <tr>
    <td height="40" valign="bottom" background="images/0018.gif" class="em">系统设置</td>
  </tr>
  <tr>
    <td height="1" bgcolor="#c6c6c6"></td>
  </tr>
</table>
<ul id="sets_nav">
  <li id="first"><a href="setsys.asp">个人喜好设置</a></li>
  <li><a href="setmark.asp">水印设置</a></li>
  <li class="inpos"><a href="setacinfo.asp">帐户信息</a></li>
  <li><a href="setpass.asp">密码修改</a></li>
  <li><a href="setoth.asp">帮助中心</a></li>
</ul>
<br />
<table width="100%" border="0" cellspacing="0" cellpadding="0">
<form name="setacinfo" action="setacinfo.asp?action=save" method="post" target="UPresult">
<input type="hidden" name="id" value="<%=userid%>" />
  <tr>
    <td height="1" bgcolor="#e1e1e1"></td>
  </tr>
    <tr>
    <td bgcolor="#fafafa" class="itemlist">用户基本信息 <img src="images/0026.gif" width="14" height="14" /></td>
  </tr>
    <tr>
      <td class="itemlist">会 员 名：<%=username%> ， 电子信箱：<%=email%>；</td>
    </tr>
	<tr>
    <td class="itemlist"> 开通时间：<%=addtime%> ， 到期时间：<%=jfrq%>；</td>
  </tr>
    <tr>
      <td height="1" bgcolor="#e1e1e1"></td>
  </tr>
	<tr>
    <td bgcolor="#fafafa" class="itemlist">用户帐户安全登录查询 <img src="images/0026.gif" width="14" height="14" /></td>
  </tr>
    <tr>
    <td class="itemlist">最后登录IP：<%=LostIp%> ， 最后登录时间：<%=LostTime%>；</td>
  </tr>
   <tr>
    <td height="1" bgcolor="#e1e1e1"></td>
  </tr>
      <tr>
    <td bgcolor="#fafafa" class="itemlist">用户联系信息设置 <img src="images/0026.gif" width="14" height="14" /></td>
  </tr>
      <tr>
    <td class="itemlist">真实姓名：<input type="text" class="text" name="xingming" value="<%=xingming%>" maxlength="30" size="40" /> </td>
  </tr>
      <tr>
    <td class="itemlist">手&nbsp;&nbsp;机&nbsp;&nbsp;号：<input type="text" class="text" name="phone" value="<%=phone%>" maxlength="30" size="40" /> </td>
  </tr>
      <tr>
    <td class="itemlist">身份证号：<input type="text" class="text" name="card" value="<%=card%>" maxlength="30" size="40" /> </td>
  </tr>
        <tr>
    <td class="itemlist">店铺名称：<input type="text" class="text" name="dpname" value="<%=dpname%>" maxlength="30" size="40" /> </td>
  </tr>
      <tr>
        <td class="itemlist">店铺网址：<input type="text" class="text" name="dplink" value="<%=dplink%>" maxlength="80" size="40" /></td>
      </tr>
    <tr>
    <td class="itemlist">旺旺帐户：<input type="text" class="text" name="dpww" value="<%=wwname%>" maxlength="50" size="40" /> </td>
  </tr>
    <tr>
    <td class="itemlist">Q&nbsp;&nbsp;Q号码：<input type="text" class="text" name="dpqq" value="<%=qqhm%>" maxlength="30" size="40" /> </td>
  </tr>
      <tr>
     <td height="1" bgcolor="#e1e1e1"></td>
  </tr>
<tr>
    <td class="subitem"><input type="submit" value="保存" class="btnt2" /> &nbsp;</td>
  </tr>
</form>
</table>
</body>
</html>
<%
if request("action")="save" then
	id=request.Form("id")
	dpname=request.Form("dpname")
	dplink=request.Form("dplink")
	dpww=request.Form("dpww")
	dpqq=request.Form("dpqq")
	realname=request.Form("xingming")
	phone=request.Form("phone")
	card=request.Form("card")
	set rs2=server.CreateObject("adodb.recordset")
	rs2.open "select * from [Liu_User] where id="&id&"",conn,1,3
	rs2("dpname")=dpname
	rs2("dplink")=dplink
	rs2("wwname")=dpww
	rs2("qqhm")=dpqq
	rs2("xingming")=realname
	rs2("phone")=phone
	rs2("card")=card
	rs2.update
	rs2.close
	set rs2=nothing
	response.Write "<script>alert('保存信息成功!');location.href='setacinfo.asp'</script>"
end if
%>