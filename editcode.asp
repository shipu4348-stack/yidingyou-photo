<!--#include file="incs/sysCode.asp"-->
<%
if request("action")="add" then
	id=request.form("html_id")
	title=trim(Request.Form("html_name"))
	Content=Request.Form("FCKeditor1")
	HtmlName=trim(request.form("html_Url"))			
	if len(Content)<=0 then
		response.write "<script>alert('内容不能为空！');history.back();</script>"
		response.End
	else
		dim HtmlName,HtmlSize,Path			
		set Fso=New DmFso
		HtmlPath=CreatHtml&"/"&HtmlName
		if Fso.CreateFile(HtmlPath,Content,True) then
			if Fso.CheckFile(HtmlPath) then				
				HtmlSize=Fso.GetFileSize(server.MapPath(HtmlPath))				
				set rs=server.CreateObject("adodb.recordset")
				rs.open "select top 1 [CodeName],[CodeSize],[CodeTime] from [Liu_Code] where CodeId="&id,conn,1,3
				if not(rs.eof and rs.bof) then
					conn.execute("update [Liu_User] set UsedBytes=UsedBytes-"&cdbl(CheckNumeric(rs("codesize")))&",ResBytes=ResBytes+"&cdbl(CheckNumeric(rs("codesize")))&" where UserName='"&UserName&"'")
					rs("CodeName")=title
					rs("CodeSize")=HtmlSize
					rs("CodeTime")=Now()
					rs.update
				end if
				rs.close
				set rs=nothing
				conn.execute("update [Liu_User] set UsedBytes=UsedBytes+"&cdbl(CheckNumeric(HtmlSize))&",ResBytes=ResBytes-"&cdbl(CheckNumeric(HtmlSize))&" where UserName='"&UserName&"'")
				FolderSize=DBGetValue("Liu_User","UsedBytes"," username='"&UserName&"'")
				response.write "<script>alert('修改成功！');top.document.getElementById('usesize').innerHTML='"&FormatFileSize(FolderSize)&"';window.location.href='editcode.asp?html_id="&id&"';</script>"
				response.End()
			end if
		end if
	end if
end if
'获取信息
id=int(request.QueryString("html_id"))
set rs=server.CreateObject("adodb.recordset")
rs.open "select top 1 [CodeId],[CodeName],[CodeUrl] from [Liu_Code] where CodeId="&id&"",conn,1,1
	if not rs.eof or not rs.bof then
		CodeId=rs("CodeId")
		CodeName=rs("CodeName")
		CodeUrl=rs("CodeUrl")	
	end if
rs.close
set rs=nothing
set Fso=New DmFso
if Fso.CheckFile(CreatHtml&"/"&CodeUrl) then
	Content=Server.HTMLEncode(Fso.ReadFile(CreatHtml&"/"&CodeUrl))	
	'Content=replace(Content,"'","")
end if
set Fso=Nothing
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
<title>修改模板</title>
<link rel="stylesheet" type="text/css" media="all" href="css/setting.css" />
<link href="fckeditor/_samples/sample.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="fckeditor/fckeditor.js"></script>

<script language="javascript">
function check(){
  var result = true ;
  var form = document.mainform ;
  var tname = form.html_name;
   if ( tname.value == "" ){
    result = false ;
    alert("大小也得给个名呀！");
    return result ;
   }
   else
   {
      document.mainform.submit();
   }
}

function savecode() {
	var str=document.getElementById('FCKeditor1').value;
	var code_win = window.open('about:blank','_blank','top=10000');
	code_win.document.open();
	code_win.document.writeln(str);
	code_win.document.close();
	code_win.document.execCommand('saveas','','code.html');
	code_win.close();
	return;
}

//function cls() {
//	if (document.all) {
//		window.opener='abc';
//	}
//	window.close();
//	return false;
//}
</script>
</head>

<body>

<FORM name="mainform" action="editcode.asp?action=add" method="POST" onsubmit="return check();">
<input type="hidden" name="html_id" value="<%=CodeId%>" />
<input type="hidden" name="html_Url" value="<%=CodeUrl%>" />
<table width="100%" border="0" cellpadding="0" cellspacing="0">
  <tr>
    <td height="40" valign="bottom" background="images/0018.gif" class="em">新建&amp;修改宝贝</td>
  </tr>
</table>
<table width="100%" border="0" cellspacing="0" cellpadding="0">

<tr>
    <td height="1" bgcolor="#e1e1e1"></td>
  </tr>
  <tr>
    <td class="dirnotice">提示：仅是保存编辑代码功能，由于一定呦不能直接上传网页文件，因此设置的功能。</td>
  </tr>
  <tr>
    <td height="1" bgcolor="#e1e1e1"></td>
  </tr>
  <tr>
    <td  bgcolor="#fafafa" class="itemlist">文件名称：
<input name="html_name" type="text" class="text" id="html_name" size="40" maxlength="30" value="<%=CodeName%>" /></td>
  </tr>
  <tr>
    <td style="padding:10px;">
 
 	<input type="hidden" id="FCKeditor1" name="FCKeditor1" value="<%=content%>" style="display:none" /> 
	    <input type="hidden" id="FCKeditor1___Config"  value="SkinPath=/fckeditor/editor/skins/office2003/" style="display:none" />
	    <iframe id="FCKeditor1___Frame" src="/fckeditor/editor/fckeditor.html?InstanceName=FCKeditor1&amp;Toolbar=ydy" width="100%" height="500" frameborder="0" scrolling="no"></iframe> 
		
</td>
  </tr>
   <tr>
    <td height="1" bgcolor="#e1e1e1"></td>
  </tr> <tr>  
    <td style="padding-left:15px; height:60px;"><input onclick="check();" name="button2" value="新增/更新" type="button" class="btnt3" /> &nbsp; <input name="button2" onclick="savecode();" value="保存到本地" type="button" class="btnt6" /></td>
</tr>

</table>
<form>
</body>
</html>