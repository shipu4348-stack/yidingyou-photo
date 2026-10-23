<!--#include virtual="/incs/model.asp"-->
<% Response.ContentType = "text/html; charset=gb2312" %>
<%
	kid=int(request.QueryString("kid"))
	Page=int(request.QueryString("currentpage"))
	UserName=trim(request.QueryString("kname"))	
	if Page<=0 then
	iPage=1
	else
	iPage=Page
	end if
	iPageSize=40
	StrTable=" [Liu_Pic]"
	StrText=" [Pid],[Purl],[Photourl],[kid],[Pdesc] "
	StrIndex=" Pid "
	StrWhere=" and kid="&kid&" and  kuser='"&UserName&"' "
	StrOrder="Pid"
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
	end with
	if not rs.eof or not rs.bof then
		for i=1 to iPageSize		
			PhotoUrl=rs("PhotoUrl")			
			response.Write("<div class='PicList2'>")
				response.Write("<div class='PicList'>")
				Dim MainUrl,kpath,kupid
				kupid=conn.execute("select [upid] from liu_folder where kid="&rs("kid")&" and kuser='"&UserName&"'")(0)
				kname=conn.execute("select [kname] from liu_folder where kid="&rs("kid")&" and kuser='"&UserName&"'")(0)
				if kupid="0" then
					MainUrl=GetUserShowPic(UserName,"img")&UserName&"/pic/"&kname&"/"
				else					
					kpath=conn.execute("select [kpath] from liu_folder where kid="&kupid&" and kuser='"&UserName&"'")(0)
					MainUrl=GetUserShowPic(UserName,"img")&UserName&"/pic"&kpath&kname&"/"
				end if
				response.Write("<a href='PhotoView.asp?kname="&UserName&"&Pid="&rs("Pid")&"&Kid="&rs("Kid")&"#p="&i-1&"' target='_top'><img src='"&escape(MainUrl&PhotoUrl)&"' /></a>")
				response.Write("</div>")
				if rs("Pdesc")<>"文件1" then
					response.Write ("<span>"&escape(rs("Pdesc"))&"</span>")
				end if
			response.Write("</div>")
		rs.movenext
		if rs.eof then exit for
		next
	end if
	rs.close
	set rs=nothing

%>