  <!--#include file="conn.asp"-->
  <!--#include virtual="/incs/FTP_conn.asp"-->
  <!--#include file="check.asp"-->
  <!--#include file="md5.asp"-->
 <%
Function DataFilesPath(subPath)
  Dim rootPath
  rootPath = Server.MapPath("/")
  If Right(rootPath, 1) = "\" Then rootPath = Left(rootPath, Len(rootPath) - 1)
  DataFilesPath = rootPath & "\datafiles\" & Replace(subPath, "/", "\")
End Function
 %>
 <%
	dim action,rsf
	dim totalpage,maxperpage,totalrecords,i,currentpage
	action=request("action")
 %>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<title>用户管理页面</title>
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
 ' case "add"
'    call add() 
'  case "addsave"
'    call addsave() 
	case "opencombo"
		call opencombo() 
	case "opensave"
		call opensave()
	case "Continue"
		call Continue() 
	case "Continue_Save"
		call Continue_Save()
	case "edit"
		call edit()
	case "editsave"
		call editsave()
	case "del"
		call del()
	case "clock"
		call clock() 
	case "unclock"
		call unclock()
	case "openftp"
		call openftp()
	case "closeftp"
		call closeftp()
	case "clear"
		call clears()
	case "contrast"
		call contrast()
	case "contrastall"
		call contrastall()
	case else
		call main()
end select

sub opencombo()
  id=request("id")
if not isinteger(id) then
 getdiv2 "对不起，请指定要开通空间的用户！","","userid","1200"
end if

if not checkflag("Pay") then
  getdiv2 "对不起，您没有【缴费开通】的权限！","","useradd","1200"
end if

set rs=rsfun("select [id],[fflx],[tcid],[username],[jfrq],[yjf] from liu_user where id="&id,1)
if rs.bof and rs.eof then
	getshow "找不到用户！",""
end if
if datediff("d",rs("jfrq"),now())<0 and rs("yjf")<>0 then
	getdiv2 "该用户空间尚未到期，无法继续开通。续费请选择续费开通功能！ ","","shownote","7200"
	rwend ""
end if
%>
 
  <form action="?action=opensave" method="post" name="add" id="add">
  <table width="501" border="0" align="center" cellpadding="0" cellspacing="1" bgcolor="#CCCCCC" class="border1">
    <tr align="center" onMouseOut="this.style.backgroundColor=''" onMouseOver="this.style.backgroundColor='#BFDFFF'" class="tdbg"> 
      <td width="94%" height="25" bgcolor="#EFEBEF" class="title"><font class="tfont"> <font class="tfont">用户</font>开通空间</font></td>
      <td width="6%" align="right" bgcolor="#EFEBEF" class="title"><a href="#" onClick="closedivc('comadd')"><img style="cursor:hand;" onClick="divclose('comedit');" src="images/close.gif"  border="0" /></a></td>
      
    </tr>
	<tr onMouseOut="this.style.backgroundColor=''" onMouseOver="this.style.backgroundColor='#BFDFFF'" class="tdbg">
	  <td height="25" colspan="2" align="center" class="tdbg">该用户选择<span class="c_red">开通</span>类型为：
	<%if rs("fflx")="1" then
	   rw "年付" 
	  else
	  rw "月付"
	  end if
	  %>-<select name="tcid">
 	 <%
 	set rss= server.CreateObject("adodb.recordset")
	Sql="Select id,comsize,comprice From ydy_combo  order by id desc "
   rss.open sql,conn,1,1
    listnum=rss.recordcount
 	If Rss.Bof And Rss.Eof Then
		Response.Write("")
	Else
	 for i=1 to listnum
	optionstr="<option value="&Rss(0)&""
	if rs("tcid")=Rss(0) then optionstr=optionstr&" selected style=""COLOR:blue;"""
	optionstr=optionstr&">"&dSize(Rss(1))&"M/￥"&Rss(2)&"</option>"
  Response.Write(optionstr)
  
    rss.movenext
	next
	End If
	Rss.Close
	Set Rss=Nothing   %> </select>的空间，是否确认
       <input name="username" type="hidden" value="<%= rs("username") %>">
 
           <input name="userid" type="hidden" value="<%= rs("id") %>">
           <input name="fflx" type="hidden" value="<%= rs("fflx") %>">
        <input name="Submit3" type="submit" class="button" value=" 确认开通 "></td>
    </tr>
  
  </table>
</form> 
 
<%
rs.close
set rs=nothing
end sub

sub opensave()
dim comsize,comprice,comkind
userid=funstr(trim(request.form("userid")))
tcid=funstr(trim(request.form("tcid")))
fflx=funstr(request.form("fflx"))
username=funstr(request.form("username"))

if userid="" then
  getshow  "请输入用户id",""
end if
  
if fflx=1 then 
   sql="update  liu_user set jfrq=""#"&addtimes&"#""  where id="&userid
   conn.execute("update  liu_user set fflx=1,tcid="&tcid&",jfrq=DateAdd(year,1,getdate())  where id="&userid)
else
 addtimes=trim(dateadd ("d",31,date()))
 sql="update  liu_user set fflx=2,tcid="&tcid&",jfrq=DateAdd(d,31,getdate()) where id="&userid
 conn.execute(sql)
end if 
conn.execute("update  liu_user set addtime=getdate()  where id="&userid) 
conn.execute("update  liu_user set yjf=1 where id="&userid)
Set Fso=Server.CreateObject("Scripting.FileSystemObject")
	NewFolderPath = DataFilesPath("users/"& username)
	If not Fso.FolderExists(NewFolderPath) then
		Fso.CreateFolder(NewFolderPath)
		Fso.CreateFolder(NewFolderPath&"/html")
		Fso.CreateFolder(NewFolderPath&"/Temp")
		Fso.CreateFolder(NewFolderPath&"/pic")
	End if
	getdiv2 "该用户空间开通成功","admin_user.asp","openok","1200"
end sub

sub Continue()
  id=request("id")
if not isinteger(id) then
 getdiv2 "对不起，请指定要开通空间的用户！","","nonono","1200"
   rwend ""
end if

if not checkflag("UserManage") then
   getdiv2 "对不起，您没有【用户续费】的权限！","","nonono","1200"
   rwend ""
end if

set rs=rsfun("select * from liu_user where id="&id,1)
if rs.bof and rs.eof then
getdiv "找不到用户！","","findname"
end if
 if rs("yjf")=0 then
 getdiv2 "该用户尚未缴费或还未开通空间过。无法使用续费功能！","","shownote","7600"
 rwend ""
end if

%>

  <form action="?action=Continue_Save" method="post" name="add" id="add">
  <table width="501" border="0" align="center" cellpadding="0" cellspacing="1" bgcolor="#CCCCCC" class="border1">
    <tr align="center" onMouseOut="this.style.backgroundColor=''" onMouseOver="this.style.backgroundColor='#BFDFFF'" class="tdbg"> 
      <td width="94%" height="25" bgcolor="#EFEBEF" class="title"><font class="tfont"> 用户续费开通空间</font></td>
      <td width="6%" align="right" bgcolor="#EFEBEF" class="title"><a href="#" onClick="closedivc('comedit')"><img style="cursor:hand;" onClick="divclose('comedit');" src="images/close.gif"  border="0" /></a></td>
      
    </tr>
	<tr onMouseOut="this.style.backgroundColor=''" onMouseOver="this.style.backgroundColor='#BFDFFF'" class="tdbg">
	  <td height="25" colspan="2" align="center" class="tdbg">该用户选择<span class="c_red">续费</span>的空间为：
  <select name="tcid">
 	 <%
 set rss= server.CreateObject("adodb.recordset")
	Sql="Select id,comsize,comprice,comkind From ydy_combo  order by id desc "
   rss.open sql,conn,1,1
    listnum=rss.recordcount
 	If Rss.Bof And Rss.Eof Then
		Response.Write("")
	Else
	 for i=1 to listnum
	optionstr="<option value="&Rss(0)&""
	if rs("tcid")=Rss(0) then optionstr=optionstr&" selected style=""COLOR:red;"""
	 if rss("comkind")=1 then
	 fflxname=" style=""COLOR:blue;"">年付" 
	  else
	 fflxname=" style=""COLOR:green;"">月付"
	  end if
	optionstr=optionstr&""&fflxname&"/"&dSize(Rss(1))&"M/￥"&Rss(2)&"</option>"
  Response.Write(optionstr)
  
    rss.movenext
	next
	End If
	Rss.Close
	Set Rss=Nothing   %> </select>的空间，是否确认
       <input name="username" type="hidden" value="<%= rs("username") %>">
	    
           <input name="userid" type="hidden" value="<%= rs("id") %>">
           <input name="fflx" type="hidden" value="<%= rs("fflx") %>">
      <input name="Submit3" type="submit" class="button" value=" 确认开通 "></td>
    </tr>
  
  </table>
</form> 
 
<%
rs.close
set rs=nothing
end sub

sub Continue_Save()
dim comsize,comprice,comkind
userid=funstr(trim(request.form("userid")))
tcid=funstr(trim(request.form("tcid")))
fflx=funstr(request.form("fflx"))
username=funstr(request.form("username"))

if userid="" then
  getshow  "请输入用户id",""
end if
  
if fflx=1 then 
   conn.execute("update  liu_user set fflx=1,tcid="&tcid&",addtime=getdate(),jfrq=DateAdd(year,1,getdate())  where id="&userid)
  else
 addtimes=trim(dateadd ("d",31,date()))
  conn.execute("update  liu_user set fflx=2,tcid="&tcid&",addtime=getdate(),jfrq=DateAdd(d,31,getdate()) where id="&userid)
 end if
  ' rwend addtimes
conn.execute("update  liu_user set updatetime=getdate()  where id="&userid)
 
conn.execute("update  liu_user set yjf=1 where id="&userid)
Set Fso=Server.CreateObject("Scripting.FileSystemObject")
	NewFolderPath = DataFilesPath("users/"& username)
	If not Fso.FolderExists(NewFolderPath) then
		Fso.CreateFolder(NewFolderPath)
		Fso.CreateFolder(NewFolderPath&"/html")		
		Fso.CreateFolder(NewFolderPath&"/Thum")
	End if
	Set Fso = nothing
   getdiv "该用户空间开通成功","","openok" 
end sub

sub edit()

dim id

id=request("id")
if not isinteger(id) then
  getdiv "对不起，请指定要编辑的用户！","","editname"

end if

set rs=rsfun("select * from liu_user where id="&id,1)
if rs.bof and rs.eof then
getshow "找不到用户！",""
end if
 
%>

 <form action="?action=editsave" method="post" name="edit" id="edit">
   <table width="650" border="0" align="center" cellpadding="0" cellspacing="1" bordercolor="#cccccc" class="border1">
		  <tr align="center" bgcolor="#EFEBEF" > 
      <td height="25" class="title" colspan="6"><div style="  width:550px;float:left; margin-top:2px;">用 户 - 编辑 </div> <div style=" width:40px; "><img src="images/close.gif"  border="0"   style="  float:right; margin-top:1px; " onClick="divclose('comedit');" /></div></td>
     </tr>
		  <td width="103"></tr>
		
	<tr>
	  <td align="left" class="tdbg">付费类型：</td>
	  <td width="118" class="tdbg"> <input name="fflx" type="radio" value="1" <%if rs("fflx")=1 then rw "checked"%>>年付  <input name="fflx" type="radio" value="1" <%if rs("fflx")=2 then rw "checked"%>>月付 </td>
	  <td width="99" class="tdbg">对应套餐：</td>
	  <td width="128" class="tdbg"> <select name="tcid">
 	 <%
 set rss= server.CreateObject("adodb.recordset")
	Sql="Select id,comsize,comprice,comkind From ydy_combo  order by id desc "
   rss.open sql,conn,1,1
    listnum=rss.recordcount
 	If Rss.Bof And Rss.Eof Then
		Response.Write("")
	Else
	 for i=1 to listnum
	optionstr="<option value="&Rss(0)&""
		if rs("tcid")=Rss(0) then optionstr=optionstr&" selected style=""COLOR:red;"""
	if rss("comkind")=1 then
	 fflxname=" style=""COLOR:blue;"">年付" 
	  else
	 fflxname=" style=""COLOR:green;"">月付"
	  end if
	optionstr=optionstr&""&fflxname&"/"&dSize(Rss(1))&"M/￥"&Rss(2)&"</option>"
  Response.Write(optionstr)
  
    rss.movenext
	next
	End If
	Rss.Close
	Set Rss=Nothing   %> </select></td>
	  <td width="72" class="tdbg">付费状态：</td>
	  <td width="121" class="tdbg">
	  <%if 	  rs("yjf")=0 then
	   rw "未付费" 
	  elseif rs("yjf")=1 then 
	  rw "已付费"
	  else
	  rw "测试用户"
	  end if%></td>
    </tr>
		
		<tr class="tdbg">
  <td align="left">用户名：</td>
		  <td><input name="username" type="text" readonly value='<%=rs("username")%>' size="18" maxlength="40"></td>
		  <td>用户密码：</td>
		  <td><input type="text" name="pwd" size="18" maxlength="40" value=''></td>
		  <td>电子邮件：</td>
		  <td><input type="text" name="email" size="18" maxlength="40" value='<%=rs("email")%>'></td>
    </tr>
		
		<tr class="tdbg">
		  <td align="left" >提示问题：</td>
					  <td ><input type="text" name="question" size="18" maxlength="40" value='<%=rs("question")%>'></td>
					  <td >答案：</td>
					  <td ><input type="text" name="answer" size="18" maxlength="40" value='<%=rs("answer")%>'></td>
					  <td >店铺名称：</td>
					  <td ><input type="text" name="dpname" size="18" maxlength="40" value='<%=rs("dpname")%>'></td>
    </tr>
		
		<tr class="tdbg">
		  <td align="left" >店铺连接：</td>
					  <td><input type="text" name="dplink" size="18" maxlength="40" value='<%=rs("dplink")%>'></td>
					  <td>网站名称：</td>
					  <td><input type="text" name="wwname" size="18" maxlength="40" value='<%=rs("wwname")%>'></td>
					  <td>QQ号码：</td>
					  <td><input type="text" name="qqhm" size="18" maxlength="40" value='<%=rs("qqhm")%>'></td>
    </tr>
		
		<tr class="tdbg">
  <td align="left" >用户姓名：</td>
		  <td ><input type="text" name="xingming" size="18" maxlength="40" value='<%=rs("xingming")%>'></td>
		  <td >电话：</td>
		  <td ><input type="text" name="phone" size="18" maxlength="40" value='<%=rs("phone")%>'></td>
		  <td >邮编：</td>
		  <td ><input type="text" name="card" size="18" maxlength="40" value='<%=rs("card")%>'></td>
     </tr>
		
		<tr class="tdbg">
<td align="left" >最后登录时间：</td>
					  <td ><input name="LostTime" type="text" disabled value='<%=rs("LostTime")%>' size="18" maxlength="40"></td>
					  <td >最后登录IP：</td>
					  <td ><input name="LostIp" type="text" disabled value='<%=rs("LostIp")%>' size="18" maxlength="40"></td>
					  <td >开通日期：</td>
					  <td ><input name="addtime" type="text" disabled value='<%=rs("addtime")%>' size="18" maxlength="40"></td>
    </tr>
		
		<tr class="tdbg">
<td align="left" >终止日期：</td>
					  <td ><input name="jfrq" type="text" disabled value='<%=rs("jfrq")%>' size="18" maxlength="40"></td>
					  <td >更新套餐时间：</td>
					  <td ><input name="Updatetime" type="text" disabled value='<%=rs("Updatetime")%>' size="18" maxlength="40"></td>
					  <td >是否锁定：</td>
					  <td > 
					    <input name="isclock" type="radio" value="1" <%if rs("isclock")=1 then rw "checked"%>>
					    冻结
                        <input name="isclock" type="radio" value="0" <%if rs("isclock")=0 then rw "checked"%>>
                      未冻结 </td>
    </tr>
		<tr class="tdbg">
		  <td align="left" >所属分站：</td>
		  <td align="center" ><select name="sid">
 	 <%
	 dim listnums
 set rss= server.CreateObject("adodb.recordset")
	Sql="Select id,sname,sid From liu_server  order by id desc "
   rss.open sql,conn,1,1
    listnums=rss.recordcount
 	If Rss.Bof And Rss.Eof Then
		Response.Write("11")
	Else
	 for i=1 to listnums
	optionstr="<option value="&Rss(2)&""
		if rs("sid")=Rss(2) then optionstr=optionstr&" selected style=""COLOR:red;"""
	optionstr=optionstr&">"&Rss(1)&"</option>"
  Response.Write(optionstr)
      rss.movenext
	next
	End If
	Rss.Close
	Set Rss=Nothing
	
	
	   %> </select>
    
    </td>
		  <td align="center" >&nbsp;</td>
		  <td align="center" ><input name="id" type="hidden" id="id" value="<%=id%>">
          <input name="Submit" type="submit" class="button" value=" 确定编辑 "></td>
		  <td align="center" >&nbsp;</td>
		  <td align="center" >&nbsp;</td>
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
     getdiv "找不到要编辑的用户！","","editname"

end if

dim fflx,tcid,username,pwd,email,question,answer,dpname,dplink,wwname,qqhm,yjf,isclock,xingming,phone,card,sid
 
	  fflx=funstr(request("fflx"))
	  tcid=funstr(request("tcid"))
	  username=funstr(request("username"))
	  pwd=funstr(request("pwd"))
	  email=funstr(request("email"))
	  question=funstr(request("question"))
	  answer=funstr(request("answer"))
	  dpname=funstr(request("dpname"))
	  dplink=funstr(request("dplink"))
	  wwname=funstr(request("wwname"))
	  qqhm=funstr(request("qqhm"))
	  yjf=funstr(request("yjf"))
	  isclock=funstr(request("isclock"))
	  xingming=funstr(request("xingming"))
	  phone=funstr(request("phone"))
	  card=funstr(request("card"))
	  sid=funstr(request("sid"))
	  
	  CountBytes=conn.execute("select comsize from [ydy_combo] where id="&tcid&"")(0)
	'修改数据库
	'response.Write tcid
	set rs=rsfun("select * from liu_user where id="&id,3)
	if rs.bof and rs.eof then
  		getdiv "找不到要编辑的用户！","","editname"
	else
		oldtcid=rs("tcid")			
		rs("fflx")=fflx
		rs("tcid")=tcid
		if pwd<>"" and not isnull(pwd) then
			rs("pwd")=md5(pwd,"long")
			rs("ftppwd")=SerUPassEnCode(pwd)
			'CDB()
'			set rsf=server.CreateObject("adodb.recordset")
'			rsf.open "select id from [ftp_users] where ftpUserName='"&UserName&"'",Fconn,1,1
'			if not(rsf.eof and rsf.bof) then
'				Fconn.execute("update [ftp_users] set ftpPassword='"&SerUPassEnCode(pwd)&"' where ftpUserName='"&UserName&"'")
'			end if
'			ClDB()
		else
			pwd2=rs("ftppwd")
		end if				
		rs("email")=email
		rs("question")=question
		rs("answer")=answer
		rs("dpname")=dpname
		rs("dplink")=dplink
		rs("wwname")=wwname
		rs("qqhm")=qqhm
		'rs("yjf")=yjf 缴费状态，编辑不修改，预留。
		rs("isclock")=isclock
		rs("xingming")=xingming
		rs("phone")=phone
		rs("card")=card
		rs("CountBytes")=CountBytes
		rs("UsedBytes")=FolderSize
		rs("ResBytes")=CountBytes
		
		rs("sid")=sid
	  rs.update	  
	end if	
	rs.close
	set rs=nothing
	set fso=nothing
	if tcid<>old then
	  if fflx=1 then
		 conn.execute("update liu_user set addtime=getdate(),jfrq=DateAdd(year,1,getdate())  where id="&id)
	  else
		 conn.execute("update liu_user set addtime=getdate(),jfrq=DateAdd(d,31,getdate()) where id="&id)
	  end if
	end if
    getdiv2 "编辑用户成功！","","addok","1200"
 end sub


sub main()
 'news 用户管理
if not checkflag("UserManage") then
  getshow "对不起，您没有【用户管理】的权限！",""
end if


response.expires=0
currentpage=funstr(Trim(request("page")))

username=funstr(Trim(request("username")))
yjf=funstr(Trim(request("yjf")))
isclock=funstr(Trim(request("isclock")))
fflx=funstr(Trim(Request("fflx")))
tcid=funstr(Trim(Request("tcid")))
sid=funstr(Trim(Request("sid")))
overtime=funstr(trim(request("overtime")))

if not isinteger(currentpage) then
  currentpage=1
else
  currentpage=clng(currentpage)
end if

maxperpage=40
totalrecords=0
totalpage=1
i=1



FileName="admin_user.asp?Action="&Action&""

strFileName=FileName & "&username=" & username &"&yjf="&yjf&"&tcid="&tcid&"&isclock="&isclock&""


sql="select id,fflx,tcid,username,yjf,isclock,addtime,jfrq,countbytes,usedbytes,isftp,sid from liu_user where id<>0 "
if username<>"" and  username<>"搜：用户名" then
 sql=sql&" and username like '%"&username&"%'"
 end if
kindstr="<font color=blue>全部</font>"
if yjf<>"" then
 sql=sql&" and yjf="&yjf&""
 if yjf=0  then
 kindstr=kindstr&"未付款用户" 
 elseif yjf=1 then
 kindstr=kindstr&"已付款用户"
 else
  kindstr=kindstr&"测试账号"
 end if
End If
if isclock<>"" then 
sql=sql&" and isclock="&isclock&""
  kindstr=kindstr&"冻结账户" 
 End If
if fflx<>"" and fflx<>"0" then
 sql=sql&" and fflx="&fflx&""
 if fflx=1 then
  fflx="年付"
 else
 fflx="月付"
 end if
 kindstr=kindstr&"付费方式为"&fflx&""
 End If

if tcid<>"" and tcid<>"0" then
 sql=sql&" and tcid="&tcid&""
 kindstr=kindstr&"套餐为【"&dsize(DBGetValue("ydy_combo","comsize","id="&tcid&""))&"M/￥"&DBGetValue("ydy_combo","comprice","id="&tcid&"")&"】"
 
 End If 
 
 if sid<>"" and sid<>"-1" then
 sql=sql&" and sid="&sid&""
 kindstr=kindstr&"分站为【"&DBGetValue("liu_server","sname","sid="&sid&"")&"】"
 
 End If 
 
 if overtime="1"  then
 sql=sql&" and datediff(minute,jfrq,getdate())>=1 "
 kindstr=kindstr&"过期用户"
 End If 
 
sql=sql&" order by id desc"
'rw sql
set rs=rsfun(sql,1)
 
 %>
  
<div style="position: absolute; width: 100%; height: 100%; z-index: 1; left: 0px; top: 0px; background-color:black;filter:alpha(opacity=70);opacity:0.7; display:none;" id="fugai_layout">
&nbsp;<iframe src="javascript:false" style="position:absolute;visibility:visible;top:0px; left:-1px; width:100%; height:100%; z-index:2; filter='progid:DXImageTransform.Microsoft.Alpha(style=0,opacity=0)';"></iframe></div>

<div id="comadd" style=" position: absolute;z-index: 100; border: 0px solid #333333;  display: none;">

</div><div id="comedit" style=" position: absolute;z-index: 100; border: 0px solid #333333;  display: none;">
 
</div>
  
<table width="100%" border="0" align="center" cellpadding="2" cellspacing="1" class="border">
  <tr class="title"> 
    <td  > <table width="100%" border="0" align="center" cellpadding="0" cellspacing="0">
  <tr> 
    <td height="22" style="color:#FFFFFF">.:: 您可以在这里进行[用户管理]相关操作</td>
    <td width="200" height="22" align="right">
	 
    </td>
  </tr>
</table>
	
	</td>
  </tr>
</table> 

  <center><font size="+3">用户管理</font><!--<span class="title"><a href="javascript:showIframe('comadd','admin_user.asp?action=add','57','502')" style="color:red;">添加用户</a></span> -->
  </center>

<br>
<table width="100%" border="0" align="center" cellpadding="2" cellspacing="1" class="border">
  <tr class="title">
    <td  ><table width="100%" border="0" align="center" cellpadding="0" cellspacing="0">
      <form name="form1" method="post" action=""><tr>
        <td height="22" style="color:#FFFFFF">  查看方式：<a href="admin_user.asp" class="STYLE2">全部用户</a> <a href="admin_user.asp?yjf=0" class="STYLE2">未付款用户</a> <a href="admin_user.asp?yjf=1" class="STYLE2">已付款用户</a> <a href="admin_user.asp?yjf=0"></a> <a href="admin_user.asp?yjf=2" class="STYLE2">测试用户</a> <a href="admin_user.asp?isclock=1" class="STYLE2">冻结账户</a> <a href="?overtime=1" class="STYLE2">到期帐户</a> <a href="javascript:showIframe('comedit','admin_user.asp?action=contrastall','120','560')" onClick="javascript:if(confirm('确定要匹配所有用户数据？\n\n系统提示：这个可能需要一段时间 ，请等待！')){return true;}else{return false;}" class="STYLE2">匹配全部</a>
<select name="fflx" id="fflx" onChange="if(this.options[this.selectedIndex].value!=''){location='admin_user.asp?fflx='+this.options[this.selectedIndex].value;}" >
  <option value="0"selected>按套餐类型显示</option>
  <option value="0">列出全部</option>
  <option value="1" >年付类型</option>
  <option value="2">月付类型</option>
</select>
          </label>
          
           
              
              
       
  <select name="tcid" id="tcid" onChange="if(this.options[this.selectedIndex].value!=''){location='admin_user.asp?tcid='+this.options[this.selectedIndex].value;}" >
						<option value="" >--请选择套餐--</option>
						<option value="0">列出全部</option>
						<%
						sql = "select *   from ydy_combo where  id<>0  "
					Set ns = conn.execute(sql)
  						Do While Not ns.Eof
							Response.Write("<option value="""& ns("id") &"""")
							'If ns("id") = id Then Response.Write(" selected")
							if ns("comkind")=1 then
								 fflxname=" style=""COLOR:blue;"">年付" 
								  else
								 fflxname=" style=""COLOR:green;"">月付"
						   end if
							Response.Write(""&fflxname&" "&dSize(ns("comsize")) &"M/￥"&ns("comprice") &"</option>")
						ns.MoveNext
						Loop
						ns.Close
						%>
			  </select>
             <select name="sid" id="sid" onChange="if(this.options[this.selectedIndex].value!=''){location='admin_user.asp?sid='+this.options[this.selectedIndex].value;}" >
						<option value="" >--请选择分站--</option>
						<option value="-1">列出全部</option>
						 <%
	 dim listnums
 set rss= server.CreateObject("adodb.recordset")
	Sql="Select id,sname,sid From liu_server  order by id desc "
   rss.open sql,conn,1,1
    listnums=rss.recordcount
 	If Rss.Bof And Rss.Eof Then
		Response.Write("11")
	Else
	 for i=1 to listnums
	optionstr="<option value="&Rss(2)&""
	optionstr=optionstr&">"&Rss(1)&"</option>"
  Response.Write(optionstr)
      rss.movenext
	next
	End If
	Rss.Close
	Set Rss=Nothing
	
	
	   %> 
			  </select> 
            <input name="username" type="text" id="username"  style="color:#a0a0a0" onFocus="this.style.color='#000';this.value=''" onBlur="if(this.value==''){this.value='搜：用户名';this.style.color='#a0a0a0'}" value='搜：用户名' size="10" maxlength="30" autocomplete="off"> <input type="submit" name="button" id="button" value="搜索"></td>
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
    
    <td height="25" align="center" class="title">  用户ID</td>
    <td align="center" class="title">用户名</td>
    <td align="center" class="title">空间类型</td>
    <td width="6%" align="center" class="title">使用情况</td>
    <td align="center" class="title">开通时间</td>
    <td height="25" align="center" class="title">到期时间</td>
    <td width="13%" align="center" class="title">分站名</td>
    <td width="13%" align="center" class="title">付费情况</td>
    <td width="26%" height="25" align="center" class="title"><span class="STYLE2">操　作</span></td>
  </tr>
  <%

  do until rs.eof or i>maxperpage
	 if datediff("d",rs("jfrq"),now())>=1 then
	 timecss="timeover"
	 else
	 timecss="timeok"
	 end if
	 
	 if rs("sid")=server_id then 
		 isdo=true
		 else
		 isdo=false
	 end if
	 
 	%>
  <tr onMouseOut="this.style.backgroundColor=''" onMouseOver="this.style.backgroundColor='#BFDFFF'" class="tdbg">
    
    <td width="6%"><%=rs("id")%></td>
    <td width="8%"><a href="/ajaxasp/managelogin.asp?username=<%=rs("username")%>" target="_blank"><%=rs("username")%></a></td>
    <td width="12%"><% 
	If rs("fflx")="1" then
	 %><a href=admin_user.asp?fflx=1><%call FColor("red","年付")%></a> 
     <%
	else
	%>
<a href=admin_user.asp?fflx=2><%call FColor("blue","月付")%></a> 
    <%
  End If %>： <%=dSize(rs("CountBytes"))%>M/￥<%=DBGetValue("ydy_combo","comprice","id="&rs("tcid")&"")%>
</td>
	<td>
    <%=int(dSize(rs("UseDBytes")))%>M
    </td>
    <td width="7%"><%=formatdatetime(rs("addtime"),2) %></td>
    <td width="9%" height="23"> <span class=<%= timecss %>><%=formatdatetime(rs("jfrq"),2)%></span></td>
    <td align="center"><% If rs("sid")="0" Then 
	rw "www.1dy.cc"
	else
	rw "up"&rs("sid")&".1dy.cc"
	end if%></td>
    <td align="center">
	<%if rs("yjf")=0 then 
		rw ""&getlink("<font color=""red"">未付费</font>","admin_user.asp?yjf=0","")&"  "
		if isdo then rw " <a href='?action=clear&id="&rs("id")&"' onClick=""javascript:if(confirm('是否确定清除用户数据？\n\n系统提示：清楚后不可恢复！')){return true;}else{return false;}"">清除</a>" 
	ELSEif rs("yjf")=1 then 
		rw ""&getlink ("已付费","admin_user.asp?yjf=1","")&" "
		if isdo then rw " <a href='?action=clear&id="&rs("id")&"' onClick=""javascript:if(confirm('是否确定清除用户数据？\n\n系统提示：清楚后不可恢复！')){return true;}else{return false;}"">清除</a>"
	else
		rw ""&getlink("测试","admin_user.asp?yjf=2","")&"  "
		if isdo then rw " <a href='?action=clear&id="&rs("id")&"' onClick=""javascript:if(confirm('是否确定清除用户数据？\n\n系统提示：清楚后不可恢复！')){return true;}else{return false;}"">清除</a>"
	end if
	%>&nbsp;
    <% if isdo then  %><a href="javascript:showIframe('comedit','admin_user.asp?action=contrast&id=<%=rs("id")%>','120','560')" >匹配</a><% End If %>
    </td>
    <td height="23" align="left">
	<% If rs("isclock")="1"then 
	ctype="unclock" 
	cname="<font color=red>解冻</font>"
	else
	ctype="clock" 
	cname="<font color=black>冻结</font>"
	end if%>
     <a href="javascript:showIframe('comedit','admin_user.asp?action=<%= ctype %>&id=<%=rs("id")%>','120','560')" ><%= cname %></a>
     <a href="javascript:showIframe('comedit','admin_user.asp?action=opencombo&id=<%=rs("id")%>','120','560')" style="color:black;">开通</a>
      <%if rs("isftp")="0" then%>
     <a href="javascript:showIframe('comedit','admin_user.asp?action=openftp&id=<%=rs("id")%>','120','560')" style="color:black;">开通FTP</a>
     <%else%>
     <a href="javascript:showIframe('comedit','admin_user.asp?action=closeftp&id=<%=rs("id")%>','120','560')" style="color:red;">暂停FTP</a>
     <%end if%>     
     <a href="javascript:showIframe('comedit','admin_user.asp?action=Continue&id=<%=rs("id")%>','120','560')" style="color:black;">续费</a>  
   <a href="javascript:showIframe('comedit','admin_user.asp?action=edit&id=<%=rs("id")%>','300','680')" style="color:black;">编辑</a> 
   <%if rs("yjf")<>2 then%>
    <% if isdo then  %><a href="?action=del&id=<%=rs("id")%>" title="删除用户..." onClick="javascript:if(confirm('是否真的要删除用户[<%=rs("username")%>]吗？\n\n系统提示：删除后不可恢复！')){return true;}else{return false;}">删除</a>  <% End If %> <%end if%>
    <% If rs("sid")<>"0" Then %>
    <a href="http://up<%=rs("sid")%>.1dy.cc/admin1dy/admin_login.asp" target="_blank" >管理</a>
   	<% End If %>

    </td>
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
	ShowUserName=DBGetValue("liu_user","username","id="&id&"")
	if ShowUserName="" then 
	 getshow "你选择的用户不存在！",""
	end if		 
	NewFolderPath = DataFilesPath("users/"& ShowUserName)
		'CDB()
'		set rsf=server.CreateObject("adodb.recordset")
'		rsf.open "select id from [ftp_users] where ftpUserName='"&UserName&"'",Fconn,1,1
'		if not(rsf.eof and rsf.bof) then
'			Fconn.execute("delete [ftp_users] where ftpUserName='"&UserName&"'")
'		end if
'		rsf.close
'		set rsf=nothing
'		ClDB()
	 set fs=new dmfso
	 if fs.ReportFolderStatus(NewFolderPath)=1 then
			if fs.deleteAFolder(NewFolderPath)=-1 then 
			    getshow "发生错误，删除该用户文件夹失败,可能该文件夹内容正在被调用！",""
			 else
				 if fs.ReportFolderStatus(NewFolderPath)=-1 then				 	
					conn.execute("delete  liu_pic where kuser='"&ShowUserName&"'")
					conn.execute("delete  Liu_Folder where kuser='"&ShowUserName&"'")
					conn.execute("delete  Liu_Message where sendname='"&ShowUserName&"'")
					conn.execute("delete  Liu_Code where kname='"&ShowUserName&"'")
					conn.execute("delete  GuestMessage where username='"&ShowUserName&"'")
					conn.execute("delete  ydy_buliang where NameUser='"&ShowUserName&"'")
					conn.execute("delete  liu_user where id="&id)
				else
				getshow "发生错误，用户【/users/"& ShowUserName&"】文件夹未删除成功，删除用户操作终止！",""
				 end if
			end if
	else
		conn.execute("delete  liu_pic where kuser='"&ShowUserName&"'")
		conn.execute("delete  Liu_Folder where kuser='"&ShowUserName&"'")
		conn.execute("delete  Liu_Message where sendname='"&ShowUserName&"'")
		conn.execute("delete  Liu_Code where kname='"&ShowUserName&"'")
		conn.execute("delete  GuestMessage where username='"&ShowUserName&"'")
		conn.execute("delete  ydy_buliang where NameUser='"&ShowUserName&"'")
		conn.execute("delete  liu_user where id="&id)
 	end if  
	 
		getshow "删除用户成功！","admin_user.asp"
 	set fs=nothing

end sub

sub unclock()
	dim id:id=request("id")
	if not isinteger(id) then 
		getdiv "请指定要解冻的用户！","","postname"
	end if
	conn.execute("update  liu_user set isclock=0 where id="&id)
	getdiv "解冻用户成功！","admin_user.asp","unclockdiv"
end sub
 
sub clock()
	dim id:id=request("id")
	if not isinteger(id) then
		getdiv "请指定要冻结的用户！","","postname"
	end if
	conn.execute("update  liu_user set isclock=1 where id="&id)
	getdiv "冻结用户成功！","admin_user.asp","clockdiv"
end sub

sub openftp()
	dim id:id=request("id")
	dim sql
	if not isinteger(id) then
		getdiv "请指定要开通FTP的用户！","","postname"
	end if
	UserName=conn.execute("select [username] from [liu_user] where id="&id&"")(0)
	ftppwd=conn.execute("select [ftppwd] from [liu_user] where id="&id&"")(0)
	CountBytes=conn.execute("select [CountBytes] from [liu_user] where id="&id&"")(0)
	UsedBytes=conn.execute("select [UsedBytes] from [liu_user] where id="&id&"")(0)
	Path=DataFilesPath("users/"&UserName&"/Temp")
	accessRule=Path&"|RWAMLCDP"'主目录及权限
	dirHome=Path
	'expiration=date()'开通日期
	'maxUsersLoginPerIP'同时可登多少个IP
	'maxUsersConcurrent'
	sql = "INSERT INTO ftp_users ( ftpUserName,ftpPassword,accessRule,dirHome,quotaEnable,quotaCurrent,quotaMax,str1) "
	sql = sql & " VALUES ('" & UserName & "', '" & ftppwd & "','" & accessRule & "','" & dirHome & "',1,"&UsedBytes&","&CountBytes&",'" & pass & "')"
	'CDB()
'	set rsf=server.CreateObject("adodb.recordset")
'	rsf.open "select id from [ftp_users] where ftpUserName='"&UserName&"'",Fconn,1,1
'	if rsf.eof and rsf.bof then
'		Fconn.execute(sql)
'	else
'		Fconn.execute("update [ftp_users] set disabled=0,quotaEnable=1,quotaCurrent="&UsedBytes&",quotaMax="&CountBytes&" where ftpUserName='"&UserName&"'")
'	end if
'	ClDB()
	conn.execute("update [liu_user] set isftp=1 where id="&id&" ")
	getdiv "开通用户FTP成功！","admin_user.asp","clockdiv"
end sub

sub closeftp()
	dim id:id=request("id")
	if not isinteger(id) then
		getdiv "请指定要暂停FTP的用户！","","postname"
	end if
	UserName=conn.execute("select [username] from [liu_user] where id="&id&"")(0)
	'CDB()
'	Fconn.execute("update [ftp_users] set disabled=1 where ftpUserName='"&UserName&"'")
'	ClDB()
	conn.execute("update [liu_user] set isftp=0 where id="&id&" ")
	getdiv "暂停用户FTP成功！","admin_user.asp","clockdiv"
end sub

sub contrast()
	dim id:id=request("id")
	if not isinteger(id) then
		getdiv "请指定要匹配的用户！","","postname"
	end if
	UserName=conn.execute("select [username] from [liu_user] where id="&id&"")(0)
	contrastini(UserName)
	contrastpic(UserName)
	contrastcode(UserName)
	call ResertFtpSize(id)
	getdiv "数据匹配完毕！","admin_user.asp","clockdiv"
	
end sub

sub contrastini(UserName)
	set rs=server.CreateObject("adodb.recordset")
	rs.open "select [countbytes] from [Liu_user] where UserName='"&UserName&"'",conn,1,1
	if not (rs.eof and rs.bof) then
		do while not rs.eof
			conn.execute("update [Liu_User] set UsedBytes=0,ResBytes="&rs("countbytes")&" where UserName='"&UserName&"'")	
		rs.movenext
		loop
	end if
	rs.close
	set rs=nothing
end sub

sub contrastpic(UserName)
	set rs=server.CreateObject("adodb.recordset")
	rs.open "select [Psize] from [Liu_pic] where kuser='"&UserName&"'",conn,1,1
	if not (rs.eof and rs.bof) then
		do while not rs.eof
			conn.execute("update [Liu_User] set UsedBytes=UsedBytes+"&cdbl(rs("Psize"))&",ResBytes=ResBytes-"&cdbl(rs("Psize"))&" where UserName='"&UserName&"'")	
		rs.movenext
		loop
	end if
	rs.close
	set rs=nothing
end sub

sub contrastcode(UserName)
	set rs=server.CreateObject("adodb.recordset")
	rs.open "select [CodeSize] from [Liu_Code] where kname='"&UserName&"'",conn,1,1
	if not (rs.eof and rs.bof) then
		do while not rs.eof
			conn.execute("update [Liu_User] set UsedBytes=UsedBytes+"&cdbl(rs("CodeSize"))&",ResBytes=ResBytes-"&cdbl(rs("CodeSize"))&" where UserName='"&UserName&"'")	
		rs.movenext
		loop
	end if
	rs.close
	set rs=nothing
end sub


sub contrastall()
	set fso=new dmfso
	set rs=server.CreateObject("adodb.recordset")
	rs.open "select [id],[username] from [Liu_User]",conn,1,1
	if not(rs.eof and rs.bof) then
		do while not rs.eof
			contrastini(rs("username"))
			contrastpic(rs("username"))
			contrastcode(rs("username"))
			call ResertFtpSize(rs("id"))	
		rs.movenext
		loop
	end if		
	set fso=nothing
	getdiv "全部用户数据匹配完毕！","admin_user.asp","clockdiv"	
end sub


sub clears()
	dim id:id=request("id")
	if not isinteger(id) then
		 getshow "请指定要清除的用户！",""
		end if
		ShowUserName=DBGetValue("liu_user","username","id="&id&"")
		if ShowUserName="" then 
		 getshow "你选择的用户不存在！",""
		end if
		NewFolderPath = DataFilesPath("users/"& ShowUserName)
	 set fs=new dmfso
	 if fs.ReportFolderStatus(NewFolderPath)=1 then	 	
		if fs.deleteAFolder(NewFolderPath)=-1 then 
			getshow "发生错误，删除该用户文件失败,可能该文件内容正在被调用！",""
		 else
			 if fs.ReportFolderStatus(NewFolderPath)=-1 then
				fs.createFolderDemo(NewFolderPath)
				fs.createFolderDemo(NewFolderPath&"/html")		
				fs.createFolderDemo(NewFolderPath&"/temp")
				fs.createFolderDemo(NewFolderPath&"/pic")
				if fs.ReportFolderStatus(NewFolderPath)=1 then
					conn.execute("delete  liu_pic where kuser='"&ShowUserName&"'")
					conn.execute("delete  Liu_Folder where kuser='"&ShowUserName&"'")
					conn.execute("delete  Liu_Message where sendname='"&ShowUserName&"'")
					conn.execute("delete  Liu_Code where kname='"&ShowUserName&"'")
					conn.execute("delete  GuestMessage where username='"&ShowUserName&"'")
					conn.execute("delete  ydy_buliang where NameUser='"&ShowUserName&"'")
				end if				
			else
				getshow "发生错误，用户【/users/"& ShowUserName&"】文件未删除成功，清除用户操作终止！",""
			end if
		end if
	else
		fs.createFolderDemo(NewFolderPath)
		fs.createFolderDemo(NewFolderPath&"/html")
		fs.createFolderDemo(NewFolderPath&"/Temp")
		fs.createFolderDemo(NewFolderPath&"/pic")
		if fs.ReportFolderStatus(NewFolderPath)=1 then
			conn.execute("delete  liu_pic where kuser='"&ShowUserName&"'")
			conn.execute("delete  Liu_Folder where kuser='"&ShowUserName&"'")
			conn.execute("delete  Liu_Message where sendname='"&ShowUserName&"'")
			conn.execute("delete  Liu_Code where kname='"&ShowUserName&"'")
			conn.execute("delete  GuestMessage where username='"&ShowUserName&"'")
			conn.execute("delete  ydy_buliang where NameUser='"&ShowUserName&"'")
		end if
 	end if
	CountBytes=DBGetValue("liu_user","CountBytes","id="&id&"")
	conn.execute("update Liu_user set UsedBytes='0',ResBytes="&CountBytes&" where username='"&ShowUserName&"'")
	call ResertFtpSize(id)
	getshow "清除用户数据成功！","admin_user.asp"
 	set fs=nothing
end sub

sub ResertFtpSize(id)
	ResBytes=DBGetValue("liu_user","ResBytes","id="&id&"")
	'CDB()
'		set rsf=server.CreateObject("adodb.recordset")
'		rsf.open "select id from [ftp_users] where ftpUserName='"&UserName&"'",Fconn,1,1
'		if not(rsf.eof and rsf.bof) then
'			Fconn.execute("update [ftp_users] set quotaMax="&ResBytes&",quotaCurrent=0 where ftpUserName='"&UserName&"'")
'		end if
'		rsf.close
'		set rsf=nothing
'	ClDB()
end sub
%>
</body>
</html>
