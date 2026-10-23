<!--#include file="./incs/SysCode.asp"-->
<%
	if Request.Cookies("1dy")("yjf")=2 then
		response.Write "<script>alert('测试用户不用续费!');location.href='home.asp';</script>"
	end if
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<title>我的一定呦 - 网络图片存储系统 www.1dy.cc - 缴费中心</title>
<link rel="stylesheet" type="text/css" media="all" href="css/index.css" />
<link href="images/2010/Global.css" type="text/css" rel="stylesheet"/>

<link rel="stylesheet" type="text/css" href="images/2010/top_bar.css" />

<script language="JavaScript1.2">

function Logout()
{
	if(confirm('确定要退出一定呦吗？'))
	{
		window.location.href="exit.asp";
	}
	else
	{
		return false;
	}
}
</script>
 <style  type="text/css">
body {
	background:transparent url(images/2010/body_bg.gif) repeat-x scroll left 36px
}
/* 黄色框体-内容导航专属样式 */
.yellow_box ul.middle_navs li {
	width:120px;
	height:auto;
	overflow:hidden;
	margin:0 auto 4px auto;
}
.yellow_box ul.middle_navs li h1 {
	width:119px;
	height:28px;
	overflow:hidden;
	line-height:28px;
	text-align:left;
	padding-left:36px;
	cursor:pointer;
	background:#f4f4f4 url(images/2010/posh_pic.gif) no-repeat;
	font-size:12px;
}
/* 标示图片 */
.yellow_box ul.middle_navs li h1.p1 {
	background-position:-590px -25px;
}
.yellow_box ul.middle_navs li h1.p2 {
	background-position:-590px -62px;
}
.yellow_box ul.middle_navs li h1.p3 {
	background-position:-590px -99px;
}
.yellow_box ul.middle_navs li h1.p4 {
	background-position:-590px -131px;
}
.yellow_box ul.middle_navs li h1.p5 {
	background-position:-590px -163px;
}
.yellow_box ul.middle_navs li h1.p6 {
	background-position:-590px -194px;
}
.yellow_box ul.middle_navs li h1.p7 {
	background-position:-590px -224px;
}
.yellow_box ul.middle_navs li h1.p8 {
	background-position:-590px -256px;
}
.yellow_box ul.middle_navs li h1.p9 {
	background-position:-590px -287px;
}
.yellow_box ul.middle_navs li h1.p10 {
	background-position:-590px -318px;
}
.yellow_box ul.middle_navs li h1 a {
	color:#333333;
}
.yellow_box ul.middle_navs li h1 span {
	width:12px;
	height:12px;
	overflow:hidden;
	float:right;
	background:url(images/2010/frame_img.gif) no-repeat;
	margin:8px 18px 0 0;
}
.yellow_box ul.middle_navs li h1 span.show {
	background-position:-319px -37px;
}
.yellow_box ul.middle_navs li h1 span.hide {
	background-position:-319px -50px;
}
.yellow_box ul.middle_navs li div {
	width:120px;
	height:auto;
	overflow:hidden;
	margin:3px 0 3px 3px;
	text-align:center;
}
.yellow_box ul.middle_navs li div {
	display:none;
}
.yellow_box ul.middle_navs li div.show {
	display:block;
}
.yellow_box ul.middle_navs li div.hide {
	display:none;
}
.yellow_box ul.middle_navs li div a {
	width:100px;
	height:20px;
	line-height:24px;
	overflow:hidden;
	float:left;
	display:block;
	color:#333333;
}
.yellow_box ul.middle_navs li div a:hover {
	text-decoration:underline;
}
#folderlist a {
	width:150px;
}
.folderlist_table {
	width:100%
}
.folderlist_td {
	width:150px;
	text-align:left
}
.folderlist_td a {
	width:100%
}
</style>
</head>

<body >
<a name="top"></a>
<!--topbar-->
<!--#include file="top_main.asp"-->
<!--/topbar-->
 
 
 
<table width="100%" border="0" cellspacing="0" cellpadding="0">
 
  <tr>
    <td height="32" valign="bottom" style="background-image:url(images/top_tdbg.jpg);background-repeat:repeat-x; background-position:bottom right; ">
<table width="384" border="0" cellspacing="0" cellpadding="0">
      <tr>
        <td width="15">　</td>
        <td width="88" align="center"><a href="home.asp" target="_top">我的一定呦</a></td>
        <td width="5">　</td>
        <td align="center" class="menu1">缴费中心</td>
        <td width="5">　</td>
        <td width="88" align="center">
        <%if workday=0 then%>
        	<a href="Photo.asp?kname=<%=UserName%>">我的相册</a>
        <%else%>
        	<a href="Photo.asp?kname=<%=UserName%>" target="_blank">我的相册</a>
        <%end if%>
        </td>
        <td width="10" align="center"><img src="images/0020.gif" width="1" height="21"></td>
        <td width="88" align="center"><a href="UserMessage.asp" target="_top">纸条箱</a></td>
        </tr>
    </table>
    
    </td>
    <td height="32" align="right" valign="bottom" style="background-image:url(images/top_tdbg.jpg);background-repeat:repeat-x; background-position:bottom right; ">
	<table width="480" border="0" cellspacing="0" cellpadding="0">
      <tr>
        <td class="gray" align="right" style="white-space:nowrap">使用状况：已用<span id="usesize"><%=FormatFileSize(FolderSize)%></span>&nbsp;/总共<%=FormatFileSize(kjdx)%>，剩余天数：<%=workday%>天</td>
        <td width="14" height="32"><br /></td>
      </tr>
    </table></td>
  </tr>
</table>
<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td width="133" align="center" valign="top">
    <table width="120" border="0" cellspacing="0" cellpadding="0">
      <tr>
        <td height="8"><img src="images/0000.gif" width="120" height="1"></td>
      </tr>
</table>

<table width="120" border="1" cellpadding="0" cellspacing="0" bordercolor="#b4b4b4" bgcolor="#FFFFFF" style="BORDER-COLLAPSE: collapse">
        <tr>
          <td>
<table width="100%" border="0" cellspacing="3" cellpadding="0">
			<tr>
              <td><div class="yellow_box">
              <ul class="middle middle_navs " id="js.classRoom">
                <!--<li>
                  <h1 class="p2"><span class="hide"></span><a href="codelist.asp" target="tx8_mainbody">宝贝描述</a></h1>
                  <div class="hide"> </div>
                </li>-->
                <li>
                  <h1 class="p5"><span class="show"></span>纸条箱</h1>
                  <div class="show " > <a href="kt1.asp" target="tx8_mainbody">自助开通</a> <a href="xf1.asp" target="tx8_mainbody">自助续费</a> <a href="sj1.asp" target="tx8_mainbody">自助扩容升级</a> </div>
                </li>
                <!--<li>
                  <h1 class="p1"><span class="hide"></span>文件夹管理</h1>
                  <div class="show"> <a href="folderlist.asp" target="tx8_mainbody" >文件夹管理</a> <a   style="cursor:pointer" target="tx8_mainbody" onClick="showExpressfolder('folderlist',0);" >快速浏览</a> </div>
                  <div id=folderlist style="display:none;"> </div>
                </li>
                <li>
                  <h1 class="p8"><span class="hide"></span>系统设置</h1>
                  <div class="show"> <a href="setmark.asp" target="tx8_mainbody" >水印设置</a> <a href="setsys.asp" target="tx8_mainbody" >喜好设置</a> </div>
                </li>
                <li>
                  <h1 class="p3"><span class="hide"></span>帐户管理</h1>
                  <div class="show"> <a href="setacinfo.asp" target="tx8_mainbody">修改帐户信息</a> <a href="setpass.asp" target="tx8_mainbody">修改登录密码</a> </div>
                </li>-->
                <li>
                  <h1 class="p4"><span class="hide"></span>服务支持</h1>
                  <div class="show"> <a href="Message.asp" target="tx8_mainbody">服务支持</a> <a href="buliang.asp" target="tx8_mainbody">举报不良信息</a></div>
                </li>
              </ul>
            </div></td>
            </tr>
            
            
          </table></td>
        </tr>
        <tr>
            <td><table width="100%" border="0" cellspacing="0" cellpadding="6">
              <tr>
                <td align="center">一定呦 版权所有</td>
              </tr>
            </table></td>
            </tr>
        
    </table>
</td>
    <td valign="top"><table width="100%" border="0" cellspacing="0" cellpadding="0">
      <tr>
        <td height="8"></td>
      </tr>
      
    </table>
      <table width="100%" border="1" cellpadding="0" cellspacing="0" bordercolor="#b4b4b4" style="BORDER-COLLAPSE: collapse">
        <tr>
          <td>
<iframe src="kt1.asp"  onload="document.all('tx8_mainbody').style.height=tx8_mainbody.document.body.scrollHeight;" scrolling="no" width="100%" height="500" name="tx8_mainbody" id="tx8_mainbody" frameborder="0"></iframe>
</td>
        </tr>
      </table>

      <table width="100%" border="0" cellspacing="0" cellpadding="0">
        <tr>
          <td height="8"></td>
        </tr>
      </table></td><td width="8"><img src="images/0000.gif" width="8"></td>
  </tr>
</table>
</body>
</html>

