<!--#include file="incs/SysCode.asp"-->
<%
	dim kid,overall,shuiyinset,FileUp,Kdesp,Title,NameType,F_File,F_Name
	Dim Kpath,kname,UploadPath,UpSavePath
	dim kpath2,kname2,UploadPath2
	KongJian=0
	Set FileUp=New Upload_File
	Set Fso=New DmFso
	pid=FileUp.form("pid")'记录ID
	oldkid=FileUp.form("oldKid")'老类别
	kid=FileUp.form("kind")'新类别
	filetype=FileUp.form("filetype")'上传文件类型
	oldPname=FileUp.form("oldPname")'老文件名
	shuiyinset=FileUp.form("shuiyinset")'是否加水印
	title=FileUp.form("title")'文件描述
	F_Name=FileUp.form("newfilename")'新文件名
	F_AttachFile=FileUp.form("AttachFile")
	
	if GetIsNull(F_Name) then'判断是否重命名文件
		F_Name=oldPname
		if Isempty(F_AttachFile) or IsNull(F_AttachFile) then'判断是否选择新文件
		'-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
		'如果没有选择新文件
			set rsModify=server.CreateObject("adodb.recordset")
			rsModify.open "select [kid],[Pdesc] from [Liu_Pic] where pid="&pid,conn,1,3
			if not (rsModify.eof or rsModify.bof) then
				rsModify("kid")=kid
				rsModify("Pdesc")=title
				rsModify.update						
			end if
			rsModify.close
			set rsModify=nothing
			response.Write("<script language='javascript'>alert('修改成功,稍后可看到效果!');location.href='modfile.asp?pid="&pid&"';</script>")
		else
			'-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
			'如果选择了新文件			
			set F_File=FileUp.file("AttachFile")			
			if oldkid=0 then
				UploadPath=CreatFolder&"/"
			else
				kpath=DBGetValue("Liu_Folder","kpath","kid="&oldkid&"")
				kname=DBGetValue("Liu_Folder","kname","kid="&oldkid&"")
				UploadPath=CreatFolder&kpath&kname&"/"
			end if
			F_FileSize=F_File.FileSize
			UpSavePath=UploadPath&F_Name
			If F_File.FileSize<=webupsize*1024 Then'判断文件大小
				F_File.SaveAs Server.MapPath(UpSavePath)
				Dim Jpeg
				Set Jpeg=New DmImg					
				If shuiyinset=0 Then'加文字水印
					Call Jpeg.DrawText(UpSavePath,MarkFontStr,MarkFontSize,MarkFontColor,MarkFont,CBool(MarkFontBold),MarkPlace,0,0)
				'ElseIf shuiyinset=2 Then'加图片水印
					'Call Jpeg.DrawPic(UpSavePath,"/user/"&UserName&"/pic/"&MarkPic,MarkPlace,0.5,MarkPicColor,0,0)
				End If				'-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
				'Dim NewPhotoPic1 '创建相册显示缩略图
				Dim NewPhotoPic '创建相册浏览缩略图
				Dim NewPerPic '创建浏览缩略图
					'NewPhotoPic1=Jpeg.CreatePerPic(UpSavePath,UploadPath,3,730,730,"P_")
					NewPerPic=Jpeg.CreatePerPic(UpSavePath,UploadPath,1,100,100,"Thum_")
					NewPhotoPic=Jpeg.CreatePerPic(UpSavePath,UploadPath,2,75,75,"Photo_")
				Set Jpeg=Nothing				'-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
				If Fso.CheckFile(UploadPath&F_Name) and Fso.CheckFile(UploadPath&"Thum_"&F_Name) and Fso.CheckFile(UploadPath&"Photo_"&F_Name)  Then'判断上传文件是否存在，并计算所占空间大小and Fso.CheckFile(PhotoPic)
					
					if kid<>oldkid then
						
						if kid=0 then
							UploadPath2=CreatFolder&"/"
						else
							kpath2=DBGetValue("Liu_Folder","kpath","kid="&kid&"")
							kname2=DBGetValue("Liu_Folder","kname","kid="&kid&"")
							UploadPath2=CreatFolder&kpath2&kname2&"/"
						end if
						fso.MoveFile UploadPath&F_Name,UploadPath2&F_Name
						fso.MoveFile UploadPath&"Thum_"&F_Name,UploadPath2&"Thum_"&F_Name
						fso.MoveFile UploadPath&"Photo_"&F_Name,UploadPath2&"Photo_"&F_Name
					end if					
					set rsModify=server.CreateObject("adodb.recordset")		
					rsModify.open "select [kid],[Purl],[Pthurl],[PhotoUrl],[Pdesc],[Psize],[Pupdate] from [Liu_Pic] where pid="&pid,conn,1,3
					if not (rsModify.eof or rsModify.bof) then
						rsModify("kid")=kid
						rsModify("Purl")=F_Name
						rsModify("Pthurl")="Thum_"&F_Name
						rsModify("PhotoUrl")="Photo_"&F_Name
						'rsModify("PhotoPic")=PhotoPic
						rsModify("Pdesc")=title
						rsModify("Psize")=F_FileSize
						rsModify("Pupdate")=now()
						rsModify.update						
					end if
					rsModify.close
					set rsModify=nothing
					
					if kid<>oldkid then
						if kid<>0  then						
							conn.execute("update [Liu_Folder] set kcount=kcount+1 where kid="&kid&"")
						end if
						if oldkid<>0 then
							conn.execute("update [Liu_Folder] set kcount=kcount-1 where kid="&oldkid&"")
						end if				
					end if
					conn.execute("update [Liu_User] set UsedBytes=UsedBytes+"&cdbl(CheckNumeric(F_FileSize))&",ResBytes=ResBytes-"&cdbl(CheckNumeric(F_FileSize))&" where UserName='"&UserName&"'")
					FolderSize=DBGetValue("Liu_User","UsedBytes"," username='"&username&"'")
					response.write("<script language='javascript'>alert('修改成功,稍后可看到效果!');location.href='modfile.asp?pid="&pid&"';top.document.getElementById('usesize').innerHTML='"&FormatFileSize(FolderSize)&"';</script>")
				end if
				'更新原记录的类别，描述，所占字节数				
			else
				FolderSize=DBGetValue("Liu_User","UsedBytes"," username='"&username&"'")
				response.write("<script language='javascript'>alert('超过上传文件大小!');location.href='modfile.asp?pid="&pid&"';top.document.getElementById('usesize').innerHTML='"&FormatFileSize(FolderSize)&"';</script>")
			end if
			set F_File=nothing			
		end if
	else
	'-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	'对文件重命名
		NewF_Name=F_Name&"."&filetype
		F_ThumName="Thum_"&F_Name&"."&filetype
		F_PhotoName="Photo_"&F_Name&"."&filetype
		set rs=server.CreateObject("adodb.recordset")
		rs.open "select [Pname] from [Liu_Pic] where Pname='"&NewF_Name&"' and kid="&kid&" and Kuser='"&UserName&"'",conn,1,1
		if not (rs.eof and rs.bof) then
			response.Write("<script language='javascript'>alert('同名文件存在!');location.href='modfile.asp?pid="&pid&"';</script>")
		else
			if oldkid=0 then
				UploadPath=CreatFolder&"/"
			else
				kpath=DBGetValue("Liu_Folder","kpath","kid="&oldkid&"")
				kname=DBGetValue("Liu_Folder","kname","kid="&oldkid&"")
				UploadPath=CreatFolder&kpath&kname&"/"
			end if
			if kid=0 then
				UploadPath2=CreatFolder&"/"
			else
				kpath2=DBGetValue("Liu_Folder","kpath","kid="&kid&"")
				kname2=DBGetValue("Liu_Folder","kname","kid="&kid&"")
				UploadPath2=CreatFolder&kpath2&kname2&"/"
			end if
			if Not Fso.CheckFile(UploadPath2&NewF_Name) or Not Fso.CheckFile(UploadPath2&F_ThumName) or Not Fso.CheckFile(UploadPath2&F_PhotoName) then
				set rsModify=server.CreateObject("adodb.recordset")
				rsModify.open "select [kid],[Pname],[Purl],[Pthurl],[PhotoUrl],[Pdesc],[PSize] from [Liu_Pic] where pid="&pid,conn,1,3
				if not (rsModify.eof and rsModify.bof) then
					Call Fso.MoveFile(UploadPath&rsModify("Purl"),UploadPath2&NewF_Name)'执行重命名
					Call Fso.MoveFile(UploadPath&rsModify("Pthurl"),UploadPath2&F_ThumName)
					Call Fso.MoveFile(UploadPath&rsModify("PhotoUrl"),UploadPath2&F_PhotoName)
					if Fso.CheckFile(UploadPath2&NewF_Name) and Fso.CheckFile(UploadPath2&F_ThumName) and Fso.CheckFile(UploadPath2&F_PhotoName)  then
						rsModify("kid")=kid
						rsModify("Pname")=NewF_Name
						rsModify("Purl")=NewF_Name
						rsModify("Pthurl")=F_ThumName
						rsModify("PhotoUrl")=F_PhotoName
						rsModify("Pdesc")=title
 						rsModify.update	
					end if						
				end if
				rsModify.close
				set rsModify=nothing
				if kid<>oldkid then
					if kid<>0  then						
						conn.execute("update [Liu_Folder] set kcount=kcount+1 where kid="&kid&"")
					end if
					if oldkid<>0 then
						conn.execute("update [Liu_Folder] set kcount=kcount-1 where kid="&oldkid&"")
					end if				
				end if
				conn.execute("update [Liu_User] set UsedBytes=UsedBytes+"&cdbl(CheckNumeric(F_FileSize))&",ResBytes=ResBytes-"&cdbl(CheckNumeric(F_FileSize))&" where UserName='"&UserName&"'")
				response.Write("<script language='javascript'>alert('修改成功,稍后可看到效果!');location.href='modfile.asp?pid="&pid&"';</script>")
			end if			
		end if
		rs.close
		set rs=nothing	
	'-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------	
	end if
	Set Fso=Nothing
	set FileUp=nothing
%>
