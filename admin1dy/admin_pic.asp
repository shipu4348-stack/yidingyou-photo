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

<script type="text/javascript">
function CheckAll(Sid,typeid)
{
	var obj=document.getElementsByTagName("input");
	var obj2=document.getElementById(Sid);
	if (typeid==0)
	{
		for(var i=0;i<obj.length;i++)
		{			
			if(obj[i].type=="checkbox")
			{	
				if(!obj[i].checked) obj[i].checked=true;
			}
		}
		obj2.innerHTML="<a href='javascript:void(0)' onClick=CheckAll('showdel',1); class='STYLE2'>取消全选</a>";
	}
	else
	{
		for(var i=0;i<obj.length;i++)
		{
			if(obj[i].type=="checkbox")
			{			
				if(obj[i].checked) obj[i].checked=false;
			}
		}
		obj2.innerHTML="<a href='javascript:void(0)' onClick=CheckAll('showdel',0); class='STYLE2'>全选</a>";
	}
}

function DelAll()
{
	var objForm=document.piclist;
	objForm.submit();
}
</script>

</head> 

<body   topmargin="0" leftmargin="0" rightmargin="0" bottommargin="0">

<%
select case action
  case "del"
    call del()
  case "delall"
    call delall()
  case else
    call main()
end select


sub main()
 'news 用户管理
if not checkflag("UserManage") then
  getshow "对不起，您没有【用户图片】的权限！",""
end if


response.expires=0
currentpage=funstr(Trim(request.QueryString("page")))
tian=cint(request.QueryString("days"))
'response.Write tian
if tian=0 then tian=1

if not isinteger(currentpage) then
  currentpage=1
else
  currentpage=clng(currentpage)
end if

maxperpage=42
totalrecords=0
totalpage=1
i=1



FileName="admin_pic.asp?Action="&Action&""

strFileName=FileName & "&days=" & tian &""

sql="select Pid,kid,kuser,Photourl,Pdate from liu_pic where Pid<>0 "
if tian>0  then
 sql=sql&" and DATEDIFF(d,Pdate,getdate())<="&tian&" "
end if
 
sql=sql&" order by pid desc"
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
    <td height="22" style="color:#FFFFFF">.:: 您可以在这里进行[用户图片]相关操作</td>
    <td width="200" height="22" align="right">
	 
    </td>
  </tr>
</table>
	
	</td>
  </tr>
</table> 

  <center><font size="+3">用户图片</font></center>

<br>
<table width="100%" border="0" align="center" cellpadding="2" cellspacing="1" class="border">
  <tr class="title">
    <td  ><table width="100%" border="0" align="center" cellpadding="0" cellspacing="0">
    <tr>
        <td height="22" style="color:#FFFFFF">  查看方式：<a href="admin_pic.asp?days=1" class="STYLE2">最近一天</a> <a href="admin_pic.asp?days=3" class="STYLE2">最近三天</a> <a href="admin_pic.asp?days=7" class="STYLE2">最近一周</a> <a href="admin_pic.asp?days=30" class="STYLE2">最近一月</a> <a href="admin_pic.asp?days=-1" class="STYLE2">查看全部</a> <span id="showdel"><a href="javascript:void(0)" onClick="CheckAll('showdel',0);" class="STYLE2">全选</a></span>  <a href="javascript:void(0)" onClick="DelAll()" class="STYLE2">删除</a>
</td>
        </tr>
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
<form name="piclist" method="post" action="?action=delall&days=<%=tian%>&page=<%=currentpage%>">
<tr><td class="tdbg"><div class="list">
  <%do until rs.eof or i>maxperpage%>
  <li>
  	<%
		dim MainPath,kupid,kname,kpath,MainUrl
		MainUrl="http://img.1dy.cc/"&rs("kuser")&"/pic"
		if rs("kid")="0" then
			MainPath=MainUrl&"/"
		else
			kupid=conn.execute("select upid from [liu_folder] where kid="&rs("kid")&"")(0)
			kname=conn.execute("select kname from [liu_folder] where kid="&rs("kid")&"")(0)
			if kupid=0 then			
				MainPath=MainUrl&"/"&kname&"/"
			else
				kpath=conn.execute("select kpath from [liu_folder] where kid="&rs("kid")&"")(0)
				MainPath=MainUrl&kpath&kname&"/"
			end if
		end if	
	%>
  	<table width="100%" border="0">
    	<tr><td><%=rs("kuser")%></td></tr>
        <tr><td><img src="<%=MainPath&rs("PhotoUrl")%>" /></td></tr>
        <tr><td><%= rs("Pdate") %></td></tr>
        <tr><td><input type="checkbox" name="checkbox1" value="<%=rs("Pid")%>"><a href="?action=del&id=<%=rs("Pid")%>&days=<%=tian%>&page=<%=currentpage%>" title="删除用户..." onClick="javascript:if(confirm('是否确定删除该图片？\n\n系统提示：删除后不可恢复！')){return true;}else{return false;}">删除</a></td></tr>
    </table>
  </li>
  
  
  <%rs.movenext
  i=i+1
   loop
  %> 
  
 </div></td></tr>
 </form>
 <tr><td>
<%if totalrecords>0 then  %>
 	<%call showpage(strFileName,totalrecords,maxperpage,true,true,"个【图片】")
 	 %> 
   <% End If %>
</td></tr>
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
		tian=request("days")
		currentpage=request("page")
		Path="../../datafiles/users/"&UserName&"/pic/"
		if not isinteger(id) then
		 getshow "请指定要删除的图片！",""
		end if
		Purl=DBGetValue("liu_pic","Purl","Pid="&id&"")
		Pthurl=DBGetValue("liu_pic","Pthurl","Pid="&id&"")
		Photourl=DBGetValue("liu_pic","Photourl","Pid="&id&"")
		'PhotoPic=DBGetValue("liu_pic","PhotoPic","Pid="&id&"")
		if Purl="" and Pthurl="" and Photourl="" and PhotoPic=""  then 
		 getshow "你选择的图片不存在！",""
		end if		 
		 set fs=new dmfso
		 if fs.ReportFileStatus(Server.MapPath(Path&Purl))=1 and fs.ReportFileStatus(Server.MapPath(Path&Pthurl))=1 and fs.ReportFileStatus(Server.MapPath(Path&Photourl))=1  then' and fs.ReportFileStatus(Server.MapPath(PhotoPic))=1	
			
				if fs.deleteAFile(Server.MapPath(Path&Purl))=-1 and fs.deleteAFile(Server.MapPath(Path&Pthurl))=-1 and fs.deleteAFile(Server.MapPath(Path&Photourl))=-1  then 'and fs.deleteAFile(Server.MapPath(PhotoPic))=-1
					'getshow "发生错误，删除该用户文件失败,可能该文件内容正在被调用！",""
				 else
					 if fs.ReportFileStatus(Server.MapPath(Purl))=-1 and fs.ReportFileStatus(Server.MapPath(Pthurl))=-1 and fs.deleteAFile(Server.MapPath(Photourl))=-1  then 'and fs.deleteAFile(Server.MapPath(PhotoPic))=-1
					conn.execute("delete  liu_pic where pid="&id)
					else
					'getshow "发生错误，文件未删除成功，删除用户记录终止！",""
					 end if
				end if
		else
			conn.execute("delete  liu_pic where pid="&id)
			'getshow "发生错误，文件不存在。！",""
		end if  
		 
			getshow "删除图片成功！","admin_pic.asp?action=&days="&tian&"&page="&currentpage&""
		set fs=nothing
end sub

sub delall()
	id=request.Form("checkbox1")
	tian=request("days")
	currentpage=request("page")
	Path="../../datafiles/users/"&UserName&"/pic/"
	set fs=new dmfso
	set rs=server.CreateObject("adodb.recordset")
	rs.open "select [Pid],[Purl],[Pthurl],[PhotoUrl],[PhotoPic] from [Liu_Pic] where Pid in ("&id&")",conn,1,1
	if not rs.eof or not rs.bof then
	  do while not rs.eof
		  if rs("Purl")<>"" or rs("Pthurl")<>"" or rs("PhotoUrl")<>"" then
			  If fs.ReportFileStatus(Server.MapPath(Path&rs("Purl")))=1 and fs.ReportFileStatus(Server.MapPath(Path&rs("Pthurl")))=1 and fs.ReportFileStatus(Server.MapPath(Path&rs("PhotoUrl")))=1  Then
				 if fs.deleteAFile(Server.MapPath(Path&rs("Purl")))=-1 and fs.deleteAFile(Server.MapPath(Path&rs("Pthurl")))=-1 and fs.deleteAFile(Server.MapPath(Path&rs("PhotoUrl")))=-1 then
					'getshow "发生错误，删除该用户文件失败,可能该文件内容正在被调用！",""
				 else
					 if fs.ReportFileStatus(Server.MapPath(Path&rs("Purl")))=-1 and fs.ReportFileStatus(Server.MapPath(Path&rs("Pthurl")))=-1 and fs.deleteAFile(Server.MapPath(Path&rs("PhotoUrl")))=-1 then
					conn.execute("delete liu_pic where pid="&rs("pid"))
					else
					conn.execute("delete liu_pic where pid="&rs("pid"))
					'getshow "发生错误，文件未删除成功，删除用户记录终止！",""
				 	end if
				end if						
			  end if
		  else
		  		conn.execute("delete liu_pic where pid="&rs("pid"))
		  end if
	  rs.movenext
	  loop
  end if
  rs.close
  set rs=nothing
  set fso=nothing
  getshow "删除图片成功！","admin_pic.asp?action=&days="&tian&"&page="&currentpage&""
end sub

%>

 

 

</body>
</html>
