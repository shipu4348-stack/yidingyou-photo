 <!--#include file="Conn.asp"-->
<!--#include file="check.asp" -->
 <%
'ad 广告管理
if not checkflag("ADManage") then
  getshow  "对不起，您没有【管理广告】的权限！",""
end if


dim action
dim totalpage,maxperpage,totalrecords,i,currentpage
action=request("action")
 
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<title>广告管理相关</title>
<link rel="stylesheet" type="text/css" href="imageS/Admin_Style.Css">
<script language="javascript" src="js/site.js"></script>
 </head>

<body leftmargin="5" topmargin="0">
<table width="100%" border="0" align="center" cellpadding="2" cellspacing="1" class="border">
  <tr class="title"> 
    <td  > <table width="100%" border="0" align="center" cellpadding="0" cellspacing="0">
  <tr> 
    <td height="22" style="color:#FFFFFF">.:: 您可以在这里进行[广告管理]相关操作</td>
    <td width="200" height="22" align="right">
	 
    </td>
  </tr>
</table>
	
	</td>
  </tr>
</table>

 <center><font size="+3">广告管理</font></center>

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
if not checkflag("ADadd") then
  getshow  "对不起，您没有【广告添加】的权限！",""
end if
%> <SCRIPT LANGUAGE="JavaScript">
		<!--
		function isMail(str) 
		{
			var a=str.indexOf("@")+1;
			var p=str.indexOf(".")+1;
			if(str.indexOf("'") > 0)
				return false;
			if(str.indexOf('"') > 0)
				return false;
			if (a<2)
			   return false;    
			if (p<1)
			   return false;    
			if (p<a+2)
			   return false;    
			if (str.length==p)
			   return false;		
			return true; 
		}


		function openwindow(url)
		{
			window.open(url);
		}


		function isNumber(str)
		{
			for (var i=0; i < str.length; i++)
			{	var ch=str.charAt(i);
				if ((ch != "0") && (ch != "1") && (ch != "2") && (ch != "3") && (ch != "4") && (ch != "5") && (ch != "6") && (ch != "7") && (ch != "8") && (ch != "9"))	
					return false;
			}
			return true; 
		}
			
			
		function chkform(){
			var er="出错:";
		
							if (add.sitename.value.length<1)
							{
								alert(er + "广告名称不能为空");
								add.sitename.focus( );
								return false;	
							}
					
							if (add.siteurl.value.length<1)
							{
								alert(er + "广告链接地址不能够为空");
								add.siteurl.focus( );
								return false;	
							}
					
							if (add.logourl.value.length<1)
							{
								alert(er + "请上传广告图片");
								add.logourl.focus( );
								return false;	
							}
						
		  }
		//-->
		</SCRIPT>
<br>
<form action="?action=addsave" method="post" name="add" id="add"  onsubmit='return chkform();' autocomplete="off" >
  <table width="600" border="0" align="center" cellpadding="0" cellspacing="1" bgcolor="#CCCCCC" class="border1">
    <tr  class="title"> 
      <td height="22"   colspan="3" align="center"  > 广告 - 添加</td>
    </tr>
    <tr bgcolor="#FFFFFF"> 
      <td width="14%" height="25" align="center" class="tdbg">名称：</td>
      <td width="43%" height="25" class="tdbg">
      <input name="sitename" type="text" class="input" id="sitename" size="40"></td>
      <td width="43%" rowspan="3" class="tdbg"> 
<img id=face src=images/nopic.gif name=tus width=126 height=88>
</td>
    </tr>
    <tr bgcolor="#FFFFFF"> 
      <td height="25" align="center" class="tdbg">网址：</td>
      <td height="25" class="tdbg">
      <input name="siteurl" type="text" class="input" id="siteurl" value="" size="40"></td>
    </tr>
    <tr bgcolor="#FFFFFF"> 
      <td height="25" align="center" class="tdbg">大图地址：</td>
      <td height="25" class="tdbg"> 
	<input name=logourl type=text size="40" maxlength="40">	  </td>
    </tr>
    <tr bgcolor="#FFFFFF">
      <td height="25" align="center" class="tdbg">上传大图：</td>
      <td height="25" colspan="2" class="tdbg"><iframe src="admin_upload.asp?formName=ad&amp;textName=logourl&amp;classType=1" height="25" width="100%" frameborder="0" scrolling="no"></iframe></td>
    </tr>
    <tr bgcolor="#FFFFFF">
      <td height="25" align="center" class="tdbg">小图地址：</td>
      <td height="25" colspan="2" class="tdbg"><input name="smallLogo" type="text" size="40" maxlength="40"></td>
    </tr> 
    <tr bgcolor="#FFFFFF">
      <td height="25" align="center" class="tdbg">上传小图：</td>
      <td height="25" colspan="2" class="tdbg"><iframe src="admin_upload.asp?formName=ad&amp;textName=smallLogo&amp;classType=2" height="25" width="100%" frameborder="0" scrolling="no"></iframe></td>
    </tr>
    <tr bgcolor="#FFFFFF">
      <td height="25" align="center" class="tdbg">广告类型：</td>
      <td height="25" colspan="2" class="tdbg">
          <select name="ltype" size="1" class="input" id="ltype">
          <option value="1" selected>首页顶部</option>
	    <option value="2">首页Flash</option>
	    <option value="3">热销单品</option>
	    <option value="4">成功店铺</option>
	    <option value="5">底部Flash</option>
	    <option value="6">会员页FLash</option>
	    <option value="7">会员底部左</option>
	    <option value="8">会员底部右</option>
        <option value="9">首页焦点图片</option>
 
        </select></td>
    </tr> 
   
    <tr bgcolor="#FFFFFF"> 
      <td height="25" align="center" class="tdbg">说明：</td>
      <td height="25" colspan="2" class="tdbg"> 
      <textarea name="remark" cols="45" rows="10" class="input" id="remark"></textarea></td>
    </tr>
    <tr bgcolor="#FFFFFF"> 
      <td height="30" colspan="3" align="center" class="tdbg"> 
        <input name="Submit" type="submit" class="button" value=" 确定添加 ">
        　 
      <input name="Submit2" type="reset" class="button" value=" 重新填写 "> </td>
    </tr>
  </table>
</form>
<%
end sub

sub addsave()

dim sitename,siteurl,logourl,remark,ltype
sitename=funstr(trim(request.form("sitename")))
siteurl=funstr(trim(request.form("siteurl")))
logourl=funstr(trim(request.form("logourl")))
remark=funstr(trim(request.form("remark")))
ltype=request("ltype")
 smallLogo=funstr(trim(request.form("smallLogo"))) 
	
if not isinteger(ltype) then
  ltype=0
end if

if sitename="" or strlength(sitename)>50 then
  getshow  "站点名称不能为空，或大于25个字符！",""
end if

if siteurl="" or siteurl="http://" then
 getshow  "广告网址不能为空！",""
end if

if ltype>0 and (logourl="" or logourl="http://") then
getshow  "请输入Logo广告地址！",""
end if

if remark="" then
getshow  "广告说明不能为空！",""
end if

set rs=server.createobject("adodb.recordset")
sql="select * from ydy_ad where id is null"
rs.open sql,conn,1,3

rs.addnew()
rs("sitename")=sitename
rs("siteurl")=siteurl
rs("logourl")=logourl
rs("remark")=remark
rs("ltype")=ltype
rs("smallLogo")=smallLogo
rs("passed")=true
 
rs.update

rs.close
getshow  "添加广告成功！","admin_ad.asp?action=add"

end sub

sub edit()

dim id

id=request("id")
if not isinteger(id) then
getshow  "对不起，请指定要编辑的广告！",""
end if

set rs=conn.execute("select * from ydy_ad where id="&id)
if rs.bof and rs.eof then
getshow  "找不到广告！",""
end if
 
logourl=rs("logourl")
 
%>
 <SCRIPT LANGUAGE="JavaScript">
		<!--
		function isMail(str) 
		{
			var a=str.indexOf("@")+1;
			var p=str.indexOf(".")+1;
			if(str.indexOf("'") > 0)
				return false;
			if(str.indexOf('"') > 0)
				return false;
			if (a<2)
			   return false;    
			if (p<1)
			   return false;    
			if (p<a+2)
			   return false;    
			if (str.length==p)
			   return false;		
			return true; 
		}


		function openwindow(url)
		{
			window.open(url);
		}


		function isNumber(str)
		{
			for (var i=0; i < str.length; i++)
			{	var ch=str.charAt(i);
				if ((ch != "0") && (ch != "1") && (ch != "2") && (ch != "3") && (ch != "4") && (ch != "5") && (ch != "6") && (ch != "7") && (ch != "8") && (ch != "9"))	
					return false;
			}
			return true; 
		}
			
			
		function chkform(){
			var er="出错:";
		
							if (edit.sitename.value.length<1)
							{
								alert(er + "广告名称不能为空");
								edit.sitename.focus( );
								return false;	
							}
					
							if (edit.siteurl.value.length<1)
							{
								alert(er + "广告链接地址不能够为空");
								edit.siteurl.focus( );
								return false;	
							}
					
							if (edit.logourl.value.length<1)
							{
								alert(er + "请上传广告图片");
								edit.logourl.focus( );
								return false;	
							}
						
		  }
		//-->
		</SCRIPT>  
<br>
<form action="?action=editsave" method="post" name="edit" id="edit" onsubmit='return chkform();' autocomplete="off" >
  <table width="600" border="0" align="center" cellpadding="0" cellspacing="1" bgcolor="#CCCCCC" class="border1">
    <tr align="center"  class="title" > 
      <td height="25" colspan="3">  广告 - 编辑 </td>
    </tr>
    <tr bgcolor="#FFFFFF"> 
      <td width="23%" height="25" align="center" class="tdbg">广告名称：</td>
      <td width="38%" height="25" class="tdbg"><input name="sitename" type="text" class="input" id="sitename" value="<%=rs("sitename")%>" size="40"></td>
      <td width="39%" rowspan="3" class="tdbg"><img id=face src=<%=rs("logourl")%> name=tus width=126 height=88></td>
    </tr>
    <tr bgcolor="#FFFFFF"> 
      <td height="25" align="center" class="tdbg">广告地址：</td>
      <td height="25" class="tdbg"><input name="siteurl" type="text" class="input" id="siteurl" value="<%=rs("siteurl")%>" size="40"></td>
    </tr>
    <tr bgcolor="#FFFFFF"> 
      <td height="25" align="center" class="tdbg">图片地址：</td>
      <td height="25" class="tdbg">   <input name="logourl" type="text" class="input" id="logourl" value="<%=rs("logourl")%>" size="40"> 	</td>
    </tr>
    <tr bgcolor="#FFFFFF">
      <td height="25" align="center" class="tdbg">上传大图：</td>
      <td height="25" colspan="2" class="tdbg"><iframe src="admin_upload.asp?formName=ad&amp;textName=logourl&amp;classType=1" height="25" width="100%" frameborder="0" scrolling="no"></iframe></td>
    </tr>
    <tr bgcolor="#FFFFFF">
      <td height="25" align="center" class="tdbg">小图地址：</td>
      <td height="25" colspan="2" class="tdbg"><input name="smallLogo" type="text" size="40" maxlength="40" value="<%=rs("smallLogo")%>" /></td>
    </tr> 
    <tr bgcolor="#FFFFFF">
      <td height="25" align="center" class="tdbg">上传小图：</td>
      <td height="25" colspan="2" class="tdbg"><iframe src="admin_upload.asp?formName=ad&amp;textName=smallLogo&amp;classType=2" height="25" width="100%" frameborder="0" scrolling="no"></iframe></td>
    </tr>
    <tr bgcolor="#FFFFFF"> 
      <td height="25" align="center" class="tdbg">广告类型：</td>
      <td height="25" colspan="2" class="tdbg">
	  <select name="ltype" size="1" class="input" id="ltype">
	    <option value="1" <%if rs("ltype")=1  then rw "selected"%> >首页顶部</option>
	    <option value="2" <%if rs("ltype")=2  then rw "selected"%> >首页Flash</option>
	    <option value="3" <%if rs("ltype")=3  then rw "selected"%> >热销单品</option>
	    <option value="4" <%if rs("ltype")=4  then rw "selected"%> >成功店铺</option>
	    <option value="5" <%if rs("ltype")=5  then rw "selected"%> >底部Flash</option>
	    <option value="6" <%if rs("ltype")=6  then rw "selected"%> >会员页FLash</option>
	    <option value="7" <%if rs("ltype")=7  then rw "selected"%> >会员底部左</option>
	    <option value="8" <%if rs("ltype")=8  then rw "selected"%> >会员底部右</option>
        <option value="9" <%if rs("ltype")=9  then rw "selected"%> >首页焦点图片</option>
       </select></td>
    </tr>
 
    <tr bgcolor="#FFFFFF"> 
      <td height="25" align="center" class="tdbg">广告说明：</td>
      <td height="25" colspan="2" class="tdbg"><textarea name="remark" cols="45" rows="10" class="input" id="remark"><%=rs("remark")%></textarea></td>
    </tr>
    <tr bgcolor="#FFFFFF"> 
      <td height="30" colspan="3" align="center" class="tdbg"> 
        <input name="Submit" type="submit" class="button" value=" 确定编辑 ">
        　 
        <input name="Submit2" type="reset" class="button" value=" 重新填写 ">
      <input name="id" type="hidden" id="id" value="<%=id%>"> </td>
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
getshow  "对不起，请指定要编辑的广告！",""
end if

dim sitename,siteurl,logourl,remark,ltype
sitename=funstr(trim(request.form("sitename")))
siteurl=funstr(trim(request.form("siteurl")))
logourl=funstr(trim(request.form("logourl")))
smallLogo=funstr(trim(request.form("smallLogo")))
remark=funstr(trim(request.form("remark")))
ltype=request("ltype")
 
if not isinteger(ltype) then
  ltype=0
end if

if sitename="" or strlength(sitename)>50 then
getshow  "站点名称不能为空，或大于25个字符！","" 
end if

if siteurl="" then
getshow  "广告网址不能为空！","" 
end if

if ltype>0 and logourl="" then
getshow  "请输入Logo广告地址！","" 
end if

if remark="" then
getshow  "Flash说明不能为空！","" 
end if

set rs=server.createobject("adodb.recordset")
sql="select * from ydy_ad where id="&id
rs.open sql,conn,1,3

if rs.bof and rs.eof then
getshow  "找不到要编辑的广告！","" 
else
 rs("sitename")=sitename
 rs("siteurl")=siteurl
 rs("logourl")=logourl
 rs("remark")=remark
 rs("ltype")=ltype
  rs("smallLogo")=smallLogo
 rs("passed")=true
 
  
		
		
 rs.update
end if

rs.close
set rs=nothing
getshow  "编辑广告成功！","admin_ad.asp" 

end sub


sub main()

response.expires=0
currentpage=request("page")
if not isinteger(currentpage) then
  currentpage=1
else
  currentpage=clng(currentpage)
end if

maxperpage=15
totalrecords=0
totalpage=1
i=1

set rs=server.createobject("adodb.recordset")
 
sql="select * from ydy_ad where id<>0 order by id desc"
rs.open sql,conn,1,1

if not(rs.bof and rs.eof) then
  rs.pagesize=maxperpage
  rs.absolutepage=currentpage
  totalpage=rs.pagecount
  totalrecords=rs.recordcount
   
%>
 

<table width="100%" border="0" cellpadding="0" cellspacing="1" bgcolor="#CCCCCC" class="border1">
  <tr align="center" class="title"> 
    <td width="4%" height="23" >ID</td>
    <td width="17%" height="23" >广告名称</td>
    <td width="28%" height="23"  >网　　址</td>
    <td width="11%" height="23" >广告类型</td>
    <td width="15%" height="23" >加入日期</td>
    <td width="15%" height="23" >操　作</td>
  </tr>
  <%do until rs.eof or i>maxperpage%>
    <div id="divs<% =i %>" style="display:none;"><img src="<%= rs("logourl") %>" /></div>

  <tr bgcolor="#FFFFFF"> 
    <td height="23" class="tdbg">&nbsp;<%=rs("id")%></td>
    <td height="23" class="tdbg">&nbsp;<a href="<%=rs("siteurl")%>" onMouseOut="closediv('divs<% =i %>')" onMouseMove="showdiv('divs<% =i %>')"  title="访问该广告..." target=_blank><%=rs("sitename")%></a></td>
    <td height="23" class="tdbg">&nbsp;<%=rs("siteurl")%></td>
    <td height="23" class="tdbg">&nbsp; 
    <%
	select case rs("ltype")
	  case 1
	    rw "首页顶部"
	  case 2
	   rw "首页Flash"
		 case 3
	   rw "热销单品"
		 case 4
	    rw "成功店铺"
		 case 5
	    rw "底部Flash"
		 case 6
	    rw "会员页FLash"
		 case 7
	    rw "会员底部左"
		 case 8
	    rw "会员底部右"
	  case else
	    rw "首页顶部"
	end select
   %>   
      
		 </td>
    <td height="23" class="tdbg">&nbsp;<%=rs("dateandtime")%></td>
    <td height="23" align="center" class="tdbg"> <a href="?action=edit&id=<%=rs("id")%>" title="编辑">编辑</a> 
      <a href="?action=del&id=<%=rs("id")%>" title="删除广告..." onClick="javascript:if(confirm('是否真的要删除广告吗？\n\n系统提示：删除后不可恢复！')){return true;}else{return false;}">删除</a></td>
  </tr>
  <%rs.movenext
   i=i+1
   loop
  %>
  <tr bgcolor="#FFFFFF"> 
    <td height="23" colspan="6" class="tdbg"> 
    <%if totalrecords>0 then call showpage("admin_ad.asp",totalrecords,maxperpage,true,true,"个广告")%>    </td>
  </tr>
</table>
<%
else
%>
<table width="100%" border="0" cellpadding="0" cellspacing="1" bgcolor="#CCCCCC" class="border1">
  <tr align="center" class="title"> 
    <td  height="23"  colspan="6" >暂时没有广告</td> 
  </tr>
  </table>
<%
end if
rs.close
set rs=nothing
end sub

sub del()

dim id:id=request("id")

if not isinteger(id) then
getshow  "请指定要删除的广告！","" 
end if
set fs=new dmfso
urlpath=server.MapPath(""&DBGetValue("ydy_ad","logourl","id="&id&"")&"")
if fs.ReportFileStatus(urlpath)=1 then 
		if fs.deleteAFile(urlpath)=1 then 
		conn.execute("delete from ydy_ad where id="&id)
		 getshow "删除广告成功！","admin_ad.asp"
		else
		getshow "删除广告失败，可能该文件正在被使用中！","admin_ad.asp"
		end if
else
        conn.execute("delete from ydy_ad where id="&id)
		getshow "提醒：该广告对应的图片并不存在，不过已成功删除在数据库中的信息","admin_ad.asp"
end if
set fs=nothing

 
getshow  "删除广告成功！","admin_ad.asp"

end sub
%>
</body>
</html>

