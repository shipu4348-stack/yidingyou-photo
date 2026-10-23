<object runat="server" id="DvStream" progid="ADODB.Stream"></object>
<% 

Class Cls_err
Public ScriptPath
public fileurl,fso
	'==================================================
	'检测文件 返回值 真:1 假:0
	'==================================================
	Public Function fileex(files)
	  fileurl=server.MapPath(files)
	  set fso=server.CreateObject("scripting.filesystemobject") '定义FSO
	  if fso.fileexists(fileurl) then
		fileex=1
	  else
		fileex=0
	  end if
	set fso=nothing '''*****
	End Function
	
	Public Function ReadTextFile(fileName)
		On Error Resume Next
		dim lastname,newlastname,allpath,i,lastfloder
			'Response.Write Server.MapPath(ScriptPath&fileName)
			DvStream.charset="gb2312"
			DvStream.Mode = 3
			DvStream.open()
			if er.fileex(ScriptPath&fileName)=1 then
				DvStream.LoadFromFile(Server.MapPath(ScriptPath&fileName))
  			end if 
			ReadTextFile=DvStream.ReadText
			DvStream.close()
		If Err Then
			err.Clear
 			Response.Clear
			Response.Write ScriptPath&fileName & "文件不存在！请检查,或者恢复官方模板数据s！"
			Response.End
		End If
	End Function


	Function writeToFile(fileName,Text)
		DvStream.charset="gb2312"
		DvStream.Mode = 3
		DvStream.open()
		DvStream.WriteText(Text)
		DvStream.SaveToFile Server.MapPath(ScriptPath&fileName),2
		DvStream.close()
	End Function

 
	
	Function rw (TextStr)   
	Const ForReading = 1, ForWriting = 2 , ForAppending = 8   
	Dim f, m ,fso 
	 Set Fso=Server.CreateObject("Scripting.FileSystemObject")
  		If er.fileex(ScriptPath&"error.txt") = 1 then   
			Set f = fso.OpenTextFile(Server.MapPath(ScriptPath&"error.txt"), ForAppending)   
			f.Write "<li class=errorli><p class=error>"&now()&"调试"&geturl()&"页面错误信息如下：</p><blockquote>"&TextStr&" </blockquote></li>"   
			f.Close   
			rw = 1   
		Else   
			writeToFile ScriptPath&"error.txt","错误调试内容如下：<br>" 
		End if   
 		Set Fso=Nothing 
	End Function 

 
	Private Sub Class_Initialize()
	ScriptPath="/err/"		
	End Sub
	
	'****************************************************
'函数名：GetUrl
'作  用：获取地址栏里的地址
'参  数：无
'返回值：Url地址
'****************************************************
Function GetUrl()
	Dim TempStr
	If LCase(Request.ServerVariables("HTTPS"))="off" Then
		TempStr="http://"
	Else
		TempStr="https://"
	End If
	TempStr=TempStr&Request.ServerVariables("SERVER_NAME")
	If Request.ServerVariables("SERVER_PORT")<>80 Then
		TempStr=TempStr&":"&Request.ServerVariables("SERVER_PORT")
	End If
	TempStr=TempStr&Request.ServerVariables("URL")
	If Trim(Request.QueryString)<>"" Then
		TempStr=TempStr&"?"&Trim(Request.QueryString)
	End If
	GetUrl=TempStr
End Function
End class 
dim er
Set er = New Cls_err
%>