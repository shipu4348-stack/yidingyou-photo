<!--#include file="./incs/SysCode.asp"-->
<%
if request.cookies("1dy")("UserName")="" then
	response.Redirect("index.asp")
else
	Kuser=request.cookies("1dy")("UserName")
end if
pid=int(request.QueryString("pid"))
set rs=server.CreateObject("adodb.recordset")
rs.open "select top 1 [Pid],[kid],[Pname],[Pthurl],[Psize],[Pdesc] from [Liu_Pic] where Pid="&pid,conn,1,1
	if not rs.eof or not rs.bof then
		Pid=rs("Pid")
		oldKid=rs("Kid")
		Pname=rs("Pname")
		Pthurl=rs("Pthurl")
		Psize=rs("Psize")
		Pdesc=rs("Pdesc")
	else
		response.Write "<script language='javascript'>alert('参数错误!');history.back();</script>"
		response.End()
	end if
rs.close
set rs=nothing
Pflex=right(Pname,3)
Psize=(Psize/1024)
Psize=Formatnumber(Psize,2)
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
<title>文件浏览</title>
<script type="text/javascript" src="js/upload.js"></script>
<script language="javascript" src="js/overtip.js"></script>
<link rel="stylesheet" type="text/css" media="all" href="css/setting.css" />
<script>
function showmark()
{
    document.getElementById('mark').style.display = "";
}
function closemark()
{
    document.getElementById('mark').style.display = "none";
}
</script>
<script language="javascript">
function chkFrm(){
    var objFrm = document.upload;
    objFrm.upbt.disabled=true;
    objFrm.action = "uploadModify.asp";
	
    if (objFrm.AttachFile.value!="")
	{
		if (document.upload.newfilename.value=="")
		{
			var filename=objFrm.AttachFile.value;
			if (filename.substr(filename.length-3,3).toUpperCase()!=objFrm.filetype.value.toUpperCase())
			{
				document.getElementById("modinfo").innerHTML="<font color=red>文件类型不一至！</font>";
				objFrm.upbt.disabled=false;
				return false;
			}
			objFrm.submit();
			return true;
		}
		else
		{
			alert("改名与上传不能同时进行！");
			objFrm.upbt.disabled=false;
			return false;
		}
    }
	else if (document.upload.newfilename.value!="")
	{
		objFrm.submit();
		return true;
	}
	else
	{
		alert("请设置你所要改动的文件名或文件!");
		objFrm.upbt.disabled=false;
		return false;
	}
    
}

function checkvalue()
{
	var jgpattern =/^\w+$/; 
	var newname = document.upload.newfilename.value; 
	if (newname!="")
	{
		if(!jgpattern.test(newname))
		{ 
		  alert("文件名只允许数字、字母、下划线..."); 
		 // document.upload.newfilename.focus();	
		} 
	}
}
</script>
</head>

<body>
<table width="100%" border="0" cellpadding="0" cellspacing="0">
  <tr>
    <td height="40" valign="bottom" background="images/0018.gif" class="em">文件编辑</td>
  </tr>
</table>
<form name ="upload" method = POST target="_self" action = "modfile.asp" ENCTYPE="multipart/form-data">
<table width="100%" border="0" cellspacing="0" cellpadding="0">
    <input type="hidden" name="oldkid" value="<%=oldKid%>">
    <input type="hidden" name="oldPName" value="<%=Pname%>">
    <input type=hidden name=pid value="<%=Pid%>">
    <input type=hidden name=filetype value="<%=Pflex%>">
<tr>
    <td height="1" bgcolor="#e1e1e1"></td>
  </tr>
  <tr>
    <td class="dirnotice">提示：不需要修改的保持默认即可，覆盖上传后如果图片没更新请点击[全屏打开]“按CTRL+F5”强制刷新。</td>
  </tr>
  <tr>
    <td height="1" bgcolor="#e1e1e1"></td>
  </tr>
  <tr>
    <td  bgcolor="#fafafa" class="itemlist">所编辑的文件： 
	<b style="cursor:hand;" title="<img src='<%=MainURL&Pthurl%>'>"><%=Pname%></b>
    </td>
  </tr>
  <tr>
    <td  bgcolor="#fafafa" class="itemlist">新文件名：<input type="text" name="newfilename" onblur="checkvalue();" size="30" maxlength="30" class="text">&nbsp;
	<font color="#FF0000">注：文件名中不用包含扩展名</font></td>
  </tr>


  <tr>
    <td class="itemlist">当前文件大小：<%=Psize%>KB</td>
  </tr>
 <tr>
    <td class="itemlist">替换文件描述： <input type="text" name="title" size="30" maxlength="30" class="text" value="<%=Pdesc%>"></td>
  </tr>
    <tr>
      <td bgcolor="#fafafa" class="itemlist">文件所在目录：   
		<span id="FolderOption"></span>
		<script>
		FolderOption(<%=oldKid%>);
		</script>
	</td>
  </tr>
    <tr >
    <td class="itemlist">上传水印设置： 
      <input onclick="javascript:closemark();" type="radio" name="shuiyinset" checked value="1">不使用水印 <input onclick="javascript:closemark();" type="radio" name="shuiyinset" value="0">使用文字水印 <input onclick="javascript:showmark();ShowLogo();" type="radio" name="shuiyinset" value="2">使用图片水印
  <img src="images/0026.gif" width="14" height="14" /></td></tr>
   </table>
<table id="mark" style="DISPLAY: none" width="100%" border="0" cellpadding="0" celspacing="0"><tr>
          <td height="30"  class="itemlist">设定水印图片：
			<span id=showlogo></span>
 			<span id="previewImage" ></span><img src="images/0026.gif" width="14" height="14" /></td>
          </tr><tr><td height="20" class="itemlist" style="color:#CBCBCB">注：非图片文件或GIF动画文件请不要设定该选项；默认空即可。</td></tr> <tr>
          <td background="images/46.gif"><img src="images/00.gif" width="1" height="1"></td>
          </tr></table>
  
 <table width="100%" border="0" cellspacing="0" cellpadding="0" >
<tr >
    <td  bgcolor="#fafafa" class="itemlist">
同名替换上传：           
         <input type="File" name="AttachFile" style="width:300px; height:22px;" class="text"  /> <span id="modinfo"></span></td></tr>
   <tr>
    <td height="1" bgcolor="#e1e1e1"></td>
  </tr> <tr>  
    <td style="padding-left:15px; height:60px;"><input name="upbt" value="确定修改" type="button" class="btnt2" onclick="return chkFrm();" /></td>
</tr>
</table>
</form>
</body>
</html>