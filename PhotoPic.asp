<!--#include file="./incs/model.asp"-->
<%
	call stopsql()
	kid=int(request.QueryString("kid"))
	UserName=trim(request.QueryString("kname"))
	if UserName="" and Isempty(UserName) and IsNull(UserName) then
		if request.cookies("1dy")("UserName")<>"" then	
			UserName=request.cookies("1dy")("UserName")
		else
			response.Write("<script>alert('地址不存在!');location.href='index.asp';</script>")
			response.End()
		end if
	end if
	set rs=server.CreateObject("adodb.recordset")
	rs.open "select [kid] from [Liu_Folder] where IsPhoto=1 and  kuser='"&UserName&"' order by kid desc",conn,1,1
	if not rs.eof and not rs.bof then
		dim SelectPhoto
		for i=0 to rs.recordcount-1
			if id=rs("kid") then
				SelectPhoto=i
			end if
		rs.movenext
		next
	end if
	rs.close
	set rs=nothing
	
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
<meta http-equiv="x-ua-compatible" content="ie=7"/>
<title>我的一定呦相册- 网络图片存储系统 www.1dy.cc</title>
<link rel="stylesheet" type="text/css" href="css/Photo.css"/>
<link href="images/2010/Global.css" type="text/css" rel="stylesheet"/>
<link rel="stylesheet" type="text/css" href="images/2010/top_bar.css" />
<script type="text/javascript" src="js/Photo.js"></script>
<script type="text/javascript" src="js/PhotoPic.js"></script>
<SCRIPT LANGUAGE="JavaScript">
<!--
  var maxLen=400;
   function checkMaxInput(obj)
     {
       var m=obj.value.length;
       var n=m;
       var j=0;
  
        for (var i=0;i<m;i++)
         {
          if (obj.value.charCodeAt(i)<0||obj.value.charCodeAt(i)>361)
    { 
            n=n+1;
            if ( i < 300 )
     {
               j=j+1;
            }
    }
         }
  
        if(n>maxLen)
         {  
            obj.value=obj.value.substring(0,maxLen-j);
   
            remLen1.innerText='';
            remLen2.innerText=maxLen;
         remLen3.innerText='/';
         remLen4.innerText='0';
         remLen5.innerText='';
          }
        else
          {
      remLen1.innerText='';
            remLen2.innerText=maxLen;
         remLen3.innerText='/';
         remLen4.innerText=maxLen-n;
         remLen5.innerText='';
     }
     }   
//-->
</SCRIPT>
<style  type="text/css">
body {
	background:transparent url(images/2010/body_bg.gif) repeat-x scroll left 36px
}
</style>
</head>
<body>
<a name="top"></a>
<!--topbar-->
<!--#include file="top_main.asp"-->
<!--/topbar-->
<div id="box">
  <div id="GongGao">
    <div class="shell">
      <div id="div1">
        <%
			set rs=server.CreateObject("adodb.recordset")
			rs.open "select top 5 * from ydy_notice where charindex('2',kind)>0 order by istop desc,id desc",conn,1,1
			if rs.eof or rs.bof then
			response.Write("<li><span>[公告]</span><a href='javascript:void(0);'>暂无公告</a></li>")
			else
				do while not rs.eof
				response.write "<li><span>[公告]</span><a href='gonggao.asp?id="&rs("id")&"'>"&rs("title")&"</a></li>"
				rs.movenext
				loop
			end if
			rs.close
			set rs=nothing         
		%>
      </div>
    </div>
    <span class="ggclose" onClick="GongGao.style.display='none'"><img src="images/photo/ggclose.gif"></span> </div>
  <script>
var c,_=Function;
with(o=document.getElementById("div1")){ innerHTML+=innerHTML; onmouseover=_("c=1"); onmouseout=_("c=0");}
(F=_("if(#%18||!c)#++,#%=o.scrollHeight>>1;setTimeout(F,#%18?10:1500);".replace(/#/g,"o.scrollTop")))();
</script>
  <div class="boxleft">
    <div class="PhotoLeft">
      <div class="PhotoAll"><a href="Photo.asp?kname=<%=UserName%>">所有相册</a></div>
      <A class="LeftBotton" id="ISLTop" onclick="ISL_GoUp_1()" hidefocus="true" href="javascript:void(0);"></A>
      <div class="pcont" id="ISL_Cont_1">
        <div class="ScrCont">
          <div id="List1_1"></div>
        </div>
      </div>
      <A class="RightBotton" id="ISLBottom" onclick="ISL_GoDown_1()" hidefocus="true" href="javascript:void(0);"></A>
      <div class="PhotoAll"><a href="Photo.asp?kname=<%=UserName%>">所有相册</a></div>
    </div>
  </div>
  <div class="boxright">
    <div id="Phototitle" ></div>
    <div id="pagebox">
      <div id="pageinfotop"></div>
    </div>
    <div id="PhotoPicList"></div>
    <div id="pagebox">
      <div id="pageinfobottom"></div>
    </div>
  </div>
  <div id="bottom"> <span style="font-family: Geneva, Arial, Helvetica,sans-serif; font-size:12px"><a href="http://#/" target="_blank">车车写代码</a>旗下网站｜一定呦版权所有 &copy; 2010<br />
    官方业务咨询：<a href="http://sighttp.qq.com/cgi-bin/check?sigkey="; target=_blank; onclick="var tempSrc='http://sighttp.qq.com/wpa.js?rantime='+Math.random()+'&sigkey=';var oldscript=document.getElementById('testJs');var newscript=document.createElement('script');newscript.setAttribute('type','text/javascript'); newscript.setAttribute('id', 'testJs');newscript.setAttribute('src',tempSrc);if(oldscript == null){document.body.appendChild(newscript);}else{oldscript.parentNode.replaceChild(newscript, oldscript);}return false;"><font color="#000000"><u>QQ:111111(YOUR_WANGWANG_NICK)</u></font></a>&nbsp;<a href="http://sighttp.qq.com/cgi-bin/check?sigkey="; target=_blank; onclick="var tempSrc='http://sighttp.qq.com/wpa.js?rantime='+Math.random()+'&sigkey=';var oldscript=document.getElementById('testJs');var newscript=document.createElement('script');newscript.setAttribute('type','text/javascript'); newscript.setAttribute('id', 'testJs');newscript.setAttribute('src',tempSrc);if(oldscript == null){document.body.appendChild(newscript);}else{oldscript.parentNode.replaceChild(newscript, oldscript);}return false;"><font color="#000000"><u>QQ:111111(叮叮)</u></font></a>&nbsp;<a href=" http://sighttp.qq.com/cgi-bin/check?sigkey="; target=_blank; onclick="var tempSrc=' http://sighttp.qq.com/wpa.js?rantime='+Math.random()+'&sigkey=';var oldscript=document.getElementById('testJs');var newscript=document.createElement('script');newscript.setAttribute('type','text/javascript'); newscript.setAttribute('id', 'testJs');newscript.setAttribute('src',tempSrc);if(oldscript == null){document.body.appendChild(newscript);}else{oldscript.parentNode.replaceChild(newscript, oldscript);}return false;"><font color="#000000"><u>QQ:111111(ViVi)</u></font></a>&nbsp;<a href="http://sighttp.qq.com/cgi-bin/check?sigkey="; target=_blank; onclick="var tempSrc='http://sighttp.qq.com/wpa.js?rantime='+Math.random()+'&sigkey=';var oldscript=document.getElementById('testJs');var newscript=document.createElement('script');newscript.setAttribute('type','text/javascript'); newscript.setAttribute('id', 'testJs');newscript.setAttribute('src',tempSrc);if(oldscript == null){document.body.appendChild(newscript);}else{oldscript.parentNode.replaceChild(newscript, oldscript);}return false;"><font color="#000000"><u>QQ:111111(CoCo)</u></font></a><font color="#000000"><u><br />
    </u></font></a>
    <!--汇款底单:Email:YOUR_EMAIL@qq.com
            <a href="http://www.bizcn.com/_default/icp.jsp" target="_blank"><font color="#000000">《中华人民共和国电信与信息服务业务》经营许可证</font></a>-->
    &nbsp; <a href="http://www.miibeian.gov.cn/" target="_blank"><font color="#000000">网站备案号：豫ICP备12345678号</font></a> </span> </div>
</div>
<div id="login0" style="width:400px; position: absolute;z-index: 100; border: 1px solid #333333; background-color:#eeeeee; display:none;">
  <table border="0" cellspacing="0" cellpadding="0" width="100%" >
    <tr>
      <td style="padding-right:10px; text-align:right;" ><img style="cursor:hand;" onClick="window.location='index.asp';" src="images/0043.gif" width="32" height="30" /></td>
    </tr>
    <tr>
      <td style="padding:10px;"><table width="100%" border="0" cellspacing="0" cellpadding="0" style="border: 1px solid #aaaaaa; background-color:#ffffff">
          <tr>
            <td  style="background: url(images/0064.png) no-repeat center center; height: 138px; width: 134px;"></td>
            <td style="line-height:150%; padding-right:10px; padding-top:10px; font-size:12px; text-align:left;" valign="top">亲爱的<%=UserName%>您好：<br />
              您的帐户尚未付费，请去交费后使用。感谢您的支持与关注。</td>
          </tr>
        </table></td>
    </tr>
  </table>
</div>
<div id="JuBao" class="JuBao" style="width:442px; height:238px; padding:4px; border:1px solid #3266CC; background-color:#BED5FF; position:absolute; z-index:100; display:none;">
  <div class="title"> <b>举报不良信息</b> <span onClick="JuBao('JuBao');"><img src="images/photo/close.gif"></span> </div>
  <div class="content"> <span class="desp">反馈内容：</span>
    <textarea name="Buling" id="Buliang" onKeyDown="checkMaxInput(this)" onKeyUp="checkMaxInput(this)" onBlur="checkMaxInput(this)"></textarea>
    <span class="wenzi">(<span  id="remLen4">400</span><span id="remLen5">/</span><span id="remLen3">400</span><span id="remLen1"></span><span id="remLen2"></span>字以内)</span> <span class="anniu">
    <input type="button" class="inputbutton" name="tijiao" onClick="ComfireJuBao()" value="提  交">
    &nbsp;
    <input type="button" class="inputbutton" name="cancle" onClick="JuBao('JuBao')" value="取  消">
    </span> </div>
</div>
<div id="SetOpen" class="JuBao" style="width:300px; height:238px; padding:4px; border:1px solid #3266CC; background-color:#BED5FF; position:absolute; z-index:100; display:none;">
  <div class="title"><b>更新相册</b><span onClick="JuBao('SetOpen');"><img src="images/photo/close.gif"></span> </div>
  <div id="ShowPhotoOpen" class="content"></div>
</div>
<div id="CheckOpen" class="JuBao" style="width:300px; height:150px; padding:4px; border:1px solid #3266CC; background-color:#BED5FF; position:absolute; z-index:100; display:none;">
  <div class="title"><b>输入密码</b><span onClick="JuBao('CheckOpen');"><img src="images/photo/close.gif"></span> </div>
  <div id="CheckPhotoOpen" class="content2"></div>
</div>
<div style="position: absolute; width: 100%; height: 100%; z-index: 1; left: 0px; top: 0px; background-color:#CCC;filter:alpha(opacity=40);opacity:0.7; display:none;" id="JuBao_layout"> &nbsp;
  <iframe src="javascript:false" style="position:absolute;visibility:visible;top:0px; left:-1px; width:100%; height:100%; z-index:3; filter='progid:DXImageTransform.Microsoft.Alpha(style=0,opacity=0)';"></iframe>
</div>
<SCRIPT type=text/javascript>
IsPay('<%=UserName%>');
ShowPhotoPic('<%=UserName%>',<%=kid%>);
PhotoInit(<%=SelectPhoto%>);
ShowPhotoName('<%=UserName%>',<%=kid%>);
ShowPicList('<%=UserName%>',<%=kid%>,1);
ShowPicPage('<%=UserName%>',<%=kid%>,1);

</SCRIPT>
</body>
</html>
