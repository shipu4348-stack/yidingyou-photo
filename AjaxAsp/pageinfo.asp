<!--#include virtual="/incs/SysCode.asp"-->
<% Response.ContentType = "text/html; charset=gb2312" %>
<%
	if Not checklogin then
		response.Write(escape("超时"))
		response.End()
	end if
	Dim kid,Page,types
	kid=CheckNumeric(request("kid"))
	Page=CheckNumeric(request("currentpage"))
	types=CheckNumeric(request("type"))
	response.Write("<table width=96% ><tr><td align=right><div class='PageInfo'>")		
	iPageSize=SysPageCount
	StrTable=" [Liu_Pic] "
	StrWhere=" and kid="&kid&" and kuser='"&UserName&"' "
	'创建存储过程对象
	set cmd=Server.CreateObject("ADODB.Command")
	with cmd
		.ActiveConnection = conn        '数据库连接字串
		.CommandText = "liu_Recordcount"         '指定存储过程名
		.CommandType = 4          '表明这是一个存储过程
		.Prepared = true        '要求将SQL命令先行编译
		.Parameters.append .CreateParameter("@StrTable",200,1,200,StrTable) '指定表名
		.Parameters.append .CreateParameter("@StrWhere",200,1,1000,StrWhere) '指定查询条件
		.Parameters.append .CreateParameter("@StrTotals",200,2,2000) '返回Sql语句output
		.Parameters.append .CreateParameter("@StrSql",200,2,2000) '返回Sql语句output				
		.Execute
	end with
	iCout=cmd(2)
	set cmd=nothing	
	if Page<1 then
		Page=1
	end if
	if (iCout mod iPageSize)=0 then
		MaxPage= int(iCout / iPageSize)
	else 
		MaxPage= int(iCout / iPageSize) + 1
	end if
	if Page>MaxPage then
		Page=MaxPage
	end if
	if MaxPage>0 then
		if Page=1 then
			response.Write("<span class='disabled'><</span>")
		else
			response.Write("<span onclick='temp=0;PicList("&kid&","&Page-1&","&types&");changepageinfo("&page-1&","&MaxPage&","&kid&","&types&");'><a href='#'><</a></span>")	
		end if
		if Page>=1 and MaxPage<10 then
			for i=1 to MaxPage
				if i=Page then
					response.Write("<span class='current'>"&i&"</span>")
				else
					response.Write("<span onclick='temp=0;PicList("&kid&","&i&","&types&");changepageinfo("&i&","&MaxPage&","&kid&","&types&");'><a href='#'>"&i&"</a></span>")
				end if
			next
		else
			if Page<5 then
				for i=1 to 2
					if i=Page then
						response.Write("<span class='current'>"&i&"</span>")
					else
						response.Write("<span onclick='temp=0;PicList("&kid&","&i&","&types&");changepageinfo("&i&","&MaxPage&","&kid&","&types&");'><a href='#'>"&i&"</a></span>")
					end if
				next
				response.Write("...")
				for i=MaxPage-2 to MaxPage
					response.Write("<span onclick='temp=0;PicList("&kid&","&i&","&types&");changepageinfo("&i&","&MaxPage&","&kid&","&types&");'><a href='#'>"&i&"</a></span>")
				next
			elseif (MaxPage-Page)<4 then
				for i=1 to 2
					response.Write("<span onclick='temp=0;PicList("&kid&","&i&","&types&");changepageinfo("&i&","&MaxPage&","&kid&","&types&");'><a href='#'>"&i&"</a></span>")
				next
				response.Write("...")
				for i=MaxPage-4 to MaxPage
					if i=Page then
						response.Write("<span class='current'>"&i&"</span>")
					else
						response.Write("<span onclick='temp=0;PicList("&kid&","&i&","&types&");changepageinfo("&i&","&MaxPage&","&kid&","&types&");'><a href='#'>"&i&"</a></span>")
					end if
				next
			else
				for i=1 to 2
					response.Write("<span onclick='temp=0;PicList("&kid&","&i&","&types&");changepageinfo("&i&","&MaxPage&","&kid&","&types&");'><a href='#'>"&i&"</a></span>")
				next
				response.Write("...")
				for i=Page-1 to Page+1
					if i=Page then
						response.Write("<span class='current'>"&i&"</span>")
					else
						response.Write("<span onclick='temp=0;PicList("&kid&","&i&","&types&");changepageinfo("&i&","&MaxPage&","&kid&","&types&");'><a href='#'>"&i&"</a></span>")
					end if
				next
				response.Write("...")
				for i=MaxPage-1 to MaxPage
					response.Write("<span onclick='temp=0;PicList("&kid&","&i&","&types&");changepageinfo("&i&","&MaxPage&","&kid&","&types&");'><a href='#'>"&i&"</a></span>")
				next
			end if
		end if
		if Page=MaxPage then
			response.Write("<span class='disabled'>></span>")
		else
			response.Write("<span onclick='temp=0;PicList("&kid&","&Page+1&","&types&");changepageinfo("&page+1&","&MaxPage&","&kid&","&types&");'><a href='#'>></a></span>")
		end if
	end if
	response.Write("</div></td></tr></table>")
%>