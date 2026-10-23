<%
Function GetUserShowPic(UserName,Types)
	Dim Sid,TempUrl
	Sid=CheckNumeric(DBGetValue("Liu_User","Sid"," UserName='"&UserName&"'"))'获取用户服务器
	if Types="img" then
		TempUrl="/datafiles/Users/"
	elseif Types="up" then
		if Sid=0 Then
			TempUrl="http://www.1dy.cc/"
		else
			TempUrl="http://up"&Sid&".1dy.cc/"
		end if
	end if
	GetUserShowPic=TempUrl
End Function

Function Checkstr(Str)
	If Isnull(Str) Then
		CheckStr = ""
		Exit Function 
	End If
	Str = Replace(Str,Chr(0),"")
	CheckStr = Replace(Str,"'","''")
End Function

Function CheckNumeric(Byval CHECK_ID)
	If CHECK_ID<>"" and IsNumeric(CHECK_ID) Then _
		CHECK_ID = cCur(CHECK_ID) _
	Else _
		CHECK_ID = 0
	CheckNumeric = CHECK_ID
End Function
'====================================================================================
'函数名：GetIsNull
'作  用：判断是否为空
'====================================================================================
Public Function GetIsNull(str)
	if str="" or Isnull(str) or Isempty(str) then
		GetIsNull=true
	else
		GetIsNull=false
	end if
end function
'==================================================
'函数名：fixjs 
'作 用：过滤数变量中函有单引号
'================================================== 
Function fixjs(Str)
	If Str <>"" Then
'		str = replace(str,"\", "\\")
'		Str = replace(str, chr(34), "\""")
'		Str = replace(str, chr(39),"\'")
		str = replace(str,"'", "&#39;")
	End If
	fixjs=Str
End Function

Function enfixjs(Str)
	If Str <>"" Then
		Str = replace(str,"&#39;", "'")
		Str = replace(str,"\""" , chr(34))
		Str = replace(str, "\'",chr(39))
		Str = replace(str,"\\", "\")
	End If
	enfixjs=Str
End Function

'==================================================
'函数名：FormatFileSize 
'作 用：转换空间大小 
'参 数：SizeNum ------ 数字型 
'================================================== 
Function FormatFileSize(Byval SizeNum)
	FormatFileSize=SizeNum&"&nbsp;Byte"
	If SizeNum>1024 Then
		SizeNum=(SizeNum/1024)
		FormatFileSize=Formatnumber(SizeNum,2)&"&nbsp;KB"
	End If
	If SizeNum>1024 Then
		SizeNum=(SizeNum/1024)
		FormatFileSize=Formatnumber(SizeNum,2)&"&nbsp;MB"
	End If
	If SizeNum>1024 Then
		SizeNum=(SizeNum/1024)
		FormatFileSize=Formatnumber(SizeNum,2)&"&nbsp;GB"
	End If
End Function
'==================================================  

'函数名：ServUPassEnCode 
'作 用：Serv-U软件密码加密函数 
'参 数：strPass ------ 字符串 
'================================================== 
Function SerUPassEnCode(strPass) 
Dim Char1,Char2,Seed,prePass,EncodePass,FinalPass 
If IsNull(strPass) Or strPass="" Then Exit Function 
Char1 = Chr(Rand(97,122)) 
Char2 = Chr(Rand(97,122))

Seed = Char1 & Char2 

prePass = Seed & strPass 
EnCodePass = Ucase(md5(prePass,"long")) '32位md5 
FinalPass = Seed & EnCodePass 
SerUPassEnCode = FinalPass 
End Function 

'================================================== 
'函数名：Rand 
'作 用：取两个整数之间的随机数 
'参 数：n,m ------ 整数
'================================================== 
Function Rand(n,m) 
Dim a,b,t 
a = n : b = m 
If b < a Then t = b : b = a : a = t 
Randomize 
Rand = Int(rnd*(b-a+1)+a) 
End Function
'-------------------字符处理函数---------------------
'****************************************************
'函数名：Rw
'作  用：输出字符串
'参  数：str ----字符串内容
'返回值：字符串
'****************************************************
Function Rw(ByVal Str)
	Response.Write(Str)
End Function
'****************************************************
'函数名：Rf
'作  用：缓冲输出字符串
'参  数：str ----字符串内容
'返回值：字符串
'****************************************************
Function Rf(ByVal Str)
	Response.Write(Str)
	Response.Flush()
End Function
'****************************************************
'函数名：RwEnd
'作  用：结束输出字符串
'参  数：str ----字符串内容
'返回值：字符串
'****************************************************
Function RwEnd(ByVal Str)
	Response.Write(Str)
	Response.End()
End Function
'****************************************************
'函数名：ReUrl
'作  用：跳转Url地址
'参  数：Url ----Url地址
'返回值：Url地址
'****************************************************
Function ReUrl(ByVal Url)
	Response.Redirect(Url)
End Function
'****************************************************
'函数名：GoReferer
'作  用：跳转会上一页地址
'参  数：无
'返回值：Url地址
'****************************************************
Function GoReferer()
	Response.Redirect(Request.ServerVariables("HTTP_REFERER"))
End Function
'****************************************************
'函数名：GetLen
'作  用：获取字符串长度
'参  数：Str ----字符串
'返回值：字符串长度
'****************************************************
Function GetLen(ByVal Str)
	Dim X,Y,I,M,C
	Str=Trim(Str)
	If IsNull(Str) Then
		GetLen=0
		Exit Function
	End If
	X=Len(Str)
	Y=0
	For I = 1 To X
		M=Mid(Str,I,1)
		C=Asc(M)
		If C<0 Then C=C+65536
		If C>255 Then
			Y=Y+2
		Else
			Y=Y+1
		End If
	Next
	GetLen=Y
End Function
'****************************************************
'函数名：LeftStr
'作  用：获取字符串
'参  数：Str ----字符串 Length截取长度
'返回值：要截取的字符串
'****************************************************
Function LeftStr(ByVal Str,ByVal Length)
	Dim X,Y,I,M,C
	Str=Trim(Str)
	If IsNull(Str) Then
		LeftStr=""
		Exit Function
	End If
	X=Len(Str)
	Y=0
	For I = 1 To X
		M=Mid(Str,I,1)
		C=Asc(M)
		If C<0 Then C=C+65536
		If C>255 Then
			Y=Y+2
		Else
			Y=Y+1
		End If
		If Y>=Length Then
			'LeftStr=Left(Str,I)&"..."
			LeftStr=Left(Str,I)
			Exit For
		Else
			LeftStr=Str
		End If
	Next
End Function
'****************************************************
'函数名：GetSpell
'作  用：获取字符串的拼音
'参  数：Str ----字符串 Length截取长度
'返回值：字符串的拼音
'****************************************************
Function GetSpell(ByVal Str,ByVal Length)
	On Error Resume Next
	Str=Replace(Str,"/","")
	Str=Replace(Str,"\","")
	Str=Replace(Str,"?","")
	Str=Replace(Str,";","")
	Str=Replace(Str,":","")
	Str=Replace(Str,"""","")
	Str=Replace(Str,"|","")
	Str=Replace(Str,"<","")
	Str=Replace(Str,">","")
	Str=Replace(Str,"'","")
	Str=Replace(Str,"~","")
	Str=Replace(Str,"!","")
	Str=Replace(Str,"@","")
	Str=Replace(Str,"#","")
	Str=Replace(Str,"$","")
	Str=Replace(Str,"%","")
	Str=Replace(Str,"^","")
	Str=Replace(Str,"&","")
	Str=Replace(Str,"*","")
	Str=Replace(Str,"+","")
	Str=Replace(Str,"-","")
	Str=Replace(Str,",","")
	Str=Replace(Str,".","")
	Str=Replace(Str," ","")
	Str=Replace(Str,"  ","")
	Dim SpellStr,I,Rs,Key
	SpellStr=""
	For I = 1 To Len(Str)
		Key=Mid(Str,I,1)
		Set Rs=Conn.Execute("Select Spell From Dm_Spell Where Chinese='"&Key&"'")
		If Not(Rs.Bof And Rs.Eof) Then
			If GetLen(Key)=1 Then 
				SpellStr=SpellStr&Key
			Else
				SpellStr=SpellStr&Rs(0)
			End If
		End If
		Rs.Close
		Set Rs=Nothing
	Next
	GetSpell=Left(Trim(SpellStr),Length)
End Function
'****************************************************
'函数名：IIf
'作  用：简化If Else End If
'参  数：blnBool条件 Str1结果1 Str2结果2
'返回值：字符串
'****************************************************
Function IIf(ByVal blnBool,ByVal Str1,ByVal Str2)
	If (blnBool) Then
		IIf=Str1
	Else
		IIf=Str2
	End If
End Function

'-------------------检测过滤函数---------------------
'****************************************************
'函数名：CheckNum
'作  用：检测是否为数字
'参  数：Str - 字符串
'返回值：不是数字返回0 是数字返回数字
'****************************************************
Function CheckNum(Byval Str)
	If IsNumeric(Str)=False Then
		CheckNum=0
		Exit Function
	Else
		CheckNum=Clng(Str)
	End If
End Function
'****************************************************
'函数名：CheckStr
'作  用：过滤危险字符
'参  数：Str - 字符串
'返回值：返回字符串
'****************************************************
Function CheckStr(ByVal Str)
	If Str="" Or IsNull(Str) Then
		CheckStr=""
		Exit Function
	End If
	'Str=LCase(Str)
	Str=Replace(Str,Chr(0),"")
	Str=Replace(Str,"""","&quot;")
	Str=Replace(Str,"'","''")
	Str=Replace(Str,"=","&#061")
	Str=Replace(Str,"<","&lt;")
	Str=Replace(Str,">","&gt;")
	Str=Replace(Str,"[","&#091;")
	Str=Replace(Str,"]","&#093;")
	Str=Replace(Str,"select","sel&#101;ct")
	Str=Replace(Str,"execute","&#101;xecute")
	Str=Replace(Str,"exec","&#101;xec")
	Str=Replace(Str,"join","jo&#105;n")
	Str=Replace(Str,"insert","ins&#101;rt")
	Str=Replace(Str,"delete","del&#101;te")
	Str=Replace(Str,"update","up&#100;ate")
	Str=Replace(Str,"drop","dro&#112;")
	Str=Replace(Str,"create","cr&#101;ate")
	Str=Replace(Str,"truncate","trunc&#097;te")
	Str=Replace(Str,"chr","c&#104;r")
	Str=Replace(Str,"count","co&#117;nt")
	Str=Replace(Str,"mid","m&#105;d")
	Str=Replace(Str,"char","ch&#097;r")
	Str=Replace(Str,"alter","alt&#101;r")
	Str=Replace(Str,"exists","e&#120;ists")
	Str=Replace(Str,"script","&#115;cript")
	Str=Replace(Str,"object","&#111;bject")
	Str=Replace(Str,"applet","&#097;pplet")
	CheckStr=Str
End Function
'****************************************************
'函数名：CheckName
'作  用：名字字符检验	
'参  数：str ----字符串
'返回值：true无误，false有误
'****************************************************
Function CheckName(Str)
	If Str="" Or IsNull(Str) Then
		CheckName=False
		Exit Function
	End If
	CheckName=True
	Dim Rep,Pass
	Set Rep=New RegExp
	Rep.Global=True
	Rep.IgnoreCase=True
	Rep.Pattern="^[a-zA-Z_u4e00-\u9fa5][\w\u4e00-\u9fa5]+$"
	Set Pass=Rep.Execute(Str)
	If Pass.Count=0 Then CheckName=false
	Set Rep=Nothing
End Function
'****************************************************
'函数名：CheckEmail
'作  用：邮箱格式检测
'参  数：str ----Email地址
'返回值：true无误，false有误
'****************************************************
Function CheckEmail(Str)
	If Str="" Or IsNull(Str) Then
		CheckEmail=False
		Exit Function
	End If
	CheckEmail=True
	Dim Rep,Pass
	Set Rep=New RegExp
	Rep.Pattern="([\.a-zA-Z0-9_-]){2,10}@([a-zA-Z0-9_-]){2,10}(\.([a-zA-Z0-9]){2,}){1,4}$"
	Pass=Rep.Test(Str)
	Set Rep=Nothing
	If Not Pass Then CheckEmail=False
End Function
'****************************************************
'函数名：CheckPost
'作  用：检测上一页是否从本站提交
'参  数：无
'返回值：True是，False否
'****************************************************
Function CheckPost()
	Dim Http_Referer,Server_Name
	Http_Referer=CStr(Request.ServerVariables("HTTP_REFERER"))
	Server_Name=CStr(Request.ServerVariables("SERVER_NAME"))
	If Mid(Http_Referer,8,Len(Server_Name))=Server_Name Then
		CheckPost=True
	Else
		CheckPost=False
	End If
End Function
'****************************************************
'函数名：HtmlCode
'作  用：过滤Html标记
'参  数：Str ----字符串
'返回值：过滤后的字符串
'****************************************************
Function HtmlCode(Str)
	If Str="" Or IsNull(Str) Then
		HtmlCode=""
		Exit Function
	End If
	Str=replace(Str,">","&gt;")
	Str=replace(Str,"<","&lt;")
	Str=Replace(Str,CHR(32)," ")
	Str=Replace(Str,CHR(9),"&nbsp;")
	Str=Replace(Str,CHR(34),"&quot;")
	Str=Replace(Str,CHR(39),"&#39;")
	Str=Replace(Str,CHR(13),"")
	Str=Replace(Str,CHR(10),"")
	Str=Replace(Str,"script","&#115cript")
	HtmlCode=Str
End Function
'****************************************************
'函数名：HtmlDel
'作  用：清理所有html标记
'参  数：Str ----字符串
'返回值：过滤后的字符串
'****************************************************
Function HtmlDel(Str)
	If Str="" Or IsNull(Str) Then
		HtmlDel=""
		Exit Function
	End If
	Dim Rep,Pass
	Set Rep=New RegExp
	Rep.Global=True
	Rep.IgnoreCase=True
	Rep.Pattern="(<.+?>)"
	HtmlDel=Rep.Replace(Str,"")
	Set Rep=Nothing
End Function
'****************************************************
'函数名：CheckBadWord
'作  用：过滤替换不允许的脏话
'参  数：Str ----字符串
'返回值：过滤后的字符串
'****************************************************
Function CheckBadWord(BadWordStr,Str)
	Dim I,Key
	Key=Split(BadWordStr,",")
	For I = 0 To Ubound(Key)
		Str=Replace(Str,Key(I)&",","*")
	Next
	CheckBadWord=Str
End Function
'****************************************************
'函数名：StopSql
'作  用：防止SQL注入
'参  数：无
'返回值：输出文本信息
'****************************************************
Function StopSql2()
StopSql=""
End Function

Function StopSql()
	Badwords= "'||''||;||and||exec||insert||select||update||delete||count||*||%||chr||mid||master||truncate||char||declare"
	Badword=Split(Badwords,"||")
	If Request.Form<>"" Then
		For Each TF_Post In Request.Form
			For i=0 To Ubound(Badword)
				If Instr(LCase(Request.Form(TF_Post)),Badword(i))>0 Then
					'Call OpenDB()
					'Sql="Insert InTo Dm_SqlIn(SqlInUrl,SqlMethod,SqlTag,SqlInIP,SqlInTime)Values('"&Replace(GetUrl,"'","''")&"','POST','"&Replace(Badword(i),"'","''")&"','"&GetIP()&"','"&Now()&"')"
					'Conn.Execute(Sql)
					'Call CloseDB()
					response.Write Replace(Badword(i),"'","''")
					Rw ("<div style=""border:1px #ccc solid;background:#f8f8f8;padding:10px;"">")&vbcrlf
					Rw ("<li>操作错误,您的操作已被系统记录！</li>")&vbcrlf
					Rw ("<li>您的IP："&GetIP()&"</li>")&vbcrlf
					Rw ("<li>提交方式：POST</li>")&vbcrlf
					Rw ("<li>提交时间："&Now()&"</li>")&vbcrlf
					RwEnd ("</div>")
					Exit function
				End If
			Next
		Next
	End If
	If Request.QueryString<>"" Then
		For Each TF_Get In Request.QueryString
			For i=0 To Ubound(Badword)
				If Instr(LCase(Request.QueryString(TF_Get)),Badword(i))>0 Then
					'Call OpenDB()
					'Sql="Insert InTo Dm_SqlIn(SqlInUrl,SqlMethod,SqlTag,SqlInIP,SqlInTime)Values('"&Replace(GetUrl,"'","''")&"','GET','"&Replace(Badword(i),"'","''")&"','"&GetIP()&"','"&Now()&"')"
					'Conn.Execute(Sql)
					'Call CloseDB()
					Rw ("<div style=""border:1px #ccc solid;background:#f8f8f8;padding:10px;"">")&vbcrlf
					Rw ("<li>操作错误,您的操作已被系统记录！</li>")&vbcrlf
					Rw ("<li>您的IP："&GetIP()&"</li>")&vbcrlf
					Rw ("<li>提交方式：GET</li>")&vbcrlf
					Rw ("<li>提交时间："&Now()&"</li>")&vbcrlf
					RwEnd ("</div>") 
					Exit function
				End If
			Next
		Next
	End If
End Function
'-------------------其他一些函数---------------------
'****************************************************
'函数名：RunTime
'作  用：程序运行时间
'参  数：StartTime ----开始运行时间
'返回值：运行时间
'****************************************************
Function RunTime(ByVal StartTime)
	Dim EndTime
	EndTime=Timer()
	RunTime=FormatNumber((EndTime-StartTime)*1000,3)
End Function
'****************************************************
'函数名：RandNumber
'作  用：获得随机数字
'参  数：StartNum-开始数 EndNum-结束数
'返回值：随机数字
'****************************************************
Function RandNumber(ByVal StartNum,ByVal EndNum)
	Randomize
	RandNumber=Int((EndNum-StartNum)*Rnd) + StartNum
End Function
'****************************************************
'函数名：FormatTime
'作  用：格式化时间
'参  数：TimeStr-时间 Types-获取样式
'返回值：时间
'****************************************************
Function FormatTime(ByVal TimeStr,ByVal Types)
	Dim D_Year,D_Month,D_Day
	Dim D_Hour,D_Minute,D_Second
	If TimeStr="" Or IsNull(TimeStr) Then
		TimeStr=Now
	End If
	If Not (IsDate(TimeStr)) Then
		FormatTime=""
		Exit Function
	End If
	D_Year=Year(TimeStr)
	D_Month=Month(TimeStr)
	D_Day=Day(TimeStr)
	D_Hour=Hour(TimeStr)
	D_Minute=Minute(TimeStr)
	D_Second=Second(TimeStr)
	If Len(D_Month)<2 Then D_Month="0"&D_Month
	If Len(D_Day)<2 Then D_Day="0"&D_Day
	If Len(D_Hour)<2 Then D_Hour="0"&D_Hour
	If Len(D_Minute)<2 Then D_Minute="0"&D_Minute
	If Len(D_Second)<2 Then D_Second="0"&D_Second
	Select Case Types
		Case 1'2000-10-10 23:45:45
		FormatTime=D_Year&"-"&D_Month&"-"&D_Day&"-"&D_Hour&":"&D_Minute&":"&D_Second
		Case 2'年-月-日 时:分:秒
		FormatTime=D_Year&"年"&D_Month&"月"&D_Day&"日"&D_Hour&"时"&D_Minute&"分"&D_Second&"秒"
		Case 3'10-10
		FormatTime=D_Month&"-"&D_Day
		Case 4'2003-10-10
		FormatTime=D_Year&"-"&D_Month&"-"&D_Day
		Case 5'2003年10月10日
		FormatTime=D_Year&"年"&D_Month&"月"&D_Day&"日"
		Case 6'20031010102562
		FormatTime=D_Year&D_Month&D_Day&D_Hour&D_Minute&D_Second
		Case Else
	End Select
	FormatTime=FormatTime
End Function
'****************************************************
'函数名：JoinRandomCode
'作  用：加入乱码防采集
'参  数：Content-内容字符串 Tags-加乱码的标记
'参  数：Author-作者 Url-地址 Stype-是否加入版权
'返回值：时间
'****************************************************
Function JoinRandomCode(Byval Content,Byval Tags,ByVal Author,Byval Url,ByVal Stype)
	Dim I,K,RandNum,Result
	If IsNull(Content) Then
		JoinRandomCode=""
		Exit Function
	End If
	Content=Lcase(Content)
	K=InStr(Content,"<"&Tags&">")
	Do While K > 0
		Result=""
		For I = 0 To 19
			Randomize
			RandNum=Int((128 * Rnd)+1)
			If RandNum = 60 Or RandNum = 62 Then
				RandNum = RandNum + 1
			End If
			Result=Result&Chr(RandNum)
		Next
		Result="<span style='display:none'>"&Result&"</span>"
		Content=Replace(Content,"<"&Tags&">",Result&"<'"&Tags&">",1,1)
		K=InStr(Content,"<"&Tags&">")
	Loop
	Content=Replace(Content,"<'"&Tags&">","<"&Tags&">")
	If Stype=1 Then
		Content=Content&"<div style='text-align:right;color:#ccc;'>"
		Content=Content&"[本文作者及"&Author&"共同拥有 转载请注明出处 "&Url&"]</div>"&vbcrlf
	End If
	JoinRandomCode=Content
End Function

'-------------------信息提示函数---------------------
'****************************************************
'函数名：ShowErr
'作  用：Js弹出信息 并返回上一页
'参  数：Str ----字符串
'返回值：弹出信息 返回上一页
'****************************************************
Function ShowErr(ByVal Str)
	Response.Write("<script>alert('"&Str&"');history.back(-1);</script>")
	Response.End
End Function
'****************************************************
'函数名：ShowSucc
'作  用：Js弹出信息 并跳转
'参  数：Str-字符串 Url-要跳转的地址
'返回值：弹出信息 并跳转
'****************************************************
Function ShowSucc(ByVal Str,Byval Url)
	Response.Write("<script>alert('"&Str&"');location.href=('"&Url&"');</script>")
	Response.End()
End Function
'****************************************************
'函数名：ShowErrMsg
'作  用：文本错误提示信息
'参  数：Str-字符串
'返回值：文本错误提示信息
'****************************************************
Function ShowErrMsg(Str)
	Dim TempStr
	TempStr=TempStr&"<meta http-equiv=refresh content=3;url=javascript:history.go(-1)>"
	TempStr=TempStr&"<table border=""0"" cellspacing=""1"" cellpadding=""0"" class=""msg"" align=""center"">"
	TempStr=TempStr&"  <tr valign=""top"">"
	TempStr=TempStr&"    <td colspan=""2"" class=""msgt"">错误提示信息</td>"
	TempStr=TempStr&"  </tr>"
	TempStr=TempStr&"  <tr valign=""top"">"
	TempStr=TempStr&"    <td class=""msgp""><img src=""Images/err.gif""/></td>"
	TempStr=TempStr&"    <td class=""msgm"">"
	TempStr=TempStr&"    <b style='color:blue;'><span id=jump>3</span> 秒钟后系统将自动返回</b><br>"
	TempStr=TempStr&"	 <li>产生错误的可能原因：</li>"&Str&""
	TempStr=TempStr&"    </td>"
	TempStr=TempStr&"  </tr>"
	TempStr=TempStr&"  <tr>"
	TempStr=TempStr&"    <td colspan=""2"" class=""msgb""><a href='javascript:history.go(-1);'>返回上一页</a></td>"
	TempStr=TempStr&"  </tr>"
	TempStr=TempStr&"</table>"
	TempStr=TempStr&"<script>function countDown(secs){jump.innerText=secs;if(--secs>0)setTimeout(""countDown(""+secs+"")"",1000);}countDown(3);</script>"
	Response.Write(TempStr)
	Response.End()
End Function
'****************************************************
'函数名：ShowSuccMsg
'作  用：文本成功提示信息
'参  数：Str-字符串
'返回值：文本成功提示信息
'****************************************************
Function ShowSuccMsg(Str,ReUrl)
	Dim TempStr
	If ReUrl<>"" Then
		TempStr=TempStr&"<meta http-equiv=refresh content=3;url="&ReUrl&">"
	Else
		TempStr=TempStr&"<meta http-equiv=refresh content=3;url="&Request.ServerVariables("HTTP_REFERER")&">"
	End If
	TempStr=TempStr&"<table border=""0"" cellspacing=""1"" cellpadding=""0"" class=""msg"" align=""center"">"
	TempStr=TempStr&"  <tr valign=""top"">"
	TempStr=TempStr&"    <td colspan=""2"" class=""msgt"">成功提示信息</td>"
	TempStr=TempStr&"  </tr>"
	TempStr=TempStr&"  <tr valign=""top"">"
	TempStr=TempStr&"    <td class=""msgp""><img src=""Images/succ.gif""/></td>"
	TempStr=TempStr&"    <td class=""msgm"">"
	TempStr=TempStr&"    <b style='color:blue;'><span id=jump>3</span> 秒钟后系统将自动返回</b><br>"
	TempStr=TempStr&"	 "&Str&""
	TempStr=TempStr&"    </td>"
	TempStr=TempStr&"  </tr>"
	TempStr=TempStr&"  <tr>"
	TempStr=TempStr&"    <td colspan=""2"" class=""msgb""><a href="&Request.ServerVariables("HTTP_REFERER")&">返回上一页</a></td>"
	TempStr=TempStr&"  </tr>"
	TempStr=TempStr&"</table>"
	TempStr=TempStr&"<script>function countDown(secs){jump.innerText=secs;if(--secs>0)setTimeout(""countDown(""+secs+"")"",1000);}countDown(3);</script>"
	Response.Write(TempStr)
	Response.End()
End Function

'--------------获取客户端和服务器端信息函数----------
'****************************************************
'函数名：IsObjInstalled
'作  用：检测组件是否支持
'参  数：strClassString-组件名称
'返回值：支持True 不支持False
'****************************************************
Function IsObjInstalled(strClassString)
	On Error Resume Next
	IsObjInstalled = False
	Err = 0
	Dim xTestObj
	Set xTestObj = Server.CreateObject(strClassString)
	If 0 = Err Then IsObjInstalled = True
	Set xTestObj = Nothing
	Err = 0
End Function
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
'****************************************************
'函数名：GetIP
'作  用：获取客户端IP
'参  数：无
'返回值：IP地址
'****************************************************
Function GetIP()
	Dim strIPAddr 
	If Request.ServerVariables("HTTP_X_FORWARDED_FOR")="" Or InStr(Request.ServerVariables("HTTP_X_FORWARDED_FOR"), "unknown")>0 Then 
		strIPAddr=Request.ServerVariables("REMOTE_ADDR") 
	ElseIf InStr(Request.ServerVariables("HTTP_X_FORWARDED_FOR"), ",")>0 Then 
		strIPAddr=Mid(Request.ServerVariables("HTTP_X_FORWARDED_FOR"),1,InStr(Request.ServerVariables("HTTP_X_FORWARDED_FOR"),",")-1) 
	ElseIf InStr(Request.ServerVariables("HTTP_X_FORWARDED_FOR"), ";")>0 Then 
		strIPAddr=Mid(Request.ServerVariables("HTTP_X_FORWARDED_FOR"),1,InStr(Request.ServerVariables("HTTP_X_FORWARDED_FOR"),";")-1) 
	Else 
		strIPAddr=Request.ServerVariables("HTTP_X_FORWARDED_FOR") 
	End If 
	GetIP=Trim(Mid(strIPAddr,1,30)) 
End Function
'****************************************************
'函数名：GetBrowser
'作  用：获取客户端浏览器信息
'参  数：无
'返回值：客户端浏览器信息
'****************************************************
Function GetBrowser()
	Dim InfoStr,Browser
	InfoStr=Request.ServerVariables("HTTP_USER_AGENT") 
	If Instr(InfoStr,"NetCaptor 6.5.0")>0 Then
		Browser="NetCaptor 6.5.0"
	ElseIf Instr(InfoStr,"MyIe 3.1")>0 Then
		Browser="MyIe 3.1"
	ElseIf Instr(InfoStr,"NetCaptor 6.5.0RC1")>0 Then
		Browser="NetCaptor 6.5.0RC1"
	ElseIf Instr(InfoStr,"NetCaptor 6.5.PB1")>0 Then
		Browser="NetCaptor 6.5.PB1"
	ElseIf Instr(InfoStr,"MSIE 5.5")>0 Then
		Browser="Internet Explorer 5.5"
	ElseIf Instr(InfoStr,"MSIE 6.0")>0 Then
		Browser="Internet Explorer 6.0"
	ElseIf Instr(InfoStr,"MSIE 6.0b")>0 Then
		Browser="Internet Explorer 6.0b"
	ElseIf Instr(InfoStr,"MSIE 5.01")>0 Then
		Browser="Internet Explorer 5.01"
	ElseIf Instr(InfoStr,"MSIE 5.0")>0 Then
		Browser="Internet Explorer 5.00"
	ElseIf Instr(InfoStr,"MSIE 4.0")>0 Then
		Browser="Internet Explorer 4.01"
	Else
		Browser="其它"
	End If
	GetBrowser=Browser
End Function
'****************************************************
'函数名：GetSystem
'作  用：获取客户端操作系统
'参  数：无
'返回值：客户端操作系统
'****************************************************
Function GetSystem()
	Dim InfoStr,System
	InfoStr=Request.ServerVariables("HTTP_USER_AGENT") 
	If Instr(InfoStr,"NT 5.1")>0 Then
		System="Windows XP"
	ElseIf Instr(InfoStr,"Tel")>0 Then
		System="Telport"
	ElseIf Instr(InfoStr,"webzip")>0 Then
		System="webzip"
	ElseIf Instr(InfoStr,"flashget")>0 Then
		System="flashget"
	ElseIf Instr(InfoStr,"offline")>0 Then
		System="offline"
	ElseIf Instr(InfoStr,"NT 5")>0 Then
		System="Windows 2000"
	ElseIf Instr(InfoStr,"NT 4")>0 Then
		System="Windows NT4"
	ElseIf Instr(InfoStr,"98")>0 Then
		System="Windows 98"
	ElseIf Instr(InfoStr,"95")>0 Then
		System="Windows 95"
	ElseIf instr(InfoStr,"unix") or instr(InfoStr,"linux") or instr(InfoStr,"SunOS") or instr(InfoStr,"BSD") Then
		System="类Unix"
	ElseIf instr(thesoft,"Mac") Then
		System="Mac"
	Else
		System="其它"
	End If
	GetSystem=System
End Function
'****************************************************
'函数名：SendMail
'作  用：用Jmail组件发送邮件
'参  数：ServerAddress-服务器地址
'参  数：AddRecipient-收信人地址
'参  数：Subject-主题 Body-信件内容 Sender-发信人地址
'****************************************************
Function SendMail(MailServerAddress,AddRecipient,Subject,Body,Sender,MailFrom)
	On Error Resume Next
	Dim JMail
	Set JMail=Server.CreateObject("JMail.SMTPMail")
	If err then
		SendMail= "没有安装JMail组件"
		err.clear
		exit function
	End If
	JMail.Logging=True
	JMail.Charset="gb2312"
	JMail.ContentType = "text/html"
	JMail.ServerAddress=MailServerAddress
	JMail.AddRecipient=AddRecipient
	JMail.Subject=Subject
	JMail.Body=MailBody
	JMail.Sender=Sender
	JMail.From = MailFrom
	JMail.Priority=1
	JMail.Execute 
	Set JMail=nothing 
	If err Then
		SendMail=err.description
		err.clear
	Else
		SendMail="OK"
	End If
End Function

'---------------------数据库相关函数-----------------
'****************************************************
'函数名：DBDel
'作  用：删除指定条件的数据
'****************************************************
Function DBDel(Table,WhereStr)
	Dim Sql
	Sql="Delete From "&Table&" Where "&WhereStr&""
	Conn.Execute(Sql)
End Function
'****************************************************
'函数名：DBUpdate
'作  用：修改指定条件和字段的内容
'****************************************************
Function DBUpdate(Table,UpVale,WhereStr)
	Dim Sql
	Sql="Update "&Table&" Set "&UpVale&" Where "&WhereStr&""
	Conn.Execute(Sql)
End Function
'****************************************************
'函数名：DBGetNum
'作  用：查询某字段数量 最大值或最小值
'****************************************************
Function DBGetNum(Table,FieldName,sType,WhereStr)
	Dim Rs,Sql
	Select Case sType
		Case 0
			Sql="Select Count("&FieldName&") From "&Table&" "&WhereStr&""
		Case 1
			Sql="Select Max("&FieldName&") From "&Table&" "&WhereStr&""
		Case 2
			Sql="Select Min("&FieldName&") From "&Table&" "&WhereStr&""
	End Select
	Set Rs=Conn.Execute(Sql)
	If Rs.Bof And Rs.Eof Then
		DBGetNum=0
	Else
		DBGetNum=Rs(0)
	End If
	Rs.Close
	Set Rs=Nothing
End Function
'****************************************************
'函数名：DBExist
'作  用：查询某字段的内容是否有重复
'****************************************************
Function DBExist(Table,FieldName,WhereStr)
	Dim Rs,Sql
	Sql="Select "&FieldName&" From "&Table&" Where "&WhereStr&""
	Set Rs=Conn.Execute(Sql)
	If Rs.Bof And Rs.Eof Then
		DBExist=False
	Else
		DBExist=True
	End If
	Rs.Close
	Set Rs=Nothing
End Function
'****************************************************
'函数名：DBGetValue
'作  用：查询指定条件某字段的内容
'****************************************************
Function DBGetValue(Table,FieldName,WhereStr)
	Dim Rs,Sql
	Sql="Select "&FieldName&" From "&Table&" Where "&WhereStr&""
	Set Rs=Conn.Execute(Sql)
	If Rs.Bof And Rs.Eof Then
		DBGetValue=""
	Else
		DBGetValue=Rs(0)
	End If
	Rs.Close
	Set Rs=Nothing
End Function

'---------------------其他相关函数-------------------
'****************************************************
'函数名：SplitStr
'作  用：分割字符串
'参  数：Str-字符串 Key-分割标记 Stype-样式
'返回值：字符串
'*****************************************************
Function SplitStr(Str,Key,Stype)
	Dim TempStr
	TempStr=Split(Str,Key)
	If Stype=1 Then
		SplitStr=TempStr(0)
	ElseIf Stype=2 Then
		SplitStr=TempStr(UBound(TempStr))
	ElseIf Stype=3 Then
		SplitStr=TempStr(UBound(TempStr)-1)
	ElseIf Stype=4 Then
		SplitStr=Replace(Str,TempStr(UBound(TempStr)),"")
	Else
		SplitStr=TempStr(0)
	End If
End Function
'****************************************************
'函数名：CheckFileExt
'作  用：检测文件类型是否允许
'参  数：FileExt 文件后缀名 UpAllowExt允许的后缀名
'*****************************************************
Function CheckFileExt(FileExt,UpAllowExt)
	Dim Key
	Key=Split(UpAllowExt,";")
	FileExt=Lcase(FileExt)
	FileExt=Trim(FileExt)
	FileExt=Ltrim(FileExt)
	FileExt=Rtrim(FileExt)
	If Key(Ubound(Key))="" Or Len(Key(Ubound(Key)))<1 Then
		KeyEnd=Ubound(Key)-1
	Else
		KeyEnd=Ubound(Key)
	End If
	For I = 0 To KeyEnd
		If Key(I)<>""Then
			Key(I)=Ltrim(Key(I))
			Key(I)=Rtrim(Key(I))
			Key(I)=Trim(Key(I))
			Key(I)=Lcase(Key(I))
			If FileExt=Key(I) Then
				CheckFileExt=True
				Exit Function
			End If
			If FileExt="asp" Or FileExt="php" Or FileExt="js" Or FileExt="html" Or FileExt="htm" Or FileExt="aspx" Or FileExt="asa" Then
				CheckFileExt=False
			End If
			If FileExt<>Key(I) Then
				CheckFileExt=False
			End If
		End if
	Next
End Function
'==================================================
'过程名：GetImgRootPath
'作  用：取得图片绝对于根目录的路径
'参  数：FolderDir ------ 文件夹
'==================================================
Function GetImgRootPath(ImgPath)
	Dim TestPath,RootPath
	TestPath=Server.MapPath(ImgPath)
	RootPath=Request.ServerVariables("APPL_PHYSICAL_PATH")
	TestPath=Replace(TestPath,RootPath,"")
	TestPath=Replace(TestPath,"\","/")
	TestPath="/"&TestPath
	GetImgRootPath=TestPath
End Function
'==================================================
'过程名：GetImgCount
'作  用：取得文章中图片数量
'参  数：str ------ 文章内容
'参  数：strpath ------ 保存图片的路径
'==================================================
Function GetImgList(ConStr)
	set objregEx=new RegExp
	objregEx.IgnoreCase=true
	objregEx.Global=true
	objregEx.Pattern="(src=).+?(jpg|gif|bmp|png)"
	set matches = objregEx.Execute(ConStr)
	Dim I
	I=0
	for each match in matches
		retstr = retstr &"||"& Match.Value
		I=I+1
	next
	if retstr<>"" then
		GetImgList=retstr
	else
		GetImgList=retstr
	end If
End Function
'****************************************************
'函数名：GetBody
'作  用：截取字符串
'参  数：ConStr-字符串 StartStr-开始代码 OverStr-结束代码 
'参  数：IncluL-是否包含开始代码 IncluR-是否包含结束代码
'返回值：截取后的字符串
'*****************************************************
Function GetBody(ConStr,StartStr,OverStr,IncluL,IncluR)
   If ConStr="$False$" or ConStr="" or IsNull(ConStr)=True Or StartStr="" or IsNull(StartStr)=True Or OverStr="" or IsNull(OverStr)=True Then
      GetBody="$False$"
      Exit Function
   End If

   Dim Start,Over
   Start = InStrB(1, ConStr, StartStr, vbBinaryCompare)
   If Start<=0 then
      GetBody="$False$"
      Exit Function
   Else
      If IncluL=False Then
         Start=Start+LenB(StartStr)
      End If
   End If
   Over=InStrB(Start,ConStr,OverStr,vbBinaryCompare)
   If Over<=0 Or Over<=Start then
      GetBody="$False$"
      Exit Function
   Else
      If IncluR=True Then
         Over=Over+LenB(OverStr)
      End If
   End If
   GetBody=MidB(ConStr,Start,Over-Start)
End Function
%>