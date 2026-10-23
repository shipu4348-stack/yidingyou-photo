<!--#include file="incs/model.asp"-->
<%
dim s_isreg,s_sid
s_isreg=DBGetValue("Liu_server","isreg"," sid='"&server_id&"'")
s_sid=DBGetValue("Liu_server","sid"," istop=1")

if s_sid<>"0" then 
	response.Redirect "http://up"&s_sid&".1dy.cc/register.asp"
end if
 
if s_isreg="0" then
 response.Write("<script>alert('本站已经停止注册,确定后跳转到其他分站注册!,');location.href='http://up"&s_sid&".1dy.cc/register.asp';</script>")
end if


Action=Checkstr(request("action"))
if Action="reg" then
	mbstyle=Checkstr(Request.Form("mbstyle"))
	if mbstyle="s3" then
		fflx=1
	elseif mbstyle="s4" then
		fflx=2
	end if
	tcid=Replace(Request.Form("tcid"),"’","’’")
	username=Replace(Request.Form("username"),"’","’’")
	pwd=Replace(Request.Form("pwd"),"’","’’")
	email=Replace(Request.Form("email"),"’","’’")
	question=Replace(Request.Form("question"),"’","’’")
	answer=Replace(Request.Form("answer"),"’","’’")
	dpname=Replace(Request.Form("dpname"),"’","’’")
	dplink=Replace(Request.Form("dplink"),"’","’’")
	wwname=Replace(Request.Form("wwname"),"’","’’")
	qqhm=Replace(Request.Form("qqhm"),"’","’’")
	realname=Replace(Request.Form("realname"),"’","’’")
	phone=Replace(Request.Form("phone"),"’","’’")
	card=Replace(Request.Form("card"),"’","’’")
	password1=md5(pwd,"long")
	password2=SerUPassEnCode(pwd)
	CountBytes=conn.execute("select comsize from [ydy_combo] where id="&tcid&"")(0)	
	if GetIsNull(username) then
		response.Write("<script>alert('用户名不能为空');location.href='index.asp';</script>")
		response.End()
	end if
	Set Fso=new dmfso
	NewFolderPath = "/datafiles/Users/"& username
	If not Fso.CheckFolder(NewFolderPath) then
		if Fso.CreateFolder(NewFolderPath) then
			set rs=server.CreateObject("adodb.recordset")
			sql="select [fflx],[tcid],[username],[pwd],[ftppwd],[email],[question],[answer],[addtime],[jfrq],[dpname],[dplink],[wwname],[qqhm],[xingming],[phone],[card],[CountBytes],[UsedBytes],[ResBytes],[isftp],[sid] from [Liu_User] where username='"&username&"'"
			rs.open sql,conn,1,3
			if rs.eof and rs.bof then
			rs.addnew
			rs("fflx")=fflx
			rs("tcid")=tcid
			rs("username")=username
			rs("pwd")=password1
			rs("ftppwd")=password2
			rs("email")=email
			rs("question")=question
			rs("answer")=answer
			rs("addtime")=now()
			rs("jfrq")=now()+regday
			rs("dpname")=dpname
			rs("dplink")=dplink
			rs("wwname")=wwname
			rs("qqhm")=qqhm
			rs("xingming")=realname
			rs("phone")=phone
			rs("card")=card
			rs("CountBytes")=CountBytes
			rs("ResBytes")=CountBytes
			rs("UsedBytes")=0
			rs("isftp")=0
			rs("sid")=s_sid
			rs.update
			end if
			rs.close
			set rs=nothing
			
		end if
	end if			
	response.Write("<script>alert('注册成功,您有7天的试用时间!');location.href='index.asp';</script>")
end if			
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<HEAD><TITLE>一定呦 - 网络图片存储系统 www.1dy.cc - 用户注册</TITLE>
<META http-equiv=Content-Type content="text/html; charset=gb2312">
 
<link href="images/2010/Global.css" type="text/css" rel="stylesheet"/>
<link href="images/2010/top_bar.css?tm=20100709" rel="stylesheet" type="text/css"/>
<link href="images/2010/main.css" type="text/css" rel="stylesheet"/>
<link href="images/2010/login.css" type="text/css" rel="stylesheet"/>
<script src="js/jquery-1.4.2.min.js" type="text/javascript"></script>

<SCRIPT language=JavaScript src="js/reg.js"></SCRIPT>
<BODY>
<a name="top"></a>
<!--topbar-->
<!--#include File="top.asp"-->
<!--/topbar-->
<CENTER>
 
<DIV class="wrapper" style="margin-top:10px;">
<DIV class=cont>
<H4>1、选择空间类型</H4>
</DIV><FORM class="bdy" id="regForm" name="regform" method="post" >

<TABLE cellSpacing=0 cellPadding=0 width=860 border=0>
  <TBODY>
  <TR>
    <TD align=left>
      <DIV class=d_fl>
      <UL>
        <LI>
<!--<INPUT  onfocus=this.blur(); onclick=mailTypeChk();chgmtBg(0); type=radio CHECKED value="1" name="fflx" id="fflx">-->
<input type="radio" name="mbstyle" value="s3" id="mtype_1" checked="checked" onClick="mailTypeChk();chgmtBg(0);" onFocus="this.blur();" />
<LABEL class="chked" for="mtype_1">无限通 - 年付型</LABEL> </LI>
        <LI>
<!--<INPUT onfocus=this.blur(); onclick=mailTypeChk();chgmtBg(1); type=radio value="2" name="fflx" id="fflx">-->
<input type="radio" name="mbstyle" value="s4" id="mtype_2" onClick="mailTypeChk();chgmtBg(1)" onFocus="this.blur();" />
<LABEL class="chk" for="mtype_2">无限通 - 月付型</LABEL></LI>
	   </UL>
       <DIV class=hotTopic></DIV>
	 </DIV>
	</TD>
    <TD align=left>
      <DIV class=d_fr>
      <DIV id=dfr1></DIV>
      <DIV class=dfr2 id=mtDesc1>
	  
<%
	set rs_1=server.createobject("adodb.recordset")
	rs_1.open "select * from ydy_combo where comkind=1 order by comprice asc",conn,1,1
	do while not rs_1.eof
	tcid=rs_1("id")
	kjdx=rs_1("comsize")
	jg=rs_1("comprice")
%>
        <LI><INPUT onclick=javascript:selfid=1; type=radio value="<%=tcid%>" name="tcid">
        <%=FormatFileSize(kjdx)%>/￥<%=jg%>/年 </LI>
<%
	rs_1.movenext
	loop
	rs_1.close
	set rs_1=nothing
%>
	  </DIV>
      
      <DIV class="dfr2 hidden" id=mtDesc2>
	  
<%
	set rs_1=server.createobject("adodb.recordset")
	rs_1.open "select * from ydy_combo where comkind=2 order by  comprice asc",conn,1,1
	do while not rs_1.eof
	tcid=rs_1("id")
	kjdx=rs_1("comsize")
	jg=rs_1("comprice")
%>
        <LI><INPUT onclick=javascript:selfid=1; type=radio value="<%=tcid%>" name="tcid">
        <%=FormatFileSize(kjdx)%>/￥<%=jg%>/月 </LI>
<%
	rs_1.movenext
	loop
	rs_1.close
	set rs_1=nothing
%>
		</DIV>
	 
	   
	   </DIV>
       
       </TD></TR></TBODY></TABLE>
 
<DIV class=cont>
<H4>2、填写注册信息</H4></DIV>

<TABLE cellSpacing=0 cellPadding=3 width=860 border=0>
  <TBODY>
  <TR>
    <TD class=h5 colSpan=3><B>(1) 选择用户名</B>（以下信息为必填项）</TD></TR>
  <TR>
    <TD align=right width=232>* 用户名：</TD>
    <TD align=left width=190><INPUT class="loginput" id="textfield" onblur="checkusername();" name="username"></TD>
    <TD id=info_username align=left>用户名只能由英文字母、数字和下划线（_）组成</TD></TR>
  <TR>
    <TD align=right>* 密码：</TD>
    <TD align=left><INPUT class=loginput id=textfield2 type=password 
    name=pwd></TD>
    <TD id=info_pwd align=left>密码只能由英文字母和数字组成</TD></TR>
  <TR>
    <TD align=right>* 确认密码：</TD>
    <TD align=left><INPUT class=loginput id=textfield3 onblur=checkpassword(); 
      type=password name=confirmpwd></TD>
    <TD id=info_confirmpwd align=left>确认重复输入上面的密码</TD></TR></TBODY></TABLE>
<TABLE cellSpacing=0 cellPadding=3 width=860 border=0>
  <TBODY>
  <TR>
    <TD class=h5 colSpan=3><B>(2) 密码保护设置</B>（以下信息必填项对保证您的帐号安全极为重要）</TD></TR>
  <TR>
    <TD align=right width=232>* 常用邮箱：</TD>
    <TD align=left width=190>
	<INPUT class=loginput id="textfield4" onblur=checkAltEmail(); name=email></TD>
    <TD id=info_email align=left>万一您遇到问题或忘记密码，可通过此邮箱联系取回</TD></TR>
	<TR>
    <TD align=right width=232>* 密码提示问题：</TD>
    <TD align=left width=190>
	<select name=question id="question">
		<option value="您的家乡是?"> 您的家乡是? </option>
		<option value="您初中的语文老师是?"> 您初中的语文老师是? </option>
		<option value="您最尊重的人是?"> 您最尊重的人是? </option>
		<option value="您最爱吃的菜是?"> 您最爱吃的菜是? </option>
		<option value="您最爱读的书是?"> 您最爱读的书是? </option>
		<option value="您最喜欢的一首歌是?"> 您最喜欢的一首歌是? </option>
		<option value="您最喜欢的运动是?"> 您最喜欢的运动是? </option>
		<option value="您最喜欢的电影是?"> 您最喜欢的电影是? </option>
		<option value="您最喜欢的节日是?"> 您最喜欢的节日是? </option>
		<option value="您最想去的地方是?"> 您最想去的地方是? </option>
		<option value="您最想做的事情是?"> 您最想做的事情是? </option>
		<option value="您最难忘的事情是?"> 您最难忘的事情是? </option>
	</select>
	</TD>
    <TD align=left></TD></TR>
	<TR>
    <TD align=right width=232>* 答案：</TD>
    <TD align=left width=190>
	<INPUT class=loginput id="answer" onBlur="checkanswer();" name=answer></TD>
    <TD id=info_answer align=left>密码保护问题答案,注意不能包含'%'和'&'</TD></TR>
  </TBODY></TABLE>
  
  <TABLE cellSpacing=0 cellPadding=3 width=860 border=0>
  <TBODY>
  <TR>
    <TD align=right width=232>高级选项：</TD>
    <TD align=left width=178><INPUT id="checkbox2" type="checkbox" onclick="ShowSelectIn();" name="checkbox2"></TD>
    <TD width="432" align=left>&nbsp;</TD>
  </TR>
  </TBODY>
  </TABLE>
  
 <div id="SelectIn" style="display:none;">
<TABLE cellSpacing=0 cellPadding=3 width=860 border=0>
  <TBODY>
  <TR>
    <TD class=h5 colSpan=3><B>(3) 店铺信息及推荐活动</B>（以下信息可选填项，建议正确填写）</TD></TR>
  <TR>
    <TD align=right width=232>店铺名称：</TD>
    <TD align=left width=178><INPUT class=loginput 
    name=dpname></TD>
    <TD width="432" align=left id=info_dpname>&nbsp;</TD>
  </TR>
	
  <TR>
    <TD align=right width=232>店铺链接：</TD>
    <TD align=left width=178><INPUT class=loginput 
    name=dplink></TD>
    <TD id=info_dpname align=left>&nbsp;</TD></TR>
  <TR>
    <TD align=right>旺旺ID：</TD>
    <TD align=left><INPUT class=loginput  name=wwname></TD>
    <TD align=left>
      </TD>
  </TR>
  <TR>
    <TD align=right>QQ号码：</TD>
    <TD align=left><INPUT class=loginput  name=qqhm></TD>
    <TD align=left>&nbsp;</TD></TR>
	
	</TBODY></TABLE>
<TABLE cellSpacing=0 cellPadding=3 width=860 border=0>
<TBODY>
<TR>
<TD class=h5 colSpan=3><B>(4) 个人基本信息</B>（以下信息可选填项，建议正确填写）</TD></TR>
<TR>
<TD align=right width=232>真实姓名：</TD>
<TD align=left width=178><INPUT class=loginput 
name=realname></TD>
<TD width="432" align=left id=info_dpname>&nbsp;</TD>
</TR>

<TR>
<TD align=right width=232>手机号：</TD>
<TD align=left width=178><INPUT class=loginput 
name=phone></TD>
<TD id=info_dpname align=left>&nbsp;</TD></TR>
<TR>
<TD align=right>身份证号：</TD>
<TD align=left><INPUT class=loginput  name=card></TD>
<TD align=left>
  </TD>
</TR>

</TBODY></TABLE>
</div>
<TABLE cellSpacing=0 cellPadding=3 width=860 border=0>
  <TBODY>
  <TR>
    <TD class=h5 colSpan=2><B>(5) 注册确认</B>（请阅读服务协议条款并输入正确验证码提交完成注册）</TD></TR>
  <TR>
    <TD align=right width=232>* 验证码：</TD>
    <TD align=left>
      <table border="0" cellpadding="0" cellspacing="0" >
      <tr><td width="51">
          <input class="loginput" style="width:40px;" name=verify type=text onkeydown="if(event.keyCode==13){return checkform();}" onblur="checkverify();" value="<%If GetCode=9999 Then Response.Write "9999"%>" maxLength=4 size=5 tabindex="3" >          
          </TD>
          <TD vAlign="bottom" width=66>
          <table cellpadding="0" cellspacing="0" bgcolor="#ffffff" style="border: 1px solid #b9b9b9; width:50px; height:24px;"><tr><td align="center">
          <img src=GetCode.asp width="40" height="10" border="0" style="cursor:pointer" 
alt="点击刷新获取有效验证码" onclick="this.src=this.src+'?'" align="absmiddle">
          </td></tr></table>
				</TD>
          <TD><SPAN id=info_verify></SPAN></TD></TR></TBODY></TABLE></TD></TR>
  <TR>
    <TD align=right>* 服务条款确认：</TD>
    <TD align=left><INPUT id="checkbox" type="checkbox" CHECKED name="checkbox"> 
      我已经阅读并接受“一定呦服务条款”</TD></TR>
  <TR>
    <TD align=middle colSpan=2 height=60>
    <INPUT class="register_b" type="button" onclick="return checkform();" value="同意以下服务条款，提交注册信息" name="Submit" <%if Isreg=1 then response.Write("disabled='false'") end if%>></TD></TR></TBODY></TABLE>
	</FORM>
	</DIV>
<TABLE cellSpacing=0 cellPadding=0 width=876 border=0>
  <TBODY>
  <TR>
    <TD height=30><IMG height=1 src="images/0046.gif" 
  width=850></TD></TR>
  <TR>
    <TD>
      <DIV class=cont>
      <H4>阅读一定呦存储平台服务协议</H4>
      </DIV></TD></TR>
  <TR>
    <TD>
		<%
		set rs=server.createobject("adodb.recordset")
		rs.open "select top 1 [content] from ydy_info where id=1",conn,1,1
		if rs.eof or rs.bof then
		response.write "请在后台添加内容"
		else
			response.write rs("content")
		end if
		%>
	  </TD></TR></TBODY></TABLE>
<TABLE cellSpacing=0 cellPadding=0 width=850 border=0>
  <TBODY>
  <TR>
    <TD vAlign=bottom height=10><IMG height=1 src="images/0046.gif" 
      width=850></TD></TR>
  <TR>
    <TD height=40><%=banquan%></TD>
  </TR></TBODY></TABLE>
</CENTER></BODY></HTML>
