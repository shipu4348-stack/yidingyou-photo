<!--#include file="incs/SysCode.asp"-->
<%
	server.ScriptTimeout=99999
	if Not checklogin then
		response.Write("<script language='javascript'>alert('请重新登录!');top.location.href='index.asp';</script>")
		response.end()
	end if
	Dim FileUp,Fso,F_File
	dim kid,overall,shuiyinset,Kdesp,Title,NameType,Num,Success,KongJian,FileCount,FolderkSize,F_Name
	Dim kpath,UploadPath,UpSavePath
	Dim Jpeg
	Success=0
	KongJian=0
	F_Name=""
	Set FileUp=New Upload_File
	Set Fso=New DmFso
	kid=CheckNumeric(FileUp.form("kind"))'路径
	kdesp=Checkstr(FileUp.form("grouptitle"))'描述
	overall=Checkstr(FileUp.form("overall"))'是否覆盖
	shuiyinset=CheckNumeric(FileUp.form("shuiyinset"))'水印设置
	Num=CheckNumeric(FileUp.form("no"))
	if kid=0 then
		UploadPath=CreatFolder&"/"
	else
		kpath=DBGetValue("Liu_Folder","kpath","kid="&kid&"")
		kname=DBGetValue("Liu_Folder","kname","kid="&kid&"")
		UploadPath=CreatFolder&"/"&kpath&kname&"/"
	end if
	UploadPath=Replace(UploadPath,"//","/")
	If Not Fso.CheckFolder(UploadPath) Then Fso.CreateFolder UploadPath
	for i=1 to Num
		Title=FileUp.form("title"&i)
		NameType=FileUp.form("shortpath"&i)	
		set F_File=FileUp.file("AttachFile"&i)
		F_FileSize=F_File.FileSize
		F_Name=""
		if NameType=0 then
			F_Name=FormatTime(Now(),6)&RandNumber(1,1000)&"."&F_File.FileExt
		elseif NameType=2 then
			F_Name=F_File.FileName
		end if
		UpSavePath=UploadPath&F_Name
		FolderkSize=DBGetValue("Liu_User","ResBytes","  UserName='"&UserName&"' ")
		if cdbl(CheckNumeric(F_FileSize)) > cdbl(CheckNumeric(FolderkSize)) then
			response.Write("<script language='javascript'>alert('您的空间不足,请扩冲空间!');location.href='upsimp.asp';top.document.getElementById('fugai_layout').style.display='none';top.document.getElementById('showmessage').style.display='none';</script>")
			response.end()
		end if
	 
		If cdbl(CheckNumeric(F_FileSize))<=cdbl(CheckNumeric(webupsize*1024)) Then
			Set Jpeg=New DmImg
			F_File.SaveAs Server.MapPath(UpSavePath)
			if Not Jpeg.IsImage(UpSavePath) then
				Fso.DelFile(UpSavePath)
			else
			 
				If shuiyinset=0 Then
					Call Jpeg.DrawText(UpSavePath,MarkFontStr,MarkFontSize,MarkFontColor,MarkFont,CBool(MarkFontBold),MarkPlace,0,0)
				'ElseIf shuiyinset=2 Then
					'Call Jpeg.DrawPic(UpSavePath,"/user/"&request.cookies("1dy")("UserName")&"/pic/"&MarkPic,MarkPlace,0.5,MarkPicColor,0,0)
				End If	
							
				'Dim NewPhotoPic1 '创建相册显示缩略图
				Dim NewPerPic '创建浏览缩略图
				Dim NewPhotoPic '创建相册浏览缩略图
				'NewPhotoPic1=Jpeg.CreatePerPic(UpSavePath,UploadPath,3,730,730,"P_")
 				NewPerPic=Jpeg.CreatePerPic(UpSavePath,UploadPath,1,100,100,"Thum_")
 				NewPhotoPic=Jpeg.CreatePerPic(UpSavePath,UploadPath,2,75,75,"Photo_")
 				PicUrl=UpSavePath'原图路径
				PthUrl=UploadPath&"Thum_"&F_Name'浏览缩略图
				PhotoUrl=UploadPath&"Photo_"&F_Name'相册缩略图
				 
				'PhotoPic=UploadPath&"P_"&F_Name
			 
				If Fso.CheckFile(PicUrl) and Fso.CheckFile(PthUrl) and Fso.CheckFile(PhotoUrl)  Then 'and Fso.CheckFile(PhotoPic)
					conn.execute("insert into [Liu_Pic] ([Kid],[Kuser],[Pname],[Purl],[Pthurl],[PhotoUrl],[Pdesc],[Psize],[Pdate]) values("&kid&",'"&UserName&"','"&F_Name&"','"&F_Name&"','Thum_"&F_Name&"','Photo_"&F_Name&"','"&kdesp&Title&"','"&F_FileSize&"','"&now()&"')")'PhotoPic
					if kid<>0 then
						conn.execute("update [Liu_Folder] set kcount=kcount+1 where kid="&kid&"")
					end if
					conn.execute("update [Liu_User] set UsedBytes=UsedBytes+"&cdbl(CheckNumeric(F_FileSize))&",ResBytes=ResBytes-"&cdbl(CheckNumeric(F_FileSize))&" where UserName='"&UserName&"'")
					Success=Success+1			
				end if
			end if
			 
			Set Jpeg=Nothing
		end if
		set F_File=nothing
	next
	Set Fso=Nothing
	set FileUp=nothing
	FolderSize=DBGetValue("Liu_User","UsedBytes","  UserName='"&UserName&"' ")
	response.write("<script language='javascript'>alert('上传成功，共上传"&Num&"个文件,成功上传"&Success&"个。');location.href=(document.referrer.indexOf('upftp.asp')>-1)?'upftp.asp':'upsimp.asp';top.document.getElementById('usesize').innerHTML='"&FormatFileSize(FolderSize)&"';top.document.getElementById('fugai_layout').style.display='none';top.document.getElementById('showmessage').style.display='none';</script>")
%>
