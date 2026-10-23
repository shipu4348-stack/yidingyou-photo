<!--#include file="err_inc.asp"-->
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">

<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
<meta http-equiv="x-ua-compatible" content="ie=7" />
<title>错误调试页面</title>
 

<style type="text/css">
.error{background:none repeat scroll 0 0 #F4F8F9;
font-size:16px;
line-height:1.5;
padding:2px;
text-align:left;
margin:1.55em 0 0.2em;
}
blockquote {
	background:url("blockquote.gif") no-repeat scroll 3px 3px #EDF1F5;
border:1px solid #DDDDDD;
margin:5px 0;
padding:8px 12px 8px 40px;
}
.errorli{ list-style:decimal
	}
.errordiv { width:98%; margin:0px auto 0px auto; }

</style>
</head>


<body>
<a href="?action=clear">清空调试数据</a>
<%
dim action
action=request("action")
if action="clear" then 
er.writeToFile "error.txt","错误内容如下:<br>"
response.Redirect "err.asp"
else
main()
end if
sub main()
  dim text
  text=er.ReadTextFile("error.txt")
  response.Write "<div class=errordiv><ol>"
  response.Write text
  response.Write "</ol></div>"
  
end sub
    %>
</body>
</html>
