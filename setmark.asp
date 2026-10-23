<!--#include file="./incs/SysCode.asp"-->
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<title>水印设置</title>
<link rel="stylesheet" type="text/css" media="all" href="css/setting.css" />
<script type="text/javascript">
function GetColor(img_val,input_val)
{
	var obj = document.getElementById("colourPalette");
	ColorImg = img_val;
	ColorValue = document.getElementById(input_val);
	if (obj){
	obj.style.left = getOffsetLeft(ColorImg) + "px";
	obj.style.top = (getOffsetTop(ColorImg) + ColorImg.offsetHeight) + "px";
	if (obj.style.visibility=="hidden")
	{
	obj.style.visibility="visible";
	}else {
	obj.style.visibility="hidden";
	}
	}
}
function getOffsetTop(elm) {
	var mOffsetTop = elm.offsetTop;
	var mOffsetParent = elm.offsetParent;
	while(mOffsetParent){
		mOffsetTop += mOffsetParent.offsetTop;
		mOffsetParent = mOffsetParent.offsetParent;
	}
	return mOffsetTop;
}
function getOffsetLeft(elm) {
	var mOffsetLeft = elm.offsetLeft;
	var mOffsetParent = elm.offsetParent;
	while(mOffsetParent) {
		mOffsetLeft += mOffsetParent.offsetLeft;
		mOffsetParent = mOffsetParent.offsetParent;
	}
	return mOffsetLeft;
}
function setColor(color)
{
	if (ColorValue){ColorValue.value = color;}
	if (ColorImg){ColorImg.style.backgroundColor = color;}
	document.getElementById("colourPalette").style.visibility="hidden";
}
</script>
</head>

<body>
<%
Dim Action
Action=Request("Action")
If Action="" Then
%>
<table width="100%" border="0" cellpadding="0" cellspacing="0">
  <tr>
    <td height="40" valign="bottom" background="images/0018.gif" class="em">系统设置</td>
  </tr>
  <tr>
    <td height="1" bgcolor="#c6c6c6"></td>
  </tr>
</table>
<ul id="sets_nav">
	<li id="first"><a href="setsys.asp">个人喜好设置</a></li>
	<li class="inpos"><a href="setmark.asp">水印设置</a></li>
    <li><a href="setacinfo.asp">帐户信息</a></li>
	<li><a href="setpass.asp">密码修改</a></li>
	<li><a href="setoth.asp">帮助中心</a></li>
</ul><br />
<form id="form1" name="form1" method="post" action="setmark.asp?action=save" target="UPresult">
<table width="100%" border="0" cellspacing="0" cellpadding="0">
    <tr>
    <td height="32" background="images/0025.gif"><span class="itemlist"><b>水印公共设置选项</b></span></td>
  </tr>
    <tr>
    <td bgcolor="#fafafa" class="itemlist">水印位置设置 
 &nbsp; 
<a href="javascript:void(0)"><img src="images/0026.gif" width="14" height="14" border="0" /></a>
	</td>
  </tr>
  <tr>
    <td class="itemlist">
	<input type="radio" name="DrawPlace" id="radio" <%If MarkPlace=2 Then response.Write("checked")%> value="2" />居中
	<input type="radio" name="DrawPlace" id="radio2" <%If MarkPlace=0 Then response.Write("checked")%> value="0"/>左上 
	<input type="radio" name="DrawPlace" id="radio3" <%If MarkPlace=1 Then response.Write("checked")%> value="1" />左下 
	<input type="radio" name="DrawPlace" id="radio4" <%If MarkPlace=3 Then response.Write("checked")%> value="3" />右上 
	<input type="radio" name="DrawPlace" id="radio5" <%If MarkPlace=4 Then response.Write("checked")%> value="4" /> 右下
</td>
  </tr>
    <tr>
    <td height="32" background="images/0025.gif"><span class="itemlist"><b><b>水印</b>文字设置选项</b></span></td>
  </tr>
      <tr>
    <td bgcolor="#fafafa" class="itemlist">文字内容设置  
      <input name="DrawTextStr" type="text" class="text" id="DrawTextStr" size="40" maxlength="30" value="<%=MarkFontStr%>">
 &nbsp; 
</td>
  </tr>
      <tr>
        <td class="itemlist">文字颜色设置 
          <input type="text" class="text" name="DrawFontColor" maxlength="7" size="7" id="DrawFontColor" value="<%=MarkFontColor%>" /> <img border="0" src="images/0027.gif" width="21" height="21" id="MarkFontColorShow" align="absmiddle" style="cursor:pointer; background-Color:<%=MarkFontColor%>;" onClick="GetColor(this,'DrawFontColor');" title="选取颜色" /> 
&nbsp; 
<a href="javascript:void(0)"><img src="images/0026.gif" width="14" height="14" border="0" /></a>
</td>
  </tr>
      <tr>
        <td bgcolor="#fafafa" class="itemlist">文字字体设置 
          <select name="DrawFont" id="DrawFont" size="1">
            <option value="宋体" <%If MarkFont="宋体" Then response.write("selected")%>>宋体</option>
      <option value="楷体_GB2312" <%If MarkFont="楷体_GB2312" Then response.write("selected")%>>楷体</option>
      <option value="新宋体" <%If MarkFont="新宋体" Then response.write("selected")%>>新宋体</option>
      <option value="黑体" <%If MarkFont="黑体" Then response.write("selected")%>>黑体</option>
      <option value="隶书" <%If MarkFont="隶书" Then response.write("selected")%>>隶书</option>
      <option value="Arial" <%If MarkFont="Arial" Then response.write("selected")%>>Arial</option>
      <option value="Georgia" <%If MarkFont="Georgia" Then response.write("selected")%>>Georgia</option>
      <option value="Impact" <%If MarkFont="Impact" Then response.write("selected")%>>Impact</option>
      <option value="Tahoma" <%If MarkFont="Tahoma" Then response.write("selected")%>>Tahoma</option>
      <option value="Stencil" <%If MarkFont="Stencil" Then response.write("selected")%>>Stencil</option>
      <option value="Verdana" <%If MarkFont="Verdana" Then response.write("selected")%>>Verdana</option>
        </select>
         &nbsp; <img src="images/0026.gif" width="14" height="14" /></td>
  </tr>
    <tr>
    <td class="itemlist">文字字号设置 
      <input name="DrawFontSize" type="text" class="text" size="3" maxlength="2" onkeyup="this.value=this.value.replace(/\D/g,'')"  value="<%=MarkFontSize%>" />PX 粗体
<input type="radio" name="DrawBold" id="DrawBold2" value="True" <%If MarkFontBold="True" Then response.Write("checked")%> />是
<input type="radio" name="DrawBold" id="DrawBold1" value="False" checked <%If MarkFontBold="False" Then response.Write("checked")%> />否
 &nbsp; <img src="images/0026.gif" width="14" height="14" /></td>
  </tr>          
    <tr>
    <td height="32" background="images/0025.gif"><span class="itemlist"><b><b>水印</b>图片设置选项</b></span></td>
  </tr>
      <tr>
    <td bgcolor="#fafafa" class="itemlist">水印图片透明度设置 
      <input name="DrawClarity" type="text" class="text" size="3" maxlength="3" onkeyup="this.value=this.value.replace(/\D/g,'')"  value="<%=MarkPicClarity*100%>" /> % &nbsp; <img src="images/0026.gif" width="14" height="14" /></td>
  </tr>
    <tr>
    <td class="itemlist">水印图片底色 
      <INPUT TYPE="text" NAME="DrawPicColor" ID="DrawPicColor" maxlength="7" size="7" value="<%=MarkPicColor%>" class="text" /> 
             <img src="images/0027.gif" alt="选取颜色" width="18" height="17" border="0" align="absmiddle" id="SetColor" style="cursor:pointer;background-Color:<%=MarkPicColor%>;" title="选取颜色!" onClick="GetColor(this,'DrawPicColor');">
              保留为空则水印图片不去除底色。</td>
  </tr>    <tr>
    <td bgcolor="#fafafa" class="itemlist">默认的水印图片设置  
<span id=showlogo><INPUT TYPE="text" NAME="DrawPicStr" ID="DrawPicStr" maxlength="50" size="35" value="<%=MarkPic%>" class="text" /> 水印图片地址为上传图片地址  </span> 
 <span id="previewImage"><font color="#FF0000">(例:1DY.GIF)</font></span>
     </td>
  </tr>
    <tr>
    <td class="prepic"></td>
  </tr>
      <tr>
     <td height="1" bgcolor="#e1e1e1"></td>
  </tr>
<tr>
    <td class="subitem"><input type="submit" value="保存" class="btnt2" /> &nbsp;
	<input type="reset" value="恢复为默认" class="btnt6" /></td>
  </tr>
</table>
<iframe id="colourPalette" src="selcolor.htm" style="visibility:hidden; position: absolute; left: 54; top: 5;border:1px solid gray; width:247px; height:170px" frameborder="0" scrolling="no" ></iframe>
</form>
<%
Else
	MarkPlace=request.form("DrawPlace")
	MarkFontStr=request.form("DrawTextStr")
	MarkFontColor=request.form("DrawFontColor")
	MarkFont=request.form("DrawFont")
	MarkFontSize=request.form("DrawFontSize")
	MarkFontBold=request.form("DrawBold")
	MarkPicClarity=request.form("DrawClarity")
	MarkPicColor=request.form("DrawPicColor")
	MarkPic=request.form("DrawPicStr")
	set rs=server.CreateObject("adodb.recordset")
	rs.open "select top 1 [MarkPlace],[MarkFontStr],[MarkFontColor],[MarkFont],[MarkFontSize],[MarkFontBold],[MarkPicClarity],[MarkPicColor],[MarkPic] from [Liu_User] where username='"&request.cookies("1dy")("UserName")&"'",conn,1,3
	rs("MarkPlace")=MarkPlace
	rs("MarkFontStr")=MarkFontStr
	rs("MarkFontColor")=MarkFontColor
	rs("MarkFont")=MarkFont
	rs("MarkFontSize")=MarkFontSize
	rs("MarkFontBold")=MarkFontBold
	if not IsNull(MarkPicClarity) then
		rs("MarkPicClarity")=MarkPicClarity/100
	end if
	rs("MarkPicColor")=MarkPicColor
	rs("MarkPic")=MarkPic
	rs.update
	rs.close
	set rs=nothing
	response.Write "<script>alert('保存信息成功！');location.href='setmark.asp';</script>"
End If
%>
</body>
</html>
