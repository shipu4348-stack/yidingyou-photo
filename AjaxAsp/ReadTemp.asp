<!--#include virtual="/incs/SysCode.asp"-->
<% Response.ContentType = "text/html; charset=gb2312" %>
<%
	Server.ScriptTimeOut =999999
	if Not checklogin then
		response.Write(escape("超时"))
		response.End()
	end if	
	xmlpath=request.QueryString("XmlPath")
	dim level,upid,piccount
	piccount=0
	level=0
	upid=0
	UserMainPath=CreatMain
	UserPath=CreatTemp
	piccount=CountList("/temp")
	
	if piccount>0 then
		CreatXml xmlpath,piccount
		WriteList "/",0,0,xmlpath
	else
		CreatXml xmlpath,1
		EditXml xmlPath
	end if

	percent=ReadXml(xmlpath)
	
	if percent=100 then
		ClearTemp UserPath
		FolderSize=DBGetValue("Liu_User","UsedBytes"," username='"&username&"' ")
		set fso=new dmfso
			if fso.DelFile(xmlpath) then
				response.Write(escape("成功"))
				response.Write FormatFileSize(FolderSize)
			end if
		set fso=nothing
	end if
'++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
'遍历临时文件夹下的目录，最多只遍历两级目录	
	function WriteList(path,kid,m,xmlpath)
		dim fso,i,ii,nn
		set fso=new dmfso
		If  fso.CheckFolder(CreatMain&"/temp"&path)  Then
			FileList=fso.GetFileList(CreatMain&"/temp"&path)
			FileListKey=Split(FileList,"|")
			For I = 1  To Ubound(FileListKey)
				FileExt=fso.GetFileExt(CreatMain&"/temp"&path&FileListKey(I))
				if CheckFileExt(FileExt,"jpg;gif;png;bmp") then
					if m=0 then
						'er.rw 		 "/"&FileListKey(I)
						'response.Write "/"&FileListKey(I)&"<br>"
						WritePic "/"&FileListKey(I),FileListKey(I),kid,xmlpath
					else
						'er.rw 		 path&FileListKey(I)
						'response.Write path&FileListKey(I)&"<br>"
 						WritePic path&FileListKey(I),FileListKey(I),kid,xmlpath
					end if					
					Response.Flush
				else					
					fso.DelFile(CreatMain&"/temp"&path&FileListKey(I))
				end if
			Next
			
   			FolderList=fso.GetFolderList(CreatMain&"/temp"&path)
			FolderListKey=Split(FolderList,"|")
			For II = 1  To Ubound(FolderListKey)
				if m=0 then	
					'er.rw CreatMain&"/temp"&path&FolderListKey(II)
					'response.Write CreatMain&"/temp"&path&FolderListKey(II)&"<br>"
					nn=WriteSqlFolder(fso.GetFolderInfo(CreatMain&"/temp"&path&FolderListKey(II),5),path,kid,m+1)
				else
					'er.rw CreatMain&"/temp"&path&FolderListKey(II)
					'response.Write CreatMain&"/temp"&path&FolderListKey(II)&"<br>"
					nn=WriteSqlFolder(fso.GetFolderInfo(CreatMain&"/temp"&path&FolderListKey(II),5),path,kid,m+1)
				end if
				'er.rw  path&FolderListKey(Ii)&"/"
				'response.Write path&FolderListKey(Ii)&"/"&"<br>"
				WriteList path&FolderListKey(Ii)&"/",nn,m+1,xmlpath
				'if not fso.DelFolder(path&"/"&FolderListKey(I)) then
					'fso.DelFolder(path&"/"&FolderListKey(I))
				'end if
				'Response.Flush
			Next
		End If
		set fso=nothing
	end function
'++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
'将遍历目录写进数据库	
	function WriteSqlFolder(FolderName,FolderPath,upid,level)
		dim fso,fid
		set fso=new dmfso
		fid=DBGetValue(" Liu_Folder "," kid "," kname='"&FolderName&"' and kuser='"&UserName&"' and klevel="&level-1&" ")
		if Not fso.CheckFolder(CreatFolder&FolderPath&FolderName) or fid=""  then
			if fso.CreateFolder(CreatFolder&FolderPath&FolderName) then
				conn.execute("insert into [Liu_Folder] (kname,kpath,kcount,upid,klevel,kuser) values('"&FolderName&"','"&FolderPath&"',0,"&upid&","&level-1&",'"&UserName&"')")
				set Ters=conn.execute("select @@IDENTITY as id")
				dim id
				id=Ters("id")
				set Ters=nothing
				WriteSqlFolder=id
			end if
		else
			WriteSqlFolder=DBGetValue(" Liu_Folder "," kid "," kname='"&FolderName&"' and kuser='"&UserName&"' and klevel="&level-1&" ")
		end if		
		set fso=nothing
	end function
'++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
'转移图片，生成缩略图，写入数据库	
	function WritePic(Picurl,Pname,kid,xmlPath)
		dim fso,F_FileSize
		set fso=new dmfso
		FileExt=fso.GetFileExt(picurl)			
		OldPicPath=CreatMain&"/temp"&Picurl
		NewPicPath=CreatFolder&Picurl
		
		if kid="0" then
			UploadPath=CreatFolder
		else
			kpath=DBGetValue("Liu_Folder","kpath","kid="&kid&"")
			kname=DBGetValue("Liu_Folder","kname","kid="&kid&"")
			UploadPath=CreatFolder&kpath&kname&"/"
		end if
		if fso.CopyFile(OldPicPath,NewPicPath) and fso.CheckFile(NewPicPath) then
			Set Jpeg=New DmImg
			Dim NewPerPic '创建浏览缩略图
			Dim NewPhotoPic '创建相册浏览缩略图
			NewPerPic=Jpeg.CreatePerPic(NewPicPath,UploadPath,1,100,100,"Thum_")
			NewPhotoPic=Jpeg.CreatePerPic(NewPicPath,UploadPath,2,75,75,"Photo_")
			Set Jpeg=Nothing
			F_FileSize=fso.GetFileInfo(NewPicPath,7)
			if F_FileSize=false then F_FileSize=0
			
			conn.execute("insert into [Liu_Pic] (Kid,Kuser,Pname,Purl,PthUrl,PhotoUrl,Pdesc,Psize,Pdate) values("&kid&",'"&UserName&"','"&Pname&"','"&Pname&"','Thum_"&Pname&"','Photo_"&Pname&"','"&F_Name&"','"&CheckNumeric(F_FileSize)&"','"&now()&"')")
			if kid<>"0" then
				conn.execute("update [Liu_Folder] set kcount=kcount+1 where kid="&kid&"")
			end if
			conn.execute("update [Liu_User] set UsedBytes=UsedBytes+"&cdbl(CheckNumeric(F_FileSize))&",ResBytes=ResBytes-"&cdbl(CheckNumeric(F_FileSize))&" where UserName='"&UserName&"'")		
			EditXml xmlPath
		end if
		set fso=nothing	
	end function
'++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
'编辑XML文件	
	function EditXml(xmlPath)
		Dim xmldoc   
		Set xmldoc=server.CreateObject("Microsoft.XMLDOM")
		xmldoc.Async=False 
		xmldoc.Load(Server.MapPath(xmlpath))
		dim root		
		Set root=xmldoc.documentElement
		totalbytes=root.childNodes(0).Text
		uploadbytes=root.childNodes(1).Text
		percentbytes=int((uploadbytes+1)/totalbytes*100)
		set uploadNode=root.childNodes(1)
		uploadNode.Text=uploadbytes+1
		set percentNode=root.childNodes(2)
		percentNode.Text=percentbytes
		xmldoc.save(Server.Mappath(xmlPath))
		set root=nothing
		set xmldoc=nothing
	end function
'++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
'获取时间	
	function RandName()
		RandName=FormatTime(Now(),6)&RandNumber(1,1000)
	end function
'++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
'读取XML文件	
	function ReadXml(xmlPath)
		Dim xmldoc   
		Set xmldoc=server.CreateObject("Microsoft.XMLDOM")
		xmldoc.Async=False 
		xmldoc.Load(Server.MapPath(xmlpath))
		dim root		
		Set root=xmldoc.documentElement
		percentbytes=root.childNodes(2).Text
		set root=nothing
		set xmldoc=nothing
		ReadXml=percentbytes
	end function
'++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
'设置停止时间
	Sub delaySec(DelaySeconds)   
		SecCount   =   0   
		Sec2   =   0   
		While   SecCount<DelaySeconds   +   1   
			Sec1=Second(Time())   
			If   Sec1<>Sec2   Then   
				Sec2=Second(Time())   
				SecCount=SecCount+1   
			End   If       
		Wend   
	End Sub
'++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
'统计临时文件夹下文件总数	
	dim k:k=0
	function CountList(path)
		set fso=new dmfso
		set Jpeg=New DmImg
		If  fso.CheckFolder(CreatMain&path)  Then
			FileList=fso.GetFileList(CreatMain&path)
			FileListKey=Split(FileList,"|")
			For I = 1  To Ubound(FileListKey)
				FileExt=fso.GetFileExt(CreatMain&path&"/"&FileListKey(I))
				if CheckFileExt(FileExt,"jpg;gif;png;bmp") and fso.GetFileInfo(CreatMain&path&"/"&FileListKey(I),7)>=1 and Jpeg.IsImage(CreatMain&path&"/"&FileListKey(I))   then
					k=K+1
				else
					fso.DelFile(path&"/"&FileListKey(I))			
				end if
			Next
			FolderList=fso.GetFolderList(CreatMain&path)
			FolderListKey=Split(FolderList,"|")
			For I = 1  To Ubound(FolderListKey)
 				CountList path&"/"&FolderListKey(I)
			Next
		End If
		set Jpeg=nothing
		set fso=nothing
		CountList=k
	end function
'++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
'生成临时XML文件	
	function CreatXml(xmlPath,PicCount)
		Dim   xmldoc   
		Set   xmldoc   =   server.CreateObject("Microsoft.XMLDOM")
		Dim   version   
		Set   version   =   xmldoc.createProcessingInstruction("xml","   version='1.0'   encoding='GB2312'")   
		xmldoc.appendChild(version)
		Dim   root   
		Set   root   =   xmldoc.CreateNode("element","progress","")  
		xmldoc.appendChild(root)
		'总图片数量
		Set   childNode0  =   xmldoc.CreateNode("element","totalbytes","")
		childNode0.Text   =   PicCount 
		root.appendChild(childNode0)
		'已生成数量
		Set   childNode1  =   xmldoc.CreateNode("element","uploadbytes","")
		childNode1.Text   =   0  
		root.appendChild(childNode1)
		'已成成比例
		Set   childNode2  =   xmldoc.CreateNode("element","percentbytes","")
		childNode2.Text   =   0
		root.appendChild(childNode2)
		xmldoc.save(Server.Mappath(xmlPath))
		set xmldoc=nothing
	end function
'++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
'清除临时文件夹下所有文件
	dim FolderList,FileList
	function ClearTemp(path)
		set fso=new dmfso
		If  Not fso.CheckFolder(path)  Then                   
			fso.CreateFolder(path)
		else
			FileList=fso.GetFileList(path)
			FileListKey=Split(FileList,"|")
			For I = 1  To Ubound(FileListKey)
				fso.DelFile(path&"/"&FileListKey(I))
			Next
			FolderList=fso.GetFolderList(path)
			FolderListKey=Split(FolderList,"|")
			For I = 1  To Ubound(FolderListKey)
				fso.DelFolder(path&"/"&FolderListKey(I))
			Next
		End If
		set fso=nothing
	end function
%>