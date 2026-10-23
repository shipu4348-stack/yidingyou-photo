<!--#include virtual="/incs/model.asp"-->
<% Response.ContentType = "text/html; charset=gb2312" %>
<%
dim username,password,verify,action
dim rs,sql
username=Checkstr(Request("username"))
password=Checkstr(Request("password"))
verify=Checkstr(Request("verify"))
action=CheckStr(Request("action"))
if action="first" then
	if cstr(session("getcode"))<>verify then
		response.Write(escape("验证码"))
	else
		set rs=server.CreateObject("adodb.recordset")
		sql="select top 1 [username],[pwd],[CountBytes],[UsedBytes],[ResBytes],[LostIp],[LostTime],[Isclock] from [Liu_User] where username='"&username&"'"
		rs.open sql,conn,1,3
		if rs.eof and rs.bof then
			response.write(escape("用户名"))
		else
			if rs("isclock")=1 then
				response.Write(escape("冻结"))
			elseif rs("pwd")<>md5(password,"long") then
				response.write(escape("密码"))
			else				
				rs("ResBytes")=rs("CountBytes")-rs("UsedBytes")
				rs("LostIp")=Request.ServerVariables("REMOTE_ADDR")
				rs("LostTime")=now()
				rs.update
				response.write escape(GetUserShowPic(username,"up"))
			end if
			rs.close
			set rs=nothing
		end if
	end if
else
	set rs=server.CreateObject("adodb.recordset")
	sql="select top 1 [id],[tcid],[yjf],[username] from [Liu_User] where username='"&username&"' and pwd='"&md5(password,"long")&"'"
	rs.open sql,conn,1,3
	if not(rs.eof and rs.bof) then
		Response.Cookies("1dy")("UserID")=rs("id")
		Response.Cookies("1dy")("UserName")=rs("username")
		Response.Cookies("1dy")("yjf")=rs("yjf")
		Response.Cookies("1dy")("tcid")=rs("tcid")
		Response.Cookies("1dy")("fate")=0
		Response.Cookies("1dy").Expires=date+1
		Response.Redirect "/home.asp"
	else
		Response.Redirect "/index.asp"
	end if
	Rs.close
	Set Rs=Nothing
end if
%>