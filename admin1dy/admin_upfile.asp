<!--#include FILE="conn.asp"-->
<!--#include FILE="check.asp"-->
<!--#include FILE="upload_5xsoft.inc"-->
  <% 
 server.ScriptTimeout=5000 
 response.charset="gb2312"
 %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>  - 文件上传</title>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
<link rel="stylesheet" type="text/css" href="imageS/Admin_Style.Css">
</head>
 <body class="tdbg">
 
<%
formName=request("formName")
textName=request("textName")
classType=request("classType")
'response.Write(formName)
'response.End()
dim upload,file,formName,formPath,iCount,classType
set upload=new upload_5xsoft ''建立上传对象
formpath="../uploadfile/"& formName & "/"
iCount=0
for each formName in upload.objFile ''列出所有上传了的文件
 set file=upload.file(formName)  ''生成一个文件对象
 
 if file.FileSize>0 then         ''如果 FileSize > 0 说明有文件数据
  filetype=split(file.filetype,"/")
  if filetype(0)="image" then
    file.SaveAs Server.mappath(formPath&filenamestr&"."&file.fileext)   ''保存文件
	%><input id='imgurl' type='hidden' value='/uploadfile/ad/<%=""&filenamestr&"."&file.fileext&""%>'>  <% rw "<a href=""admin_upload.asp"">继续上传</a>"%>
	<!--文件本地路径:<%'=file.FilePath&file.FileName&" ("&file.FileSize&")"%> => <a href='#' onclick='win()'>/uploadfile/ad/<%'=filenamestr&"."&file.fileext&""%></a> 成功!<br>
	图片格式:<%'=file.filetype%><br>
	图片大小:<%'=file.FileSize%> 
   -->
<%
	iCount=iCount+1
  else
    getshow "文件类型不对,请重新选择!",""
  end if
 end if
 set file=nothing
next

set upload=nothing  ''删除此对象
'Response.Write iCount
sub HtmEnd(Msg)
 set upload=nothing
 rw"<br>"&Msg&" [<a href=""javascript:history.back();"">返回</a>]</body></html>"
 response.end
end sub

 
%>
<%
select case classType
case 1
response.Write("<script language='javascript'>parent.document.all." & textName &  ".innerText=document.getElementById('imgurl').value;parent.document.all.face.src=document.getElementById('imgurl').value;</script>")
case 2
response.Write("<script language='javascript'>parent.document.all." & textName &  ".innerText=document.getElementById('imgurl').value;</script>")
case else
response.Write("<script language='javascript'>parent.document.all." & textName &  ".innerText=document.getElementById('imgurl').value;</script>")
end select
%>

</body>
</html>
 
 