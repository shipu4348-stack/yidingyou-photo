  <!--#include file="conn.asp"-->
  <!--#include file="check.asp"-->
  <!--#include file="md5.asp"-->
 <%
	dim action
	dim totalpage,maxperpage,totalrecords,i,currentpage
	action=request("action")
	if not checkflag("DataManage") then
  getshow "对不起，您没有【数据更新】的权限！",""
end if
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<title>数据更新_用户管理页面</title>
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

<%
select case action
  case "update_yjf"
    call update_yjf() 
  case "update_combo"
    call update_combo() 
    case else
    call main()
end select

 sub update_combo()
 set rss=rsfun("select * from ydy_combo",1)
     listnum=rss.recordcount
 	If Rss.Bof And Rss.Eof Then
		i=0
	Else
	 for i=1 to listnum
	 usenum=DBGetNum("liu_user","id","0","where tcid="&rss("id")&" and yjf<>0 ")
     conn.execute("update  ydy_combo set usenum="&usenum&" where id="&Rss("id"))
     rss.movenext
	next
	End If
	Rss.Close
	Set Rss=Nothing 
getdiv2 "共更新套餐<font color=red>"&i&"</font>个餐套被使用情况！","","errorshow","1200"
  end sub
  sub update_yjf()
 set rss=rsfun("select * from liu_user where datediff(minute,jfrq,getdate())>=1 and yjf<>0 ",1)
     listnum=rss.recordcount
 	If Rss.Bof And Rss.Eof Then
		i=0
	Else
	 for i=1 to listnum
  conn.execute("update  liu_user set yjf=0 where id="&Rss("id"))
     rss.movenext
	next
	End If
	Rss.Close
	Set Rss=Nothing 
getdiv2 "共发现异常用户<font color=red>"&i&"</font>位，并已经更新其付费状态，请到用户管理中进行相关操作！","","errorshow","7200"
  end sub


 sub main()
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
    <td height="22" style="color:#FFFFFF">.:: 您可以在这里进行[数据更新]相关操作</td>
    <td width="200" height="22" align="right">
	 
    </td>
  </tr>
</table>
	
	</td>
  </tr>
</table> 

  <center>
    <font size="+3">数据更新</font><!--<span class="title"><a href="javascript:showIframe('comadd','admin_user.asp?action=add','57','502')" style="color:red;">添加用户</a></span> -->
  </center>

<br>
<table width="100%" border="0" align="center" cellpadding="2" cellspacing="1" class="border">
  <tr class="title">
    <td  ><table width="100%" border="0" align="center" cellpadding="0" cellspacing="0">
      <form name="form1" method="post" action=""><tr>
        <td height="22" style="color:#FFFFFF">功能介绍：此功能为更新程序各项统计，以及数据有效性的更新操作。例如更新一些过期用户的付费状态，将查出过期用户，并暂停其空间使用权。<a href="admin_user.asp" class="STYLE2"> </a></td>
        </tr></form>
    </table></td>
  </tr>
  <tr class="title">
    <td class="tdbg"  style="color:black;" >&nbsp; </td>
  </tr>
</table>
 <br>

 
 
<table width="100%" border="0" align="center" cellpadding="0" cellspacing="1"   class="border1">
  <tr align="center" bgcolor="#EFEBEF">
    
    <td height="25" align="center" class="title">  更新项目</td>
    <td width="15%" class="title"><span class="STYLE2">操　作</span></td>
    <td align="center" class="title">项目说明</td>
  </tr>
 
  <tr onMouseOut="this.style.backgroundColor=''" onMouseOver="this.style.backgroundColor='#BFDFFF'" class="tdbg">
    
    <td width="18%" height="23">更新用户付费状态 ：</td>
    <td align="center"><a href="javascript:showIframe('comedit','?action=update_yjf','55','503')" style="color:green;">开始更新</a></td>
    <td width="67%">此统计可以更新已经过期的用户，并将其付费状态更改为未付费，以便管理用户操作。 </td>
  </tr>
  <tr onMouseOut="this.style.backgroundColor=''" onMouseOver="this.style.backgroundColor='#BFDFFF'" class="tdbg">
    <td height="23">更新各套餐使用情况：</td>
    <td align="center"><a href="javascript:showIframe('comedit','?action=update_combo','55','503')" style="color:green;">开始更新</a></td>
    <td>更细各个套餐总使用人数，方便管理方了解各套餐用户喜爱程度。</td>
  </tr>
 

</table>
 

<%
end sub
 %>

 

 

</body>
</html>
