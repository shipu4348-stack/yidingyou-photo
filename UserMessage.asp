<!--#include file="./incs/SysCode.asp"-->
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">

<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<title>我的一定呦 - 网络图片存储系统 www.1dy.cc - 短消息</title>
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
 
<table width="100%" border="0" cellpadding="0" cellspacing="0"  >
 
  <tr>
    <td width="65%" height="32" valign="bottom" style="background-image:url(images/top_tdbg.jpg);background-repeat:repeat-x; background-position:bottom right; ">
		<table width="384" border="0" cellspacing="0" cellpadding="0">
      <tr>

        <td width="88" align="center"><a href="home.asp" target="_top">我的一定呦</a></td>
         <td width="10" align="center"><img src="images/0020.gif" width="1" height="21"></td>
        <td width="88" align="center"><a href="pay.asp">缴费中心</a></td>
         <td width="10" align="center"><img src="images/0020.gif" width="1" height="21"></td>
        <td width="88" align="center">
         <%if workday=0 then%>
        	<a href="Photo.asp?kname=<%=UserName%>">我的相册</a>
        <%else%>
        	<a href="Photo.asp?kname=<%=UserName%>" target="_blank">我的相册</a>
        <%end if%>
        </td>       
        <td width="88" align="center"  class="menu1">纸条箱</td>
        </tr>
    </table>
    </td>
    <td height="32" align="right" valign="bottom" style="background-image:url(images/top_tdbg.jpg);background-repeat:repeat-x; background-position:bottom right; ">
		<table width="480" border="0" cellspacing="0" cellpadding="0">
      <tr>
        <td class="gray" align="right" style="white-space:nowrap">使用状况：已用<span id="usesize"><%=FormatFileSize(FolderSize)%></span>&nbsp;/总共<%=FormatFileSize(kjdx)%>，剩余天数：<%=workday%>天</td>
        <td width="14" height="32"><br /></td>
      </tr>
    </table>
    </td>
  </tr>
</table>
<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td width="133" align="center" valign="top">
    <table width="120" border="0" cellspacing="0" cellpadding="0">
      <tr>
        <td width="120" height="8"><img src="images/0000.gif" width="120" height="1"></td>
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
                  <div class="show " > <a href="send.asp" target="tx8_mainbody">发件箱</a> <a href="accept.asp" target="tx8_mainbody">收件箱</a> <a href="sender.asp" target="tx8_mainbody">已发送</a> </div>
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
        
        
    </table></td>
    <td valign="top"><table width="100%" border="0" cellspacing="0" cellpadding="0">
      <tr>
        <td height="8"></td>
      </tr>
      
    </table>
      <table width="100%" border="1" cellpadding="0" cellspacing="0" bordercolor="#b4b4b4" style="BORDER-COLLAPSE: collapse">
        <tr>
          <td>
<iframe src="accept.asp"  onload="document.all('tx8_mainbody').style.height=tx8_mainbody.document.body.scrollHeight;" scrolling="no" width="100%" height="500" name="tx8_mainbody" id="tx8_mainbody" frameborder="0"></iframe>
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

<div id="login0" style="width:400px; position: absolute;z-index: 100; border: 1px solid #333333; background-color:#eeeeee; display:none;">
	<table border="0" cellspacing="0" cellpadding="0" width="100%" >
  <tr>
    <td style="padding-right:10px; text-align:right;" ><img style="cursor:hand;" onClick="window.location='pay.asp';" src="images/0043.gif" width="32" height="30" /></td>
  </tr>
  <tr>
    <td style="padding:10px;"><table width="100%" border="0" cellspacing="0" cellpadding="0" style="border: 1px solid #aaaaaa; background-color:#ffffff">
      <tr>
        <td  style="background: url(images/0064.png) no-repeat center center; height: 138px; width: 134px;"></td>
        <td style="line-height:150%; padding-right:10px; padding-top:10px;" valign="top">亲爱的<%=UserName%>您好：<br />您的帐户尚未付费，请去交费后使用。感谢您的支持与关注。</td>
      </tr>
    </table></td>
  </tr>
</table>
<script language="javascript">
function fugai(){
if(top.document.body.scrollHeight>top.document.body.clientHeight)
{
	top.document.getElementById("fugai_layout").style.height=top.document.body.scrollHeight;
}
else
{
	top.document.getElementById("fugai_layout").style.height=top.document.body.clientHeight;
}
top.document.getElementById("fugai_layout").style.width=top.document.body.scrollWidth;
top.document.getElementById("fugai_layout").style.display="block";
}
</script>
</div>
<div style="position: absolute; width: 100%; height: 100%; z-index: 1; left: 0px; top: 0px; background-color:black;filter:alpha(opacity=70);opacity:0.7; display:none;" id="fugai_layout">
&nbsp;<iframe src="javascript:false" style="position:absolute;visibility:visible;top:0px; left:-1px; width:100%; height:100%; z-index:2; filter='progid:DXImageTransform.Microsoft.Alpha(style=0,opacity=0)';"></iframe></div>
<%
	if Request.Cookies("1dy")("yjf")=0 and workday<=0 and request.Cookies("1dy")("fate")=1 then
	response.Write "<script language='javascript'>"
	response.Write("fugai")
	response.Write "document.getElementById('fugai_layout').style.display='';"
	response.Write "document.getElementById('login0').style.display='';"
	response.Write "document.getElementById('login0').style.left=(document.body.clientWidth/2)-(document.getElementById('login0').offsetWidth/2)+'px';"
	response.Write "document.getElementById('login0').style.top=(document.body.clientHeight/2)-(document.getElementById('login0').offsetHeight/2)+'px';"
	response.write "</script>"
	end if
	if Request.Cookies("1dy")("yjf")=3 then
		response.Write "<script>alert('测试用户不能使用!');location.href='home.asp';</script>"
	end if
%>
</body>
</html>

