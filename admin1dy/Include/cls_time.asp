<% 
'--------------------时间处理函数--------------------
'整理：逸乐
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

 %>