<!--#include file="incs/model.asp"-->
<%
	username=session("forgetname")
	if username="" and not isnull(username) then
		session("forgetname")=""
		response.Write("<script>alert('参数错误，请正确使用!');window.close();</script>")
		response.End()
	end if
	
	if request("action")="password" then
		pwd=request.Form("password")
		set rs=server.CreateObject("adodb.recordset")
		rs.open "select top 1 [pwd] from [Liu_user] where username='"&username&"'",conn,1,3
		if rs.eof or rs.bof then
			session("forgetname")=""
			response.Write("<script>alert('参数错误，请正确使用!');window.close();</script>")
			response.End()
		else
			rs("pwd")=md5(pwd,"long")
			rs.update
			rs.close
			set rs=nothing
			session("forgetname")=""
			response.Write("<script>alert('修改成功，请重新登录!');location.href='index.asp';</script>")
			response.End()
		end if
	end if
	
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<HEAD><TITLE>一定呦 - 找回密码</TITLE>
<META http-equiv=Content-Type content="text/html; charset=gb2312">
<LINK href="images/default.css" type=text/css rel=stylesheet>
<link href="css/css2.css" rel="stylesheet" type="text/css">
<script language="javascript" src="js/checkfindpassword.js"></script>
</HEAD>
<BODY>
<center>
  <table width="755" border="0" cellspacing="0" cellpadding="0">
    <tr>
      <td width="230"><img src="images/logo1.jpg" style="width:180px; height:72px; border:0px; margin-top:4px; display:inline;"></td>
      <td height="70" align="right" valign="top"><table width="470" border="0" cellspacing="0" 

cellpadding="0">
          <tr>
            <td width="26"><img src="images/035.gif" width="26" height="32"></td>
            <td align="center" background="images/037.gif"><script language="javascript" 

src="js/menu2.js"></script></td>
            <td width="26"><img src="images/036.gif" width="26" height="32"></td>
          </tr>
      </table></td>
    </tr>
  </table>
  <form action="findpassword.asp?action=password" method="POST" name="forgot" onSubmit="return check_password();">
  <table width="755" border="0" cellpadding="0" cellspacing="0">

    <tr>
      <td height="16" background="images/046.gif">　</td>
    </tr>
    <tr>
      <td align="left" class="td1" height="34"><img src="images/047.gif" width="52" height="29" 

align="absmiddle">第三步：请重设密码</td>
    </tr>
  </table>
  <hr width="755" size="1" color="#EFEFEF" noshade>
  <table width="755" border="0" cellspacing="0" cellpadding="0">
    <tr>
      <td width="170" height="30" align="right"> 新密码： <span class="O">*</span> </td>
      <td width="180" align="left">&nbsp;
        <input name="password" id="password" type="text" style="height:16px; width:150px;" maxlength="25" class="input3"></td>
      <td width="35" rowspan="2"><hr width="1" size="50" color="#EFEFEF" noshade></td>
      <td width="370" rowspan="2" align="left" class="td2">请记好填写的密码</td>
    </tr>
    <tr>
      <td height="30" align="right">确认密码： <span class="O">* </span></td>
      <td align="left">&nbsp;
          <input name="compassword" id="compassword" type="text" style="height:16px; width:150px;" maxlength="25" class="input3"></td>
    </tr>
  </table>
<hr width="755" size="1" color="#EFEFEF" noshade>
  <table width="755" border="0" cellspacing="0" cellpadding="0">
    <tr>
      <td height="50" align="center"><input type="submit" class="register_b" name="Submit" value=" 点 击 重 设 密 码"></td>
    </tr>
  </table>
  <hr width="755" size="1" color="#EFEFEF" noshade>
  <table width="755" border="0" cellspacing="0" cellpadding="0">
    <tr>
      <td height="50" align="left"><div id="ReadContract">
<div id="ContractContent" style="width:90%; height:60px; line-height:150%;">
  <table width="100%"  border="0" cellspacing="0" cellpadding="0">
    <tr>
      <td width="20" valign="top"><img src="images/053.gif" width="14" height="17"> </td>
      <td>帮助提示：如果您要找回登陆密码，需要完全正确填写 <strong>第一步</strong> 和 <strong>第二步

</strong> 提交；如果您只要找回您的会员名或密码提示问题答案，只需要填写 <strong>第二步</strong> 进行提交。

如果您的电子邮箱地址不正确，或者您已经忘记注册时填写的邮箱地址，那我们无法帮您找回任何信息。你只能 <A 

href="register.asp">点击这里</A> 重新进行注册。所以请保护好、记好您注册时填写的电子信箱。</td>
    </tr>
  </table>
  </div>
      </div></td>
    </tr>
  </table>
  </form>
  <table width="755"  border="0" cellspacing="0" cellpadding="0">
    <tr>
      <td height="20"><hr width="500" size="1"></td>
    </tr>
    <tr>
      <td align="center" valign="top" height="30"><span style="font-family: Geneva, Arial, Helvetica, 

sans-serif; font-size:12px">车车写代码旗下网站｜一定呦版权所有 &copy; 2009<br />官方业务咨询：<a href="tencent://message/?uin=12345678&amp;Site=www.1dy.cc&amp;Menu=yes"><font color="#000000"><u>QQ:12345678</u></font></a> <a href="http://www.taobao.com/webww/ww.php?v=2&touid=鍙背&siteid=cntaobao&status=1&charset=utf-8"  target="_blank">&nbsp;&nbsp;<font color="#000000"><u>旺旺:一定呦</u></font></a> 汇款底单:Email:YOUR_EMAIL@qq.com<br>
            <a href="http://www.bizcn.com/_default/icp.jsp" target="_blank"><font color="#000000">《中华人民共和国电信与信息服务业务》经营许可证</font></a>&nbsp; 
            <a href="http://www.miibeian.gov.cn/" target="_blank"><font color="#000000">网站备案号：豫ICP备12345678号</span></td>
    </tr>
  </table>
</center>

</BODY></HTML>
