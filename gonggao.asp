<!--#include file="incs/model.asp"-->
<%
	call stopsql
	id=CheckNumeric(request.QueryString("id"))
	set rs=server.CreateObject("adodb.recordset")
	rs.open "select * from ydy_notice where id="&id&"",conn,1,1
	if rs.eof or rs.bof then
		response.write "<script language='javascript'>alert('此内容已被删除或不存!');history.back();</script>"
	else
		title=rs("title")
		content=rs("content")
	end if
	rs.close
	set rs=nothing
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
"http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<title>一定呦 - 帮助信息</title>
<link href="css/css2.css" rel="stylesheet" type="text/css">
</head>

<body><center>
  <table width="755" border="0" cellspacing="0" cellpadding="0">
    <tr>
      <td width="230"><img src="images/logo1.jpg" style="width:180px; height:72px; border:0px; margin-top:4px; margin-bottom:4px; margin-left:15px; display:inline;"></td>
      <td height="70" align="right" valign="top"><table width="470" border="0" cellspacing="0" cellpadding="0">
          <tr>
            <td width="26"><img src="images/035.gif" width="26" height="32"></td>
            <td align="center" background="images/037.gif"><script language="javascript" src="js/menu2.js"></script></td>
            <td width="26"><img src="images/036.gif" width="26" height="32"></td>
          </tr>
      </table></td>
    </tr>
  </table>
  <table width="755" border="0" cellspacing="0" cellpadding="0">
    <tr>
      <td><img src="images/067.gif" width="755" height="82"></td>
    </tr>
  </table>
   <hr width="750" size="1" color="#EFEFEF" noshade>
  <table width="750" border="0" cellspacing="0" cellpadding="3">
    <tr>
      <td height="30" class="td2"><b><font color="red"><%=title%></font></b></td>
    </tr>
    <tr>
      <td class="td2"><%=content%></td>
    </tr>
  </table>
  <hr width="750" size="1" color="#4A92DE" noshade>

  <table width="755"  border="0" cellspacing="0" cellpadding="0">
    <tr>
      <td height="20"><hr width="500" size="1"></td>
    </tr>
    <!--<tr>
      <td align="center" valign="top" height="30"><span style="font-family: Geneva, Arial, Helvetica, sans-serif; font-size:12px">车车写代码旗下网站｜一定呦版权所有 &copy; 2009<br />官方业务咨询：<a href="tencent://message/?uin=12345678&amp;Site=www.1dy.cc&amp;Menu=yes"><font color="#000000"><u>QQ:12345678</u></font></a> <a href="http://www.taobao.com/webww/ww.php?v=2&touid=鍙背&siteid=cntaobao&status=1&charset=utf-8"  target="_blank">&nbsp;&nbsp;<font color="#000000"><u>旺旺:一定呦</u></font></a> 汇款底单:Email:YOUR_EMAIL@qq.com<br>
            <a href="http://www.bizcn.com/_default/icp.jsp" target="_blank"><font color="#000000">《中华人民共和国电信与信息服务业务》经营许可证</font></a>&nbsp; 
            <a href="http://www.miibeian.gov.cn/" target="_blank"><font color="#000000">网站备案号：豫ICP备12345678号</font></td>
    </tr>-->
  </table>
  <!--#include file="foot.asp"-->
</center>
</body>
</html>
