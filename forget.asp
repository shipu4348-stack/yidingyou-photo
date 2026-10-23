<!--#include file="incs/model.asp"-->
<%
Action=request("action")
if Action="forget" then
	if cstr(session("getcode"))<>cstr(trim(request.Form("verify"))) then
		GoError("请输入正确的验证码!")
	else
		username=Replace(Request.Form("username"),"’","’’")
		email=trim(Request.Form("email"))
		answer=Replace(Request.Form("answer"),"’","’’")
		set rs=server.CreateObject("adodb.recordset")
		sql="select top 1 [username],[pwd],[email],[answer] from [Liu_User] where username='"&username&"' and email='"&email&"'"
		rs.open sql,conn,1,1
		if rs.eof or rs.bof then
			response.Write("<script>alert('email输入不正确!');history.go(-1);</script>")
			response.End()
		else
			if answer<>rs("answer") then
				response.Write("<script>alert('密码提示问题不正确!');history.go(-1);</script>")
				response.End()
			else
				session("forgetname")=rs("username")
				response.Redirect "findpassword.asp"
			end if
		end if	
		rs.close
		set rs=nothing
	end if	
end if	
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<HEAD><TITLE>一定呦 - 网络图片存储系统 www.1dy.cc - 找回密码</TITLE>
<META http-equiv=Content-Type content="text/html; charset=gb2312">

<link href="css/css2.css" rel="stylesheet" type="text/css">
<link href="images/2010/Global.css" type="text/css" rel="stylesheet"/>
 <link rel="stylesheet" type="text/css" href="images/2010/top_bar.css?tm=20100709" />
<link href="images/2010/main.css" type="text/css" rel="stylesheet"/>
<link href="images/2010/login.css" type="text/css" rel="stylesheet"/>
<script src="js/jquery-1.4.2.min.js" type="text/javascript"></script>

<script language="javascript" src="js/checkfindpassword.js"></script>
</HEAD>
<BODY>
<center>
  <a name="top"></a>
<!--topbar-->
<!--#include File="top.asp"-->
<!--/topbar-->

  <form action="forget.asp?action=forget" method="POST" name="forgot" onSubmit="return check_forgot();">
  <table width="755" border="0" cellpadding="0" cellspacing="0">

    <tr>
      <td height="16" background="images/046.gif">　</td>
    </tr>
    <tr>
      <td align="left" class="td1" height="34"><img src="images/047.gif" width="52" height="29" 

align="absmiddle">第一步：找回登陆密码信息</td>
    </tr>
  </table>
  <table width="755" border="0" cellspacing="0" cellpadding="0">
    <tr>
      <td width="170" height="30" align="right"> 会员名： <span class="O">*</span> </td>
      <td width="180" align="left">&nbsp;
          <input name="username" type="text" style="height:16px; width:150px; ime-mode:disabled;" 

maxlength="20" class="input1"></td>
      <td width="35" rowspan="2"><hr width="1" size="50" color="#EFEFEF" noshade></td>
      <td width="370" rowspan="2" align="left" class="td2"> 请正确填写您的会员名然后点击显示提示问题。</td>
    </tr>
    <tr>
      <td height="30">　</td>
      <td align="left">&nbsp;
          <input type="button" name="check_username" value="请点击显示提示问题" onClick="checkfind(document.forgot.username.value);" onMouseOver="this.style.cursor='hand';"/></td>
    </tr>
  </table>
  <hr width="755" size="1" color="#EFEFEF" noshade>
  <table width="755" border="0" cellspacing="0" cellpadding="0">
    <tr>
      <td width="170" height="30" align="right"> 密码提示问题： <span class="O">*</span> </td>
      <td width="180" align="left">&nbsp;
          <input name="question" id="question" type="text" style="height:16px; width:150px;" maxlength="25" 

class="input3" readonly></td>
      <td width="35" rowspan="2"><hr width="1" size="50" color="#EFEFEF" noshade></td>
      <td width="370" rowspan="2" align="left" class="td2"> 请正确填写您注册时设定的密码保护答案，然后填写 

第二步。

</td>
    </tr>
    <tr>
      <td height="30" align="right">密码问题答案： <span class="O">* </span> </td>
      <td align="left">&nbsp;
          <input name="answer" type="text" style="height:16px; width:150px;" maxlength="25"  

class="input1"></td>
    </tr>
  </table>
  <br>
  <table width="755" border="0" cellpadding="0" cellspacing="0">
    <tr>
      <td height="16" background="images/046.gif">　</td>
    </tr>
    <tr>
      <td align="left" class="td1"><img src="images/047.gif" width="52" height="29" align="absmiddle">第二步：找回会员名及密码保护信息
        </td>
    </tr>
  </table>
  <table width="755" border="0" cellspacing="0" cellpadding="0">
    <tr>
      <td width="170" height="30" align="right">电子邮件： <span class="O">* </span>      </td>
      <td width="180" align="left">&nbsp; <input name="email" type="text" style="height:16px; 

width:150px;" maxlength="100" class="input3" onChange="javascript:this.value=this.value.toLowerCase

();"></td>
      <td width="35" rowspan="2"><hr width="1" size="60" color="#EFEFEF" noshade></td>
      <td width="370" rowspan="2" align="left" class="td2">请正确填写您注册时的电子信箱地址跟验证码，来找回您的相关注册信息。如果您只找回会员名或密码保护信息，只需进行这步即可。如果您忘记了您的信箱地址，那我们无法帮您找回任何信息。</td>
    </tr>
    <tr>
      <td height="30" align="right">验证码： <span class="O">*</span> </td>
      <td width="180" align="left"><table width="176" border="0" cellspacing="0" cellpadding="0">
        <tr>
          <td width="80" align="right"><input type="text" name="verify" style="height:16px; width:54px;" 

maxlength="4"  class="input1"></td>
          <td align="right"><table width="70" height="20" border="1" cellspacing="0" cellpadding="0" 

bordercolor="#A5A6AD" style="border-collapse:collapse">
              <tr>
                <td align="center" bgcolor="#FFFFFF">
 <img src="GetCode.asp" width="40" height="10" border="0" style="cursor:pointer" 
alt="点击刷新获取有效验证码" onclick="this.src=this.src+'?'" align="absmiddle">
</td>
              </tr>
          </table></td>
        </tr>
      </table></td>
    </tr>
  </table>
<hr width="755" size="1" color="#EFEFEF" noshade>
  <table width="755" border="0" cellspacing="0" cellpadding="0">
    <tr>
      <td height="50" align="center"><input type="submit" class="register_b" name="Submit" value="点 击 找 回 密 码"></td>
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
    <!--<tr>
      <td align="center" valign="top" height="30"><span style="font-family: Geneva, Arial, Helvetica, 

sans-serif; font-size:12px">车车写代码旗下网站｜一定呦版权所有 &copy; 2009<br />官方业务咨询：<a href="tencent://message/?uin=12345678&amp;Site=www.1dy.cc&amp;Menu=yes"><font color="#000000"><u>QQ:12345678</u></font></a> <a href="http://www.taobao.com/webww/ww.php?v=2&touid=鍙背&siteid=cntaobao&status=1&charset=utf-8"  target="_blank">&nbsp;&nbsp;<font color="#000000"><u>旺旺:一定呦</u></font></a> 汇款底单:Email:YOUR_EMAIL@qq.com<br>
            <a href="http://www.bizcn.com/_default/icp.jsp" target="_blank"><font color="#000000">《中华人民共和国电信与信息服务业务》经营许可证</font></a>&nbsp; 
            <a href="http://www.miibeian.gov.cn/" target="_blank"><font color="#000000">网站备案号：豫ICP备12345678号</span></td>
    </tr>-->
  </table>
  <!--#include file="foot.asp"-->
</center>

</BODY></HTML>
<script>
var xmlHttp;
function GetXmlHttpObject()
{
	var xmlHttp=null;
	try
	  {
	  // Firefox, Opera 8.0+, Safari
	  xmlHttp=new XMLHttpRequest();
	  }
	catch (e)
	  {
	  // Internet Explorer
	  try
		{
		xmlHttp=new ActiveXObject("Msxml2.XMLHTTP");
		}
	  catch (e)
		{
		xmlHttp=new ActiveXObject("Microsoft.XMLHTTP");
		}
	  }
	return xmlHttp;
}

function updatePage() {
  if (xmlHttp.readyState == 4)
  {
    var response = unescape(xmlHttp.responseText);
	//alert(response);
	if(response.indexOf("空")>=0)
	{
		alert('用户名不能为空!');
	}
    else if(response.indexOf("未")>=0)
    {
     	alert('很抱歉，未找到用户!');
    }
    else
    {
     document.getElementById("question").value=response;
    }    
   }  
}

function checkfind(findname)
{
    xmlHttp=GetXmlHttpObject();
    var url = "findquestion.asp?username="+findname;
    xmlHttp.open("GET", url, true);
    xmlHttp.onreadystatechange = updatePage;
    xmlHttp.send(null);  
    return true;
}
</script>