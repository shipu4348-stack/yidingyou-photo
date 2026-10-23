<!--#include file="./incs/SysCode.asp"-->
<!--#include file="alipayto/alipay_payto.asp"-->
<%
dim action,shijian,dingdan,content,jiage,oldprice,newprice
set fso=new dmfso
action=request.QueryString("action")
if request.cookies("1dy")("UserName")<>"" then
	set rs=server.CreateObject("adodb.recordset")
	rs.open "select top 1 [tcid] from [Liu_User] where username='"&request.cookies("1dy")("UserName")&"'",conn,1,1
	if not rs.eof or not rs.bof then
		set rscom=server.CreateObject("adodb.recordset")
		rscom.open "select [comsize],[comprice],[comkind] from [ydy_combo] where id="&rs("tcid"),conn,1,1
			if rscom("comkind")=1 then
			content="无限通"&Fso.FormatFileSize(rscom("comsize"))&"/￥"&rscom("comprice")&"/年"
			elseif rscom("comkind")=2 then
			content="无限通"&Fso.FormatFileSize(rscom("comsize"))&"/￥"&rscom("comprice")&"/月"
			end if
			oldprice=rscom("comprice")
		rscom.close
		set rscom=nothing
	end if
	rs.close
	set rs=nothing
end if

shijian=now()
dingdan=year(shijian)&month(shijian)&day(shijian)&hour(shijian)&minute(shijian)&second(shijian)
'客户网站订单号，（现取系统时间，可改成网站自'己的变量）

select case action
case "xf"
call xf()
case "kt"
call kt()
case "sj"
call sj()
end select


sub kt()
subject="一定呦网站订单"	'商品名称，如果客户走购物车流程可以设为
body=request.cookies("1dy")("UserName")&"空间"&content&"开通，共需"&oldprice&"元"      '商品描述
out_trade_no=dingdan    '按时间获取的订单号，可以修改成自己网站的订单号，保证每次提交的都是唯一即可
price=oldprice	   '商品单价	0.01～100000000.00  ，注：不要出现3,000.00，价格不支持","号
quantity="1" '商品数量,如果走购物车默认为1
discount ="0"  '商品折扣
seller_email=seller_email   '卖家的支付宝帐号，c2c客户，可以更改此参数。
Set AlipayObj	= New creatAlipayItemURL
itemUrl=AlipayObj.creatAlipayItemURL(subject,body,out_trade_no,price,quantity,seller_email)
'response.Redirect itemUrl,"_blank"
response.Write "<script>window.top.location.href='"&itemUrl&"'</script>"
end sub


sub xf()
subject="一定呦网站订单"	'商品名称，如果客户走购物车流程可以设为
body=request.cookies("1dy")("UserName")&"空间"&content&"续费，共需"&oldprice&"元"      '商品描述
out_trade_no=dingdan    '按时间获取的订单号，可以修改成自己网站的订单号，保证每次提交的都是唯一即可
price=oldprice	   '商品单价	0.01～100000000.00  ，注：不要出现3,000.00，价格不支持","号
quantity="1" '商品数量,如果走购物车默认为1
discount ="0"  '商品折扣
seller_email=seller_email   '卖家的支付宝帐号，c2c客户，可以更改此参数。
Set AlipayObj	= New creatAlipayItemURL
itemUrl=AlipayObj.creatAlipayItemURL(subject,body,out_trade_no,price,quantity,seller_email)
'response.Redirect itemUrl,"_blank"
response.Write "<script>window.top.location.href='"&itemUrl&"'</script>"
end sub


sub sj()
tcid=cint(request.Form("fee"))
set rssj=server.CreateObject("adodb.recordset")
rssj.open "select [comsize],[comprice],[comkind] from [ydy_combo] where id="&tcid,conn,1,1
	if rssj("comkind")=1 then
	content2="无限通"&Fso.FormatFileSize(rssj("comsize"))&"/￥"&rssj("comprice")&"/年"
	elseif rssj("comkind")=2 then
	content2="无限通"&Fso.FormatFileSize(rssj("comsize"))&"/￥"&rssj("comprice")&"/月"
	end if
	newprice=rssj("comprice")
rssj.close
set rssj=nothing

if fflx=1 then
	ArgMoney=Formatnumber(jiage/365,2)
	countday=365
elseif fflx=2 then
	ArgMoney=Formatnumber(jiage/30,2)
	countday=30
end if

newprice=newprice-((countday-workday)*ArgMoney)+0.5
		
subject="一定呦网站订单"	'商品名称，如果客户走购物车流程可以设为
body=request.cookies("1dy")("UserName")&"-"&content&"升级"&content2&"，共需"&newprice&"元"      '商品描述
out_trade_no=dingdan    '按时间获取的订单号，可以修改成自己网站的订单号，保证每次提交的都是唯一即可
price=newprice	   '商品单价	0.01～100000000.00  ，注：不要出现3,000.00，价格不支持","号
quantity="1" '商品数量,如果走购物车默认为1
discount ="0"  '商品折扣
seller_email=seller_email   '卖家的支付宝帐号，c2c客户，可以更改此参数。
Set AlipayObj	= New creatAlipayItemURL
itemUrl=AlipayObj.creatAlipayItemURL(subject,body,out_trade_no,price,quantity,seller_email)
'response.Redirect itemUrl,"_blank"
response.Write "<script>window.top.location.href='"&itemUrl&"'</script>"
end sub	
%>