<!--#include virtual="/incs/model.asp"-->
<% Response.ContentType = "text/html; charset=gb2312" %>
<%
	Page=request.QueryString("currentpage")
	UserName=trim(request.QueryString("kname"))
	if Page<=0 then
	iPage=1
	else
	iPage=Page
	end if
	iPageSize=10
	StrTable=" [Liu_Folder]"
	StrText=" [kid],[kname],[PostTime],[IsOpen],[upid],[kpath] "
	StrIndex=" kid "
	if request.cookies("1dy")("UserName")<>"" and request.cookies("1dy")("UserName")=UserName then
		StrWhere=" and IsPhoto=1 and  kuser='"&UserName&"' "
	else		
		StrWhere=" and IsPhoto=1 and IsOpen<>2 and  kuser='"&UserName&"' "
	end if
	StrOrder="kid"
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
		response.Write("<div class='PhotoList'")
			if request.cookies("1dy")("UserName")<>"" and request.cookies("1dy")("UserName")=UserName then
				response.Write(" onmouseover=showSetOpen('setOpen"&rs("kid")&"'); onmouseout=showSetOpen('setOpen"&rs("kid")&"');")
			end if
		response.Write(">")
		dim kcount
		set rss=server.CreateObject("adodb.recordset")
		rss.open "select [pid] from [Liu_Pic] where kid="&rs("kid")&"",conn,1,1
		if rss.recordcount>0 then
			kcount=rss.recordcount
		else
			kcount=0
		end if
		rss.close
		set rss=nothing
		response.Write("<div class='PhotoName'><b title='"&escape(rs("kname"))&"'>"&escape(left(rs("kname"),9))&"</b>("&kcount&")</div>")
		response.Write("<div class='PhotoDate'>"&year(rs("PostTime"))&"-"&month(rs("PostTime"))&"-"&day(rs("PostTime"))&"")
		if rs("IsOpen")=1 then
			response.Write(escape("<font color='red'>&nbsp;需要密码</font>"))
		elseif rs("IsOpen")=2 then
			response.Write(escape("<font color='red'>&nbsp;私有</font>"))
		end if
		response.Write(escape("</div>"))
		dim PicUrl
		if rs("IsOpen")=1 and  request.cookies("1dy")("UserName")<>UserName and instr(session("1dyName"),rs("kid"))=0 then	
			PicUrl="../images/photo/ndpdb.jpg"
			response.Write(escape("<div id='PhotoPic"&rs("kid")&"' class='PhotoPic' style='display:none;'><img src='"&PicUrl&"' onload='ResizeImage(this,133,152,""PhotoPic"&rs("kid")&""")'  onclick='ShowPhotoPass("""&UserName&""","&rs("kid")&")' style='cursor:pointer' /></div>"))
			response.Write(escape("<div id='setOpen"&rs("kid")&"' class='setOpen' style='display:none;'><a href='javascript:void(0)' onclick=ShowPhotoOpen("""&UserName&""","&rs("kid")&")>重命名 / 设密码</a></div>"))
		else
			set rspic=server.CreateObject("adodb.recordset")
			rspic.open "select top 1 [Pid],[Purl],[pthurl] from [Liu_Pic] where kid="&rs("kid")&" and  kuser='"&UserName&"' order by Pid desc",conn,1,1
			if rspic.recordcount>0 then
				if rs("upid")=0 then
					MainUrl=GetUserShowPic(UserName,"img")&UserName&"/pic/"&rs("kname")&"/"
				else
					kpath=conn.execute("select [kpath] from liu_folder where kid="&rs("upid")&" and kuser='"&UserName&"'")(0)
					MainUrl=GetUserShowPic(UserName,"img")&UserName&"/pic"&kpath&rs("kname")&"/"
				end if
				PhotoPic=MainUrl&rspic("pthurl")
			else
				PhotoPic="../images/photo/nocvb.jpg"
			end if
			rspic.close
			set rspic=nothing
			response.Write(escape("<div id='PhotoPic"&rs("kid")&"' class='PhotoPic' style='display:none;'><img src='"&PhotoPic&"' alt='"&rs("kname")&"' onload='ResizeImage(this,133,152,""PhotoPic"&rs("kid")&""")'  onclick='ViewPhoto("""&UserName&""","&rs("kid")&")' style='cursor:pointer;' /></div>"))
			response.Write(escape("<div id='setOpen"&rs("kid")&"' class='setOpen' style='display:none;'><a href='javascript:void(0)' onclick=ShowPhotoOpen("""&UserName&""","&rs("kid")&")>重命名 / 设密码</a></div>"))
		end if
		response.Write("</div>")
		rs.movenext
		if rs.eof then exit for
		next
		response.Write("<div class='clear'></div>")
	end if
	rs.close
	set rs=nothing
	conn.close
	set conn=nothing
%>