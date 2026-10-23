<!--#include file="incs/sysCode.asp"-->
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
<title>收件箱</title>
<link rel="stylesheet" type="text/css" media="all" href="css/common.css" />
</head>

<body>
<table width="100%" border="0" cellpadding="0" cellspacing="0">
  <tr>
    <td height="40" valign="bottom" background="images/0018.gif" class="emm">收件管理</td>
  </tr>
</table>
<table class="dirlist">
	<tr>
	  <th width="19%"><div>发件人</div></th>
	  <th width="47%"><div>主题</div></th>
	  <th width="18%"><div>发送时间</div></th>
	  <th width="16%"><div>操作</div></th>
	</tr>
<%'开始分页
	Const MaxPerPage=10
	dim totalPut   
	dim CurrentPage
	dim TotalPages
	dim j
		if Not isempty(request("page")) then
		currentPage=int(request("page"))
	else
		currentPage=1
	end if 
	
sql_text="select * from [Liu_Message] where accetpname='"&request.cookies("1dy")("UserName")&"' order by sendtime desc"
	
set rs=server.createobject("adodb.recordset")
rs.open sql_text,conn,1,1

	if err.number<>0 then
	response.write "数据库中无数据"
	end if
	
	if rs.eof And rs.bof then
		Response.Write "<tr><td colspan='4'>还没有人给你发消息！</td></tr>"
	else
		totalPut=rs.recordcount

		if currentpage<1 then
			currentpage=1
		end if

		if (currentpage-1)*MaxPerPage>totalput then
			if (totalPut mod MaxPerPage)=0 then
				currentpage= totalPut \ MaxPerPage
			else
				currentpage= totalPut \ MaxPerPage + 1
			end if
		end if

		if currentPage=1 then
			showContent
			showpage totalput,MaxPerPage,"accept.asp"
		else
			if (currentPage-1)*MaxPerPage<totalPut then
				rs.move  (currentPage-1)*MaxPerPage
				dim bookmark
				bookmark=rs.bookmark
				showContent
				showpage totalput,MaxPerPage,"accept.asp"
			else
				currentPage=1
				showContent
				showpage totalput,MaxPerPage,"accept.asp"
			end if
		end if
					end if

	sub showContent
	dim i
	i=0
		do while not rs.eof
	%>
        
                <tr onMouseOver='this.bgColor="#eef5ff"' onMouseOut='this.bgColor="#FFFFFF"'>
					<td><%=rs("sendname")%></td>
                  <td><a href="resend.asp?id=<%=rs("id")%>"><%=rs("sendtitle")%></a></td>
                  <td><%=rs("sendtime")%></td>
                  <td><a href="accept.asp?action=del&html_id=<%=rs("id")%>" >删除</a></td>

  </tr>
  
		<%	
			i=i+1
			if i>=MaxPerPage then Exit Do
			rs.movenext
		  loop
		  rs.close
		  set rs=nothing
		  end sub
		  %>
                        
</table>
<%
	Function showpage(totalnumber,maxperpage,filename)  
	Dim n
	
	If totalnumber Mod maxperpage=0 Then  
		n= totalnumber \ maxperpage  
	Else
		n= totalnumber \ maxperpage+1  
	End If
	response.Write"<tr><td colspan='4' align='center'>"
	'Response.Write "<form method=Post action="&filename&">"  
	Response.Write "<p align='center' class='contents'> "  
	If CurrentPage<2 Then  
		Response.Write "<font class='contents'>首页 上一页</font> "  
	Else  
		Response.Write "<a href="&filename&"?page=1 class='contents'>首页</a> "  
		Response.Write "<a href="&filename&"?page="&CurrentPage-1&" class='contents'>上一页</a> "  
	End If
	
	If n-currentpage<1 Then  
		Response.Write "<font class='contents'>下一页 尾页</font>"  
	Else  
		Response.Write "<a href="&filename&"?page="&(CurrentPage+1)&" class='contents'>"  
		Response.Write "下一页</a> <a href="&filename&"?page="&n&" class='contents'>尾页</a>"  
	End If  
		Response.Write "<font class='contents'> 页次：</font><font class='contents'>"&CurrentPage&"</font><font class='contents'>/"&n&"页</font> "  
		'Response.Write "<font class='contents'> 共有"&totalnumber&"个会员 " 
		'Response.Write "<font class='contents'>转到：</font><input type='text' name='page' size=2 maxlength=10 class=smallInput value="&currentpage&">"  
		'Response.Write "&nbsp;<input type='submit'  class='contents' value='GO' name='cndok'></form>"  		
		response.Write "</td></tr>"
	End Function  
%>
</body>
</html>
<%
	if request("action")="del" then
		id=int(request.QueryString("html_id"))
		conn.execute("delete from [Liu_Message] where id="&id&"")
		response.write "<script language=javascript>alert('删除成功！');window.location.href='accept.asp';</script>"
		response.End
	end if
%>