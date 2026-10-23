<!--#include virtual="/incs/conn.asp"-->
<% Response.ContentType = "text/html; charset=gb2312" %>
<%
	UserName=trim(request.QueryString("kname"))
	Page=cint(request.QueryString("currentpage"))
	iPageSize=10
	StrTable=" [Liu_Folder]"
	if request.cookies("1dy")("UserName")<>"" and request.cookies("1dy")("UserName")=UserName then
		StrWhere=" and IsPhoto=1 and IsOpen<>2 and  kuser='"&UserName&"' "
	else
		StrWhere=" and IsPhoto=1 and  kuser='"&UserName&"' "
	end if
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
	
	if MaxPage>=1 then
		dim SumStr
		SumStr=""
		if MaxPage>6 then
			SumStr=SumStr&"<div id='PageListPic' style='display:none; height:108px;'>"
		else
			SumStr=SumStr&"<div id='PageListPic' style='display:none;'>"
		end if
		for i=1 to MaxPage
			if i=Page then
				SumStr=SumStr&"<a href='javascript:void(0)' hideFocus='true' class='Checkbg' onclick='ShowPhoto("""&UserName&""","&i&");changepageinfo("""&UserName&""","&i&","&MaxPage&");'>"&i&"</a>"
			else
				SumStr=SumStr&"<a href='javascript:void(0)' hideFocus='true' class='num' onclick=alert('123456')>"&i&"</a>"
				'SumStr=SumStr&"<a href='javascript:void(0)' hideFocus='true' class='num' onclick='ShowPhoto("""&UserName&""","&i&");changepageinfo("""&UserName&""","&i&","&MaxPage&");'>"&i&"</a>"
			end if
		next
		SumStr=SumStr&"</div>"			
		if Page=1 and Page=MaxPage  then
			response.Write(escape("<li><a>上一页</a></li><li><a href='javascript:void(0)' hideFocus='true' onblur='ShowPageNum(this);' onclick='ShowPageNum(this);' class='Pagebg'>"&Page&"/"&MaxPage&"</a>"&SumStr&"</li><li><a>下一页</a></li>"))
			'response.Write("a")
		elseif Page=1 and Page<MaxPage then
			response.Write(escape("<li><a>上一页</a></li><li><a href='javascript:void(0)' hideFocus='true' onblur='ShowPageNum(this);' onclick='ShowPageNum(this);' class='Pagebg'>"&Page&"/"&MaxPage&"</a>"&SumStr&"</li><li><a href='javascript:void(0)' hideFocus='true' onclick='ShowPhoto("""&UserName&""","&Page+1&");changepageinfo("""&UserName&""","&page+1&","&MaxPage&");'>下一页</a></li>"))
			'response.Write("b")
		elseif Page>1 and Page<MaxPage then
			response.Write(escape("<li><a href='javascript:void(0)' hideFocus='true' onclick='javascript:ShowPhoto("""&UserName&""","&Page-1&");changepageinfo("&page-1&");'>上一页</a></li><li><a href='javascript:void(0)' hideFocus='true' onblur='ShowPageNum(this);' onclick='ShowPageNum(this);' class='Pagebg'>"&Page&"/"&MaxPage&"</a>"&SumStr&"</li><li><a href='javascript:void(0)' hideFocus='true' onclick='javascript:ShowPhoto("""&UserName&""","&Page+1&");changepageinfo("""&UserName&""","&page+1&","&MaxPage&");'>下一页</a></li>"))
		elseif Page=MaxPage then
			response.Write(escape("<li><a href='javascript:void(0)' hideFocus='true' onclick='javascript:ShowPhoto("""&UserName&""","&Page-1&");changepageinfo("""&UserName&""","&page-1&","&MaxPage&");'>上一页</a></li><li><a href='javascript:void(0)' hideFocus='true' onblur='ShowPageNum(this);' onclick='ShowPageNum(this);' class='Pagebg'>"&Page&"/"&MaxPage&"</a>"&SumStr&"</li><li><a>下一页</a></li>"))
			'response.Write("d")
		end if
	end if
%>