<!--#include virtual="/incs/model.asp"-->
<% Response.ContentType = "text/html; charset=gb2312" %>
<%
call stopsql()
UserName=trim(request.QueryString("kname"))
kid=request.QueryString("kid")
set rs=server.CreateObject("adodb.recordset")
rs.open "select top 1 [kid],[kname],[IsOpen],[Password] from [Liu_Folder] where kid="&kid&" and kuser='"&UserName&"'",conn,1,1
if not rs.eof and not rs.bof then
'response.Write("<form name='form1'>")
response.Write(escape("<span class='printinfo'>相册名称：</span><span class='print'><input type='text' class='inputtext' name='PhotoName2' maxlength='10' id='PhotoName2' value='"&trim(rs("kname"))&"' /></span>"))
response.Write(escape("<span class='shwoOpen' id='menu1'><a href='javascript:void(0)' hideFocus='true' >访问权限设置:</a></span>"))
response.Write(escape("<span id='menu2'>"))

response.Write(escape("<span class='shwoOpen'>访问权限:"))
if rs("IsOpen")=0 then
response.Write(escape("<input name='Open' type='radio' id='Open' onclick=closePassword('menu3','PwOk'); checked value='0' />公开"))
else
response.Write(escape("<input name='Open' type='radio' id='Open' onclick=closePassword('menu3','PwOk'); value='0' />公开"))
end if

if rs("IsOpen")=1 then
response.Write(escape("<input name='Open' type='radio' id='Open'  onclick=showPassword('menu3','PwOk'); checked value='1' />访问密码"))
else
response.Write(escape("<input name='Open' type='radio' id='Open'  onclick=showPassword('menu3','PwOk'); value='1' />访问密码"))
end if


if rs("IsOpen")=2 then
response.Write(escape("<input name='Open' type='radio' id='Open' onclick=closePassword('menu3','PwOk'); checked value='2' />私有"))
else
response.Write(escape("<input name='Open' type='radio' id='Open' onclick=closePassword('menu3','PwOk'); value='2' />私有"))
end if


response.Write(escape("</span>"))
response.Write(escape("<span id='menu3' style='display:none;'>"))
response.Write(escape("<span class='printinfo'>密码：</span><span class='print'><input type='password' class='inputtext' name='pw1' id='pw1' /></span>"))
response.Write(escape("<span class='printinfo'>确认密码：</span><span class='print'><input type='password' class='inputtext' name='pw2' id='pw2' onKeyUp=IsDisabled() /></span>"))
response.Write(escape("</span>"))
response.Write(escape("</span>"))
response.Write(escape("<span class='anniu' style='margin-top:10px;'><input type='button' id='PwOk' class='inputbutton' name='tijiao' onClick=ModifyPhotoOpen("""&UserName&""","&kid&") value='提  交'>&nbsp;<input type='button' name='cancle' class='inputbutton' onClick=JuBao('SetOpen'); value='取  消'></span>"))
'response.Write("</form>")
end if
rs.close
set rs=nothing
%>