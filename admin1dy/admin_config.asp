<!--#include file="Conn.asp"-->
<!--#include file="check.asp" -->
<!--#include virtual="/incs/WebSiteConfig.asp" -->
 <%
'ad 广告管理
if not checkflag("AD") then
  getshow  "对不起，您没有【管理广告】的权限！",""
end if

dim action
action=request("action")
 
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<title>广告管理相关</title>
<script language=javascript src="mouse_up.js"></script>
<link rel="stylesheet" type="text/css" href="imageS/Admin_Style.Css">
</head>

<body leftmargin="5" topmargin="0">
 

<table width="100%" border="0" align="center" cellpadding="2" cellspacing="1" class="border">
  <tr class="title"> 
    <td  > <table width="100%" border="0" align="center" cellpadding="0" cellspacing="0">
  <tr> 
    <td height="22" style="color:#FFFFFF">.:: 您可以在这里进行相关操作</td>
    <td width="200" height="22" align="right">
	 
    </td>
  </tr>
</table>
	
	</td>
  </tr>
</table>

 <center>
   <font size="+3">网站配置信息</font>
 </center>

<%
select case action
  case "editsave"
    call editsave()
  case else
  	call main()
end select
%> 
<br>
<%

sub main()

%>
   
<br>
<form action="?action=editsave" method="post" name="edit" id="edit">
  <table width="98%" border="0" align="center" cellpadding="0" cellspacing="1" bgcolor="#CCCCCC" class="border1">
    <tr align="center"  class="title" > 
      <td height="25" colspan="2">  网站配置 </td>
    </tr>
    <tr bgcolor="#FFFFFF"> 
      <td width="25%" height="25" align="center" class="tdbg">用户注册免费使用天数：</td>
      <td width="75%" height="25" class="tdbg"><input name="regday" type="text" class="input" id="regday" value="<%=regday%>" onKeyUp="this.value=this.value.replace(/\D/g,'')" size="5"></td>
    </tr>
    <tr bgcolor="#FFFFFF"> 
      <td height="25" align="center" class="tdbg">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;是否停止注册：</td>
      <td height="25" class="tdbg"><input name="Isreg" type="radio" id="Isreg" <%If Isreg=0 Then Rw("checked=""checked""")%> value="0">否<input name="Isreg" type="radio" id="Isreg" <%If Isreg=1 Then Rw("checked=""checked""")%> value="1">是</td>
    </tr>
    <tr bgcolor="#FFFFFF"> 
      <td height="25" align="center" class="tdbg">&nbsp;&nbsp;&nbsp;&nbsp;上传文件大小限制：</td>
      <td height="25" class="tdbg"><input name="webupsize" type="text" class="input" id="webupsize" value="<%=webupsize%>" onKeyUp="this.value=this.value.replace(/\D/g,'')" size="10">KB</td>
    </tr>
    <tr bgcolor="#FFFFFF"> 
      <td height="25" align="center" class="tdbg">&nbsp;&nbsp;&nbsp;&nbsp;新注册用户是否开通FTP：</td>
      <td height="25" class="tdbg"><input name="Isftp" type="radio" id="Isftp" <%If Isftp=0 Then Rw("checked=""checked""")%> value="0">否<input name="Isftp" type="radio" id="Isftp" <%If Isftp=1 Then Rw("checked=""checked""")%> value="1">是</td>
    </tr>
    <tr bgcolor="#FFFFFF"> 
      <td height="30" colspan="3" align="center" class="tdbg"> 
        <input name="Submit" type="submit" class="button" value=" 确定编辑 "></td>
    </tr>
  </table>
</form>
<%
end sub

sub editsave()
	Dim TempStr
	TempStr="<"&Chr(37)& vbcrlf
	TempStr=TempStr&"'###############网站配置##########"&vbcrlf
	TempStr=TempStr&"'-----------------用户注册使用天数------------"& vbcrlf
	TempStr=TempStr&"Const regday="&cint(Request.Form("regday"))& vbcrlf
	TempStr=TempStr&"'-----------------是否停止注册------------"& vbcrlf
	TempStr=TempStr&"Const Isreg="&cint(Request.Form("Isreg"))& vbcrlf
	TempStr=TempStr&"'---------------允许上传文件大小----------"& vbcrlf
	TempStr=TempStr&"Const webupsize="&cint(Request.Form("webupsize"))& vbcrlf
	TempStr=TempStr&"'-----------------是否停止FTP------------"& vbcrlf
	TempStr=TempStr&"Const Isftp="&cint(Request.Form("Isftp"))& vbcrlf
	TempStr=TempStr&Chr(37)&">"
	Set Fso=New DmFso
		if Fso.WriteTxtFile(server.MapPath("/incs/WebSiteConfig.asp"),TempStr,1)=1 then 
			getshow "修改成功","admin_config.asp"
		else
			getshow "修改失败","admin_config.asp"
		end if		
	Set Fso=Nothing
end sub
%>
</body>
</html>

