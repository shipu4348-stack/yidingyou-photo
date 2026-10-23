<!--#include file="incs/model.asp"-->
<%
call stopsql()
Response.Cookies("1dy")("UserID")=""
Response.Cookies("1dy")("UserName")=""
Response.Cookies("1dy")("yjf")=""
Response.Cookies("1dy")("OverTime")=""
Response.Cookies("1dy")("tcid")=""
response.Cookies("liu")("kid")=""
response.Cookies("liu")("tag")=""
response.Cookies("liu")("shortpath")=""
response.Cookies("liu")("overall")=""
response.Cookies("liu")("shuiyin")=""
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
<title>一定呦图片存储</title>
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
<script src="js/yl_jcarousellite_1.0.1.min.js" type="text/javascript"></script>
<script src="js/yl_jquery.featureList-1.0.0.js" type="text/javascript"></script>
<script type="text/javascript">
$(function(){

setTimeout(function(){
$("#pro_list").jCarouselLite({
    btnNext: "#btn_pro_next",
    btnPrev: "#btn_pro_prev",
	visible: 3,
	scroll:3,
	speed: 1500,
	auto:3000
});
},500)


$.featureList(
	$("#focus_btn span"),
	$("#focus_img li"), {
	start_item	:	0,
	transition_interval:7000
	}
);

});

</script>
<LINK href="online/style1/images/qq/qq.css?v=5" type=text/css rel=stylesheet>
</head>
<body>
<a name="top"></a>
<!--topbar-->
<!--#include File="top.asp"-->
<!--/topbar-->
<!--登陆 -->
<div id="lad_center">
  <div class="lad_lt">
    <div class="tt">欢迎光临一定呦，为您提供专业的图片存储服务!<a href="register.asp"><img border="0" src="images/2010/reg/land_t.gif" style="margin-left: 5px;"></a></div>
    <div style="margin-top:13px;*margin-top:13px;width:620px;height:auto;">
      <div class="mod-banner">
        <div id="focus_img">
          <ul>
            <%
sql="select top 3 logoUrl,sitename,smallLogo from ydy_ad where ltype=9 order by id desc"
set rs=conn.execute(sql)
dim k:k=1
while not rs.eof
if k=1 then
response.Write("<li style='display:none;'><img height='240' width='620' src='" & rs("logourl") & "'></li>")
else
response.Write("<li style='display:list-item;opacity:1;'><img height='240' width='620' src='" & rs("logourl") & "'></li>")
end if
				rs.movenext
				k=k+1
				wend
				%>
          </ul>
        </div>
      </div>
      <div id="focus_btn">
      <%
rs.movefirst
while not rs.eof
response.Write("<span class='btn'><img src='" & rs("smallLogo") & "'></span>")
				rs.movenext
				wend
				rs.close
				%>
       </div>
    </div>
    <!--<div class="cont">
  		 </div> 
		 <div class="fb">
		   <ul>
		     <li class="xs"><p class="zb"><a href="#">超强FTP上传</a></p><p class="xz">方便快速，不限文件大小</p></li>
			 <li class="zq"><p class="zb"><a href="#">CDN加速</a></p><p class="xz">全线CDN加速，图片访问加速</p></li>
             <li class="r3"><p class="zb"><a href="#">超级搬家</a></p><p class="xz">简单操作为您解决搬家烦恼</p></li>
		   </ul>
		 </div>-->
  </div>
  <div class="lad_rt">
    <div class="top"><a target="_blank" href="#"><img border="0" title="下一个会是谁？" src="images/2010/user_dlx.gif"></a> </div>
    <div class="top2"><a title="点击即可访问推荐店家！" target="_blank" href="#"><img border="0" src="images/2010/user_dlx.gif"></a> </div>
    <form name="login">
      <p style="">用户名</span>
        <input type="text" maxlength="64" name="username" id="username"  class="sr" tabindex="1">
        <a href="forget.asp" target="_blank" style="color: rgb(0, 0, 0);">找回用户名</a></p>
      <p>密　码
        <input type="password" maxlength="16" name="password"  id="password"  class="sr" tabindex="2">
        <a href="forget.asp" style="color: rgb(0, 0, 0);">找回密码</a></p>
      <!--<p style="padding: 2px 0px 6px 45px; text-indent: -3px;"><input type="checkbox" style="border: medium none ; background: rgb(243, 243, 243) none repeat scroll 0% 0%; -moz-background-clip: -moz-initial; -moz-background-origin: -moz-initial; -moz-background-inline-policy: -moz-initial;" value="30" name="usertime">记住用户名</p> -->
      <table width="212" border="0" align="center" cellpadding="0" cellspacing="0" >
        <tr>
          <td height="22" colspan="3"><span id=username_d></span><span id=password_d></span></td>
        </tr>
        <tr>
          <td height="22" colspan="3"><span id=verify_d>请见下面的文字输入框中</span></td>
        </tr>
        <tr>
          <td width="58" height="44"><input name="verifycode" type="text" id="verify"  maxlength="4" class="loginput" style="width:40px;vertical-align:middle;" onkeydown="if(event.keyCode==13){return checkform();}"  tabindex="3"/></td>
          <td width="62" valign="middle"><table cellpadding="0" cellspacing="0" bgcolor="#ebf8ff" style="border: 1px solid #abdafe; width:50px; height:24px;">
              <tr>
                <td align="center"><img src="GetCode.asp" width="40" height="10" style="cursor:pointer"
alt="点击刷新获取有效验证码" onclick="this.src=this.src+'?'" align="absmiddle"></td>
              </tr>
            </table></td>
          <td width="92"><input name="btnloginfree" type="button" value="登 录" tabindex="4" class="dl1" id="loginbtn" onmouseover="this.className='dl2'" onmousedown="this.className='dl3'" onmouseout="this.className='dl1'" onclick="return checkform();" /></td>
        </tr>
        <tr>
          <td colspan="3"><span style="text-indent: 40px;">
            <input type="button" value="" name="btnregtest" class="test_1" onclick="javascript:testid();" onmouseover="this.className='test_2'" onmousedown="this.className='test_3'" onmouseout="this.className='test_1'" />
            &nbsp;</span>
            <input type="button" value="" name="btnregfree" class="reg_1" onclick="javascript:window.open('register.asp')" onmouseover="this.className='reg_2'" onmousedown="this.className='reg_3'" onmouseout="this.className='reg_1'" />
            <br />
            <input NAME="Use_Cookie" TYPE="checkbox" VALUE="1" id="Use_Cookie" style="vertical-align:middle; display:none" /></td>
        </tr>
      </table>
      <br />
    </form>
    <div class="bottom">
      <p><b>你知道这些数据吗？</b> <br>
        <span id="info1"> 一定呦目前共有<font color="#fe5301">12<%=left(day(now()),1)%>
        <%
   dim rs,sql
   sql="select count(*) as zong from [liu_user]"
   set rs=conn.execute(sql)
   response.Write(rs("zong"))
   rs.close
   %>
        </font>人使用 共存储图片<font color="#fe5301">1<%=left(month(now()),1)%>
        <%
 sql="select count(*) as zong from [liu_pic]"
 set rs=conn.execute(sql)
 response.Write(rs("zong"))
 rs.close
 %>
        <%=left(day(now()),1)%></font>张图片 </span>
        <%
set rs=nothing
%>
      </p>
    </div>
  </div>
  <div class="clearfix"></div>
</div>
<!--登陆结束 -->
<!--公告 -->
<div id="Note" style="clear:both">
  <div class="bh" style="margin:0 auto;">
    <div class="lt">我们的变化:</div>
    <ul>
      <% 
	set rs=server.CreateObject("adodb.recordset")
	rs.open "select top 5 * from ydy_notice where charindex('2',kind)>0 order by istop desc,id desc",conn,1,1
	if rs.eof or rs.bof then
		response.Write "<li>暂无公告</li>"
	else
		do while not rs.eof
		response.write "<li><a href='Note_show.asp?id="&rs("id")&"'>"&rs("title")&"</a></li>"
		rs.movenext
		loop
		
	end if
	rs.close
	set rs=nothing
%>
    </ul>
  </div>
  <div class="clearfix"></div>
</div>
<!--/公告 -->
<!--相册 -->
<div id="photo" style="clear:both">
  <div class="bar">
    <div class="bar-left"></div>
    <div class="bar-right"></div>
  </div>
  <div class="album-ad">
    <div id="table_left" class="album-ad-left">
      <table cellspacing="0" cellpadding="0">
        <tbody>
          <tr>
            <td class="sp"></td>
            <td valign="middle" colspan="4" class="title"> 推荐相册 </td>
            <td colspan="3" class="more"></td>
          </tr>
          <tr>
            <td class="sp"></td>
            <td class="album-photo"><a target="_blank" href="Photo.asp?kname=fcxzfcxz"> <img width="93" height="93" onload="setWantSize(this,93,93)" src="/images/2010/erqita.png"> </a></td>
            <td class="sp"></td>
            <td class="album-photo"><a target="_blank" href="Photo.asp?kname=fcxzfcxz"> <img width="93" height="93" onload="setWantSize(this,93,93)" src="/images/2010/longmen.png"> </a></td>
            <td class="sp"></td>
            <td class="album-photo"><a target="_blank" href="Photo.asp?kname=fcxzfcxz"> <img width="93" height="93" onload="setWantSize(this,93,93)" src="/images/2010/zhangjiajie.jpeg"> </a></td>
            <td class="sp"></td>
            <td class="album-photo"><a target="_blank" href="Photo.asp?kname=fcxzfcxz"> <img width="93" height="93" onload="setWantSize(this,93,93)" src="/images/2010/dayanta.jpeg"> </a></td>
          </tr>
          <tr>
            <td class="sp"></td>
            <td class="album-name"><a target="_blank" href="Photo.asp?kname=smile"> 清明上河园 </a></td>
            <td class="sp"></td>
            <td class="album-name"><a target="_blank" href="Photo.asp?kname=Garcia"> Cartoon </a></td>
            <td class="sp"></td>
            <td class="album-name"><a target="_blank" href="Photo.asp?kname=yangyang"> 百变达人街头潮搭王 </a></td>
            <td class="sp"></td>
            <td class="album-name"><a target="_blank" href="Photo.asp?kname=o7coco7o"> 那年的游玩 </a></td>
          </tr>
        </tbody>
      </table>
    </div>
    <div id="table_right" class="album-ad-right2">
      <table cellspacing="0" cellpadding="0" style="margin-left: 26px;">
        <tbody>
          <tr>
            <td width="317" class="title"> 客户中心 </td>
          </tr>
          <tr>
            <td >有问题，请联系我们的客服为您排忧解难吧! </td>
          </tr>
          <tr>
            <td ><table width="100%" border="0" cellspacing="0" cellpadding="0">
                <tr>
                  <td width="30%" height="109"><img src="images/2010/callme.gif" width="66" height="55" /></td>
                  <td width="33%"><table width="100%" border="0" cellspacing="0" cellpadding="0">
                      <tr>
                        <td height="23" valign="middle"><img src="/online/style1/images/qq/ww_online.gif" alt="旺旺在线" width="72" height="21"></td>
                      </tr>
                      <tr>
                        <td height="23" valign="middle"><img src="/online/style1/images/qq/ww_online.gif" alt="旺旺在线" width="72" height="21"></td>
                      </tr>
                      <tr>
                        <td height="23" valign="middle"><img src="/online/style1/images/qq/ww_online.gif" alt="旺旺在线" width="72" height="21"></td>
                      </tr>
                      <tr>
                        <td height="23" valign="middle"><img src="/online/style1/images/qq/ww_online.gif" alt="旺旺在线" width="72" height="21"></td>
                      </tr>
                    </table></td>
                  <td width="37%"><table width="100%" border="0" align="center" cellpadding="0" cellspacing="0" dwcopytype="CopyTableRow">
                      <tr >
                        <td width="14" height="20" ><a href="http://sighttp.qq.com/cgi-bin/check?sigkey=YOUR_QQ_SIGKEY_1"; target=_blank; onclick="var tempSrc='http://sighttp.qq.com/wpa.js?rantime='+Math.random()+'&sigkey=YOUR_QQ_SIGKEY_1';var oldscript=document.getElementById('testJs');var newscript=document.createElement('script');newscript.setAttribute('type','text/javascript'); newscript.setAttribute('id', 'testJs');newscript.setAttribute('src',tempSrc);if(oldscript == null){document.body.appendChild(newscript);}else{oldscript.parentNode.replaceChild(newscript, oldscript);}return false;"><img border="0" SRC='http://wpa.qq.com/pa?p=1:111111:45' alt="联系我购买"></a></td>
                        <td class="col"><a href="http://sighttp.qq.com/cgi-bin/check?sigkey=YOUR_QQ_SIGKEY_1"; target=_blank; onclick="var tempSrc='http://sighttp.qq.com/wpa.js?rantime='+Math.random()+'&sigkey=YOUR_QQ_SIGKEY_1';var oldscript=document.getElementById('testJs');var newscript=document.createElement('script');newscript.setAttribute('type','text/javascript'); newscript.setAttribute('id', 'testJs');newscript.setAttribute('src',tempSrc);if(oldscript == null){document.body.appendChild(newscript);}else{oldscript.parentNode.replaceChild(newscript, oldscript);}return false;">导购 
                          - 可米</a></td>
                      </tr>
                      <tr >
                        <td width="14" height="20" ><a href="http://sighttp.qq.com/cgi-bin/check?sigkey=YOUR_QQ_SIGKEY_2"; target=_blank; onclick="var tempSrc='http://sighttp.qq.com/wpa.js?rantime='+Math.random()+'&sigkey=YOUR_QQ_SIGKEY_2';var oldscript=document.getElementById('testJs');var newscript=document.createElement('script');newscript.setAttribute('type','text/javascript'); newscript.setAttribute('id', 'testJs');newscript.setAttribute('src',tempSrc);if(oldscript == null){document.body.appendChild(newscript);}else{oldscript.parentNode.replaceChild(newscript, oldscript);}return false;"><img border="0" SRC='http://wpa.qq.com/pa?p=1:111111:45' alt="请联系我购买"></a></td>
                        <td class="col"><a href="http://sighttp.qq.com/cgi-bin/check?sigkey=YOUR_QQ_SIGKEY_2"; target=_blank; onclick="var tempSrc='http://sighttp.qq.com/wpa.js?rantime='+Math.random()+'&sigkey=YOUR_QQ_SIGKEY_2';var oldscript=document.getElementById('testJs');var newscript=document.createElement('script');newscript.setAttribute('type','text/javascript'); newscript.setAttribute('id', 'testJs');newscript.setAttribute('src',tempSrc);if(oldscript == null){document.body.appendChild(newscript);}else{oldscript.parentNode.replaceChild(newscript, oldscript);}return false;">导购  - 叮叮</a></td>
                      </tr>
                      <tr >
                        <td width="14" height="20" ><a href=" http://sighttp.qq.com/cgi-bin/check?sigkey=YOUR_QQ_SIGKEY_3"; target=_blank; onclick="var tempSrc=' http://sighttp.qq.com/wpa.js?rantime='+Math.random()+'&sigkey=YOUR_QQ_SIGKEY_3';var oldscript=document.getElementById('testJs');var newscript=document.createElement('script');newscript.setAttribute('type','text/javascript'); newscript.setAttribute('id', 'testJs');newscript.setAttribute('src',tempSrc);if(oldscript == null){document.body.appendChild(newscript);}else{oldscript.parentNode.replaceChild(newscript, oldscript);}return false;"><img border="0" SRC=' http://wpa.qq.com/pa?p=1:111111:45' alt=" 请联系我购买"></a></td>
                        <td class="col"><a href=" http://sighttp.qq.com/cgi-bin/check?sigkey=YOUR_QQ_SIGKEY_3"; target=_blank; onclick="var tempSrc=' http://sighttp.qq.com/wpa.js?rantime='+Math.random()+'&sigkey=YOUR_QQ_SIGKEY_3';var oldscript=document.getElementById('testJs');var newscript=document.createElement('script');newscript.setAttribute('type','text/javascript'); newscript.setAttribute('id', 'testJs');newscript.setAttribute('src',tempSrc);if(oldscript == null){document.body.appendChild(newscript);}else{oldscript.parentNode.replaceChild(newscript, oldscript);}return false;">导购  - ViVi</a></td>
                      </tr>
                      <tr >
                        <td width="14" height="20" ><a href="http://sighttp.qq.com/cgi-bin/check?sigkey=YOUR_QQ_SIGKEY_4"; target=_blank; onclick="var tempSrc='http://sighttp.qq.com/wpa.js?rantime='+Math.random()+'&sigkey=YOUR_QQ_SIGKEY_4';var oldscript=document.getElementById('testJs');var newscript=document.createElement('script');newscript.setAttribute('type','text/javascript'); newscript.setAttribute('id', 'testJs');newscript.setAttribute('src',tempSrc);if(oldscript == null){document.body.appendChild(newscript);}else{oldscript.parentNode.replaceChild(newscript, oldscript);}return false;"><img border="0" SRC='http://wpa.qq.com/pa?p=1:111111:45' alt="联系我"></a></td>
                        <td class="col"><a href="http://sighttp.qq.com/cgi-bin/check?sigkey=YOUR_QQ_SIGKEY_4"; target=_blank; onclick="var tempSrc='http://sighttp.qq.com/wpa.js?rantime='+Math.random()+'&sigkey=YOUR_QQ_SIGKEY_4';var oldscript=document.getElementById('testJs');var newscript=document.createElement('script');newscript.setAttribute('type','text/javascript'); newscript.setAttribute('id', 'testJs');newscript.setAttribute('src',tempSrc);if(oldscript == null){document.body.appendChild(newscript);}else{oldscript.parentNode.replaceChild(newscript, oldscript);}return false;">导购  - CoCo</a></td>
                      </tr>
                    </table></td>
                </tr>
                <tr>
                  <td colspan="3">一定呦全国免费客户服务热线：<span style="color:#F00" class="fb">123 456 7890</span></td>
                </tr>
              </table></td>
          </tr>
        </tbody>
      </table>
    </div>
  </div>
</div>
<!--/相册 -->
<!--成功店铺 -->
<div id="photo" style="clear:both">
  <div class="bar">
    <div class="bar-left"></div>
    <div class="bar-right"></div>
  </div>
  <div class="album-ad">
    <div id="table_left" class="album-ad-left">
      <table width="600" border="0" cellpadding="0" cellspacing="0">
        <tr>
          <td width="1%">&nbsp;</td>
          <td width="3%" >&nbsp;</td>
          <td width="52%" class="title"><span class="title">成功店铺</span></td>
          <td width="44%" ><p class="sub-info"><span class="btn" id="btn_pro_prev">&nbsp;</span> <span class="btn" id="btn_pro_next">&nbsp;</span></p></td>
        </tr>
        <tr>
          <td></td>
          <td colspan="3"><div class="pro_list" id="pro_list">
              <ul class="con-product" >
                <li><a href="http://jdajay.taobao.com/" target="_blank"><img src="images/2010/temp/ad1.jpg" width="183" height="117" /></a></li>
                <li><a href="http://jialen.taobao.com/" target="_blank"><img src="images/2010/temp/ad2.gif" width="183" height="117" /></a></li>
                <li><img src="images/2010/temp/ad3.jpg" width="183" height="117" /></li>
                <li><img src="images/2010/temp/ad3.jpg" width="183" height="117" /></li>
                <li><img src="images/2010/temp/ad2.jpg" width="183" height="117" /></li>
                <li><a href="http://jdajay.taobao.com/" target="_blank"><img src="images/2010/temp/ad1.jpg" width="183" height="117" /></a></li>
              </ul>
            </div></td>
        </tr>
      </table>
    </div>
    <div id="table_right" class="album-ad-right">
      <table cellspacing="0" cellpadding="0" style="margin-left: 26px;">
        <tbody>
          <tr>
            <td colspan="2" class="title">动感影集</td>
            <td colspan="1" class="more"></td>
          </tr>
          <tr>
            <td class="v-photo"><div style="position: relative;"> <a target="_blank" href"#"> <img width="142" height="104" onload="setWantSize(this,134,105)" src="images/2010/temp/19108cd14c6c85b5a0ec9c87.gif"> </a> <a target="_blank" title="柏拉图的秋野" href"#"
              class="playIcon"> </a> </div></td>
            <td class="sp"></td>
            <td class="v-photo"><div style="position: relative;"> <a target="_blank" href"#"> <img width="134" height="98" onload="setWantSize(this,134,105)" src="images/2010/temp/46ba386d1f8f63c042169460.jpg"> </a> <a target="_blank" title="双胞胎小美女" href"#"
              class="playIcon"> </a> </div></td>
          </tr>
          <tr>
            <td class="v-name"><a target="_blank" href="#"> 柏拉图的秋野 </a></td>
            <td class="sp"></td>
            <td class="v-name"><a target="_blank" href="#"> 双胞胎小美女 </a></td>
          </tr>
        </tbody>
      </table>
    </div>
    <div class="clearfix"></div>
  </div>
</div>
<!--test -->
 
<!--/test -->
<!--#include file="foot.asp"-->
<!--#include file="online/style1/online.asp"-->
</body>
</html>
