<!--#include file="./incs/SysCode.asp"-->
<!--#include file="./incs/Cls_Md5.asp"-->
<%
dim rsf
if request("action")="save" and Request.Cookies("1dy")("yjf")<>2 then
	oldpwd=request.Form("oldpwd")
	newpwd=request.Form("newpwd")
	newpwd1=request.Form("newpwd1")
	if newpwd<>newpwd1 then
		response.write "<script>alert('两次密码输入不一致!');history.go(-1);</script>"
		response.End()
	end if
	oldpwd1=md5(oldpwd,"long")
	oldpwd2=SerUPassEnCode(oldpwd)
	set rs2=server.CreateObject("adodb.recordset")
	rs2.open "select [pwd],[ftppwd] from [Liu_User] where  username='"&UserName&"' and pwd='"&oldpwd1&"'",conn,1,3
	if rs2.eof and rs2.bof then
		response.write "<script>alert('老密码不正确!');history.go(-1);</script>"
		response.End()
	else
		rs2("pwd")=md5(newpwd,"long")
		rs2("ftppwd")=SerUPassEnCode(newpwd)
		rs2.update
'		CDB()
'		set rsf=server.CreateObject("adodb.recordset")
'		rsf.open "select id from [ftp_users] where ftpUserName='"&UserName&"'",Fconn,1,1
'		if not(rsf.eof and rsf.bof) then
'			Fconn.execute("update [ftp_users] set ftpPassword='"&SerUPassEnCode(newpwd)&"',str1='" & newpwd & "' where ftpUserName='"&UserName&"'")
'		end if
'		ClDB()
	end if
	rs2.close
	set rs2=nothing		
	response.Write "<script>alert('密码修改成功，请重新登陆!');location.href='exit.asp';</script>"	
end if
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
<title>密码修改</title>
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
  <li><a href="setacinfo.asp">帐户信息</a></li>
  <li class="inpos"><a href="setpass.asp">密码修改</a></li>
  <li><a href="setoth.asp">帮助中心</a></li>
</ul>
<br />
<table width="100%" border="0" cellspacing="0" cellpadding="0">
 <form action="setpass.asp?action=save" method="post" >
  <tr>
    <td height="1" bgcolor="#e1e1e1"></td>
  </tr>
    <tr>
    <td bgcolor="#fafafa" class="itemlist">登录密码修改 <img src="images/0026.gif" width="14" height="14" /></td>
  </tr>
  <tr>
    <td class="itemlist" style="height:50px;">原登录密码 
    <input name="oldpwd" type="password" class="text" id="textfield" size="30" maxlength="20" onpropertychange="checknum(this)" /></td>
  </tr>
      
    <tr>
    <td class="itemlist" style="height:50px;">新登录密码
      <input name="newpwd" type="password" class="text" id="textfield2" size="30" maxlength="20" onpropertychange="checknum(this)" /></td>
  </tr>

    <tr>
    <td class="itemlist" style="height:50px;">重复新密码
      <input name="newpwd1" type="password" class="text" id="textfield3" size="30" maxlength="20" onpropertychange="checknum(this)" /></td>
  </tr>
        
      <tr>
     <td height="1" bgcolor="#e1e1e1"></td>
  </tr>
<tr>
    <td class="subitem" style="height:70px;"><input type="submit" value="保存" class="btnt2"  /> &nbsp;
		
	<input type="reset" value="恢复为默认" class="btnt6" /></td>
  </tr>
 </form>
</table>
</body>
</html>
<script   language=javascript>   
  var   re=/^[A-Za-z0-9]*$/;   
  var   str='';   
  function   checknum(obj)   
  {   
   if(re.test(obj.value)==false){
    obj.value=str;
    alert("只能输入字母和数字！");
 } 
 else {
    str=obj.value;
 }      
  }   
  </script>