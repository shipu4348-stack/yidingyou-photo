<!--#include virtual="/incs/SysCode.asp"-->
<% Response.ContentType = "text/html; charset=gb2312" %>
<%
	if Not checklogin then
		response.Write(escape("超时"))
		response.End()
	end if	
	kid=CheckNumeric(request("kid"))
	Page=CheckNumeric(request("currentpage"))
	types=CheckNumeric(request("type"))
	klevel=0
	if kid=0 then
	MainURl=MainURl&"/"
	else
	kpath=DBGetValue("Liu_Folder","kpath","kid="&kid&"")
	kname=DBGetValue("Liu_Folder","kname","kid="&kid&"")
	MainURl=MainURL&kpath&kname&"/"
	end if
	if kid="" then	kid=0
	if types=2 then	response.Write("<table class='dirlist1'>")	
	if Page<=0 then
		iPage=1
	else
		iPage=Page
	end if
	iPageSize=SysPageCount
	StrTable=" [Liu_Pic] "
	StrText=" [Pid],[Pname],[Purl],[Pthurl],[Pdesc],[Psize],[Pdate] "
	StrIndex=" pid "
	StrWhere=" and kid="&kid&" and  kuser='"&UserName&"' "
	StrOrder=" pid "
	indexOrder=1
	'创建存储过程对象
	set cmd=Server.CreateObject("ADODB.Command")
	with cmd
		.ActiveConnection = conn        '数据库连接字串
		.CommandText = "liu_Page"         '指定存储过程名
		.CommandType = 4          '表明这是一个存储过程
		.Prepared = true        '要求将SQL命令先行编译
		.Parameters.append .CreateParameter("@iPage",3,1,4,iPage)'指定页数
		.Parameters.append .CreateParameter("@iPageSize",3,1,10,iPageSize) '指定每页记录数
		.Parameters.append .CreateParameter("@StrTable",200,1,200,StrTable) '指定表名
		.Parameters.append .CreateParameter("@StrText",200,1,1000,StrText) '指定字段名
		.Parameters.append .CreateParameter("@StrWhere",200,1,1000,StrWhere) '指定查询条件
		.Parameters.append .CreateParameter("@StrIndex",200,1,30,StrIndex) '指定主关键字
		.Parameters.append .CreateParameter("@StrOrder",200,1,100,StrOrder) '指定排序关键字
		.Parameters.append .CreateParameter("@indexOrder",3,1,4,indexOrder) '指定排序方式，1为降序，0为升序
		.Parameters.append .CreateParameter("@StrSql",200,2,2000) '返回Sql语句output					
		set rs= .Execute
		'.Execute
	end with
	if not rs.eof or not rs.bof then
		for i=1 to iPageSize
		if types=1 then
			If SysDisplayType=1 Then
				response.Write("<div class='image' title='"&escape("文件描述："&rs("Pdesc")&"&#10;大小："&FormatFileSize(rs("Psize"))&"&#10;上传日期："&rs("Pdate")&"")&"'>")
			else
				response.Write("<div class='image' title='"&escape("文件名："&rs("Pname")&"&#10;大小："&rs("Psize")&"kb&#10;上传日期："&rs("Pdate")&"")&"'>")
			End if
			response.Write("<span style='cursor:hand;' onclick='showpic("&rs("Pid")&","""&escape(MainURL&rs("Purl"))&""");' class='highslide'>")
			response.Write("<div style='background: url("&escape(MainURL&rs("PthUrl"))&") no-repeat center center;'><img src='images/0000.gif' height='105' width='105' /></div></span>")
			response.Write("<div><input value='"&escape(rs("Pname"))&"' class='input' style='width:105px;' readonly /></div>")			
			response.Write("<div class='opp'><table cellpadding='1' cellspacing='0' border='0' align='center'><tr><td>")
			response.Write("<input type='hidden' name='url' value='"&escape(MainURL&rs("Purl"))&"'>")
			response.Write("<input type='checkbox' name='pid' value='"&rs("Pid")&"' class='check' /></td>")
			response.Write("<td><a href='modfile.asp?pid="&rs("Pid")&"'>"&escape("编")&"</a>")
			response.Write("<a href='javascript:deletesingle("&rs("Pid")&",1,"&klevel&");'>"&escape("删")&"</a>")
			response.Write("<a href='javascript:copylink("""&escape(MainURL&rs("Purl"))&""");'>"&escape("址")&"</a>")
			response.Write("</td></tr></table></div>")		
			response.Write("</div>")
		elseif types=2 then
			response.Write("<tr onMouseOver=this.bgColor='#eef5ff'; onMouseOut=this.bgColor='#FFFFFF';><td width='50'>")
			response.Write("<input type='hidden' name='url' value='"&escape(MainURL&rs("Purl"))&"'><input type='checkbox' name='pid' value='"&rs("Pid")&"' />")
			dim flex
			flex=right(rs("Pname"),3)
			if flex="jpg" or flex="JPG" then
				response.Write("<img src='images/mjpg.gif' align='absmiddle'>")
			elseif flex="gif" or flex="GIF" then
				response.Write("<img src='images/mgif.gif' align='absmiddle'>")
			elseif flex="bmp" or flex="BMP" then
				response.Write("<img src='images/mbmp.gif' align='absmiddle'>")
			elseif flex="png" or flex="PNG" then
				response.Write("<img src='images/mpng.gif' align='absmiddle'>")
			else
				response.Write("<img src='images/mjpg.gif' align='absmiddle'>")
			end if
			response.Write("</td>")
			response.Write("<td width='30%'><span class='spanlink' title='<img src="""&escape(MainURL&rs("Pthurl"))&""">' onclick='showpic("&rs("Pid")&","""&escape(MainURL&rs("Purl"))&""");'>"&escape(rs("Pname"))&"</span></td>")
			response.Write("<td width='18%'>"&FormatFileSize(rs("Psize"))&"</td>")
			response.Write("<td width='18%'>"&rs("Pdate")&"</td>")
			response.Write("<td><a href='javascript:copylink("""&escape(MainURL&rs("Purl"))&""");'>"&escape("获取地址")&"</a> <a href='modfile.asp?pid="&rs("pid")&"'>"&escape("编辑")&"</a> <a href='javascript:deletesingle("&rs("pid")&",2,"&klevel&");'>"&escape("删除")&"</a></td>")
			response.Write("</tr>")
		end if	
		rs.movenext
		if rs.eof then exit for
		next
		else
		response.Write("<tr id=""image"" onMouseOver=this.bgColor='#eef5ff' onMouseOut=this.bgColor='#FFFFFF'>")
		response.Write("<td colspan=""3"">"&escape("<font color=red>该目录下暂无上传图片，赶快去上传文件吧！ <a href=upftp.asp?kid="&kid&">点此上传</a></font>")&"")
		response.Write("</td></tr>")
	end if
	rs.close
	set rs=nothing
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
			SizeNum=(SizeNum/1024)
			FormatFileSize=Formatnumber(SizeNum,2)&"&nbsp;MB"
		End If
		If SizeNum>1024 Then
			SizeNum=(SizeNum/1024)
			FormatFileSize=Formatnumber(SizeNum,2)&"&nbsp;GB"
		End If
	End Function
%>