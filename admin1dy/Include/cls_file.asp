<% '***************************
'名称：FSO操作类
'***************************
Class DmFso 

Private Fso
Public  FsoObj

Private Sub Class_Initialize
 Set Fso=Server.CreateObject("Scripting.FileSystemObject")
 Set FsoObj=Fso
End Sub

Private Sub Class_Terminate
 Set Fso=Nothing
 Set FsoObj=Nothing
End Sub

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
 GetPath=Server.MapPath(FileDir)
End Function

Function GetFileSize(FileName)   
'//功能：取文件大小   
'//形参：文件名   
'//返回值：成功为文件大小，失败为-1   
'//   
Dim f   
If ReportFileStatus(FileName) = 1 Then   
Set f = fso.Getfile(FileName)   
GetFileSize = f.Size   
Else   
GetFileSize = -1   
End if   
End Function  

'2.使用FSO删除指定文件  
Function deleteAFile(filespec)   
'//功能：文件删除   
'//形参：文件名   
'//返回值：成功为1，失败为-1   
'//   
If ReportFileStatus(filespec) = 1 Then   
fso.deleteFile(filespec)   
deleteAFile = 1   
Else   
deleteAFile = -1   
End if   
End Function  

'3.FSO显示指定目录下的所有文件

Function ShowFileList(folderspec)   
'//功能：目录存在时显示此目录下的所有文件   
'//形参：目录名   
'//返回值：成功为文件列表，失败为-1   
'//   
Dim f, f1, fc, s   
If ReportFolderStatus(folderspec) = 1 Then   
Set f = fso.GetFolder(folderspec)   
Set fc = f.Files   
For Each f1 in fc   
s = s & f1.name   
s = s & "|"   
Next   
ShowFileList = s   
Else   
ShowFileList = -1   
End if   
End Function 

'4.使用fso复制指定文件  

Function CopyAFile(SourceFile,DestinationFile)   
'//功能：源文件存在时，才能对文件进行复制，目的文件无影响   
'//形参：源文件，目的文件   
'//返回值：成功为1，失败为-1   
'//   
Dim MyFile   
If ReportFileStatus(SourceFile) = 1 Then   
Set MyFile = fso.GetFile(SourceFile)   
MyFile.Copy (DestinationFile)   
CopyAFile = 1   
Else   
CopyAFile = -1   
End if   
End Function  

'5.源文件存在时目的文件不存在时才能对文件进行移动

'Response.Write MoveAFile("f:\123\4561.exe","f:\123\4562.txt")   
Function MoveAFile(SourceFile,DestinationFile)   
'//形参：源文件，目的文件   
'//返回值：成功为1，失败为-1   
'//   
If ReportFileStatus(SourceFile)=1 And ReportFileStatus(DestinationFileORPath) =-1 Then   
fso.MoveFile SourceFile,DestinationFileORPath   
MoveAFile = 1   
Else   
MoveAFile = -1   
End if   
End Function  

'6.FSO判断指定文件是否存在？  

Function ReportFileStatus(FileName)   
'//功能：判断文件是否存在   
'//形参：文件名   
'//返回值：成功为1，失败为-1   
'//   
Dim msg   
msg = -1   
If (fso.FileExists(FileName)) Then   
msg = 1   
Else   
msg = -1   
End If   
ReportFileStatus = msg   
End Function  

'7.FSO读取文件创建日期  

Function ShowDatecreated(filespec)   
'//功能：文件创建日期   
'//形参：文件名   
'//返回值：成功：文件创建日期，失败：-1   
'//   
Dim f   
If ReportFileStatus(filespec) = 1 Then   
Set f = fso.GetFile(filespec)   
ShowDatecreated = f.Datecreated   
Else   
ShowDatecreated = -1   
End if   
End Function


'8.FSO显示文件读写权限属性  


Function GetAttributes(FileName)   
'//功能：显示文件属性   
'//形参：文件名   
'//返回值：成功：文件属性，失败：-1   
'//   
Dim f,Str   
If ReportFileStatus(FileName) = 1 Then   
Set f = fso.GetFile(FileName)   
select Case f.attributes   
Case 0 Str="普通文件。没有设置任何属性。 "   
Case 1 Str="只读文件。可读写。 "   
Case 2 Str="隐藏文件。可读写。 "   
Case 4 Str="系统文件。可读写。 "   
Case 16 Str="文件夹或目录。只读。 "   
Case 32 Str="上次备份后已更改的文件。可读写。 "   
Case 1024 Str="链接或快捷方式。只读。 "   
Case 2048 Str=" 压缩文件。只读。"   
End select   
GetAttributes = Str   
Else   
GetAttributes = -1   
End if   
End Function  

 

'9.FSO显示指定文件最后一次访问/最后一次修改时间  

'Response.Write ShowFileAccessInfo("文件路径")   
Function ShowFileAccessInfo(FileName,InfoType)   
'//功能：显示文件创建时信息   
'//形参：文件名,信息类别   
'// 1 -----创建时间   
'// 2 -----上次访问时间   
'// 3 -----上次修改时间   
'// 4 -----文件路径   
'// 5 -----文件名称   
'// 6 -----文件类型   
'// 7 -----文件大小   
'// 8 -----父目录   
'// 9 -----根目录   
'//返回值：成功为文件创建时信息，失败：-1   
'//   
Dim f, s   
If ReportFileStatus(FileName) = 1 then   
Set f = fso.GetFile(FileName)   
select Case InfoType   
Case 1 s = f.Datecreated '// 1 -----创建时间   
Case 2 s = f.DateLastAccessed '// 2 -----上次访问时间   
Case 3 s = f.DateLastModified '// 3 -----上次修改时间   
Case 4 s = f.Path '// 4-----文件路径   
Case 5 s = f.Name '// 5 -----文件名称   
Case 6 s = f.Type '// 6-----文件类型   
Case 7 s = f.Size '// 7-----文件大小   
Case 8 s = f.ParentFolder '// 8 -----父目录   
Case 9 s = f.RootFolder '// 8 -----根目录   
End select   
ShowFileAccessInfo = s   
ELse   
ShowFileAccessInfo = -1   
End if   
End Function  

'10.FSO写指定内容到文本文件  


Function WriteTxtFile(FileName,TextStr,WriteORAppendType)   
Const ForReading = 1, ForWriting = 2 , ForAppending = 8   
Dim f, m   
select Case WriteORAppendType   
Case 1: '文件进行写操作   
Set f = fso.OpenTextFile(FileName, ForWriting, True)   
f.Write TextStr   
f.Close   
If ReportFileStatus(FileName) = 1 then   
WriteTxtFile = 1   
Else   
WriteTxtFile = -1   
End if   
Case 2: '文件末尾进行写操作
If ReportFileStatus(FileName) = 1 then   
Set f = fso.OpenTextFile(FileName, ForAppending)   
f.Write TextStr   
f.Close   
WriteTxtFile = 1   
Else   
WriteTxtFile = -1   
End if   
End select   
End Function 

'11.利用FSO读取文本文件内容  


Function ReadTxtFile(FileName)   
Const ForReading = 1, ForWriting = 2   
Dim f, m   
If ReportFileStatus(FileName) = 1 then   
Set f = fso.OpenTextFile(FileName, ForReading)   
m = f.ReadLine   
'm = f.ReadAll   
'f.SkipLine   
ReadTxtFile = m   
f.Close   
Else   
ReadTxtFile = -1   
End if   
End Function  

 

'12.FSO返回文件夹目录空间大小

Function GetFolderSize(FolderName)   
'//功能：取目录大小   
'//形参：目录名   
'//返回值：成功为目录大小，失败为-1   
'//   
Dim f   
If ReportFolderStatus(FolderName) = 1 Then   
Set f = fso.GetFolder(FolderName)   
GetFolderSize = f.Size   
Else   
GetFolderSize = -1   
End if   
End Function 

'13.使用FSO创建文件夹  

Function createFolderDemo(FolderName)   
'//功能：创建的文件夹   
'//形参：目录名   
'//返回值：成功为1，失败为-1   
'//   
Dim f   
If ReportFolderStatus(Folderspec) = 1 Then   
createFolderDemo = -1   
Else   
Set f = fso.createFolder(FolderName)   
createFolderDemo = 1   
End if   
End Function  

'14.FSO删除指定文件夹目录  

Function deleteAFolder(Folderspec)   
'//功能：目录删除   
'//形参：目录名   
'//返回值：成功为1，失败为-1   
'//   
'Response.write Folderspec   
If ReportFolderStatus(Folderspec) = 1 Then   
fso.deleteFolder (Folderspec)   
deleteAFolder = 1   
Else   
deleteAFolder = -1   
End if   
End Function 

'15.FSO显示指定目录的文件夹目录列表

Function ShowFolderList(folderspec)   
'//功能：目录存在时显示此目录下的所有子目录   
'//形参：目录名   
'//返回值：成功为子目录列表，失败为-1   
'//   
Dim f, f1, fc, s   
If ReportFolderStatus(folderspec) = 1 Then   
Set f = fso.GetFolder(folderspec)   
Set fc = f.SubFolders   
For Each f1 in fc   
s = s & f1.name   
s = s & "|"   
Next   
ShowFolderList = s   
Else   
ShowFolderList = -1   
End if   
End Function  

'16.FSO复制指定文件夹目录

Function CopyAFolder(SourceFolder,DestinationFolder)   
'//功能：源目录存在时，才能对目录进行复制，目的目录无影响   
'//形参：源目录，目的目录   
'//返回值：成功为1，失败为-1   
'//   
Dim MyFolder   
If ReportFolderStatus(SourceFolder) = 1 and ReportFolderStatus(DestinationFolder) = -1 Then   
Set MyFolder = fso.GetFolder(SourceFolder)   
fso.CopyFolder SourceFolder,DestinationFolder   
CopyAFolder = 1   
Else   
CopyAFolder = -1   
End if   
End Function 

'17.移动指定文件夹目录  


Function MoveAFolder(SourcePath,DestinationPath)   
'//功能：源目录存在时目的目录不存在时才能对目录进行移动   
'//形参：源目录，目的目录   
'//返回值：成功为1，失败为-1   
'//   
If ReportFolderStatus(SourcePath)=1 And ReportFolderStatus(DestinationPath)=0 Then   
fso.MoveFolder SourcePath, DestinationPath   
MoveAFolder = 1   
Else   
MoveAFolder = -1   
End if   
End Function 

'18.判断某目录是否存在  

'Response.Write ReportFolderStatus("G:\soft\delphi\my_pro\")   
Function ReportFolderStatus(fldr)   
'//功能：判断目录是否存在   
'//形参：目录   
'//返回值：成功为1，失败为-1     
Dim msg   
msg = -1   
If (fso.FolderExists(fldr)) Then   
msg = 1   
Else   
msg = -1   
End If   
ReportFolderStatus = msg
End Function 

'19.显示目录创建时信息  

Function ShowFolderAccessInfo(FolderName,InfoType)   
'//功能：显示目录创建时信息   
'//形参：目录名,信息类别   
'// 1 -----创建时间   
'// 2 -----上次访问时间   
'// 3 -----上次修改时间   
'// 4 -----目录路径   
'// 5 -----目录名称   
'// 6 -----目录类型   
'// 7 -----目录大小   
'// 8 -----父目录   
'// 9 -----根目录   
'//返回值：成功为目录创建时信息，失败：-1   
'//   
Dim f, s   
If ReportFolderStatus(FolderName) = 1 then   
Set f = fso.GetFolder(FolderName)   
select Case InfoType   
Case 1 s = f.Datecreated '// 1 -----创建时间   
Case 2 s = f.DateLastAccessed '// 2 -----上次访问时间   
Case 3 s = f.DateLastModified '// 3 -----上次修改时间   
Case 4 s = f.Path '// 4-----文件路径   
Case 5 s = f.Name '// 5-----文件名称   
Case 6 s = f.Type '// 6-----文件类型   
Case 7 s = f.Size '// 7-----文件大小   
Case 8 s = f.ParentFolder '// 8 -----父目录   
Case 9 s = f.RootFolder '// 9 -----根目录   
End select   
ShowFolderAccessInfo = s   
ELse   
ShowFolderAccessInfo = -1   
End if   
End Function  

'20.返回文件夹嵌套数

Function DisplayLevelDepth(pathspec)   
Dim f, n ,Path   
Set f = fso.GetFolder(pathspec)   
If f.IsRootFolder Then   
DisplayLevelDepth ="指定的文件夹是根文件夹。"&RootFolder   
Else   
Do Until f.IsRootFolder   
Path = Path & f.Name &"<br>"   
Set f = f.ParentFolder   
n = n + 1   
Loop   
DisplayLevelDepth ="指定的文件夹是嵌套级为 " & n & "的文件夹。<br />"&Path   
End If   
End Function  

'21.判断指定磁盘驱动器是否存在？  

'Response.Write ReportDriveStatus("C:\")   
Function ReportDriveStatus(drv)   
'//功能：判断磁盘是否存在   
'//形参：磁盘   
'//返回值：成功为1，失败为-1   
'//   
Dim msg   
msg = -1   
If fso.DriveExists(drv) Then   
msg = 1   
Else   
msg = -1   
End If   
ReportDriveStatus = msg   
End Function  

 

'22.FSO返回指定磁盘可用的类型包括 FAT、NTFS 和 CDFS。  

'Response.Write ShowFileSystemType("C:\")   
Function ShowFileSystemType(drvspec)   
'//功能：磁盘类型   
'//形参：磁盘名   
'//返回值：成功为类型：FAT、NTFS 和 CDFS，失败：-1   
'//   
Dim d   
If ReportDriveStatus(drvspec) = 1 Then   
Set d = fso. GetDrive(drvspec)   
ShowFileSystemType = d.FileSystem   
ELse   
ShowFileSystemType = -1   
End if   
End Function 

 


Function FormatSize(Byval SizeNum)
 FormatSize=SizeNum&"&nbsp;Byte"
 If SizeNum>1024 Then
  SizeNum=(SizeNum/1024)
  FormatSize=Formatnumber(SizeNum,2)&"&nbsp;KB"
 End If
 If SizeNum>1024 Then
  SizeNum=(SizeNum/1024)
  FormatSize=Formatnumber(SizeNum,2)&"&nbsp;MB"
 End If
 If SizeNum>1024 Then
  SizeNum=(SizeNum/1024)
  FormatSize=Formatnumber(SizeNum,2)&"&nbsp;GB"
 End If
End Function

 

'得到文件的前缀
Function Get_FilenamePrefix(Filename)
 Tempstr = split(Filename,".") 
 
 Prefix = ""
 
 For i=0 to UBound(Tempstr)-1
  Prefix = Prefix & Tempstr(i)
  If i < UBound(Tempstr)-1 Then Prefix = Prefix & "."  
 Next
 
 Get_FilenamePrefix = Prefix
End Function

'得到文件的后缀
Function Get_FilenameSuffix(Filename)
 Tempstr = split(Filename,".")
 Get_FilenameSuffix = Tempstr(UBound(Tempstr))
End Function

Function bytes2BSTR(vIn)
 Dim strReturn,i,ThisCharCode,innerCode,Hight8,Low8,NextCharCode
 strReturn = ""
 For i = 1 To LenB(vIn)
 ThisCharCode = AscB(MidB(vIn,i,1))
 If ThisCharCode < &H80 Then
 strReturn = strReturn & Chr(ThisCharCode)
 Else
 NextCharCode = AscB(MidB(vIn,i+1,1))
 strReturn = strReturn & Chr(CLng(ThisCharCode) * &H100 + CInt(NextCharCode))
 i = i + 1
 End If
 Next
 bytes2BSTR = strReturn 
End Function


 '检查目录是否存在！(sFolderPath,sIsCreate 不存在是否创建)
 Public Function CheckDir(sFolderPath,sIsCreate)
  On Error Resume Next
  Dim objFSO,sTrPath
  sTrPath=sFolderPath
  CheckDir=False:err=0
  Set objFSO = Server.CreateObject(Trim(cl.Web_Info(13)))
  If objFSO.FolderExists(Server.MapPath(sTrPath)) Then
   CheckDir=True
   Set objFSO = Nothing
   Exit Function
  Else
   if sIsCreate=True then
    objFSO.CreateFolder Server.MapPath(sTrPath)
    if err=0 then CheckDir=True
   end if
   Set objFSO = Nothing
  End If
  err=0
 End Function

 

 

End Class

 %>