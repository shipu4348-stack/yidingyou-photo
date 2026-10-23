<!--#include file="./incs/model.asp"-->
<%
	call stopsql()
	dim UserName
	UserName=trim(request.QueryString("kname"))
	if UserName="" and Isempty(UserName) and IsNull(UserName) then
		response.Write("<script>alert('参数错误!');window.close();</script>")
		response.End()
	end if
	set rs=server.CreateObject("adodb.recordset")
	rs.open "select top 1 [username],[yjf] from [Liu_User] where username='"&UserName&"'",conn,1,1
	if rs.eof or rs.bof then
		response.Write("<script>alert('参数错误!');window.close();</script>")
		response.End()
	else
		if rs("yjf")=0 then
			Response.Cookies("1dy")("yjf2")=rs("yjf")
		else
			Response.Cookies("1dy")("yjf2")=rs("yjf")
			Response.Cookies("1dy")("PhotoName")=rs("username")
		end if
	end if
	rs.close
	set rs=nothing
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
<title>我的一定呦相册- 网络图片存储系统 www.1dy.cc</title>
<link rel="stylesheet" type="text/css" href="css/Photo.css"/>
<script type="text/javascript" src="js/Photo.js"></script>
<script type="text/javascript">
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
</head>

<body>
<div id="box">
	<div id="head">
    	<div class="logo"><div style="background:url(images/2010/LOGO.gif);  height:82px; width:176px;" ></div></div>
        <div class="NavList">我的相册</div>
        <div class="UserNav">
        	<%if request.cookies("1dy")("UserName")<>"" then%>
        	<%=request.cookies("1dy")("PhotoName")%>的相册&nbsp;|
            <%end if%>
            <a href="home.asp" target="_self">我的一定呦</a>|<a href="pay.asp" target="_self">缴费中心</a>|<a href="UserMessage.asp" target="_self">纸条箱</a>
            <%if request.cookies("1dy")("UserName")<>"" then%>
        	|<a href="javascript:void(0)" onClick="JuBao();">举报不良信息</a>
            <%end if%>
        </div>
    </div>
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
    <span class="ggclose" onClick="GongGao.style.display='none'"><img src="images/photo/ggclose.gif"></span>
    </div>
    <script>
var c,_=Function;
with(o=document.getElementById("div1")){ innerHTML+=innerHTML; onmouseover=_("c=1"); onmouseout=_("c=0");}
(F=_("if(#%18||!c)#++,#%=o.scrollHeight>>1;setTimeout(F,#%18?10:1500);".replace(/#/g,"o.scrollTop")))();
</script>
    <div id="pageinfotop"></div>
    <div id="Photo"></div>
    <div id="pageinfobottom"></div>
<div id="bottom">
Copyright &copy; 2009 一定呦版权所有
    </div>
</div>
<div id="login0" style="width:400px; position: absolute;z-index: 100; border: 1px solid #333333; background-color:#eeeeee; display:none;">
	<table border="0" cellspacing="0" cellpadding="0" width="100%" >
  <tr>
    <td style="padding-right:10px; text-align:right;" ><img style="cursor:hand;" onClick="window.location='pay.asp';" src="images/0043.gif" width="32" height="30" /></td>
  </tr>
  <tr>
    <td style="padding:10px;"><table width="100%" border="0" cellspacing="0" cellpadding="0" style="border: 1px solid #aaaaaa; background-color:#ffffff">
      <tr>
        <td  style="background: url(images/0064.png) no-repeat center center; height: 138px; width: 134px;"></td>
        <td style="line-height:150%; padding-right:10px; padding-top:10px; font-size:12px;" valign="top">亲爱的<%=request.cookies("1dy")("UserName")%>您好：<br />您的帐户尚未付费，请去交费后使用。感谢您的支持与关注。</td>
      </tr>
    </table></td>
  </tr>
</table>
</div>

<div id="JuBao" style="width:442px; height:238px; padding:4px; border:1px solid #3266CC; background-color:#BED5FF; position:absolute; z-index:100; display:none;">
	<div class="title">
    	<b>举报不良信息</b>
        <span onClick="JuBao();"><img src="images/photo/close.gif"></span>
    </div>
    <div class="content">
    	<span class="desp">反馈内容：</span><textarea name="Buling" id="Buliang" onKeyDown="checkMaxInput(this)" onKeyUp="checkMaxInput(this)" onBlur="checkMaxInput(this)"></textarea>
        <span class="wenzi">(<span  id="remLen4">400</span><span id="remLen5">/</span><span id="remLen3">400</span><span id="remLen1"></span><span id="remLen2"></span>字以内)</span>
        <span class="anniu"><input type="button" name="tijiao" onClick="ComfireJuBao()" value="提  交">&nbsp;<input type="button" name="cancle" onClick="JuBao()" value="取  消"></span>
    </div>
</div>

<div style="position: absolute; width: 100%; height: 100%; z-index: 1; left: 0px; top: 0px; background-color:black;filter:alpha(opacity=70);opacity:0.7; display:none;" id="fugai_layout">
&nbsp;<iframe src="javascript:false" style="position:absolute;visibility:visible;top:0px; left:-1px; width:100%; height:100%; z-index:2; filter='progid:DXImageTransform.Microsoft.Alpha(style=0,opacity=0)';"></iframe></div>

<div style="position: absolute; width: 100%; height: 100%; z-index: 1; left: 0px; top: 0px; background-color:#CCC;filter:alpha(opacity=40);opacity:0.7; display:none;" id="JuBao_layout">
&nbsp;<iframe src="javascript:false" style="position:absolute;visibility:visible;top:0px; left:-1px; width:100%; height:100%; z-index:3; filter='progid:DXImageTransform.Microsoft.Alpha(style=0,opacity=0)';"></iframe></div>
<%
	if request.Cookies("1dy")("yjf2")=0 then
	response.Write "<script language='javascript'>"
	response.Write "document.getElementById('fugai_layout').style.display='';"
	response.Write "document.getElementById('login0').style.display='';"
	response.Write "document.getElementById('login0').style.left=(document.body.clientWidth/2)-(document.getElementById('login0').offsetWidth/2)+'px';"
	response.Write "document.getElementById('login0').style.top=(document.body.clientHeight/2)-(document.getElementById('login0').offsetHeight/2)+'px';"
	response.write "</script>"
	end if
%>
<script>
	ShowPhoto(1);
	ShowPhotoPage(1);
</script>
</body>
</html>
