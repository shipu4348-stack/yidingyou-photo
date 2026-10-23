<% 
'-------------------字符处理函数---------------------
'整理：逸乐
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

Sub FColor(color,str)
    If color="" then
      Rw "<Font color=""Red"">"&str&"</Font>"
      Else
      Rw "<Font color="""&color&""">"&str&"</Font>"
    End If
End Sub
'**************************************************
'函数名：getLink
'作  用：把一个有 HREF 属性的 HTML 锚点放置在 String 对象中的文本两端。 
'参  数：
'Objname  = 需要加超链的文本
'Url   = HREF 超链 
'IsPop   = 是否弹出新窗口
'返回值：加好超链的文本
'**************************************************
 Function getLink(Objname , Url , IsPop)
 Tempstr = "<a href='"&Url&"' "
 
 if IsPop = true then
  Tempstr = Tempstr & "target='_blank'>"
 else
  Tempstr = Tempstr & " >"
 end if
 
 Tempstr = Tempstr & Objname &"</a>"
 getLink = Tempstr 
End Function


'==============================
'获取字符长度GetStrLen
'参数str为指定字符,汉字为2. a,为输出数量
'==============================
Function GetStrLen(str,a)
If IsNull(str) Or str = "" Then
getStrLen = 0
Else
Dim i, n, k, chrA, chrb
k = 0
n = Len(str)
For i = 1 To n
chrA = Mid(str, i, 1)
If Asc(chrA) >= 0 And Asc(chrA) <= 255 Then
k = k + 1
Else
k = k + 2
End If
chrb=chrb & chrA
if k>=a then
exit for
end if
Next
'在此输出K可得字符数量,汉字为2
getStrLen = chrb
End If
End Function
'==================================================
'字符函数 funstr
'判断无效字符
'==================================================
    Function funstr(str)  
    
  str = replace(str, "<", "&lt;", 1, -1, 1)
  str = replace(str, ">", "&gt;", 1, -1, 1)
        'str = replace(str, "=", "")
     str = trim(str)
  str = replace(str,"'","&rsquo;")
   funstr = str
    End Function
 
'==================================================
'清除HTML代码函数
'==================================================
Function ClearHtml(Content) 
Content=Zxj_ReplaceHtml("&#[^>]*;", "", Content) 
Content=Zxj_ReplaceHtml("</?marquee[^>]*>", "", Content) 
Content=Zxj_ReplaceHtml("</?object[^>]*>", "", Content) 
Content=Zxj_ReplaceHtml("</?param[^>]*>", "", Content) 
Content=Zxj_ReplaceHtml("</?embed[^>]*>", "", Content) 
Content=Zxj_ReplaceHtml("</?table[^>]*>", "", Content) 
Content=Zxj_ReplaceHtml(" ","",Content) 
Content=Zxj_ReplaceHtml("</?tr[^>]*>", "", Content) 
Content=Zxj_ReplaceHtml("</?th[^>]*>","",Content) 
Content=Zxj_ReplaceHtml("</?p[^>]*>","",Content) 
Content=Zxj_ReplaceHtml("</?a[^>]*>","",Content) 
'Content=Zxj_ReplaceHtml("</?img[^>]*>","",Content) 
Content=Zxj_ReplaceHtml("</?tbody[^>]*>","",Content) 
Content=Zxj_ReplaceHtml("</?li[^>]*>","",Content) 
Content=Zxj_ReplaceHtml("</?span[^>]*>","",Content) 
Content=Zxj_ReplaceHtml("</?div[^>]*>","",Content) 
Content=Zxj_ReplaceHtml("</?th[^>]*>", "", Content) 
Content=Zxj_ReplaceHtml("</?td[^>]*>", "", Content) 
Content=Zxj_ReplaceHtml("</?script[^>]*>", "", Content) 
Content=Zxj_ReplaceHtml("(javascript|jscript|vbscript|vbs):", "", Content) 
Content=Zxj_ReplaceHtml("on(mouse|exit|error|click|key)", "", Content) 
Content=Zxj_ReplaceHtml("<\\?xml[^>]*>", "", Content) 
Content=Zxj_ReplaceHtml("<\/?[a-z]+:[^>]*>", "", Content) 
Content=Zxj_ReplaceHtml("</?font[^>]*>", "", Content) 
Content=Zxj_ReplaceHtml("</?b[^>]*>","",Content) 
Content=Zxj_ReplaceHtml("</?u[^>]*>","",Content) 
Content=Zxj_ReplaceHtml("</?i[^>]*>","",Content)
Content=Zxj_ReplaceHtml("</?strong[^>]*>","",Content) 
ClearHtml=Content 
End Function 
Function Zxj_ReplaceHtml(patrn, strng,content) 
IF IsNull(content) Then 
content="" 
End IF 
Set regEx = New RegExp ' 建立正则表达式。 
regEx.Pattern = patrn ' 设置模式。 
regEx.IgnoreCase = true ' 设置忽略字符大小写。 
regEx.Global = True ' 设置全局可用性。 
Zxj_ReplaceHtml=regEx.Replace(content,strng) ' 执行正则匹配 
End Function
 
' ============================================
' 把字符串进行HTML解码,替换server.htmlencode
' 去除Html格式，用于显示输出
' ============================================
Function outHTML(str)
 Dim sTemp
 sTemp = str
 outHTML = ""
 If IsNull(sTemp) = True Then
  Exit Function
 End If
 sTemp = Replace(sTemp, "&", "&amp;")
 sTemp = Replace(sTemp, "<", "&lt;")
 sTemp = Replace(sTemp, ">", "&gt;")
 sTemp = Replace(sTemp, "'", """")
 sTemp = Replace(sTemp, CHR(32), "&nbsp;")
    sTemp = Replace(sTemp, CHR(9), "&nbsp;")
    sTemp = Replace(sTemp, CHR(39), "&#39;")
    sTemp = Replace(sTemp, CHR(13), "")
    sTemp = Replace(sTemp, CHR(10) & CHR(10), "</p><p> ")
    sTemp = Replace(sTemp, CHR(10), "<br> ")
 outHTML = sTemp
End Function
 
 
' ============================================
' 去除Html格式，用于从数据库中取出值填入输入框时
' 注意：value="?"这边一定要用双引号
' ============================================
Function inHTML(str)
 Dim sTemp
 sTemp = str
 inHTML = ""
 If IsNull(sTemp) = True Then
  Exit Function
 End If
 sTemp = Replace(sTemp, "&amp;", "&")
 sTemp = Replace(sTemp, "&lt;", "<")
 sTemp = Replace(sTemp, "&gt;", ">")
 sTemp = Replace(sTemp, "&quot;", Chr(34))
 sTemp = Replace(sTemp, "</p><p> ",CHR(10) & CHR(10))
 sTemp = Replace(sTemp, "<br> ",CHR(10))
 inHTML = sTemp
End Function

 
 
'**************************************************
'函数名：URL_Encode
'作  用：把字符串编码成UNIcode
'参  数：strings  ----所需编码的字符串
'返回值：编码好的unicode字符串
'**************************************************
Function URL_Encode(strings)
 URLEncod = replace(replace(server.URLEncode(strings),"%2F","/"),"+"," ")
end Function 
'**************************************************
'函数名：TextToHtml
'作  用：转换文本字符 为 HTML 字符
'参  数：Text  ----所需转换的文本
'返回值：转换好的html文本
'**************************************************
function TextToHtml(Text) 
 
 Text = replace(Text, VBCRLF ,"<br>")
 Text = replace(Text, VBCR ,"<br>")
 Text = replace(Text, VBLF ,"<br>")
 Text = replace(Text, "'" ,"&#146;")
 Text = replace(Text, " " ,"&nbsp;")
 Text = replace(Text, " " ,"&nbsp;")
 Text = replace(Text, "&amp;" ,"&")
 Text = replace(Text, "&lt;" ,"<")
 Text = replace(Text, "&gt;" ,">")
 TextToHtml = Text
end function
 
'**************************************************
'函数名：strLength
'作  用：求字符串长度。汉字算两个字符，英文算一个字符。
'参  数：str  ----要求长度的字符串
'返回值：字符串长度
'**************************************************
function strLength(str)
 ON ERROR RESUME NEXT
 dim WINNT_CHINESE
 WINNT_CHINESE    = (len("中国")=2)
 if WINNT_CHINESE then
        dim l,t,c
        dim i
        l=len(str)
        t=l
        for i=1 to l
         c=asc(mid(str,i,1))
            if c<0 then c=c+65536
            if c>255 then
                t=t+1
            end if
        next
        strLength=t
    else 
        strLength=len(str)
    end if
    if err.number<>0 then err.clear
end function
'=================================================================
'判断数字是否整形
'=================================================================
function isInteger(para)
       on error resume next
       dim str
       dim l,i
       if isNUll(para) then 
          isInteger=false
          exit function
       end if
       str=cstr(para)
       if trim(str)="" then
          isInteger=false
          exit function
       end if
       l=len(str)
       for i=1 to l
           if mid(str,i,1)>"9" or mid(str,i,1)<"0" then
              isInteger=false 
              exit function
           end if
       next
       isInteger=true
       if err.number<>0 then err.clear
end function
'=================================================================
' 
'数值单位转换从小到大 byt to G
'=================================================================
Function baoliu_Size(Byval SizeNum)
	dSize=SizeNum&"&nbsp;Byte"
	If SizeNum>1024 Then
		SizeNum=(SizeNum/1024)
		dSize=Formatnumber(SizeNum,2)&"&nbsp;KB"
	End If
	If SizeNum>1024 Then
		SizeNum=(SizeNum/1024/1024)
		dSize=Formatnumber(SizeNum,2)&"&nbsp;MB"
	End If
	If SizeNum>1024 Then
		SizeNum=(SizeNum/1024)
		dSize=Formatnumber(SizeNum,2)&"&nbsp;GB"
	End If
End Function
'=================================================================
' 
'数值单位转换从小到大 byt to G
'=================================================================
Function dSize(Byval SizeNum)
 
	If SizeNum>1024 Then
		dSize=(SizeNum/1024/1024)
 	End If
 
End Function
 
 %>
