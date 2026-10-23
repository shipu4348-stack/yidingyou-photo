<%
'***************************
'名称：FSO操作类
'***************************
Class DmFso	

Private Fso
Public 	FsoObj

Private Sub Class_Initialize
	Set Fso=Server.CreateObject("Scripting.FileSystemObject")
	Set FsoObj=Fso
End Sub

Private Sub Class_Terminate
	Set Fso=Nothing
	Set FsoObj=Nothing
End Sub

Function ReportFileStatus(FileName)    
	Dim msg   
	msg = -1   
		If (Fso.FileExists(FileName)) Then   
			msg = 1   
		Else   
			msg = -1   
		End If   
	ReportFileStatus = msg   
End Function

Function GetFileSize(FileName)
	Dim f   
	If ReportFileStatus(FileName) = 1 Then   
		Set f = Fso.Getfile(FileName)
		GetFileSize = f.Size  
	Else   
		GetFileSize = -1   
	End if   
End Function

Function GetFolderSize(FolderName)
	Dim Folder
	Set Folder=Fso.GetFolder(FolderName)
	GetFolderSize=Folder.Size
End Function

Function IsObjInstalled(ClassStr)
	On Error Resume Next
	IsObjInstalled=False
	Err=0
	Dim TestObj
	Set TestObj=Server.CreateObject(ClassStr)
	If 0=Err Then IsObjInstalled=True
	Set TestObj=Nothing
	Err=0
End Function

Function GetPath(Byval FileDir)
if FileDir="" or isnull(FileDir) then
 exit function
else
	GetPath=ResolvePath(FileDir)
end if
End Function

Function ResolvePath(Byval p)
	Dim basePath
	If InStr(p, "..") = 0 Then
		ResolvePath = Server.MapPath(p)
		Exit Function
	End If
	basePath = Server.MapPath("/")
	If Right(basePath, 1) = "\" Then basePath = Left(basePath, Len(basePath) - 1)
	p = Replace(p, "\", "/")
	Do While Left(p, 3) = "../"
		basePath = Left(basePath, InStrRev(basePath, "\") - 1)
		p = Mid(p, 4)
	Loop
	ResolvePath = basePath & "\" & Replace(p, "/", "\")
End Function

Function CheckFile(Byval FileDir)
	If Fso.FileExists(GetPath(FileDir)) Then
		CheckFile=True
	Else
		CheckFile=False
	End If
End Function

Function GetFileInfo(Byval FileDir,Byval InfoType)
	If CheckFile(FileDir) Then
		Dim F
		Set F=Fso.GetFile(GetPath(FileDir))
		Select Case InfoType
			Case 1 GetFileInfo=F.Datecreated
			Case 2 GetFileInfo=F.DateLastAccessed
			Case 3 GetFileInfo=F.DateLastModified
			Case 4 GetFileInfo=F.Path
			Case 5 GetFileInfo=F.Name
			Case 6 GetFileInfo=F.Type
			Case 7 GetFileInfo=F.Size
			Case 8 GetFileInfo=F.ParentFolder
			Case 9 GetFileInfo=F.RootFolder
			Case 0 
			GetFileInfo=F.Datecreated&"@"&F.DateLastAccessed&"@"&F.DateLastModified
			GetFileInfo=GetFileInfo&"@"&F.Path&"@"&F.Name&"@"&F.Type&"@"&F.Size
			GetFileInfo=GetFileInfo&"@"&F.ParentFolder
		End Select
		Set F=Nothing
	Else
		GetFileInfo=False
	End If
End Function

Function GetFileExt(FileDir)
	If FileDir<>"" Then
		GetFileExt=Lcase(Mid(FileDir,InstrRev(FileDir,".")+1))
	Else
		GetFileExt=False
	End If
End Function

Function ReadFile(Byval FileDir)
	If CheckFile(FileDir)=False Then
		ReadFile=False
		Exit Function
	Else
		Dim F
		Set F=Fso.OpenTextFile(GetPath(FileDir))
		ReadFile=F.ReadAll
		Set F=Nothing
	End If
End Function

Function CreateFile(Byval FileDir,Byval FileContent,Byval IsMake)
	If CheckFile(FileDir) Then
		If IsMake=True Then
			Dim F
			Set F=Fso.CreateTextFile(GetPath(FileDir),True)
			F.Write FileContent
			CreateFile=True
			Set F=Nothing
		Else
			CreateFile=False
		End If
	Else
		Set F=Fso.CreateTextFile(GetPath(FileDir),True)
		F.Write FileContent
		CreateFile=True
		Set F=Nothing
	End If
End Function

Function WriteFile(Byval FileDir,Byval FileContent,ByVal WriteType)
	If CheckFile(FileDir) Then
		Dim F
		Set F=Fso.OpenTextFile(GetPath(FileDir),WriteType)
		F.Write FileContent
		Set F=Nothing
		WriteFile=True
	Else
		WriteFile=False
	ENd If
End Function

Function MoveFile(Byval FileDir,Byval NewFileDir)
	If CheckFile(FileDir) And  CheckFile(NewFileDir)=False Then
		Fso.MoveFile GetPath(FileDir),GetPath(NewFileDir)
		MoveFile=True
	Else
		MoveFile=False
	End If
End Function

Function CopyFile(Byval FileDir,Byval NewFileDir)
	If CheckFile(FileDir) Then
		Dim F
		Set F=Fso.GetFile(GetPath(FileDir))
		F.Copy (GetPath(NewFileDir))
		CopyFile=True
		Set F=Nothing
	Else
		CopyFile=False
	End If
End Function

Function DelFile(Byval FileDir)
	If CheckFile(FileDir) Then
		Fso.DeleteFile(GetPath(FileDir))
		DelFile=True
	Else
		DelFile=False
	End If
End Function

'判断目录是否存在
Function CheckFolder(Byval FolderDir)
	If Fso.FolderExists(GetPath(FolderDir)) Then
		CheckFolder=True
	Else
		CheckFolder=False
	End If
End Function

Function GetFolderInfo(Byval FolderDir,Byval InfoType)
	If CheckFolder(FolderDir) Then
		Dim F
		Set F=Fso.GetFolder(GetPath(FolderDir))
		Select Case InfoType
			Case 1 GetFolderInfo=F.Datecreated
			Case 2 GetFolderInfo=F.DateLastAccessed
			Case 3 GetFolderInfo=F.DateLastModified
			Case 4 GetFolderInfo=F.Path
			Case 5 GetFolderInfo=F.Name
			Case 6 GetFolderInfo=F.Type
			Case 7 GetFolderInfo=F.Size
			Case 8 GetFolderInfo=F.ParentFolder
			Case 9 GetFolderInfo=F.RootFolder
			Case 0 
			GetFolderInfo=F.Datecreated&"@"&F.DateLastAccessed&"@"&F.DateLastModified
			GetFolderInfo=GetFolderInfo&"@"&F.Path&"@"&F.Name&"@"&F.Type&"@"&F.Size
			GetFolderInfo=GetFolderInfo&"@"&F.ParentFolder
		End Select
		Set F=Nothing
	Else
		GetFolderInfo=False
	End If
End Function

Function CreateFolder(Byval FolderStr)
		Dim absPath,parentAbs,parentVirt,pos
		If CheckFolder(FolderStr) Then
			CreateFolder=False
			Exit Function
		End If
		absPath=GetPath(FolderStr)
		pos=InStrRev(absPath,"\")
		If pos>3 Then
			parentAbs=Left(absPath,pos-1)
			If Not Fso.FolderExists(parentAbs) Then
				parentVirt=Mid(FolderStr,1,InStrRev(Replace(FolderStr,"/","\"),"\")-1)
				If parentVirt<>"" And parentVirt<>FolderStr Then
					CreateFolder(parentVirt)
				End If
			End If
		End If
		Fso.CreateFolder(absPath)
		CreateFolder=True
	End Function

Function MoveFolder(Byval FolderDir,Byval NewFolderDir)
	If CheckFolder(FolderDir) And CheckFolder(NewFolderDir)=False Then
		Fso.MoveFolder GetPath(FolderDir),GetPath(NewFolderDir)
		MoveFolder=True	
	Else
		MoveFolder=False
	End If
End Function

Function CopyFolder(Byval FolderDir,Byval NewFolderDir)
	If CheckFolder(FolderDir) Then
		Fso.CopyFolder GetPath(FolderDir),GetPath(NewFolderDir)
		CopyFolder=True
	Else
		CopyFolder=False
	End If
End Function

Function DelFolder(Byval FolderDir)
	If CheckFolder(FolderDir) Then
		Fso.DeleteFolder(GetPath(FolderDir))
		DelFolder=True
	Else
		DelFolder=False
	End If
End Function

Function GetFolderList(Byval FolderDir)
	If CheckFolder(FolderDir)=False Then
		GetFolderList=False
		Exit Function
	Else
		Dim FolderObj,FolderList,F
		Set FolderObj=Fso.GetFolder(GetPath(FolderDir))
		Set FolderList=FolderObj.SubFolders
		'GetFolderList=FolderObj.SubFolders.Count
		For Each F In FolderList
			GetFolderList=GetFolderList&"|"&F.Name
		Next
		Set FolderList=Nothing
		Set FolderObj=Nothing
	End If
End Function

Function GetFileList(Byval FolderDir)
	If CheckFolder(FolderDir)=False Then
		GetFileList=False
		Exit Function
	Else
		Dim FileObj,FileList,F
		Set FileObj=Fso.GetFolder(GetPath(FolderDir))
		Set FileList=FileObj.Files
		'GetFileList=FileObj.Files.Count
		For Each F In FileList
			GetFileList=GetFileList&"|"&F.Name
		Next
		Set FileList=Nothing
		Set FileObj=Nothing
	End If
End Function

Function FormatSize(Byval SizeNum)
	  SizeNum=(SizeNum/1024/1024)
	  FormatSize=Formatnumber(SizeNum,2)
End Function

Function FormatKSize(Byval SizeNum)
	  SizeNum=(SizeNum/1024)
	  FormatKSize=Formatnumber(SizeNum,0)
End Function

Function FormatFileSize(Byval SizeNum)
	FormatFileSize=SizeNum&"&nbsp;Byte"
	If SizeNum>1024 Then
		SizeNum=(SizeNum/1024)
		FormatFileSize=Formatnumber(SizeNum,2)&"KB"
	End If
	If SizeNum>1024 Then
		SizeNum=(SizeNum/1024)
		FormatFileSize=Formatnumber(SizeNum,2)&"MB"
	End If
	If SizeNum>1024 Then
		SizeNum=(SizeNum/1024)
		FormatFileSize=Formatnumber(SizeNum,2)&"GB"
	End If
End Function

End Class
%>