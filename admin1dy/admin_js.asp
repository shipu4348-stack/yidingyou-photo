<!--#include file="conn.asp"-->
<!--#include file="check.asp"-->
<%  rel=checkstr(trim(request("rel")))
 if not checkflag("ADManage") then
  getshow "对不起，您没有【调用代码】的权限！",""
end if
 %>
 <html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<title>广告调用</title>
<script>
function GenerateJs()
{
	var s;
	s+="js.asp?num=";
	s+=document.all.num.value;
	s+="&ltype=";
	s+=document.all.ltype.value;
	s+="&kind=";
	s+=document.all.kind.value;
	s+="&width=";
	s+=document.all.width.value;
	s+="&height=";
	s+=document.all.height.value;
	s+="&css_td=";
	s+=document.all.css_td.value;
	s+="&css_pic=";
	s+=document.all.css_pic.value;
 	s+="&hnum=";
	s+=document.all.hnum.value;
 
//	s+="&showClass=";
//	s+=document.all.showClass.checked ? "1" : "0";
	document.all.jstext.value="<script src=\""+s+"\"><\/script>";
}

function CopyJs()
{
	document.all.jstext.focus();
	document.all.jstext.select();
	document.execCommand("copy");
}
</script>
<link rel="stylesheet" type="text/css" href="imageS/Admin_Style.Css">
</head>

<body leftmargin="5" topmargin="0">

<table width="100%" border="0" align="center" cellpadding="2" cellspacing="1" class="border">
  <tr class="title"> 
    <td  > <table width="100%" border="0" align="center" cellpadding="0" cellspacing="0">
  <tr> 
    <td height="22" style="color:#FFFFFF">.:: 您可以在这里进行[广告调用]相关操作</td>
    <td width="200" height="22" align="right">
	 
    </td>
  </tr>
</table>
	
	</td>
  </tr>
</table>

 <center><font size="+3">广告调用</font></center>
 
<table width="95%" border="0" align="center" cellpadding="0" cellspacing="1" bordercolorlight="#ECEEE4" bordercolordark="#CCCABC" bgcolor="#CCCCCC" class="border1">
  <form name="form1" method="post" action="">
    <tr>
      <td height="30" colspan="4" align="center" class="title"><b>广 告 调 用 脚 本</b> </td>
    </tr>
    <tr>
      <td width="17%" height="25" align="center"  valign="middle" class="tdbg">调用位置： </td>
      <td width="25%" class="tdbg"><select name="ltype" id="ltype">
        <option value="1" selected>首页顶部</option>
        <option value="2">首页Flash</option>
        <option value="3">热销单品</option>
        <option value="4">成功店铺</option>
        <option value="5">底部Flash</option>
        <option value="6">会员页FLash</option>
        <option value="7">会员底部左</option>
        <option value="8">会员底部右</option>
        <option value="9">会员底部左</option>
      </select></td>
      <td width="22%" class="tdbg">调用类型： </td>
      <td width="36%" class="tdbg"><select name="kind" id="kind">
        <option value="Pic" selected="selected">图片格式</option>
        <option value="Flash">Flash格式</option>
      </select></td>
    </tr>
    <tr>
      <td width="17%" height="25" align="center"  valign="middle" class="tdbg">调用数量： </td>
      <td class="tdbg"><input name="num" type="text" id="num" value=10 size=6 maxlength=3 /></td>
      <td class="tdbg">图片宽度： </td>
      <td class="tdbg"><input name="width" type="text" id="width" value=100 size=6 maxlength=3 /></td>
    </tr>
    <tr>
      <td width="17%" height="25" align="center"  valign="middle" class="tdbg">图片高度： </td>
      <td class="tdbg"><input name="height" type="text" id="height" value=150 size=6 maxlength=3 /></td>
      <td class="tdbg">一行显示个数： </td>
      <td class="tdbg"><input name="hnum" type="text" id="hnum" value=1 size=6 maxlength=3 /></td>
    </tr>
    <tr>
      <td width="17%" height="25" align="center"  valign="middle" class="tdbg">表格CSS</td>
      <td class="tdbg"><input name="css_td" type="text" id="css_td" value="bbb" size="6" maxlength="10" /></td>
      <td class="tdbg">图片CSS： </td>
      <td class="tdbg"><input name="css_pic" type="text" id="css_pic" value=mainpic size=6 maxlength=10 /></td>
    </tr>
    <tr>
      <td height="25" colspan="4" align="center"  valign="middle" class="tdbg"><input name="button" type="button" onClick="GenerateJs();" value="生成脚本" />
        &nbsp; &nbsp;
        <input name="button" type="button" onClick="CopyJs();" value="拷贝脚本" />      </td>
    </tr>
    <tr>
      <td height="25" colspan="4" align="center"  valign="middle" class="tdbg"><br />
          <textarea name="textarea" cols=90 rows=6 id="jstext"></textarea>
          <br />
        <br />
        注：把生成的脚本粘贴到html文件内即可以显示指定的内容 </td>
    </tr>
  </form>
</table>
