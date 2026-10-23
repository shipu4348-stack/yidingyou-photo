<%
'------------------安全处理函数---------------
'整理：逸乐
' ============================================
' 定义禁止从本地提交数据
' ============================================
Sub HttpCHK()
 Dim server1,server2
 server1=cstr(request.servervariables("http_referer"))
 server2=cstr(request.servervariables("server_name"))
 If mid(server1,8,len(server2))<>server2 then
 Response.Write "<script>alert('请不要从本地提交数据，谢谢合作');history.back();</script>"
 'Call GoError("请不要从本地提交数据，谢谢合作!")
 Response.End
 End If
End Sub
' ============================================
' 防SQL注入，过滤提交数据 2009年8月21日9:37:52更新
' ============================================
Public Function CheckStr(strChar)
  strChar=replace(replace(strChar," ",""),"'","")
  strChar=replace(replace(strChar,".",""),"<","")
  strChar=replace(replace(strChar,")",""),"(","")
  strChar=replace(replace(strChar,"?",""),"*","")
  strChar=replace(replace(strChar,"/",""),"\","")
  checkstr=replace(strChar,Chr(0),"")
 End Function

 %>