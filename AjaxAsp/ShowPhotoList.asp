<!--#include virtual="/incs/model.asp"-->
<% Response.ContentType = "text/html; charset=gb2312" %>
<%
	kid=request.QueryString("kid")
	UserName=trim(request.QueryString("kname"))
	
	StrTable=" [Liu_Folder]"
	StrText=" [kid],[kname],[IsOpen],[upid] "
		
	if request.cookies("1dy")("UserName")<>"" and request.cookies("1dy")("UserName")=UserName then
		StrWhere=" and IsPhoto=1 and  kuser='"&UserName&"' "
	else		
		StrWhere=" and IsPhoto=1 and IsOpen<>2 and  kuser='"&UserName&"' "
	end if
	
	StrOrder=" kid "
	indexOrder=1
	'创建存储过程对象
	set cmd=Server.CreateObject("ADODB.Command")
	with cmd
		.ActiveConnection = conn        '数据库连接字串
		.CommandText = "liu_PageAll"         '指定存储过程名
		.CommandType = 4          '表明这是一个存储过程
		.Prepared = true        '要求将SQL命令先行编译
		.Parameters.append .CreateParameter("@StrTable",200,1,200,StrTable) '指定表名
		.Parameters.append .CreateParameter("@StrText",200,1,1000,StrText) '指定字段名
		.Parameters.append .CreateParameter("@StrWhere",200,1,1000,StrWhere) '指定查询条件
		.Parameters.append .CreateParameter("@StrOrder",200,1,100,StrOrder) '指定排序关键字
		.Parameters.append .CreateParameter("@indexOrder",3,1,4,indexOrder) '指定排序方式，1为降序，0为升序
		.Parameters.append .CreateParameter("@StrSql",200,2,2000) '返回Sql语句output					
		set rs= .Execute
	end with
	
	if not rs.eof or not rs.bof then
		do while not rs.eof
		response.Write("<a href='javascript:void(0)'")
			if kid=rs("kid") then
				response.Write("class='plCheck'")
			else
				response.Write("class='pl'")
			end if
		response.Write(">")
		response.Write("<b>"&escape(rs("kname"))&"</b>")		
			
		dim PicUrl
		if rs("IsOpen")=1 and  request.cookies("1dy")("UserName")<>UserName and instr(session("1dyName"),rs("kid"))=0 then
			PicUrl="../images/photo/ndpds.jpg"
			response.Write("<span class='img'><img  id='Photo"&rs("kid")&"' onclick='ShowPhotoPass("""&UserName&""","&rs("kid")&")' src='"&PicUrl&"' /></span>")
		else		
			set rspic=server.CreateObject("adodb.recordset")
			rspic.open "select top 1 [Pid],[Purl],[PhotoUrl] from [Liu_Pic] where kid="&rs("kid")&" order by Pid desc",conn,1,1
			if rspic.recordcount>0 then
				Dim MainUrl,kpath
				if rs("upid")=0 then
					MainUrl=GetUserShowPic(UserName,"img")&UserName&"/pic/"&rs("kname")&"/"
				else
					kpath=conn.execute("select [kpath] from liu_folder where kid="&rs("upid")&" and kuser='"&UserName&"'")(0)
					MainUrl=GetUserShowPic(UserName,"img")&UserName&"/pic"&kpath&rs("kname")&"/"
				end if
				PhotoUrl=escape(MainUrl&rspic("PhotoUrl"))
			else
				PhotoUrl="../images/photo/nocvb.jpg"
			end if
			rspic.close
			set rspic=nothing		
			response.Write("<span class='img'><img  id='Photo"&rs("kid")&"'  onclick='ChangePhoto(""Photo"&rs("kid")&""");ShowPhotoName("""&UserName&""","&rs("kid")&");ShowPicList("""&UserName&""","&rs("kid")&",1);ShowPicPage("""&UserName&""","&rs("kid")&",1);' src='"&PhotoUrl&"' /></span>")
		end if		
		response.Write("</a>")		
		rs.movenext
		loop
	end if
	rs.close
	set rs=nothing
	conn.close
	set conn=nothing

%>