<!--#include virtual="/incs/SysCode.asp"-->
<% Response.ContentType = "text/html; charset=gb2312" %>
<%
	if Not checklogin then
		response.Write(escape("超时"))
		response.End()
	end if
	upid=CheckNumeric(request("upid"))
	Page=CheckNumeric(request("currentpage"))
	response.Write("<table class='dirlist'>")
	response.Write("<tr>")
	response.Write("<th width='65%'><div>"&escape("文件夹名")&"</div></th>")
	response.Write("<th width='10%'><div>"&escape("文件总数")&"</div></th>")
	response.Write("<th width='25%'><div>"&escape("操作")&"</div></th>")
	response.Write("</tr>")

	set rs=server.CreateObject("adodb.recordset")
	sql="select [kid],[kname],[kpath],[kcount],[upid],[klevel],[kuser],[IsPhoto] from [Liu_Folder] where upid="&upid&" and  kuser='"&UserName&"'  order by kid desc"
	rs.open sql,conn,1,1	
	if rs.eof and rs.bof  then
		response.Write("<tr id=""forder"" onMouseOver=this.bgColor='#eef5ff' onMouseOut=this.bgColor='#FFFFFF'>")
		response.Write("<td colspan=""3"">"&escape("该目录下暂无文件夹")&"")
		response.Write("</td></tr>")
	else
		rs.pagesize=10
		MaxSize=rs.pagesize
		MaxCount=rs.recordcount
		if Page<1 then
			Page=1
		end if
		if (MaxCount mod MaxSize)=0 then
			MaxPage=MaxCount\MaxSize
		else
			MaxPage=MaxCount\MaxSize+1
		end if
		if Page>MaxPage then
			Page=MaxPage
		end if		
		rs.AbsolutePage=Page
		for i=1 to MaxSize
		response.Write("<tr id=""forder_"&rs("kid")&""" onMouseOver=this.bgColor='#eef5ff' onMouseOut=this.bgColor='#FFFFFF'>")
		response.Write("<td><span id='K"&rs("kid")&"'><img src='images/0040.gif' width='16' height='14' align='absmiddle' />&nbsp;<a href='../folderlist.asp?upid="&rs("kid")&"&klevel="&rs("klevel")+1&"&kpath="&escape(rs("kpath")&rs("kname"))&"'>"&escape(rs("kname"))&"</a></span>")
		response.Write("<input type='text' value='"&escape(trim(rs("kname")))&"' id='inputK"&rs("kid")&"' style='display:none;' maxlength=""10"" /></td>")
		response.Write("<td>"&rs("kcount")&"</td>")
		response.Write("<td><div id='divK"&rs("kid")&"'>")
		response.Write("<a href='../folderlist.asp?upid="&rs("kid")&"&klevel="&rs("klevel")+1&"&kpath="&escape(rs("kpath")&rs("kname"))&"'><font color='#2b82e9'>"&escape("子文件夹管理")&"</font></a>")
		if rs("IsPhoto")=0 then
			response.Write("&nbsp;<span class='spanlink' onclick='setPhoto("&rs("kid")&","&upid&","&Page&");'>"&escape("设定相册")&"</span>")
		else
			response.Write("&nbsp;<span class='spanlink' onclick='setPhoto("&rs("kid")&","&upid&","&Page&");'>"&escape("取消相册")&"</span>")
		end if
		response.Write("&nbsp;<span class='spanlink' onclick='changefoldername("&rs("kid")&","""&escape(rs("kname"))&""");'>"&escape("改名")&"</span>")			
		response.Write("&nbsp;<span class='spanlink' onclick='DeleteFolder("&rs("kid")&");'>"&escape("删除")&"</span></div>")
		response.Write("<span id='modbK"&rs("kid")&"' style='display:none;'><input type='button' name='submit' value='"&escape("修改")&"' class='btnt2' onclick=modfoldername("&rs("kid")&",document.getElementById('inputK"&rs("kid")&"').value,"&rs("klevel")&"); id='Div"&rs("kid")&"'> &nbsp; <input type=button name='cancel' class='btnt2' value='"&escape("取消")&"'  onclick='cancelchangefoldername("&rs("kid")&");'></span>")
		response.Write("</td></tr>")		
		rs.movenext
		if rs.eof then exit for
		next

		
	end if
	
	rs.close
	set rs=nothing
	conn.close
	set conn=nothing
	response.Write("</table>")
%>