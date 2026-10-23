<%
Class DmImg

Private Fso

Private Sub Class_Initialize
	Set Fso=Server.CreateObject("Scripting.FileSystemObject")
End Sub

Private Sub Class_Terminate
	Set Fso=Nothing
End Sub

Function GetPath(Byval FileDir)
	GetPath=Server.MapPath(FileDir)
End Function

Function CheckFile(Byval FileDir)
	If Fso.FileExists(GetPath(FileDir)) Then
		CheckFile=True
	Else
		CheckFile=False
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

Function IsImage(Byval FileDir)
	On Error Resume Next
	IsImage=False
	Err.Number=0
	Dim WiaImg
	Set WiaImg=Server.CreateObject("WIA.ImageFile")
	WiaImg.LoadFile GetPath(FileDir)
	If Err.Number=0 And WiaImg.Width>0 Then
		IsImage=True
	End If
	Set WiaImg=Nothing
	Err.Clear
End Function

Function GetWiaFormatId(Byval FileDir)
	Dim ext
	ext=Lcase(Mid(FileDir,InstrRev(FileDir,".")+1))
	Select Case ext
		Case "jpg","jpeg"
			GetWiaFormatId="{B96B3CAE-0728-11D3-9D7B-0000F81EF32E}"
		Case "png"
			GetWiaFormatId="{B96B3CAF-0728-11D3-9D7B-0000F81EF32E}"
		Case "gif"
			GetWiaFormatId="{B96B3CB0-0728-11D3-9D7B-0000F81EF32E}"
		Case "bmp"
			GetWiaFormatId="{B96B3CAB-0728-11D3-9D7B-0000F81EF32E}"
		Case "tiff","tif"
			GetWiaFormatId="{B96B3CB1-0728-11D3-9D7B-0000F81EF32E}"
		Case Else
			GetWiaFormatId="{B96B3CAE-0728-11D3-9D7B-0000F81EF32E}"
	End Select
End Function

Function CreatePerPic(ImgPath,SavePath,PreType,PreWidth,PreHeight,PreFix)
	If ImgPath="" Or CheckFile(ImgPath)=False Then
		CreatePerPic=False
		Exit Function
	End If
	On Error Resume Next
	Dim ImgKey,ImgName
	If InStr(ImgPath,"/")>0 Or InStr(ImgPath,"\")>0 Then
		ImgPath=Replace(ImgPath,"/","\")
		ImgKey=Split(ImgPath,"\")
		ImgName=ImgKey(Ubound(ImgKey))
	Else
		ImgName=ImgPath
	End If

	Dim WiaImg,WiaProc
	Set WiaImg=Server.CreateObject("WIA.ImageFile")
	WiaImg.LoadFile GetPath(ImgPath)
	If Err.Number<>0 Then
		Set WiaImg=Nothing
		Err.Clear
		CreatePerPic=False
		Exit Function
	End If

	Dim PicWidth,PicHeight
	PicWidth=WiaImg.Width
	PicHeight=WiaImg.Height

	Dim n_BuildWidth,n_BuildHeight

	If PreType=1 Then
		If PicWidth<=100 And PicHeight<=100 Then
			Set WiaImg=Nothing
			If CopyFile(ImgPath,SavePath&PreFix&ImgName) Then
				CreatePerPic=SavePath&"/"&PreFix&ImgName
			End If
			Exit Function
		End If
		If PicWidth/PreWidth > PicHeight/PreHeight Then
			n_BuildWidth=PreWidth
			n_BuildHeight=PicHeight*PreWidth/PicWidth
		Else
			n_BuildWidth=PicWidth*PreHeight/PicHeight
			n_BuildHeight=PreHeight
		End If
	ElseIf PreType=3 Then
		If PicWidth<=730 And PicHeight<=730 Then
			Set WiaImg=Nothing
			If CopyFile(ImgPath,SavePath&"/"&PreFix&ImgName) Then
				CreatePerPic=SavePath&"/"&PreFix&ImgName
			End If
			Exit Function
		End If
		If PicWidth>PreWidth Then
			n_BuildWidth=PreWidth
			n_BuildHeight=PicHeight*PreWidth/PicWidth
		ElseIf PicHeight>PreHeight Then
			n_BuildWidth=PicWidth*PreHeight/PicHeight
			n_BuildHeight=PreHeight
		Else
			n_BuildWidth=PicWidth
			n_BuildHeight=PicHeight
		End If
	Else
		If PicWidth<=PreWidth And PicHeight<=PreHeight Then
			n_BuildWidth=PicWidth
			n_BuildHeight=PicHeight
		ElseIf PicWidth/PicHeight > PreWidth/PreHeight Then
			n_BuildWidth=PreWidth
			n_BuildHeight=Int(PicHeight*PreWidth/PicWidth)
		Else
			n_BuildHeight=PreHeight
			n_BuildWidth=Int(PicWidth*PreHeight/PicHeight)
		End If
	End If

	Set WiaProc=Server.CreateObject("WIA.ImageProcess")
	WiaProc.Filters.Add WiaProc.FilterInfos("Scale").FilterID
	Err.Clear
	WiaProc.Filters(1).Properties("MaximumWidth")=n_BuildWidth
	WiaProc.Filters(1).Properties("MaximumHeight")=n_BuildHeight
	WiaProc.Filters(1).Properties("PreserveAspectRatio")=True
	WiaProc.Filters(1).Properties("Upscale")=False
	Err.Clear

	If PreType<>2 Then
		WiaProc.Filters.Add WiaProc.FilterInfos("Convert").FilterID
		WiaProc.Filters(2).Properties("FormatID")=GetWiaFormatId(ImgName)
		Err.Clear
		If Lcase(Mid(ImgName,InstrRev(ImgName,".")+1))="jpg" Or Lcase(Mid(ImgName,InstrRev(ImgName,".")+1))="jpeg" Then
			WiaProc.Filters(2).Properties("Quality")=85
		End If
		Err.Clear
	End If

	Dim WiaResult
	Set WiaResult=WiaProc.Apply(WiaImg)
	If Err.Number<>0 Then
		Set WiaProc=Nothing
		Set WiaImg=Nothing
		Err.Clear
		CreatePerPic=False
		Exit Function
	End If

	Dim saveAbsPath
	saveAbsPath=GetPath(SavePath)&"\"&PreFix&ImgName
	WiaResult.SaveFile saveAbsPath
	If Err.Number<>0 Then
		Set WiaResult=Nothing
		Set WiaProc=Nothing
		Set WiaImg=Nothing
		Err.Clear
		CreatePerPic=False
		Exit Function
	End If

	Set WiaResult=Nothing
	Set WiaProc=Nothing
	Set WiaImg=Nothing
	Err.Clear
	CreatePerPic=SavePath&"/"&PreFix&ImgName
	CreatePerPic=Replace(CreatePerPic,"//","/")
End Function

Function DrawText(ImgPath,DrawTextStr,DrawFontSize,DrawFontColor,DrawFont,DrawBold,DrawPlace,DrawWidth,DrawHeight)
	DrawText=False
End Function

Function DrawPic(ImgPath,DrawPicStr,DrawPlace,DrawClarity,DrawPicColor,DrawWidth,DrawHeight)
	DrawPic=False
End Function

End Class
%>