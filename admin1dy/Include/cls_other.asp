<%
'--------------------杂乱处理函数--------------------
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
'整理：逸乐
' ============================================
' 生成4位随机数
' ============================================
Sub RndNum()
 Dim zNum
 Randomize
 zNum = cint(8999*Rnd+1000)
 Session("ybVerifycode") = zNum
 Response.Write zNum
End Sub

' ============================================
'判断用户权限
' ============================================
Function checkflag(flag)
 if flag="" then
   checkflag=false
   Exit Function
 end if
 if instr(session("flag"),flag)<1 then
  checkflag=false
  exit function
 else
  checkflag=true 
 end if
end Function

'判断权限
'==================================================
'生成上传文件名函数 filenamestr
'==================================================
function filenamestr()
   str=now()
   strs=split(str," ")
   strsa=split(strs(0),"-")
   strsb=split(strs(1),":")
   filenamestr=""
   filenamestr=filenamestr&strsa(0)
   filenamestr=filenamestr&strsa(1)
   filenamestr=filenamestr&strsa(2)
   filenamestr=filenamestr&strsb(0)
   filenamestr=filenamestr&strsb(1)
   filenamestr=filenamestr&strsb(2)
end function

function filenametime(str)
  arr=split(str,"-")
  filenametime=arr(0)&arr(1)&arr(2)
end function
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
%>
 