<!--#include virtual="/incs/SysCode.asp"-->
<% Response.ContentType = "text/html; charset=gb2312" %>
<%
	if Not checklogin then
		response.Write(escape("³¬Ê±"))
		response.End()
	end if
	upid=CheckNumeric(request("upid"))
	Page=CheckNumeric(request("currentpage"))
	response.Write("<table width=96% ><tr><td align=right><div class='PageInfo'>")
	set rs=server.CreateObject("adodb.recordset")
	sql="select [kid] from [Liu_Folder] where upid="&upid&" and kuser='"&UserName&"' "
	rs.open sql,conn,1,1
	if not (rs.eof and rs.bof) then
		rs.pagesize=10
		iPage=rs.pagesize
		iCout=rs.recordcount
		if Page<1 then
			Page=1
		end if
		if (iCout mod iPage)=0 then
			MaxPage= int(iCout / iPage) 
		else 
			MaxPage= int(iCout / iPage) + 1
		end if
		if Page>MaxPage then
			Page=MaxPage
		end if
		
		if Page=1 then
			response.Write("<span class='disabled'><</span>")
		else
			response.Write("<span onclick='temp=0;ShowFolder("&upid&","&Page-1&");changepageinfo("&page-1&","&MaxPage&","&upid&");'><a href='#'><</a></span>")	
		end if
		if Page>=1 then
			for i=1 to MaxPage
				if i=Page then
					response.Write("<span class='current'>"&i&"</span>")
				else
					response.Write("<span onclick='temp=0;ShowFolder("&upid&","&i&");changepageinfo("&i&","&MaxPage&","&upid&");'><a href='#'>"&i&"</a></span>")
				end if
			next
		end if
		if Page=MaxPage then
			response.Write("<span class='disabled'>></span>")
		else
			response.Write("<span onclick='temp=0;ShowFolder("&upid&","&Page+1&");changepageinfo("&page+1&","&MaxPage&","&upid&");'><a href='#'>></a></span>")
		end if
	end if
	rs.close
	set rs=nothing
	response.Write("</div></td></tr></table>")
%>