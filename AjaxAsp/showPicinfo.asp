<!--#include virtual="/incs/model.asp"-->
<% Response.ContentType = "text/html; charset=gb2312" %>
<%
call stopsql()
Pid=int(request.QueryString("Pid"))
UserName=trim(request.QueryString("kname"))
set rs=server.CreateObject("adodb.recordset")
sql="select top 1 [Pid],[Pdesc] from [Liu_Pic] where pid="&pid&" and  kuser='"&UserName&"'"
rs.open sql,conn,1,1	
if not rs.eof or not rs.bof then
	if request.cookies("1dy")("UserName")=UserName then
		if rs("Pdesc")="文件1" then
			response.Write("<div id='photoinfo2' onclick='CancleInfo();' style='display:;'><a class='photoinfo'  href='javascript:void(0)' hidefocus='hidefocus' >"&escape("请添加描述")&"</a></div>")
			response.Write("<div id='phototext' style='text-align:left; padding-bottom:10px; display:none;'>")
			response.Write("<textarea name='infoname' id='infoname' class='textarea2'></textarea>")
		else
			response.Write("<div id='photoinfo2' onclick='CancleInfo();' style='display:;'><a class='photoinfo'  href='javascript:void(0)' hidefocus='hidefocus' >"&escape(rs("Pdesc"))&"</a></div>")
			response.Write("<div id='phototext' style='text-align:left; padding-bottom:10px; display:none;'>")
			response.Write("<textarea name='infoname' id='infoname' class='textarea2'>"&escape(rs("Pdesc"))&"</textarea>")
		end if
		'response.Write("<div id='phototext' style='text-align:left; padding-bottom:10px; display:none;'>")
		response.Write("<input type='hidden' name='pid' id='pid' value='"&rs("Pid")&"' />")
		response.Write("<input type='hidden' name='kuser' id='kuser' value='"&UserName&"' />")
		'response.Write("<textarea name='infoname' id='infoname' class='textarea2'>"&escape(rs("Pdesc"))&"</textarea>")
		response.Write("<input class='photoinput' type='button' onclick='ComfireInfo();' value='"&escape("确定")&"' />&nbsp;")
		response.Write("<input class='photoinput' type='button' onclick='CancleInfo();' value='"&escape("取消")&"' />")
		response.Write("</div>")
	else
		if rs("Pdesc")<>"文件1" then
		response.Write(escape(rs("Pdesc")))
		end if
	end if
end if
rs.close
set rs=nothing
conn.close
set conn=nothing
%>