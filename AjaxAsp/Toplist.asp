<!--#include virtual="/incs/SysCode.asp"-->
<% Response.ContentType = "text/html; charset=gb2312" %>
<%
	if Not checklogin then
		response.Write(escape("超时"))
		response.End()
	end if
	Dim MainURL2,kpath,kname
	set rs=server.CreateObject("adodb.recordset")
	sql="select top 50 [Pid],[Kid],[Pname],[Purl],[Pthurl],[Pdesc],[Psize],[Pdate] from [Liu_Pic] where kuser='"&UserName&"' order by Pdate desc"
	rs.open sql,conn,1,1
	if not rs.eof or not rs.bof then
		do while not rs.eof
			MainURL2=""
			if rs("kid")=0 then
				MainURL2=MainURL&"/"
			else
				kpath=DBGetValue("Liu_Folder","kpath","kid="&rs("kid")&"")
				kname=DBGetValue("Liu_Folder","kname","kid="&rs("kid")&"")
				MainURL2=MainURL&kpath&kname&"/"
			end if
			If SysDisplayType=1 Then
			response.Write("<div class='image' title='"&escape("文件描述："&rs("Pdesc")&"&#10;大小："&FormatFileSize(rs("Psize"))&"&#10;上传日期："&rs("Pdate")&"")&"'>")
			else
			response.Write("<div class='image' title='"&escape("文件名："&rs("Pname")&"&#10;大小："&FormatFileSize(rs("Psize"))&"&#10;上传日期："&rs("Pdate")&"")&"'>")
			End if
			response.Write("<span style='cursor:hand;' onclick='showpic("&rs("Pid")&","""&escape(MainURL2&rs("Purl"))&""");' class='highslide'>")
			response.Write("<div style='background: url("&escape(MainURL2&rs("PthUrl"))&") no-repeat center center;'><img src='images/0000.gif' height='105' width='105' /></div></span>")
			response.Write("<div><input value='"&rs("Pname")&"' class='input' style='width:105px;' readonly /></div>")				
			response.Write("<div class='opp'><table cellpadding='1' cellspacing='0' border='0' align='center'><tr><td>")			
			response.Write("<input type='hidden' name='url' value='"&escape(MainURL2&rs("Purl"))&"'>")
			response.Write("<input type='hidden' name='kid' value='"&rs("kid")&"'><input type='checkbox' name='pid' value='"&rs("Pid")&"' class='check' /></td>")
			response.Write("<td><a href='modfile.asp?pid="&rs("Pid")&"'>"&escape("编")&"</a>")
			response.Write("<a href='javascript:deletesearch("&rs("Pid")&",4,-1);'>"&escape("删")&"</a>")
			response.Write("<a href='javascript:copylink("""&escape(MainURL2&rs("Purl"))&""");'>"&escape("址")&"</a>")
			response.Write("</td></tr></table></div>")		
			response.Write("</div>")
		rs.movenext
		loop
		else
		response.Write("<tr id=""image"" onMouseOver=this.bgColor='#eef5ff' onMouseOut=this.bgColor='#FFFFFF'>")
		response.Write("<td colspan=""3"">"&escape("<font color=red>该目录下暂无上传图片，赶快去上传文件吧！ <a href=upftp.asp?kid="&kid&">点此上传</a></font>")&"")
		response.Write("</td></tr>")
	end if
	rs.close
	set rs=nothing
	conn.close
	set conn=nothing
	if types=2 then
		response.Write("</table>")
	end if
	
	Function FormatFileSize(Byval SizeNum)
		FormatSize=SizeNum&"&nbsp;Byte"
		If SizeNum>1024 Then
			SizeNum=(SizeNum/1024)
			FormatFileSize=Formatnumber(SizeNum,2)&"&nbsp;KB"
		End If
		If SizeNum>1024 Then
			SizeNum=(SizeNum/1024/1024)
			FormatFileSize=Formatnumber(SizeNum,2)&"&nbsp;MB"
		End If
		If SizeNum>1024 Then
			SizeNum=(SizeNum/1024)
			FormatFileSize=Formatnumber(SizeNum,2)&"&nbsp;GB"
		End If
	End Function
%>