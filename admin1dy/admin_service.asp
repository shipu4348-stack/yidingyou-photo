  <!--#include file="conn.asp"-->
  <!--#include file="check.asp"-->
 <%
	dim action
	dim totalpage,maxperpage,totalrecords,i,currentpage
	action=request("action")
	'2009年9月25日9:19:15
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<title>客服管理页面</title>
 <link rel="stylesheet" type="text/css" href="images/Admin_Style.Css">

<style type="text/css">
<!--
.STYLE2 {color: #FFFFFF}
-->
</style>
<script type="text/javascript" src="js/site.js"></script> 
<script language="JavaScript">
 // var XSSspRefURL = window.location.href._encodeHTML();
   var XSSspRefURL =window.location.href;
  	function writestr(str)
	{
	document.getElementById("strid").innerHTML=str;
	}
 	</script>
    <script type="text/ecmascript" >
function divclose(divname){
parent.document.getElementById(divname).style.display='none';
parent.document.getElementById('fugai_layout').style.display='none';
}
</script>
</head> 

<body   topmargin="0" leftmargin="0" rightmargin="0" bottommargin="0">

<%
select case action
  case "add"
    call add() 
  case "addsave"
    call addsave()
  case "edit"
    call edit()
  case "editsave"
    call editsave()
  case "del"
    call del()
  case else
    call main()
end select

sub add()
 'newsAdd 客服添加
if not checkflag("serviceManage") then
  getshow "对不起，您没有【客服添加】的权限！",""
end if
response.expires=0
%>
 
  <form action="?action=addsave" method="post" name="add" id="add">
  <table width="501" border="0" align="center" cellpadding="0" cellspacing="1" bgcolor="#CCCCCC" class="border1">
    <tr align="center" onMouseOut="this.style.backgroundColor=''" onMouseOver="this.style.backgroundColor='#BFDFFF'" class="tdbg"> 
      <td width="94%" height="25" bgcolor="#EFEBEF" class="title"><font class="tfont">客 服 - 添 加</font></td>
      <td width="6%" align="right" bgcolor="#EFEBEF" class="title"><a href="#" onClick="closedivc('comadd')"><img style="cursor:hand;" onClick="divclose('comadd');" src="images/close.gif"  border="0" /></a></td>
      
    </tr>
	<tr onMouseOut="this.style.backgroundColor=''" onMouseOver="this.style.backgroundColor='#BFDFFF'" class="tdbg">
	  <td height="25" colspan="2" align="left" class="tdbg">客服名称：
	  <input name="sname" type="text" class="input" id="sname" size="10" maxlength="10"  >
      <span >QQ号码：</span><input name="QQ" type="text" class="input" id="qq" size="12" maxlength="12" onKeyUp="value=value.replace(/[^\d]/g,'')">
      M
      <span >旺旺号码：</span>
      <input name="wangwang" type="text" class="input" id="wangwang" size="15" maxlength="15">
      <br>
      店铺地址：
      <input name="url" type="text" id="url" size="50" maxlength="80">
      <input name="Submit3" type="submit" class="button" value=" 确定添加 "></td>
    </tr>
  
  </table>
</form>
 
<%
end sub

sub addsave()
dim sname,qq,wangwang,url
sname=funstr(trim(request.form("sname")))
qq=trim(request.form("qq"))
wangwang=funstr(request.form("wangwang"))
url=funstr(request.form("url"))
 

if sname="" then
  getshow  "请输入客服名称",""
end if
 
 
  
set rs=rsfun("select * from ydy_service where id is null",3)
rs.addnew()
rs("sname")=sname
rs("qq")=qq
rs("wangwang")=wangwang
rs("url")=url
rs.update
rs.close
getdiv "添加客服成功！","","addservice"   

end sub

sub edit()

dim id

id=request("id")
if not isinteger(id) then
getshow "对不起，请指定要编辑的客服！",""
end if

set rs=rsfun("select * from ydy_service where id="&id,1)
if rs.bof and rs.eof then
getshow "找不到客服！",""
end if
 
%>

 <form action="?action=editsave" method="post" name="edit" id="edit">
  <table width="500" border="0" align="center" cellpadding="0" cellspacing="1" bgcolor="#CCCCCC" class="border1">
    <tr align="center" bgcolor="#EFEBEF" > 
      <td width="468" height="25" class="title"><span class="STYLE2">客 服 - 编辑</span></td>
      <td width="27" class="title"><img style="cursor:hand;" onClick="divclose('comedit');" src="images/close.gif"  border="0" /></td>
    </tr>
    <tr bgcolor="#FFFFFF">
      <td height="25" colspan="2" align="left" class="tdbg">客服名称：
     <input name="sname" type="text" class="input" id="sname" value="<%=rs("sname")%>" size="10" maxlength="10" >
        QQ号码：
      <input name="qq" type="text" class="input" id="qq" value="<%=rs("qq")%>" size="12" maxlength="12" onKeyUp="value=value.replace(/[^\d]/g,'')">
      旺旺号码：
      <input name="wangwang" type="text" class="input" id="wangwang" value="<%=rs("wangwang")%>" size="15" maxlength="15"> <input name="id" type="hidden" id="id" value="<%=id%>">
      <br>
      支付地址：
      <input name="url" type="text" id="url" value="<%=trim(rs("url"))%>" size="50" maxlength="80">
      <input name="Submit" type="submit" class="button" value=" 确定编辑 "></td>
    </tr>
 
  </table>
 
</form>
<%
rs.close
set rs=nothing
end sub

sub editsave()

dim id:id=request("id")
if not isinteger(id) then
  getshow "对不起，请指定要编辑的客服！",""
end if

dim sname,qq,wangwang,url
sname=funstr(trim(request.form("sname")))
qq=trim(request.form("qq"))
wangwang=funstr(request.form("wangwang"))
url=funstr(request.form("url"))
 

if sname="" then
  getshow  "请输入客服名称",""
end if

 

  set rs=rsfun("select * from ydy_service where id="&id,3)
 if rs.bof and rs.eof then
	getshow "找不到要编辑的客服！",""
		else
			rs("sname")=sname
			rs("qq")=qq
			rs("wangwang")=wangwang
			rs("url")=url
 		  rs.update
end if

rs.close
set rs=nothing
getdiv "修改客服成功","admin_service.asp","editok"
 end sub


sub main()
 'news 客服管理
if not checkflag("serviceManage") then
  getshow "对不起，您没有【客服管理】的权限！",""
end if



response.expires=0
currentpage=request("page")
 
if not isinteger(currentpage) then
  currentpage=1
else
  currentpage=clng(currentpage)
end if

maxperpage=30
totalrecords=0
totalpage=1
i=1



FileName="admin_service.asp?Action="&Action&""

strFileName=FileName & "&orderby=" & orderby&"&kind="&kind


sql="select * from ydy_service where id<>0 "

'if comkind<>"" then
'sql=sql&"and comkind="&comkind&""
'end if

if orderby="" then
     orderby="id"
 end if

 if kind<>"desc" and kind<>"asc" or isnull(kind) then 
 kind="desc" 
 end if
 
 sql=sql&" order by "&orderby&" "&kind&""
 
 set rs=rsfun(sql,1)
dim content
if not(rs.bof and rs.eof) then
  rs.pagesize=maxperpage
  rs.absolutepage=currentpage
  totalpage=rs.pagecount
  totalrecords=rs.recordcount %>
  
<div style="position: absolute; width: 100%; height: 100%; z-index: 1; left: 0px; top: 0px; background-color:black;filter:alpha(opacity=70);opacity:0.7; display:none;" id="fugai_layout">
&nbsp;<iframe src="javascript:false" style="position:absolute;visibility:visible;top:0px; left:-1px; width:100%; height:100%; z-index:2; filter='progid:DXImageTransform.Microsoft.Alpha(style=0,opacity=0)';"></iframe></div>

<div id="comadd" style=" position: absolute;z-index: 100; border: 0px solid #333333;  display: none;">

</div><div id="comedit" style=" position: absolute;z-index: 100; border: 0px solid #333333;  display: none;">
 
</div>
  
<table width="100%" border="0" align="center" cellpadding="2" cellspacing="1" class="border">
  <tr class="title"> 
    <td  > <table width="100%" border="0" align="center" cellpadding="0" cellspacing="0">
  <tr> 
    <td height="22" style="color:#FFFFFF">.:: 您可以在这里进行[客服管理]相关操作</td>
    <td width="200" height="22" align="right">
	 
    </td>
  </tr>
</table>
	
	</td>
  </tr>
</table> 

  <center><font size="+3">客服管理</font></center>

<br>
<br>
  
<table width="74%" border="0" align="center" cellpadding="0" cellspacing="1"   class="border1">
  <tr align="center" bgcolor="#EFEBEF">
    
    <td height="25" colspan="6" class="title">&nbsp;&nbsp;<a href="javascript:showIframe('comadd','admin_service.asp?action=add','78','501')" style="color:red;">添加客服</a> &nbsp;   </td>
  </tr>  <tr onMouseOut="this.style.backgroundColor=''" onMouseOver="this.style.backgroundColor='#BFDFFF'" class="tdbg">
    <td><strong>ID </strong></td>
    <td height="23"><strong>客服名</strong></td>
    <td><strong>QQ</strong></td>
    <td><strong>旺旺</strong></td>
    <td width="134" align="center"><strong>店铺</strong></td>
    <td width="134" height="23" align="center"><strong> 操　作 </strong></td>
  </tr>
  <%
  color=""
  do until rs.eof or i>maxperpage
  	id=rs("id")
	sname=rs("sname")
	qq=rs("qq")
	wangwang=rs("wangwang")
	 url=rs("url")
 	%>

  <tr onMouseOut="this.style.backgroundColor=''" onMouseOver="this.style.backgroundColor='#BFDFFF'" class="tdbg">
    
    <td width="35"><%=id%></td>
    <td width="122" height="23" > <%=sname%></td>
    <td width="219"><%=qq%></td>
    <td width="150"><%=wangwang%></td>
    <td align="center"><%if rs("url")<>"" then %><a href="<%=rs("url")%>" target="_blank">进入</a><% Else %>
    未填
<% End If %>
</td>
    <td height="23" align="center"><a href="javascript:showIframe('comedit','admin_service.asp?action=edit&id=<%=rs("id")%>','76','500')" style="color:red;">编辑</a> 
    <a href="?action=del&id=<%=rs("id")%>" title="删除客服..." onClick="javascript:if(confirm('是否真的要删除客服吗？\n\n系统提示：删除后不可恢复！')){return true;}else{return false;}">删除</a></td>
  </tr>
  <%rs.movenext
   i=i+1
   loop
  %> 
  
  <%if totalrecords>0 then  %>
 	<%call showpage(strFileName,totalrecords,maxperpage,true,true,"个【客服】信息")
 	 %> 
   <% End If %>

</table>
<%
rs.close
set rs=nothing
 
else
 %> <br>
<br>

   <table width="100%" border="0" cellpadding="0" cellspacing="1" bgcolor="#CCCCCC" class="border1">
  <tr align="center" class="title"> 
    <td width="100%" height="23"  align="center"> <% rw("暂无客服信息") %></td>
  
  </tr>
</table>
<table width="74%" border="0" align="center" cellpadding="0" cellspacing="1" class="border1">
 <tr>
     <td class="title">前台调用简单说明</td>
   </tr>
   <tr>
     <td class="tdbg">QQ在线代码生成：<a href="http://is.qq.com/webpresence/code.shtml" target="_blank">http://is.qq.com/webpresence/code.shtml</a><BR>
       阿里旺旺在线代码生成：<a href="http://www.taobao.com/help/wangwang/wangwang_0628_12.php" target="_blank">http://www.taobao.com/help/wangwang/wangwang_0628_12.php</a><BR>
       MSN在线代码生成:<a href="http://www.365groups.com/msnonlinecode.aspx" target="_blank">http://www.365groups.com/msnonlinecode.aspx</a><BR>
     Skype在线代码生成：<a href="http://skype.tom.com/products/skypeme.htm" target="_blank">http://skype.tom.com/products/skypeme.htm</a><BR></td>
   </tr>
 </table>
</body>
</html>

<%
  end if
%>

<%
end sub

sub del()

dim id:id=request("id")

if not isinteger(id) then
getshow "请指定要删除的客服！",""
end if
 
conn.execute("delete  ydy_service where id="&id)
 
getshow "删除客服成功！","admin_service.asp"

end sub
%>
