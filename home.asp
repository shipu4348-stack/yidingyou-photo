<!--#include file="./incs/SysCode.asp"-->
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<title>我的一定呦 - 网络图片存储系统 www.1dy.cc</title>
<link rel="stylesheet" type="text/css" href="css/index.css" />
<link rel="stylesheet" type="text/css" href="css/common.css">
<link href="images/2010/Global.css" type="text/css" rel="stylesheet"/>
<link rel="stylesheet" type="text/css" href="images/2010/top_bar.css" />
<script src="js/jquery-1.4.2.min.js" type="text/javascript"></script>
<script src="js/fun.js" type="text/javascript"></script>
<script src="js/folderlist.js"></script>
<LINK href="online/style1/images/qq/qq.css?v=5" type=text/css rel=stylesheet>
<script language="JavaScript1.2"> 
var dragswitch=0 
var nsx 
var nsy 
var nstemp 
var ID
var Zorder=1
function drag_dropns(name){ 
temp=eval(name) 

temp.captureEvents(Event.MOUSEDOWN | Event.MOUSEUP) 
temp.onmousedown=gons 
temp.onmousemove=dragns 
temp.onmouseup=stopns 
} 

function gons(e){ 
temp.captureEvents(Event.MOUSEMOVE) 
nsx=e.x 
nsy=e.y 
} 
function dragns(e){ 
if (dragswitch==1){ 
temp.moveBy(e.x-nsx,e.y-nsy) 
return false 
} 
} 

function stopns(){ 
temp.releaseEvents(Event.MOUSEMOVE) 
} 
var dragapproved=false 
function drag_dropie(){ 
if (dragapproved==true){ 
document.getElementById('dispic'+ID).style.pixelLeft=tempx+event.clientX-iex 
document.getElementById('dispic'+ID).style.pixelTop=tempy+event.clientY-iey 
return false 
} 
} 

function initializedragie(id){ 
iex=event.clientX 
iey=event.clientY
ID=id;
tempx=document.getElementById('dispic'+ID).style.pixelLeft 
tempy=document.getElementById('dispic'+ID).style.pixelTop
document.getElementById('dispic'+ID).style.zIndex=Zorder+1 
dragapproved=true 
document.onmousemove=drag_dropie 
} 
if (document.all){ 
document.onmouseup=new Function("dragapproved=false") 
} 

</script>
<script language="JavaScript1.2">
function bbimg(o){
	var zoom=parseInt(o.style.zoom, 10)||100;zoom+=event.wheelDelta/12;if (zoom>0) o.style.zoom=zoom+'%';
	return false;
}
function closeshowpic(id)
{
document.getElementById('dispic'+id).innerHTML='';
document.getElementById('dispic'+id).style.display='none';
}

function showlxmenu()
{
if(document.getElementById("lxmanager").style.display=="block")
{
document.getElementById("lxmanager").style.display="none"
}
else
{
document.getElementById("lxmanager").style.display="block";
}
}

function showurl1(url)
  {
  var content;
  window.clipboardData.setData('Text','<img src="'+url+'">');
  content='网络地址已拷贝到剪贴板，可以使用粘贴或Ctrl+V调用。\n\n<img src="'+url+'">';
  alert(content);
  }
function showurl(url)
  {
  var content;
  window.clipboardData.setData('Text',url);
  content='网络地址已拷贝到剪贴板，可以使用粘贴或Ctrl+V调用。\n\n'+url;
  alert(content);
  }
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
function checksearch()
{
	if(document.search.search_content.value!="搜索文件")
	{
		document.search.submit();
	}
	else
	{
		alert("请输入搜索条件！");
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
<body>
<a name="top"></a>
<!--topbar-->
<!--#include file="top_main.asp"-->
<!--/topbar-->
<table width="100%" border="0" align="center" cellpadding="0" cellspacing="0" >
  <tr>
    <td height="32" valign="bottom" style="background-image:url(images/top_tdbg.jpg);background-repeat:repeat-x; background-position:bottom right; "><table width="384" border="0" cellspacing="0" cellpadding="0">
        <tr>
          <td width="15">　</td>
          <td align="center" class="menu1"><a href="home.asp" style="color:#ffffff">我的一定呦</a></td>
          <td width="88" align="center"><a href="pay.asp" target="_top">缴费中心</a></td>
          <td width="10" align="center"><img src="images/0020.gif" width="1" height="21"></td>
          <td width="88" align="center"><%if workday=0 then%>
            <a href="Photo.asp?kname=<%=UserName%>">我的相册</a>
            <%else%>
            <a href="Photo.asp?kname=<%=UserName%>" target="_blank">我的相册</a>
            <%end if%></td>
          <td width="10" align="center"><img src="images/0020.gif" width="1" height="21"></td>
          <td width="88" align="center"><a href="UserMessage.asp" target="_top">纸条箱</a></td>
        </tr>
      </table></td>
    <td height="32" align="right" valign="bottom" style="background-image:url(images/top_tdbg.jpg);background-repeat:repeat-x; background-position:bottom right;"><table width="480" border="0" cellspacing="0" cellpadding="0">
        <tr>
          <td class="gray" align="right" style="white-space:nowrap">使用状况：已用<span id="usesize"><%=FormatFileSize(FolderSize)%></span>&nbsp;/总共<%=FormatFileSize(kjdx)%>，剩余天数：<%=workday%>天</td>
          <td width="14" height="32"><br /></td>
        </tr>
      </table></td>
  </tr>
</table>
<table width="100%" border="0" align="center" cellpadding="0" cellspacing="0">
  <tr>
    <td width="133" align="center" valign="top"><table width="120" border="0" cellspacing="0" cellpadding="0">
        <tr>
          <td height="8"><img src="images/0000.gif" width="120" height="1"></td>
        </tr>
      </table>
      <!--<table width="120" border="0" cellspacing="0" cellpadding="0">
      <tr>
        <td><div id="two_btn">
		  <%if SysViewType=0 then%>
          <a target="tx8_mainbody" onClick="changedir(6);" href="main.asp?type=1"><div class="dir06" id="dir06">浏览</div></a>
		  <%elseif SysViewType=1 then%>
		  <a target="tx8_mainbody" onClick="changedir(6);" href="list.asp?type=2"><div class="dir06" id="dir06">浏览</div></a>
		  <%elseif SysViewType=2 then%>
		  <a target="tx8_mainbody" onClick="changedir(6);" href="top50.asp"><div class="dir06" id="dir06">浏览</div></a>
		  <%end if%>
		  <%if SysUpLoadType=0 then%>
          <a href="upsimp.asp" onClick="changedir(7);" target="tx8_mainbody"><div class="dir07" id="dir07">上传</div></a>
		  <%elseif SysUpLoadType=1 then%>
		  <a href="upftp.asp" onClick="changedir(7);" target="tx8_mainbody"><div class="dir07" id="dir07">上传</div></a>
		  <%end if%>
        </div></td>
      </tr>
      <tr>
        <td height="8"></td>
      </tr>
    </table> -->
      <table width="120" border="1" cellpadding="3" cellspacing="0" bordercolor="#b4b4b4" bgcolor="#FFFFFF" style="BORDER-COLLAPSE: collapse">
        <form name=search action="search.asp" method="post" target="tx8_mainbody">
          <tr>
            <td height="40" align="center"><div id="search" style="float:left;">
                <input type="text" class="inp_search" name="search_content" style="font-size:12px; color:#CCCCCC; height:16px; " value="搜索文件" onFocus="this.style.color='#000000';this.value=''" onBlur="if(this.value.length < 1 ){this.value='搜索文件';this.style.color='#cccccc'}" id="search_key" />
                <br />
                <div class="advsearch"><img src="images/0012.gif" width="34" height="22" style="cursor:hand;" onClick="checksearch();"><img src="images/0013.gif" width="11" height="22"></div>
              </div>
              </div></td>
          </tr>
        </form>
        <tr>
          <td height="60"><div class="yellow_box">
              <ul class="middle middle_navs " id="js.classRoom">
                <li>
                  <h1 class="p2"><span class="hide"></span><a href="codelist.asp" target="tx8_mainbody">宝贝描述</a></h1>
                  <div class="hide"> </div>
                </li>
                <li>
                  <h1 class="p6"><span class="hide"></span><a href="MovePic.asp" target="tx8_mainbody">图片搬家</a></h1>
                  <div class="hide"> </div>
                </li>
                <li>
                  <h1 class="p5"><span class="show"></span>图片存储</h1>
                  <div class="show " > <a href="main.asp?type=1" target="tx8_mainbody">图片查看</a> <a href="list.asp?type=2" target="tx8_mainbody">列表查看</a> <a href="top50.asp"     target="tx8_mainbody">最新上传</a> <a href="upsimp.asp"    target="tx8_mainbody">普通上传</a> <a href="upftp.asp"  target="tx8_mainbody">批量上传</a> </div>
                </li>
                <li>
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
                </li>
                <li>
                  <h1 class="p4"><span class="hide"></span>服务支持</h1>
                  <div class="show"> <a href="Message.asp" target="tx8_mainbody">提交问题</a> <a href="buliang.asp" target="tx8_mainbody">举报不良信息</a> </div>
                </li>
              </ul>
            </div></td>
        </tr>
        <tr>
          <td><table width="100%" border="0" cellspacing="0" cellpadding="6">
              <tr>
                <td align="left">一定呦 版权所有</td>
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
          <td><iframe src="maininfo.asp" height="600" scrolling="no" width="100%"   name="tx8_mainbody" id="tx8_mainbody" frameborder="0" style=" display:block; z-index:-1;"></iframe>
            <script type="text/javascript">

function reinitIframe(){
	//var len=1;
	 //for(i=1;i<=len;i++){ 
 	try{
		var mainheight = $('#tx8_mainbody').contents().find("body").height(); 
		$('#tx8_mainbody').height(mainheight);
 	}catch (ex){}
	}
 // }
  window.setInterval("reinitIframe()", 100);
</script></td>
        </tr>
      </table>
      <table width="100%" border="0" cellspacing="0" cellpadding="0">
        <tr>
          <td height="8"></td>
        </tr>
      </table></td>
    <td width="8"><img src="images/0000.gif" width="8"></td>
  </tr>
</table>
<div style="position: absolute; width: 100%; height: 100%; z-index:1; left: 0px; top: 0px;filter: alpha(opacity=70);opacity:0.7;background-color:#000000; display:none;" id="fugai_layout"> &nbsp;
  <!--<iframe src="javascript:false" style="position:absolute;visibility:visible;top:0px; left:-1px; width:100%; height:100%; z-index:2; filter='progid:DXImageTransform.Microsoft.Alpha(style=0,opacity=0)';"></iframe> -->
</div>
<div id="login1" style="width:400px; position: absolute;z-index: 1001; border: 1px solid #333333; background-color:#eeeeee; display:none;">
  <table width="100%" border="0" cellspacing="0" cellpadding="0" >
    <tr>
      <td style="padding-right:10px; text-align:right;" ><img style="cursor:hand;" onClick="document.getElementById('login1').style.display='none';document.getElementById('fugai_layout').style.display='none';" src="images/0043.gif" width="32" height="30" /></td>
    </tr>
    <tr>
      <td style="padding:10px;"><table width="100%" border="0" cellspacing="0" cellpadding="0" style="border: 1px solid #aaaaaa; background-color:#ffffff">
          <tr>
            <td style="background: url(images/0066.png) no-repeat center center; height: 138px; width: 134px;"></td>
            <td style="line-height:150%; padding-right:10px; padding-top:10px;" valign="top">亲爱的<%=request.cookies("1dy")("UserName")%>您好：<br />
              您的帐户即将到期，请尽快联系销售人员或客服续费或<a href=pay.asp><font color=red><b>自助缴费</b></font></a>，以免耽误您的正常使用。提醒：欠费超过10天，您的账户将有可能随时被系统销户并无法恢复。感谢您的支持与关注。</td>
          </tr>
        </table></td>
    </tr>
  </table>
</div>
<div id="login0" style="width:400px; position: absolute;z-index: 1001; border: 1px solid #333333; background-color:#eeeeee; display:none;">
  <table border="0" cellspacing="0" cellpadding="0" width="100%" >
    <tr>
      <td style="padding-right:10px; text-align:right;" ><img style="cursor:hand;" onClick="window.location='pay.asp';" src="images/0043.gif" width="32" height="30" /></td>
    </tr>
    <tr>
      <td style="padding:10px;"><table width="100%" border="0" cellspacing="0" cellpadding="0" style="border: 1px solid #aaaaaa; background-color:#ffffff">
          <tr>
            <td  style="background: url(images/0064.png) no-repeat center center; height: 138px; width: 134px;"></td>
            <td style="line-height:150%; padding-right:10px; padding-top:10px;" valign="top">亲爱的<%=request.cookies("1dy")("UserName")%>您好：<br />
              您的帐户尚未付费，请去交费后使用。感谢您的支持与关注。</td>
          </tr>
        </table></td>
    </tr>
  </table>
</div>
<div id="login2" style="width:400px; position: absolute;z-index: 1001; border: 1px solid #333333; background-color:#eeeeee; display:none;">
  <table width="100%" border="0" cellspacing="0" cellpadding="0">
    <tr>
      <td style="padding-right:10px; text-align:right;" ><img src="images/0043.gif" style="cursor:hand;" onClick="document.getElementById('login2').style.display='none';document.getElementById('fugai_layout').style.display='none';" width="32" height="30" /></td>
    </tr>
    <tr>
      <td style="padding:10px;"><table width="100%" border="0" cellspacing="0" cellpadding="0" style="border: 1px solid #aaaaaa; background-color:#ffffff">
          <tr>
            <td style="background: url(images/0063.png) no-repeat center center; height: 138px; width: 134px;"></td>
            <td style="line-height:150%; padding-right:10px; padding-top:10px;" valign="top">亲爱的<%=request.cookies("1dy")("UserName")%>您好：<br />
              您的空间已用已用<span id="usesize"><%=FormatFileSize(FolderSize)%></span>&nbsp;/总共<%=FormatFileSize(kjdx)%>，您当前容量使用比例提醒为<%=SysNotic%>%，超出了提醒预设值，特此提醒。提示：如果您的使用比率超过95%，建议您<a href="pay.asp"><font color=red>升级扩容空间</font></a>，以免在特殊情况下造成空间不足而耽误正常使用。 </td>
          </tr>
        </table></td>
    </tr>
  </table>
</div>
<div id="login3" style="width:400px; position: absolute;z-index: 1001; border: 1px solid #333333; background-color:#eeeeee; display:none;">
  <table width="100%" border="0" cellspacing="0" >
    <tr>
      <td style="padding-right:10px; text-align:right;" ><img style="cursor:hand;" onClick="document.getElementById('login3').style.display='none';document.getElementById('fugai_layout').style.display='none';" src="images/0043.gif" width="32" height="30" /></td>
    </tr>
    <tr>
      <td style="padding:10px;"><table width="100%" border="0" cellspacing="0" cellpadding="0" style="border: 1px solid #aaaaaa; background-color:#ffffff">
          <tr>
            <td style="background: url(images/0062.png) no-repeat center center; height: 138px; width: 134px;"></td>
            <td style="line-height:150%; padding-right:10px; padding-top:10px;" valign="top">　　您好，您正在使用的是公用体验帐户，该帐户下所存储信息定期清除。为了不影响您的正常使用，请及时联系一定呦的销售代表为您开通正式帐户。希望您通过这次愉快的体验留下您的宝贵意见，感谢使用一定呦 -- 企业级网络存储服务商。</td>
          </tr>
        </table></td>
    </tr>
  </table>
</div>
<div id="login4" style="width:400px; position: absolute;z-index: 1001; border: 1px solid #333333; background-color:#eeeeee; display:none;">
  <table width="100%" border="0" cellspacing="0" >
    <tr>
      <td style="padding-right:10px; text-align:right;" ><img style="cursor:hand;" onClick="document.getElementById('login4').style.display='none';document.getElementById('fugai_layout').style.display='none';" src="images/0043.gif" width="32" height="30" /></td>
    </tr>
    <tr>
      <td style="padding:10px;"><table width="100%" border="0" cellspacing="0" cellpadding="0" style="border: 1px solid #aaaaaa; background-color:#ffffff">
          <tr>
            <td style="background: url(images/0062.png) no-repeat center center; height: 138px; width: 134px;"></td>
            <td style="line-height:150%; padding-right:10px; padding-top:10px;" valign="top">　　
              亲爱的<%=request.cookies("1dy")("UserName")%>您好，您使用的账户尚未付费，该帐户下所存储的信息会在你的账户到期时清除。为了不影响您的正常使用，请及时联系一定呦的销售代表为您开通正式帐户。希望您通过这次愉快的体验留下您的宝贵意见，感谢使用一定呦 -- 企业级网络存储服务商。</td>
          </tr>
        </table></td>
    </tr>
  </table>
</div>
<div id="login5" style="width:400px; position: absolute;z-index: 1001; border: 1px solid #333333; background-color:#eeeeee; display:none;">
  <table width="100%" border="0" cellspacing="0" >
    <tr>
      <td style="padding-right:10px; text-align:right;" ><img style="cursor:hand;" onClick="document.getElementById('login5').style.display='none';document.getElementById('fugai_layout').style.display='none';" src="images/0043.gif" width="32" height="30" /></td>
    </tr>
    <tr>
      <td style="padding:10px;"><table width="100%" border="0" cellspacing="0" cellpadding="0" style="border: 1px solid #aaaaaa; background-color:#ffffff">
          <tr>
            <td style="background: url(images/0062.png) no-repeat center center; height: 138px; width: 134px;"></td>
            <td style="line-height:150%; padding-right:10px; padding-top:10px;" valign="top">亲爱的<%=request.cookies("1dy")("UserName")%>您好：<br />
              您的空间已用已用<span id="usesize"><%=FormatFileSize(FolderSize)%></span>&nbsp;/总共<%=FormatFileSize(kjdx)%>，容量使用比例提醒为<%=SysNotic%>%，欢迎您的使用企业级网络存储服务商。 </td>
          </tr>
        </table></td>
    </tr>
  </table>
</div>
<div style="position:absolute; width: 400px; height: 60px; z-index: 100; left: 230px; top: -70px; display:; background-color:#f0f0f0; border: 1px solid #dedede;" id="showmessage" align="center"><br />
  <img src="images/0061.gif" align="absmiddle" width="31" height="31"> &nbsp; 正在上传请稍候，提示上传成功即代表上传完毕。</div>
<div style="position: absolute; width: 400px; height: 60px; z-index: 100; left: 230px; top: -60px; display:none; background-color:#f0f0f0; border: 1px solid #dedede;" id="delinfo" align="center"><br />
  <img src="images/0061.gif" align="absmiddle" width="31" height="31"> &nbsp; 正在删除请稍候，提示删除成功即代表删除完毕。</div>
<div style="position: absolute; width: 400px; height: 60px; z-index: 100; left: 230px; top: -60px; display:none; background-color:#f0f0f0; border: 1px solid #dedede;" id="setphoto" align="center"><br />
  <img src="images/0061.gif" align="absmiddle" width="31" height="31"> &nbsp; 正在设定请稍候…</div>
<div style="position: absolute; width: 400px; height: 60px; z-index: 100; left: 230px; top: -60px; display:none; background-color:#f0f0f0; border: 1px solid #dedede;" id="daorupic" align="center"><br />
  <img src="images/0061.gif" align="absmiddle" width="31" height="31"> &nbsp; 由于图片过多，可能要花几分钟，请耐心等待，正在导入…<span id="ProgressPercent">0%</span></div>
<iframe name=UPresult style="display:none;" height=300 width=500></iframe>
<DIV id="dispics"></div>
<!--#include file="online/style1/online.asp"-->
</body>
</html>
