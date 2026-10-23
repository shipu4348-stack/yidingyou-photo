<!--#include file="incs/conn.asp"-->
<!--#include file="incs/cls_pages.asp"-->
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
<title>帮助信息-一定呦图片存储</title>
<meta name="keywords" content="存储空间，图片存储" />
<meta http-equiv="X-UA-Compatible" content="IE=EmulateIE7" />
<meta name="Description" content="一定呦-网络图片存储，提供淘宝，拍拍，有啊等店铺宝贝图片存储空间!" />
<link href="images/2010/Global.css" type="text/css" rel="stylesheet"/>
<link rel="stylesheet" type="text/css" href="images/2010/top_bar.css" />
<link href="images/2010/main.css" type="text/css" rel="stylesheet"/>
<link href="images/2010/login.css" type="text/css" rel="stylesheet"/>
<script src="js/jquery-1.4.2.min.js" type="text/javascript"></script>
<script src="js/yl_common.js" type="text/javascript"></script>
<script type="text/javascript" src="js/indexlogin.js?v=2"></script>
<script type="text/javascript" src="js/sindexagent.js"></script>
<%
'****************************************************
'函数名：HtmlDel
'作  用：清理所有html标记
'参  数：Str ----字符串
'返回值：过滤后的字符串
'****************************************************
Function HtmlDel(Str)
	If Str="" Or IsNull(Str) Then
		HtmlDel=""
		Exit Function
	End If
	Dim Rep,Pass
	Set Rep=New RegExp
	Rep.Global=True
	Rep.IgnoreCase=True
	Rep.Pattern="(<.+?>)"
	HtmlDel=Rep.Replace(Str,"")
	Set Rep=Nothing
End Function
%>
</head>
<body>
<a name="top"></a>
<!--topbar-->
<!--#include File="top.asp"-->
<div id="content">
  <div class="layout lay-ms">
    <div class="lay-main">
      <div class="main-wrap">
        <div class="mod-box-a">
          <div class="bh-a">
            <h3>帮助信息</h3>
          </div>
          <div class="bc-a">
            <div class="mod-tab-a">
              <div id="tab_company_con" class="tc-a">
                <div style="display: block;" class="tab-content">
                  <div class="con-txt">
                    <%
											sqlnew=sqlnew&"select * from ydy_notice where classType=2 "
											
                                           	sqlnew=sqlnew&" order by istop desc,id desc"
										   
										   
											 Set rsx=new Record09
											Set rsx.connection=conn
											rsx.openx sqlnew,20
											listnum=rsx.recordcount
											for each o in rsx.DataClass 
											 response.write "<li><b><font color='red'>问：</font>" & o.title & "</b></li>"
											  response.write "<li><b><font color='blue'>答：</font></b>" & HtmlDel(o.content) & "</li>"
											 next
                                            %>
                    <br />
                    <%
 if listnum>0 then 
					 
					 response.Write ""
Rsx.format="<div class=""manu"" style='margin-top:30px;'><span  class=""disabled"">$a1第一页$ae</span> <span  class=""disabled"">$a2上页$ae</span>&nbsp;$z6&nbsp;<span   >$a3下页"&_
				"$ae</span>&nbsp;<span  class=""disabled"">$a4最后一页$ae</span>  "&_ 
				"</div>"
Rsx.scroll

else 

%>
                    <div>暂无帮助信息</div>
                    <%end if%>
                    <!--<table width="100%" border="0" align="center" cellpadding="3" cellspacing="0">
    <tr>
      <td height="30" class="td2" align="left"><b><font color="red">问：</font>空间可以升级吗？费用怎么核算？</b></td>
    </tr>
    <tr>
      <td class="td2" align="left"><font color="blue">答：</font>根据服务器当前是否可以升级状态，来确定用户当时是否可以升级。首先联系销售人员确认用户该组服务器是否可升级。如果可升级则标准如下，升级情况大体分两种：1、年费率到年费率升级；2、月费率到年费率的升级。年到年的升级费用核算是：新资费-（原资费-(原资费/365)*已使用天数）=要补的差价，注：升级完毕后，您的使用状况是 在新空间大小下使用时间为1年。月到年的升级费用核算是：直接补交要升级到某容量一年的全资费，升级完在原有的包月剩余天数上加上365天。注：升级只能做月到年，年到年的升级，不能降级，并且只有在现有空间规格基础上，进行升级。无限通和网通单线之间不能互相转换。</td>
    </tr>
  </table>
 <hr width="100%" size="1" color="#EFEFEF" noshade>
  <table width="100%" border="0" align="center" cellpadding="3" cellspacing="0">
    <tr>
      <td height="30" class="td2" align="left"><b><font color="red">问：</font>为什么我使用保持原文件名不变选项上传，不能正确显示图片？</b></td>
    </tr>
    <tr>
      <td class="td2" align="left"><font color="blue">答：</font>请确定你上传的图片原文件名中不包含中文字符或空格，由于网络地址对中文支持不好，所以请删除包含中文字符的文件，更名符合通常规则的文件名再次上传。</td>
    </tr>
  </table>
 <hr width="100%" size="1" color="#EFEFEF" noshade>
  <table width="100%" border="0" align="center" cellpadding="3" cellspacing="0">

    <tr>
      <td height="30" class="td2" align="left"><b><font color="red">问：</font>我的帐户到期了怎么办，多长时间不续费，我的资料就没了？</b></td>
    </tr>
    <tr>
      <td class="td2" align="left"><font color="blue">答：</font>一定呦对用户到期前10天就开始在用户登陆的时候，提示用户续费了；如果用户帐户到期后3天内，用户帐户还可以正常登陆使用，图片也能正常浏览；如果自用户到期后超过3天，用户不能登陆，也就不能维护了，图片不能浏览，但用户资料保留；自用户到期后超过10天，还未续费，则删除该用户所有存储资料，不在保留，也不负责恢复。</td>
    </tr>
  </table>
 <hr width="100%" size="1" color="#EFEFEF" noshade>
  <table width="100%" border="0" align="center" cellpadding="3" cellspacing="0">
    <tr>
      <td height="30" class="td2" align="left"><b><font color="red">问：</font>一定呦上传都支持什么格式的文件？</b></td>
    </tr>
    <tr>
      <td class="td2" align="left"><font color="blue">答：</font>一定呦支持的文件格式有 .jpg .gif .png .bmp .ani 等格式文件，其他格式文件不允许上传。</td>
    </tr>
  </table>
 <hr width="100%" size="1" color="#EFEFEF" noshade>
  <table width="100%" border="0" align="center" cellpadding="3" cellspacing="0">
    <tr>
      <td height="30" class="td2" align="left"><b><font color="red">问：</font>为什么我上传总是失败？</b></td>
    </tr>
    <tr>
      <td class="td2" align="left"><font color="blue">答：</font>确认您上传的文件是一定呦支持的格式；确认您还有足够的空间来上传；确认您上传的文件是不是太大；一定呦对上传文件的大小没有限制，只要您的空间足够大就可以上传，但是过大的文件；尤其是在您的网络环境不太好的情况下容易产生超时现象，所以建议您上传的文件不要过大。</td>
    </tr>
  </table>
 <hr width="100%" size="1" color="#EFEFEF" noshade>
  <table width="100%" border="0" align="center" cellpadding="3" cellspacing="0">
    <tr>
      <td height="30" class="td2" align="left"><b><font color="red">问：</font>为什么我全屏登陆登不进来？</b></td>
    </tr>
    <tr>
      <td class="td2" align="left"><font color="blue">答：</font>由于WINDOWS XP-SP2系统的IE安全设置或是3721等类似的安全型IE工具条的阻挡，导致您全屏登陆被拦截，无法正常登陆。解决办法，系统设置：打开IE-点击工具-Internet 选项-隐私选项卡最下面的设置-弹出窗口阻止程序-点击设置-把(*.1dy.cc)括号内的地址输入到要允许的网站地址栏内点添加。工具条设置：根据不同工具条，具体设置，基本是允许本网站窗口弹出，或删除或停用工具条。有时需要两者同时进行。</td>
    </tr>
  </table>
 <hr width="100%" size="1" color="#EFEFEF" noshade>
  <table width="100%" border="0" align="center" cellpadding="3" cellspacing="0">
    <tr>
      <td height="30" class="td2" align="left"><b><font color="red">问：</font>为什么我注册完，用收到的密码登陆,总提示密码错误?</b></td>
    </tr>
    <tr>
      <td class="td2" align="left"><font color="blue">答：</font>系统发送的密码是不会错的。第一次登陆，最好用复制粘贴的方法在登陆区填写密码，系统发送的密码是6位，所以，粘贴到登陆区密码栏应该是6个圆点或者星号，如果多了或少了，都是复制错了，多了个空格，或者少复制了一位。因此造成登陆失败。</td>
    </tr>
  </table>-->
                  </div>
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>
    <!-- /.lay-main-->
    <div class="lay-side">
      <div class="mod-left-menu">
        <ul>
          <li><a  href="About.asp?ac=aboutus">公司简介</a></li>
          <li><a href="help.asp" class="current">帮助信息</a></li>
          <li><a href="Note.asp?ac=note">网站公告</a></li>
          <li><a href="affairs.asp">大事记</a></li>
        </ul>
      </div>
    </div>
    <!-- /.lay-side -->
  </div>
  <!-- /.lay-ms-->
</div>
<script>
tabPage("tab_company","li");
</script>
<!--/test -->
<!--#include file="foot.asp"-->
</body>
</html>
