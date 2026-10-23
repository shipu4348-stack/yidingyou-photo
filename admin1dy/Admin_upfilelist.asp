<!--#include file="check.asp"-->
<!--#include file="conn.asp"-->
<%  
 rel=checkstr(trim(request("rel")))
 if not checkflag("ADUpload") then
  getshow "对不起，您没有【广告附件管理】的权限！",""
end if

%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
<title> - 文件列表</title>
<link rel="stylesheet" type="text/css" href="imageS/Admin_Style.Css">
</head>
<script language="javascript" src="js/site.js"></script>
<script>
function win(imgurl,i){
  imgurl=imgurl+i;
   window.opener.document.all.imgurl.innerText=document.getElementById(imgurl).value;
   //window.opener.document.all.bb.innerText=document.getElementById("sex").value;

   window.close();
} 

</script>
<body>

<% if rel="" then %>
 
<table width="100%" border="0" align="center" cellpadding="2" cellspacing="1" class="border">
  <tr class="title"> 
    <td  > <table width="100%" border="0" align="center" cellpadding="0" cellspacing="0">
  <tr> 
    <td height="22" style="color:#FFFFFF">.:: 您可以在这里进行[广告附件]相关操作</td>
    <td width="200" height="22" align="right">
	 
    </td>
  </tr>
</table>
	
	</td>
  </tr>
</table>

 <center><font size="+3">广告附件管理</font></center>
<table width="99%" border="0" cellpadding="0" cellspacing="1" bgcolor="#CCCCCC" class="border1">
  <tr align="center" height="24">
    <td height="30" colspan="5"  bgcolor="#EDF9D5" class="title"><b>&nbsp;说明</b> &nbsp;&nbsp;只需点击所需要的文件名即可!</td>
  </tr>
  <tr align="center">
    <td height="25" bgcolor="#FFFFFF" class="tdbg">文件名</td>
    <td bgcolor="#FFFFFF" class="tdbg">类型</td>
    <td bgcolor="#FFFFFF" class="tdbg">文件大小</td>
    <td bgcolor="#FFFFFF" class="tdbg">创建时间</td>
    <td bgcolor="#FFFFFF" class="tdbg">操作</td>
  </tr>
  <%  
counts=1
set fso=server.CreateObject("scripting.filesystemobject")
set getfolder=fso.getfolder(server.MapPath("/uploadfile/ad/"))
set openfolders=getfolder.files
for each openf in openfolders
url="/uploadfile/ad/"&openf.name
%>
  <input name="hidden" type="hidden" id="imgurl<% =counts %>" value="<% =url %>" />
  <div id="div<% =counts %>" style="display:none;"><img src="../uploadfile/ad/<%= openf.name %>" /></div>
  <tr align="left">
    <td height="25" bgcolor="#FFFFFF" class="tdbg"><img src="images/dir.gif" /><a href="#" onmouseout="closediv('div<% =counts %>')" onmousemove="showdiv('div<% =counts %>')" ><%= openf.name %></a></td>
    <td bgcolor="#FFFFFF" class="tdbg"><%= openf.type %> </td>
    <td bgcolor="#FFFFFF" class="tdbg"><%= openf.size/1000 %> KB</td>
    <td bgcolor="#FFFFFF" class="tdbg"><%= openf.DateCreated %></td>
    <td bgcolor="#FFFFFF" class="tdbg"> 
	<a href="admin_upfilelist.asp?rel=del&amp;dir=<%= Server.URLEncode(openf.name) %>" title="删除广告..." onClick="javascript:if(confirm('是否真的要删除广告吗？\n\n系统提示：删除后不可恢复！')){return true;}else{return false;}">删除</a>
	</td>
  </tr>
  <% 
counts=counts+1
next
set openfolders=nothing
set getfolder=nothing
set fso=nothing
%>
  <tr align="left">
    <td colspan="5" bgcolor="#FFFFFF" class="tdbg"><br /></td>
  </tr>
</table>
<% end if %>

<% 
if rel="del" then
  dir=request.QueryString("dir")
  dir=Replace(dir,"/","")
  dir=Replace(dir,"\","")
  if InStr(dir,"..")>0 then dir=""
  set fso=server.CreateObject("scripting.filesystemobject")
  fpath=Server.MapPath("/uploadfile/ad/" & dir)
  if fso.FileExists(fpath) then
   set f=fso.getfile(fpath)
   f.delete
   set f=nothing
  end if
  set fso=nothing
  getshow "","admin_upfilelist.asp"
end if
 %>
 
 <% connclose %>
</body>
</html>
