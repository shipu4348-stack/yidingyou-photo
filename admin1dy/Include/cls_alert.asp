<%
'------------------对话框处理函数------------------
'整理：逸乐
'==================================================
'弹出对话框
'==================================================
sub getshow(str,url)
  if str="" and url <>"" then
    response.Write "<script language='javascript'>window.document.location.href='"& url &"'</script>"
    response.End()
  end if
  if str<>"" and url="" then
    response.Write "<script language='javascript'>alert('"&str&"');history.go(-1)</script>"
    response.End()
  end if
  if str<>"" and url<>"" then
    response.Write "<script language='javascript'>alert('"&str&"');window.document.location.href='"& url &"'</script>"
    response.End()
  end if
  
end sub 

'==================================================
'弹出对话框div格式
'==================================================
sub getdiv(str,url,divname)
  if str="" and url <>"" then
    response.Write "<div id='"& divname &"'  style='margin-left:auto; margin-right:auto; text-align:center;'></div><script language='javascript'>document.getElementById('"& divname &")'.innerHTML='"& str &"<img style=""cursor:hand;"" onClick=divclose(""comedit""); src=images/close.gif  border=0 />';setTimeout(""window.parent.location.href='"& url &"'"",600);</script>"
    response.End()
  end if
  if str<>"" and url="" then
    response.Write "<div id='"& divname &"'  style='margin-left:auto; margin-right:auto; text-align:center;'></div><script language='javascript'>document.getElementById('"& divname &"').innerHTML='"& str &"<img style=""cursor:hand;"" onClick=divclose(""comedit""); src=images/close.gif  border=0 />';setTimeout(""window.parent.location.reload();"",600)</script> "
    response.End()
  end if
  if str<>"" and url<>"" then
    response.Write "<div id='"& divname &"'  style='margin-left:auto; margin-right:auto; text-align:center;'></div><script language='javascript'>document.getElementById('"& divname &"').innerHTML='"& str &"<img style=""cursor:hand;"" onClick=divclose(""comedit""); src=images/close.gif  border=0 />';setTimeout(""window.parent.location.href='"& url &"'"",600);</script>"
    response.End()
  end if
  
end sub 
'==================================================
'弹出对话框div格式
'==================================================
sub getdiv2(str,url,divname,killtime)
if killtime="" then killtime="600"
  if str="" and url <>"" then
    response.Write "<div id='"& divname &"'  style='margin-left:auto; margin-right:auto; text-align:center;'></div><script language='javascript'>document.getElementById('"& divname &")'.innerHTML='"& str &"<img style=""cursor:hand;"" onClick=divclose(""comedit""); src=images/close.gif  border=0 />';setTimeout(""window.parent.location.href='"& url &"'"","& killtime &");</script>"
    response.End()
  end if
  if str<>"" and url="" then
    response.Write "<div id='"& divname &"'  style='margin-left:auto; margin-right:auto; text-align:center;'></div><script language='javascript'>document.getElementById('"& divname &"').innerHTML='"& str &"<img style=""cursor:hand;"" onClick=divclose(""comedit""); src=images/close.gif  border=0 />';setTimeout(""window.parent.location.reload();"","& killtime &")</script> "
    response.End()
  end if
  if str<>"" and url<>"" then
    response.Write "<div id='"& divname &"'  style='margin-left:auto; margin-right:auto; text-align:center;'></div><script language='javascript'>document.getElementById('"& divname &"').innerHTML='"& str &"<img style=""cursor:hand;"" onClick=divclose(""comedit""); src=images/close.gif  border=0 />';setTimeout(""window.parent.location.href='"& url &"'"","& killtime &");</script>"
    response.End()
  end if
  
end sub 
 %>