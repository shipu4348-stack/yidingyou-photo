<!--#include virtual="/incs/model.asp"-->
<% Response.ContentType = "text/html; charset=gb2312" %>
<%
	call stopsql()
	UserName=trim(request.QueryString("kname"))
	kid=int(request.QueryString("kid"))
	Page=int(request.QueryString("currentpage"))
	
	iPageSize=40
	StrTable=" [Liu_Pic]"
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
	if MaxPage<>0 then
	
		if MaxPage>6 then
			SumStr=SumStr&"<div id='PageListPic' style='display:none; height:108px;'>"
		else
			SumStr=SumStr&"<div id='PageListPic' style='display:none;'>"
		end if
	
		for i=1 to MaxPage
			if i=Page then
				SumStr=SumStr&"<a href='javascript:void(0)' class='Checkbg' onclick='javascript:ShowPicList("""&UserName&""","&kid&","&i&");changepageinfo("""&UserName&""","&kid&","&i&","&MaxPage&");'>"&i&"</a>"
			else
				SumStr=SumStr&"<a href='javascript:void(0)' class='num' onclick='javascript:ShowPicList("""&UserName&""","&kid&","&i&");changepageinfo("""&UserName&""","&kid&","&i&","&MaxPage&");'>"&i&"</a>"
			end if
		next
		SumStr=SumStr&"</div>"
		if Page=1 and Page=MaxPage then
			response.Write(escape("<li><a>上一页</a></li><li><a href='javascript:void(0)' onclick='ShowPageNum(this);' hidefocus='hidefocus' class='Pagebg'>"&Page&"/"&MaxPage&"</a>"&SumStr&"</li><li><a>下一页</a></li>"))
			'response.Write("a")
		elseif Page=1 and Page<MaxPage then
			response.Write(escape("<li><a>上一页</a></li><li><a href='javascript:void(0)' hidefocus='hidefocus' onclick='ShowPageNum(this);' class='Pagebg'>"&Page&"/"&MaxPage&"</a>"&SumStr&"</li><li><a href='javascript:void(0)' onclick='javascript:ShowPicList("""&UserName&""","&kid&","&Page+1&");changepageinfo("""&UserName&""","&kid&","&page+1&","&MaxPage&");'>下一页</a></li>"))
			'response.Write("b")
		elseif Page>1 and Page<MaxPage then
			response.Write(escape("<li><a href='javascript:void(0)' onclick='javascript:ShowPicList("""&UserName&""","&kid&","&Page-1&");changepageinfo("""&UserName&""","&kid&","&page-1&","&MaxPage&");'>上一页</a></li><li><a href='javascript:void(0)' onclick='ShowPageNum(this);' hidefocus='hidefocus' class='Pagebg'>"&Page&"/"&MaxPage&"</a>"&SumStr&"</li><li><a href='javascript:void(0)' onclick='javascript:ShowPicList("""&UserName&""","&kid&","&Page+1&");changepageinfo("""&UserName&""","&kid&","&page+1&","&MaxPage&");'>下一页</a></li>"))
		elseif Page=MaxPage then
			response.Write(escape("<li><a href='javascript:void(0)' onclick='javascript:ShowPicList("""&UserName&""","&kid&","&Page-1&");changepageinfo("""&UserName&""","&kid&","&page-1&","&MaxPage&");'>上一页</a></li><li><a href='javascript:void(0)' onclick='ShowPageNum(this);' hidefocus='hidefocus' class='Pagebg'>"&Page&"/"&MaxPage&"</a>"&SumStr&"</li><li><a>下一页</a></li>"))
			'response.Write("d")
		end if
	end if
%>