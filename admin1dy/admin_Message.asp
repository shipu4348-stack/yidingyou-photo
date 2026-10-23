  <!--#include file="conn.asp"-->
  <!--#include file="check.asp"-->
  <!--#include file="md5.asp"-->
 <%
	dim action
	dim totalpage,maxperpage,totalrecords,i,currentpage
	action=request("action")
	
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<title>服务于支持_用户管理页面</title>
 <link rel="stylesheet" type="text/css" href="images/Admin_Style.Css">

<style type="text/css">
<!--
.STYLE2 {color: #FFFFFF}
.timeover{
	text-decoration:line-through;
 
}
.timecss{
 	}
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
<table width="100%" border="0" align="center" cellpadding="2" cellspacing="1" class="border">
  <tr class="title"> 
    <td  > <table width="100%" border="0" align="center" cellpadding="0" cellspacing="0">
  <tr> 
    <td height="22" style="color:#FFFFFF">.:: 您可以在这里进行[服务与支持]相关操作 </td>
    <td width="200" height="22" align="right">
	 
    </td>
  </tr>
</table>
	
	</td>
  </tr>
</table> 

  <center>
    <font size="+3">服务与支持</font><!--<span class="title"><a href="javascript:showIframe('comadd','admin_Message.asp?action=add','57','502')" style="color:red;">添加用户</a></span> -->
  </center>

<br>
<%
select case action
  case "Show_Question"
    call Show_Question() 
  case "Question_replay"
    call Question_replay() 
	  case "del"
    call del() 
    case else
    call main()
end select

 sub Show_Question()
 %>
<%
 id=Trim(Request.QueryString("id"))
 
 set rs=rsfun("select * from GuestMessage where id="&id&"",1)
   '  listnum=rss.recordcount
 	If not(Rs.Bof And Rs.Eof) Then
	id=rs("id")
	question=rs("question")
	username=rs("username")
 	addtime=rs("addtime")
	content=rs("content")
	replay=rs("replay")
	'	i=0
	
	' for i=1 to listnum
	' usenum=DBGetNum("liu_user","id","0","where tcid="&rss("id")&" and yjf<>0 ")
     'conn.execute("update  ydy_combo set usenum="&usenum&" where id="&Rss("id"))
    ' rss.movenext
	'next
	Else
	getdiv "该问题不存在","","errorshow"
	End If
	Rs.Close
	Set Rs=Nothing 
 
%>
 <table width="100%" border="0" align="center" cellpadding="2" cellspacing="1" class="border">
  <tr class="title">
    <td  ><table width="100%" border="0" align="center" cellpadding="0" cellspacing="0">
      <form name="form1" method="post" action=""><tr>
        <td height="22" style="color:#FFFFFF">  查看方式：<a href="admin_Message.asp" class="STYLE2">全部问题</a> <a href="admin_Message.asp?replay=0" class="STYLE2">未解决问题</a> <a href="admin_Message.asp?replay=1" class="STYLE2">已解决问题</a> <a href="admin_Message.asp?yjf=0"></a>
          </label>
          <input name="username" type="text" id="username"  style="color:#a0a0a0" onFocus="this.style.color='#000';this.value=''" onBlur="if(this.value==''){this.value='搜：用户名';this.style.color='#a0a0a0'}" value='搜：用户名' size="10" maxlength="30" autocomplete="off"> 
          <input type="submit" name="button" id="button" value="搜索"></td>
        </tr></form>
    </table></td>
  </tr>
  <tr class="title">
    <td class="tdbg"  style="color:black;" >您现在选择的查看方式是：回复问题</td>
  </tr>
</table>
<br>
<table width="99%" border="0" align="center" cellpadding="2" cellspacing="1" class="border1" style="margin-left:auto; margin-right:auto; ">
   <tr class="title">
     <td  ><table width="100%" border="0" align="center" cellpadding="0" cellspacing="0">
          <tr>
           <td height="22" style="color:#FFFFFF">问题：[<%= question %>]</td>
         </tr>
      </table></td>
   </tr>
   <tr class="title">
     <td class="tdbg"  style="color:black;" ><span style="color:#000000">用户：<%= username %> 与<%= addtime %>提出的</span>:<br>
<blockquote><%= content%></blockquote></td>
   </tr>
 
 <%  set rss=rsfun("select * from GuestMessage where parentid="&id&"",1)
     listnum=rss.recordcount
 	If not(Rss.Bof And Rss.Eof) Then
	  for i=1 to listnum
	 replayname=rss("username")
 	replaytime=rss("addtime")
	content=rss("content")
	  if rss("isadmin")="1" then 
	  color="#BFDFFF"
	  levename="<font color=red>管理员</font>"
	  else
	  levename="用户"
	  color="#d6dff7"
	  end if
	 
  %>
 <tr class="title">
     <td class="tdbg"  style="color:black; background:<%= color %>;" ><span style="color:#000000"><%= levename %>：<%= replayname %> 与<%= replaytime %>回复</span>:<br>
<blockquote><%= content%></blockquote></td>
   </tr>
 <%
      rss.movenext
	 next
 
	End If
	Rss.Close
	Set Rss=Nothing  %>
  
   
   
 </table>
<br>
<% If replay<>1 Then %>
<table width="100%" border="0" cellpadding="0" cellspacing="1" class="border1">
  <tr>
    <td class="title"><div class="replay_info" style="margin-top:5px;">发表您的回复</div></td>
  </tr><form name="form2" method="post" action="?action=Question_replay">
  <tr>
    <td class="tdbg">
      <textarea name="content" cols="50" rows="4" id="content"></textarea>
      <br>
<input name="username" type="hidden" value="<%=session("admin")%>">
<input name="qid" type="hidden" value="<%=id%>"> 
是否解决 
<input name="replay" type="checkbox" id="replay" value="1">
<input type="submit" name="button2" id="button2" value="提交">
    </td>
  </tr></form>
</table>
<% Else %>
<table width="100%" border="0" cellpadding="0" cellspacing="1" class="border1">
  <tr>
    <td class="title"><div class="replay_info" style="margin-top:5px;">问题已解决，无法继续回复。</div></td>
  </tr> 
 
</table>
<% End If %>

 
 <%
  end sub
  
  sub Question_replay()
 qid=funstr(Trim(Request.Form("qid")))
 content=Trim(Request.Form("content"))
 username=Trim(Request.Form("username"))
 replay=Trim(Request.Form("replay"))
 sql="insert into GuestMessage(username,content,parentid,isadmin) VALUES ('"&username&"','"&content&"','"&qid&"',1)"
 set re=conn.execute(sql)
 conn.execute("update GuestMessage set retime=getdate() where id="&qid&"")
 if replay="1" then
  conn.execute("update GuestMessage set replay=1 where id="&qid&"")
  end if
 conn.execute("update GuestMessage set isadmin=1 where id="&qid&"")
    
getshow "回复成功","admin_Message.asp" 
  end sub


sub main()
 'news 用户管理
if not checkflag("UserManage") then
  getshow "对不起，您没有【用户管理】的权限！",""
end if


response.expires=0
currentpage=funstr(Trim(request("page")))

username=funstr(Trim(request("username")))
replay=funstr(Trim(request("replay")))
 

if not isinteger(currentpage) then
  currentpage=1
else
  currentpage=clng(currentpage)
end if

maxperpage=40
totalrecords=0
totalpage=1
i=1



FileName="admin_Message.asp?Action="&Action&""

strFileName=FileName & "&username=" & username &"&replay="&replay&""

kindstr="<font color=blue>全部</font>"
sql="select * from GuestMessage where parentid=0 "
if username<>"" and  username<>"搜：用户名" then
 sql=sql&" and username like '%"&username&"%'"
 kindstr=kindstr&"姓名包含："&username&"" 
 end if

if replay<>"" then
 sql=sql&" and replay="&replay&""
 if yjf=0  then
 kindstr=kindstr&"未解决问题" 
 else 
 kindstr=kindstr&"已解决问题"
  end if
End If
  
sql=sql&" order by id desc"
'rw sql
set rs=rsfun(sql,1)
 
 %>
  
<div style="position: absolute; width: 100%; height: 100%; z-index: 1; left: 0px; top: 0px; background-color:black;filter:alpha(opacity=70);opacity:0.7; display:none;" id="fugai_layout">
&nbsp;<iframe src="javascript:false" style="position:absolute;visibility:visible;top:0px; left:-1px; width:100%; height:100%; z-index:2; filter='progid:DXImageTransform.Microsoft.Alpha(style=0,opacity=0)';"></iframe></div>

<div id="comadd" style=" position: absolute;z-index: 100; border: 0px solid #333333;  display: none;">

</div><div id="comedit" style=" position: absolute;z-index: 100; border: 0px solid #333333;  display: none; text-align:center;">
 
</div>
  

<table width="100%" border="0" align="center" cellpadding="2" cellspacing="1" class="border">
  <tr class="title">
    <td  ><table width="100%" border="0" align="center" cellpadding="0" cellspacing="0">
      <form name="form1" method="post" action=""><tr>
        <td height="22" style="color:#FFFFFF">  查看方式：<a href="admin_Message.asp" class="STYLE2">全部问题</a> <a href="admin_Message.asp?replay=0" class="STYLE2">未解决问题</a> <a href="admin_Message.asp?replay=1" class="STYLE2">已解决问题</a> <a href="admin_Message.asp?yjf=0"></a>
          </label>
          <input name="username" type="text" id="username"  style="color:#a0a0a0" onFocus="this.style.color='#000';this.value=''" onBlur="if(this.value==''){this.value='搜：用户名';this.style.color='#a0a0a0'}" value='搜：用户名' size="10" maxlength="30" autocomplete="off"> 
          <input type="submit" name="button" id="button" value="搜索"></td>
        </tr></form>
    </table></td>
  </tr>
  <tr class="title">
    <td class="tdbg"  style="color:black;" >您现在选择的查看方式是：<%= kindstr %></td>
  </tr>
</table>
 
 
<br>
  <%   if not(rs.bof and rs.eof) then
  rs.pagesize=maxperpage
  rs.absolutepage=currentpage
  totalpage=rs.pagecount
  totalrecords=rs.recordcount %>
<table width="100%" border="0" align="center" cellpadding="0" cellspacing="1"   class="border1">
  <tr align="center" bgcolor="#EFEBEF">
    
    <td height="25" align="center" class="title">  问题编号</td>
    <td align="center" class="title">用户名</td>
    <td align="center" class="title">问题</td>
    <td align="center" class="title">状态</td>
    <td width="14%" height="25" align="center" class="title"><span class="STYLE2">操　作</span></td>
  </tr>
  <%

  do until rs.eof or i>maxperpage
	 
 	%>
  <tr onMouseOut="this.style.backgroundColor=''" onMouseOver="this.style.backgroundColor='#BFDFFF'" class="tdbg">
    
    <td width="7%"><%=rs("id")%></td>
    <td width="8%"><%=rs("username")%></td>
    <td width="43%"><% If rs("isadmin")=0  Then  Response.Write("<img src=images/new_03.gif>")%><a href="admin_message.asp?action=Show_Question&id=<%=rs("id")%>" style="color:green;"><%=rs("question")%></a> </td>
    <td width="28%"><%if rs("replay")=0 then 
	rw "<a href=?action=re&id="&rs("id")&" >未解决</a>"
	else
	fcolor "blue","已解决"
	end if
	%></td>
    <td height="23" align="center"><a href="admin_message.asp?action=Show_Question&id=<%=rs("id")%>" style="color:green;">回复</a> 确认解决 <a href="?action=del&id=<%=rs("id")%>" title="删除用户..." onClick="javascript:if(confirm('是否真的要删除用户吗？\n\n系统提示：删除后不可恢复！')){return true;}else{return false;}"> 删除</a></td>
  </tr>
  <%rs.movenext
   i=i+1
   loop
  %> 
  
<%if totalrecords>0 then  %>
 	<%call showpage(strFileName,totalrecords,maxperpage,true,true,"个【用户】")
 	 %> 
   <% End If %>

</table>
 
<%
rs.close
set rs=nothing
 
else
 %> 
   <table width="100%" border="0" cellpadding="0" cellspacing="1" bgcolor="#CCCCCC" class="border1">
  <tr align="center" > 
    <td width="100%" height="23"  align="center" class="tdbg"> <%rw("暂无符合检索条件：“"&kindstr&"”的用户信息") %></td>
  
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
getshow "请指定要删除的用户！",""
 end if
 conn.execute("delete  GuestMessage   where id="&id)
 conn.execute("delete   guestmessage where parentid="&id&"")
 getshow "删除信息成功！","admin_message.asp"
  %> 
<%
 end sub
 %>

 

 

</body>
</html>
