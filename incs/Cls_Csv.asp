<%
	'读取CSV文件内容
	Function LoadFile(str)
		On Error Resume Next
		Dim LoadTempStr,Stream
		IF Len(str)=0 Then Exit Function
		LoadTempStr=Empty
		Set Stream=Server.CreateObject("adodb.stream")
		Stream.Type=2'1－二进制，2－文本
		Stream.mode=3 '1－读，2－写，3－读写
		Stream.charset="Unicode"
		Stream.open
		Stream.loadfromfile Server.MapPath(str)
		LoadTempStr=Stream.readtext
		Stream.Close
		Set Stream=Nothing
		IF Err Then
			LoadFile=""
		Else
			LoadFile=LoadTempStr
		End IF
	End Function
	
	Function GetFolder(path)
		Dim KeyPath,I,TempPath,FolderID	
		TempPath=CreatFolder&"/"
		if GetIsNull(path) then
			GetFolder=0
		else
			KeyPath=split(Path,"/")
			if UBound(KeyPath) > 0 Then
				TempID=0
				for I=0 To UBound(KeyPath)
					dim TempKeyPath,TempKeyName,TempKPath
					TempKeyPath=""
					TempKeyName=""
					TempKPath=""
					if CreatNewFolder(TempPath&KeyPath(I)) then
						if CheckNumeric(TempID)=0 then
							TempKeyPath="/"
						else
							TempKeyName=DBGetValue("Liu_Folder","kname"," kid="&TempID&" and kuser='"&UserName&"' and klevel="&I-1&"")
							TempKPath=DBGetValue("Liu_Folder","kpath"," kid="&TempID&" and kuser='"&UserName&"' and klevel="&I-1&"")
							TempKeyPath=TempKPath&TempKeyName&"/"
						end if
						TempID=GetFolderId(TempID,KeyPath(I),I,UserName,TempKeyPath)
						TempPath=TempPath&KeyPath(I)&"/"
						'TempID=DBGetValue("Liu_Folder","kid"," kname='"&KeyPath(I)&"'and kuser='"&UserName&"' and klevel="&I&"")
					else						
						TempID=DBGetValue("Liu_Folder","kid"," kname='"&KeyPath(I)&"'and kuser='"&UserName&"' and upid="&TempID&" and klevel="&I&"")
						TempPath=TempPath&KeyPath(I)&"/"
					end if
				next
				GetFolder=TempID
			else
				if CreatNewFolder(TempPath&Path) then
					GetFolder=GetFolderId(0,Path,0,UserName,"/")
					'GetFolder=TempPath&Path&"/"
					'GetFolder=DBGetValue("Liu_Folder","kid"," kname='"&Path&"'and kuser='"&UserName&"' and klevel=0")
				else
					GetFolder=DBGetValue("Liu_Folder","kid"," kname='"&Path&"'and kuser='"&UserName&"' and klevel=0")
				end if
			end if
		end if
	End Function
	Function GetFolderId(upid,kname,klevel,UserName,kpath)
		On Error Resume Next
		Conn.Execute("insert into [Liu_Folder] (kname,upid,klevel,kuser,kpath) values('"&kname&"',"&upid&","&klevel&",'"&UserName&"','"&kpath&"')")
		GetFolderId=DBGetNum("Liu_Folder","kid",1,"Where Kuser='"&UserName&"'")
	End Function
	'创建文件夹
	Function CreatNewFolder(FolderPath)
		dim fso
		set fso=new dmfso
		if Not fso.CheckFolder(FolderPath) then
			CreatNewFolder=fso.CreateFolder(FolderPath)
		else
			CreatNewFolder=false
		end if		
		set fso=nothing
	End Function	
	
	'显示图片
	Function ShowPic(str)
		On Error Resume Next
		Dim ObjRegExp,Matchs,Strs,Match,RetStr
		Strs=""
		RetStr=""
		Set ObjRegExp = New Regexp
		ObjRegExp.IgnoreCase = True
		ObjRegExp.Global = True '设置为全文搜索
		ObjRegExp.Pattern = "<img.+?>" '为了确保能准确地取出图片地址所以分为两层配置：首先找到里面的<img>标签， 
		Strs=trim(str)   
		Set Matches =ObjRegExp.Execute(strs)'开始执行配置   
		For Each Match in Matches   
			RetStr = RetStr &GetImages( Match.Value )'执行第二轮的匹配
		Next
		IF Err Then
			ShowPic=""
		Else
			ShowPic = RetStr
		End IF  
		 
	End Function
	'获取所有图片地址
	Function GetImages(str)
		Dim objRegExp,Match,Matchs
		GetImages=""   
		Set objRegExp = New Regexp   
		objRegExp.IgnoreCase = True   
		objRegExp.Global = True   
		objRegExp.Pattern = "http://.+?"""'取出里面的地址   
		set Matchs=objRegExp.Execute(str)   
		For Each Match in Matchs
			GetImages=GetImages&left(Match.Value,len(Match.Value)-1)&"||$$$||"'把里面的地址串起来备用   
		next   
	End Function
	'取得图片内容 
	Function GetHttpPage(url)
		On Error Resume Next  
		dim Http
		set Http=server.createobject("Msxml2.ServerXMLHTTP")'使用xmlhttp的方法来获得图片的内容   
		Http.open "GET",url,false
		Http.send()
		if Http.readystate<>4 then   
			exit function
		end if
		GetHttpPage=Http.responseBody
		set Http=nothing   
		if err.number<>0 then err.Clear
	End Function	
	'保存远程图片 
	Function SaveImages(StrUrl,StrFileName)
		On Error Resume Next
		Dim GetUrl,ObjStream,Imgs
		GetUrl=trim(StrUrl)   
		Imgs=GetHttpPage(GetUrl)	'取得图片的具休内容的过程
		Set ObjStream = Server.CreateObject("ADODB.Stream")		'建立ADODB.Stream对象，必须要ADO 2.5以上版本   
		ObjStream.Type =1	'以二进制模式打开
		ObjStream.Open
		ObjStream.write Imgs	'将字符串内容写入缓冲
		ObjStream.SaveToFile server.mappath(StrFileName),2	'-将缓冲的内容写入文件
		ObjStream.Close()	'关闭对象
		set ObjStream=nothing
		IF Err Then
			SaveImages = false
		Else
			SaveImages = true
		End IF  
	End Function
	'保存Csv文件
	Function SaveCsv(Content,StrFileName)
		On Error Resume Next
		Dim ObjStream
		Set ObjStream = Server.CreateObject("ADODB.Stream")		'建立ADODB.Stream对象，必须要ADO 2.5以上版本   
		ObjStream.Type =2	'以二进制模式打开
		ObjStream.mode=3 
		ObjStream.Open
		ObjStream.WriteText Content	'将字符串内容写入缓冲
		ObjStream.SaveToFile server.mappath(StrFileName),2	'-将缓冲的内容写入文件
		ObjStream.Close()	'关闭对象
		set ObjStream=nothing
		IF Err Then
			SaveCsv = false
		Else
			SaveCsv = true
		End IF  
	End Function	
	'判断图片是否存在
	Function CheckURL(strUrl)
		On Error Resume Next
		Dim XMLHTTP
		'set XMLHTTP = Server.CreateObject("Microsoft.XMLHTTP")
		set XMLHTTP = Server.CreateObject("Msxml2.ServerXMLHTTP")
		XMLHTTP.open "HEAD",strUrl,false
		XMLHTTP.send()
		'CheckURL=(XMLHTTP.status=200)
		IF Err Then
			CheckURL=false
		else
			CheckURL=(XMLHTTP.Readystate=4)
		end if
		
		set XMLHTTP = nothing
	End Function
	'返回指定URL的
	Function ParseURL(strURL, strPart) 
		Dim arrTemp, strTemp, nPos 
		'On Error Resume Next 
		Select Case LCase(strPart) 
			Case "http" 
				nPos = InStr(strURL, ":") + 1 
				Do Until (Mid(strURL, nPos, 1) <> "/") And (Mid(strURL, nPos, 1) <> "\") 
					nPos = nPos + 1 
				Loop 
				ParseURL = Left(strURL, nPos - 1) 
			Case "server"
				strTemp = ParseURL(strURL, "http") 
				strURL = Right(strURL, Len(strURL) - Len(strTemp)) 
				If InStr(strURL, "/") Then 
					strTemp = Left(strURL, InStr(strURL, "/") - 1) 
				ElseIf InStr(strURL, "\") Then 
					strTemp = Left(strURL, InStr(strURL, "\") - 1) 
				End If 
				If InStr(strTemp, "@") Then 
					ParseURL = Right(strTemp, Len(strTemp) - InStr(strTemp, "@")) 
				Else 
					ParseURL = strTemp 
				End If 
			Case "domain" 
				strTemp = ParseURL(strURL, "server") 
				arrTemp = Split(strTemp, ".") 
				ParseURL = arrTemp(UBound(arrTemp) - 1) & "." & arrTemp(UBound(arrTemp)) 
			Case "path"
				strTemp = ParseURL(strURL, "server")
				If InStr(strURL, "#") Then strURL = Left(strURL, InStr(strURL, "#") - 1) 
				If InStr(strURL, "?") Then strURL = Left(strURL, InStr(strURL, "?") - 1) 
				If InStrRev(strURL, "/") > InStrRev(strURL, "\") Then
					ParseURL = Left(strURL, InStrRev(strURL, "/"))
					'ParseURL = Replace(strURL,strTemp,"")
				ElseIf InStrRev(strURL, "\") > InStrRev(strURL, "/") Then 
					ParseURL = Left(strURL, InStrRev(strURL, "\"))
					'ParseURL = Replace(strURL,strTemp,"")
				End If		
		End Select 
		If Err.Number <> 0 Then ParseURL = "" 
	End Function
%>