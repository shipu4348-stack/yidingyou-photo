<!--#include file="Incs/SysCode.asp"-->
<%
	server.ScriptTimeout=99999
	if Not checklogin then
 		response.Write "{""id"":""0"",""errid"":""1""}"
		response.End()
	end if
	Dim FileUp,F_File
	dim kid,overall,shuiyinset,Title,NameType,formName,FolderkSize
	Dim UploadPath,kpath,kname,UpSavePath
	Dim Jpeg
	kid=CheckNumeric(request.Cookies("liu")("kid"))'路径
	'kdesp=request.Cookies("liu")("tag")'描述Kdesp
	NameType=CheckNumeric(request.Cookies("liu")("shortpath"))'命名方式
	overall=Checkstr(request.Cookies("liu")("overall"))'是否覆盖
	shuiyinset=CheckNumeric(request.Cookies("liu")("shuiyin"))'水印设置	
	if kid=0 then
		UploadPath=CreatFolder&"/"
	else
		kpath=DBGetValue("Liu_Folder","kpath","kid="&kid&"")
		kname=DBGetValue("Liu_Folder","kname","kid="&kid&"")
		UploadPath=CreatFolder&kpath&kname&"/"
	end if
	Set FileUp=New Upload_File
		set F_File=FileUp.file("spPhotoFile0")
			set Fso=new DmFso
			F_FileSize=F_File.FileSize
			'判断剩余空间大小
			if NameType=0 then
				F_Name=FormatTime(Now(),6)&RandNumber(1,1000)&"."&F_File.FileExt
			elseif NameType=1 then
				F_Name=F_File.FileName
			end if
			'判断剩余空间大小
			FolderkSize=DBGetValue("Liu_User","ResBytes","  UserName='"&UserName&"' ")			
			if  cdbl(CheckNumeric(F_FileSize)) > cdbl(CheckNumeric(FolderkSize)) then
				response.Write "{""id"":""0"",""errid"":""1""}"
				response.End()
			end if					
			UpSavePath=UploadPath&F_Name
			F_File.SaveAs Server.MapPath(UpSavePath)
			Set Jpeg=New DmImg
			if Not Jpeg.IsImage(UpSavePath) then
				Fso.DelFile(UpSavePath)
				response.Write "{""id"":""0"",""errid"":""1""}"
				response.End()
			end if			
			If shuiyinset=0 Then				
				Call Jpeg.DrawText(UpSavePath,MarkFontStr,MarkFontSize,MarkFontColor,MarkFont,CBool(MarkFontBold),MarkPlace,0,0)
			ElseIf shuiyinset=2 Then
				Call Jpeg.DrawPic(UpSavePath,"/user/"&UserName&"/pic/"&MarkPic,MarkPlace,0.5,MarkPicColor,0,0)
			End If
			
			'Dim NewPhotoPic1 '创建相册显示缩略图
			Dim NewPerPic '创建浏览缩略图
			Dim NewPhotoPic '创建相册浏览缩略图
				'NewPhotoPic1=Jpeg.CreatePerPic(UpSavePath,UploadPath,3,730,730,"P_")
				NewPerPic=Jpeg.CreatePerPic(UpSavePath,UploadPath,1,100,100,"Thum_")
				NewPhotoPic=Jpeg.CreatePerPic(UpSavePath,UploadPath,2,75,75,"Photo_")
			Set Jpeg=Nothing			
			
			PicUrl=UpSavePath'原图路径
			PthUrl=UploadPath&"Thum_"&F_Name'浏览缩略图
			PhotoUrl=UploadPath&"Photo_"&F_Name'相册缩略图
			'PhotoPic=UploadPath&"P_"&F_Name
			
			
			If Fso.CheckFile(PicUrl) and Fso.CheckFile(PthUrl) and Fso.CheckFile(PhotoUrl)  Then'and Fso.CheckFile(PhotoPic)
				conn.execute("insert into [Liu_Pic] ([Kid],[Kuser],[Pname],[Purl],[Pthurl],[PhotoUrl],[Psize],[Pdate]) values("&kid&",'"&UserName&"','"&F_Name&"','"&F_Name&"','Thum_"&F_Name&"','Photo_"&F_Name&"','"&F_FileSize&"','"&now()&"')")
				set Ters=conn.execute("select @@IDENTITY as id")
				dim id
				id=Ters("id")
				set Ters=nothing
				if kid<>0 then
					conn.execute("update [Liu_Folder] set kcount=kcount+1 where kid="&kid&"")
				end if
				conn.execute("update [Liu_User] set UsedBytes=UsedBytes+"&cdbl(CheckNumeric(F_FileSize))&",ResBytes=ResBytes-"&cdbl(CheckNumeric(F_FileSize))&" where UserName='"&UserName&"'")
				response.Write "{""id"":"""&id&""",""errid"":""0""}"
			end if
			set Fso=nothing
		set F_File=nothing
	set FileUp=nothing
%>
