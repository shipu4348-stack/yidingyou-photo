<!--#include file="incs/conn.asp"-->
<%
if request("action")="add" then
	newsname=Replace(Request.Form("html_name"),"’","’’")
	Content=Replace(Request.Form("html_content"),"’","’’")
	parentid=Replace(Request.Form("parentid"),"’","’’")
	kind=Request("kind")
	if newsname="" then
		response.write "<script language=javascript>alert('标题不能为空！');history.back();</script>"
		response.End
	end if
	if Content="" then
		response.write "<script language=javascript>alert('内容不能为空！');history.back();</script>"
		response.End
	end if
	
	set rs=server.CreateObject("adodb.recordset")
	rs.open "select * from GuestMessage",conn,1,3
	rs.addnew
	rs("username")=request.cookies("1dy")("UserName")
	rs("question")=newsname
	rs("content")=Content
	if parentid<>"" then 
	rs("parentid")=parentid
	end if
	rs.update
	rs.close
	set rs=nothing
	
	if kind<>"" then 
	conn.execute("update GuestMessage set isadmin=0 where id="&parentid&"")
	end if
	response.write "<script language=javascript>alert('提交成功,等待管理员处理！');window.location.href='message.asp';</script>"
	response.End
end if
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
<title>服务与支持</title>
<link rel="stylesheet" type="text/css" media="all" href="css/setting.css" />
<link rel="stylesheet" type="text/css" media="all" href="css/common.css" />
</head>

<body>

<FORM name="mainform" action="message.asp?action=add" method="POST">
<table width="100%" border="0" cellpadding="0" cellspacing="0">
  <tr>
    <td height="40" valign="bottom" background="images/0018.gif" class="em">服务与支持</td>
  </tr>
</table>
<table width="100%" border="0" cellspacing="0" cellpadding="0">

<tr>
    <td height="1" bgcolor="#e1e1e1" colspan="2"></td>
  </tr>
  <tr>
    <td class="dirnotice" colspan="2">提示：如有不明白问题可直接在这里与管理员联系。</td>
  </tr>
  <tr>
    <td height="1" bgcolor="#e1e1e1" colspan="2"></td>
  </tr>
  <tr bgcolor="#fafafa">
    <td width="13%" class="itemlist">问题标题： </td><td width="87%" style="padding-left:5px;">
    <input name="html_name" type="text" class="text" id="textfield" size="40" maxlength="30" /></td>
  </tr>
  <tr>
    <td height="1" bgcolor="#e1e1e1" colspan="2"></td>
  </tr>
  <tr bgcolor="#fafafa">
    <td style="padding:10px;" class="itemlist">问题内容</td><td style="padding:5px;">
	<textarea name="html_content" class="text"></textarea>
</td>
  </tr>
   <tr>
    <td height="1" bgcolor="#e1e1e1" colspan="2"></td>
  </tr>
  <tr>  
    <td style="padding-left:15px; height:60px;"><input name="button2" value="提交" type="submit" class="btnt3" /> </td>
</tr>

</table>
<form>

<table class="dirlist">
	<tr>
	  <th width="18%"><div>编号</div></th>
		<th width="41%"><div>标题</div></th>
	  <th width="15%"><div>时间</div></th>
	  <th width="14%"><div>状态</div></th>
	  <th width="12%"><div>操作</div></th>
	</tr>
<%'开始分页
	Const MaxPerPage=6
	dim totalPut   
	dim CurrentPage
	dim TotalPages
	dim j
	dim sql
		if Not isempty(request("page")) then
		currentPage=Cint(request("page"))
	else
		currentPage=1
	end if 
	
sql_text="select * from GuestMessage where parentid=0 and username='"&request.cookies("1dy")("UserName")&"'order by replay desc,retime desc"
	
set rs=server.createobject("adodb.recordset")
rs.open sql_text,conn,1,1

	if err.number<>0 then
	response.write "数据库中无数据"
	end if
	
	if rs.eof And rs.bof then
		'Response.Write "<p align='center' class='contents'> 您还没有添加信息！</p>"
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
			showpage totalput,MaxPerPage,"Message.asp"
		else
			if (currentPage-1)*MaxPerPage<totalPut then
				rs.move  (currentPage-1)*MaxPerPage
				dim bookmark
				bookmark=rs.bookmark
				showContent
				showpage totalput,MaxPerPage,"Message.asp"
			else
				currentPage=1
				showContent
				showpage totalput,MaxPerPage,"Message.asp"
			end if
		end if
					end if

	sub showContent
	dim i
	i=0
		do while not rs.eof
	%>
        
                <tr onMouseOver='this.bgColor="#eef5ff"' onMouseOut='this.bgColor="#FFFFFF"'>
					<td><%=i+1%></td>
                  <td><a href="MessageView.asp?id=<%=rs("id")%>"><% If rs("isadmin")=1  Then  Response.Write("<img src=images/new_03.gif>")%><%=rs("question")%></a></td>
                  <td><%=rs("addtime")%></td>
				  <td>
				  	<% 
						if rs("replay")=0 then
							response.write "未解决"
						else
							response.write "<font color='red'>已解决</font>"
						end if
					%>
				  </td>
                  <td><a href="message.asp?action=del&html_id=<%=rs("id")%>" >删除</a></td>

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
	response.Write"<tr><td colspan='5' align='center'>"
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
		id=cint(request.QueryString("html_id"))
		conn.execute("delete from guestmessage where id="&id&"")
		conn.execute("delete from guestmessage where parentid="&id&"")
		response.write "<script language=javascript>alert('删除成功！');window.location.href='message.asp';</script>"
		response.End
	end if
%>