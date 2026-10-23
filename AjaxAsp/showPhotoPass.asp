<!--#include virtual="/incs/model.asp"-->
<% Response.ContentType = "text/html; charset=gb2312" %>
<%
call stopsql()
UserName=trim(request.QueryString("kname"))
kid=int(request.QueryString("kid"))
response.Write(escape("<span class='printinfo'>密码：</span><span class='print'><input type='password' class='inputtext' name='pass' id='Pwd3' /></span>"))
response.Write(escape("<span class='anniu'><input type='button' id='PwOk' class='inputbutton' name='tijiao' onClick=CheckPhotoPass("""&UserName&""","&kid&") value='提  交'>&nbsp;<input type='button' name='cancle' class='inputbutton' onClick=JuBao('CheckOpen'); value='取  消'></span>"))
%>