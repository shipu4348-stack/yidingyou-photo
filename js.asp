<!--#include file="incs/model.asp"-->
 <%
  dim num,ltype,kind,width,height,css,hnum
num = cint(request.querystring("num"))'显示个数
ltype=cint(request.QueryString("ltype"))'显示广告位置
kind=request.QueryString("kind")'flash格式pic格式
a_height=cint(request.QueryString("height"))'广告高度
a_width=cint(request.QueryString("width"))'广告宽度
css_td=request.QueryString("css_td")'表格css样式
css_pic=request.QueryString("css_pic")'图片css样式
hnum=cint(request.QueryString("hnum"))'一行显示个数

'初始变量开始
if num ="" then num=5
if a_height="" then a_height=100
if a_width="" then a_width= 100
if ltype="" then ltype=2
if kind="" then kind="Pic"
if hnum="" then hnum=1
'初始变量结束
dim str,i,j
i=0
j=0 
 	str=""	
	sql="Select top "& num &" sitename,siteurl,logourl from ydy_ad where id <>0 "
	sql=sql&" and ltype="&ltype&" "
	sql=sql&" order by id desc"
	set rs=conn.execute(sql)
 	if rs.bof and rs.eof then 
	str=str+"没有符合条件的广告"
	else
 rs.movefirst
 
  str=str+"<table width='100%' border='0' cellspacing='0' cellpadding='0' algin=center >"
 str=str+"<tr>"
 	if kind="Pic" then
do while not rs.eof

  			str=str+"<td class="&css_td&" algin=center><a href='"&rs("siteurl")&"' title='"&rs("sitename")&"' target='_blank'><img src='"&rs("logourl")&"' border='0' class="&css_pic&" height='"&a_height&"' width='"&a_width&"' ></a></td>"
    		i=i+1
			if (i mod hnum) =0 then str=str+"</tr><tr>"
		rs.moveNext
		loop
			str=str+"</table>"
	else
 			str=str+"flash"
    end if

end if
			
rs.close : conn.close
set rs=nothing : set conn=nothing

response.write "document.write ("&Chr(34)&str&Chr(34)&");"
%>