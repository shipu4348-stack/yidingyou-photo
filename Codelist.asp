<!--#include file="incs/sysCode.asp"-->
<%
	if request("action")="del" then
		id=int(request("html_id"))
		page=int(request("page"))
		username=request.cookies("1dy")("UserName")
		set rs=server.CreateObject("adodb.recordset")
		rs.open "select top 1 [CodeUrl] from [Liu_Code] where CodeId="&id,conn,1,1
		if not rs.eof and not rs.bof then
			CodeUrl=rs("CodeUrl")
			set Fso=New DmFso
			if Fso.CheckFile(CreatHtml&"/"&CodeUrl) then
				PathSize=Fso.FormatSize(Fso.GetFileSize(server.MapPath(CreatHtml&"/"&CodeUrl)))
				Fso.DelFile(CreatHtml&"/"&CodeUrl)
			end if
		end if
		rs.close
		set rs=nothing	
		conn.execute("update [Liu_User] set UsedBytes=UsedBytes-"&cdbl(CheckNumeric(PathSize))&",ResBytes=ResBytes+"&cdbl(CheckNumeric(PathSize))&" where UserName='"&UserName&"'")
		conn.execute("delete [Liu_Code] where CodeId="&id&"")
		FolderSize=DBGetValue("Liu_User","UsedBytes"," username='"&UserName&"'")
		response.write "<script>alert('删除成功!');top.document.getElementById('usesize').innerHTML='"&FormatFileSize(FolderSize)&"';window.location.href='codelist.asp?page="&page&"';</script>"
		response.End
	end if
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
<title>宝贝描述</title>
<link rel="stylesheet" type="text/css" media="all" href="css/common.css" />
</head>
<body>
<table width="100%" border="0" cellpadding="0" cellspacing="0">
  <tr>
    <td height="40" valign="bottom" background="images/0018.gif" class="emm">宝贝描述</td>
  </tr>
</table>
<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td height="1" colspan="2" bgcolor="#e1e1e1"></td>
  </tr>
  <form action="codelist.asp">
    <tr>
      <td class="makdir">按名称查找宝贝：
        <input name="tempname" type="text" class="makdir" id="textfield" size="30" maxlength="30" />
        &nbsp;
        <input type="submit" value="查找" class="btnt2" />
        &nbsp;
        <input type="button" value="新建宝贝" class="btnt5" onclick="window.open('setcode.asp','_self','');" 

/></td>
    </tr>
  </form>
</table>
<table class="dirlist">
  <tr>
    <th><div>宝贝名称</div></th>
    <th><div>所占容量</div></th>
    <th><div>最后修改时间</div></th>
    <th><div>操作</div></th>
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
	
sql_text="select [Codeid],[CodeName],[CodeSize],[Codetime] from [Liu_Code] where kname='"&request.cookies("1dy")("UserName")&"'"

Dim titlenav
If (Request.QueryString("tempname") <> "") Then 
titlenav = Request.QueryString("tempname")
sql_text=sql_text&" and CodeName like '%"&titlenav&"%'"
End If
sql_text=sql_text&" order by CodeTime desc"

	
set rs=server.createobject("adodb.recordset")
rs.open sql_text,conn,1,1
	if err.number<>0 then
	response.write "数据库中无数据"
	end if
	
	if rs.eof And rs.bof then
		Response.Write "<tr><td align='center' colspan='4'> 您还没有添加信息！</td></tr>"
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
			showpage totalput,MaxPerPage,"Codelist.asp"
		else
			if (currentPage-1)*MaxPerPage<totalPut then
				rs.move  (currentPage-1)*MaxPerPage
				dim bookmark
				bookmark=rs.bookmark
				showContent
				showpage totalput,MaxPerPage,"Codelist.asp"
			else
				currentPage=1
				showContent
				showpage totalput,MaxPerPage,"Codelist.asp"
			end if
		end if
					end if

	sub showContent
	dim i
	i=0
		do while not rs.eof
	%>
  <tr onMouseOver='this.bgColor="#eef5ff"' onMouseOut='this.bgColor="#FFFFFF"'>
    <td><a href="showcode.asp?html_id=<%=rs("CodeId")%>" target="_blank"><%=rs("CodeName")%></a></td>
    <td><%=rs("CodeSize")%></td>
    <td><%=rs("Codetime")%></td>
    <td><a href="editcode.asp?html_id=<%=rs("CodeId")%>" >查看/编辑</a> <a href="Codelist.asp?action=del&html_id=<%=rs("CodeId")%>&page=<%=CurrentPage%>" onclick="return confirm('确定删除吗？')" >删除</a></td>
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
<table width="100%" border="0" cellspacing="0" cellpadding="0" >
  <tr>
    <td height="40"><%
	Function showpage(totalnumber,maxperpage,filename)  
	Dim n
	
	If totalnumber Mod maxperpage=0 Then  
		n= totalnumber \ maxperpage  
	Else
		n= totalnumber \ maxperpage+1  
	End If
	response.Write"<tr><td colspan='4' align='center'>"
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
		response.Write "</td></tr>"
	End Function  
%></td>
  </tr>
</table>
</body>
</html>