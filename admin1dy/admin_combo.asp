  <!--#include file="conn.asp"-->
  <!--#include file="check.asp"-->
 <%
	dim action
	dim totalpage,maxperpage,totalrecords,i,currentpage
	action=request("action")
	
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<title>套餐管理页面</title>
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
 'newsAdd 套餐添加
if not checkflag("ComboManage") then
  getshow "对不起，您没有【套餐添加】的权限！",""
end if
response.expires=0
%>
 
  <form action="?action=addsave" method="post" name="add" id="add">
  <table width="501" border="0" align="center" cellpadding="0" cellspacing="1" bgcolor="#CCCCCC" class="border1">
    <tr align="center" onMouseOut="this.style.backgroundColor=''" onMouseOver="this.style.backgroundColor='#BFDFFF'" class="tdbg"> 
      <td width="94%" height="25" bgcolor="#EFEBEF" class="title"><font class="tfont">套 餐 - 添 加</font></td>
      <td width="6%" align="right" bgcolor="#EFEBEF" class="title"><a href="#" onClick="closedivc('comadd')"><img style="cursor:hand;" onClick="divclose('comadd');" src="images/close.gif"  border="0" /></a></td>
      
    </tr>
	<tr onMouseOut="this.style.backgroundColor=''" onMouseOver="this.style.backgroundColor='#BFDFFF'" class="tdbg">
	  <td height="25" colspan="2" align="left" class="tdbg">套餐类型：
	    <select name="comkind" id="comkind">
	      <option value="1">年付类型</option>
	      <option value="2">月付类型</option>
        </select>
      <span >套餐大小</span>： <input name="comsize" type="text" class="input" id="comsize" size="5" maxlength="7" onKeyUp="value=value.replace(/[^\d]/g,'')">
      M
      <span >套餐价格</span>：
      <input name="comprice" type="text" class="input" id="comprice" size="5" maxlength="5">
      <input name="Submit3" type="submit" class="button" value=" 确定添加 ">
      <br>
      支付地址：
      <input name="payurl" type="text" id="payurl" size="66" maxlength="80"></td>
    </tr>
  
  </table>
</form>
 
<%
end sub

sub addsave()
dim comsize,comprice,comkind
comsize=funstr(trim(request.form("comsize")))
comprice=trim(request.form("comprice"))
comkind=funstr(request.form("comkind"))
payurl=funstr(request.form("payurl"))
 

if comsize="" then
  getshow  "请输入套餐大小",""
end if

if comprice="" then
  getshow  "请输入套餐价格",""
end if

 
  
set rs=rsfun("select * from ydy_combo where id is null",3)
rs.addnew()
rs("comsize")=comsize*1024*1024
rs("comprice")=comprice
rs("comkind")=comkind
rs("usenum")=0
rs("payurl")=payurl
rs.update
rs.close
getdiv "添加套餐成功！","","addcombo"   

end sub

sub edit()

dim id,currentpage

id=request("id")
currentpage=cint(Request("page"))
if not isinteger(id) then
getshow "对不起，请指定要编辑的套餐！",""
end if

set rs=rsfun("select * from ydy_combo where id="&id,1)
if rs.bof and rs.eof then
getshow "找不到套餐！",""
end if
 
%>

 <form action="?action=editsave&page=<%=currentpage%>" method="post" name="edit" id="edit">
  <table width="500" border="0" align="center" cellpadding="0" cellspacing="1" bgcolor="#CCCCCC" class="border1">
    <tr align="center" bgcolor="#EFEBEF" > 
      <td width="468" height="25" class="title"><span class="STYLE2">套 餐 - 编辑</span></td>
      <td width="27" class="title"><img style="cursor:hand;" onClick="divclose('comedit');" src="images/close.gif"  border="0" /></td>
    </tr>
    <tr bgcolor="#FFFFFF">
      <td height="25" colspan="2" align="left" class="tdbg">套餐类型：
        <select name="comkind" id="comkind">
          <option value="1" <%if rs("comkind")="1" then response.write " selected"%>>年付类型</option>
          <option value="2" <%if rs("comkind")="2" then response.write " selected"%>>月付类型</option>
      </select>
        套餐大小：
      <input name="comsize" type="text" class="input" id="comsize" value="<%=dSize(rs("comsize"))%>" size="5" maxlength="7" onKeyUp="value=value.replace(/[^\d]/g,'')">
      M套餐价格：
      <input name="comprice" type="text" class="input" id="comprice" value="<%=rs("comprice")%>" size="5" maxlength="5"> <input name="id" type="hidden" id="id" value="<%=id%>"> 
      <input name="Submit" type="submit" class="button" value=" 确定编辑 ">
      <br>
      支付地址：
      <input name="payurl" type="text" id="payurl" value="<%=rs("payurl")%>" size="66" maxlength="80"></td>
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
  getshow "对不起，请指定要编辑的套餐！",""
end if

dim comsize,comprice,comkind,currentpage
currentpage=cint(Request("page"))
comsize=funstr(trim(request.form("comsize")))
comprice=funstr(trim(request.form("comprice")))
comkind=funstr(request.form("comkind"))
payurl=funstr(request.form("payurl"))
  if comsize="" then
  getshow  "请输入套餐大小",""
end if

if comprice="" then
  getshow  "请输入套餐价格",""
end if

  set rs=rsfun("select * from ydy_combo where id="&id,3)
 if rs.bof and rs.eof then
	getshow "找不到要编辑的套餐！",""
		else
			rs("comsize")=comsize*1024*1024
			rs("comprice")=comprice
			rs("comkind")=comkind
			rs("payurl")=payurl
 		  rs.update
end if

rs.close
set rs=nothing
getdiv "修改套餐成功","admin_combo.asp?page="&currentpage&"","editok"
 end sub


sub main()
 'news 套餐管理
if not checkflag("ComboManage") then
  getshow "对不起，您没有【套餐管理】的权限！",""
end if



response.expires=0
currentpage=request("page")
kind=funstr(request("kind"))
comkind=funstr(request("comkind"))
orderby=funstr(request("orderby"))
if not isinteger(currentpage) then
  currentpage=1
else
  currentpage=clng(currentpage)
end if

maxperpage=30
totalrecords=0
totalpage=1
i=1



FileName="admin_combo.asp?Action="&Action&""

strFileName=FileName & "&orderby=" & orderby&"&kind="&kind


sql="select * from ydy_combo where id<>0 "

if comkind<>"" then
sql=sql&"and comkind="&comkind&""
end if
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
    <td height="22" style="color:#FFFFFF">.:: 您可以在这里进行[套餐管理]相关操作</td>
    <td width="200" height="22" align="right">
	 
    </td>
  </tr>
</table>
	
	</td>
  </tr>
</table> 

  <center><font size="+3">套餐管理</font></center>

<br>
<br>
  
<table width="750" border="0" align="center" cellpadding="0" cellspacing="1"   class="border1">
  <tr align="center" bgcolor="#EFEBEF">
    
    <td height="25" class="title">&nbsp;</td>
    <td height="25" colspan="2" class="title">&nbsp;&nbsp;<a href="javascript:showIframe('comadd','admin_combo.asp?action=add','78','502')" style="color:red;">添加套餐</a> &nbsp;   选择查看套餐类型： <%=getlink("<font color=white>全部类型</font>","?","") %>&nbsp;&nbsp;<%=getlink("<font color=white>年付类型</font>","?comkind=1","") %>&nbsp;&nbsp;<%=getlink("<font color=white>月付类型</font>","?comkind=2","") %>|</td>
    <td width="100" height="25" class="title"><span class="STYLE2">操　作</span></td>
  </tr>  <tr onMouseOut="this.style.backgroundColor=''" onMouseOver="this.style.backgroundColor='#BFDFFF'" class="tdbg">
    <td>ID<a  href="?orderby=id&kind=desc">&uarr;</a><a href="?orderby=id&kind=asc">&darr;</a></td>
    <td height="23">套餐名</td>
    <td>被使用人数 排序<a  href="?orderby=usenum&kind=desc">↑</a><a href="?orderby=usenum&kind=asc">↓</a></td>
    <td height="23" align="center">&nbsp;</td>
  </tr>
  <%
  color=""
  do until rs.eof or i>maxperpage
  	id=rs("id")
	comsize=rs("comsize")
	comprice=rs("comprice")
	comkind=rs("comkind")
	if comkind="1" then 
	comkind="年"
	color="00F"
	else
	comkind="月"
	color="000"
	end if
 	%>

  <tr onMouseOut="this.style.backgroundColor=''" onMouseOver="this.style.backgroundColor='#BFDFFF'" class="tdbg">
    
    <td width="41"><%=id%></td>
    <td width="250" height="23" style="color:#<%= color %>"><%=dSize(comsize)%>&nbsp;M/￥<%=comprice%><%=comkind%></td>
    <td width="352"><%=rs("usenum")%>个</td>
    <td height="23" align="center"><a href="javascript:showIframe('comedit','admin_combo.asp?action=edit&id=<%=rs("id")%>&page=<%=currentpage%>','76','500')" style="color:red;">编辑</a> 
    <a href="?action=del&id=<%=rs("id")%>" title="删除套餐..." onClick="javascript:if(confirm('是否真的要删除套餐吗？\n\n系统提示：删除后不可恢复！')){return true;}else{return false;}">删除</a></td>
  </tr>
  <%rs.movenext
   i=i+1
   loop
  %> 
  
  <%if totalrecords>0 then  %>
 	<%call showpage(strFileName,totalrecords,maxperpage,true,true,"个【套餐】信息")
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
    <td width="100%" height="23"  align="center"> <% rw("暂无套餐信息") %></td>
  
  </tr>
</table>

<%
  end if
%>

<%
end sub

sub del()

dim id:id=request("id")

if not isinteger(id) then
getshow "请指定要删除的套餐！",""
end if
 
conn.execute("delete  ydy_combo where id="&id)
 
getshow "删除套餐成功！","admin_combo.asp"

end sub
%>

 

 

</body>
</html>
