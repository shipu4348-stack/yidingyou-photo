<!--#include file="./incs/SysCode.asp"-->
<%
fee=int(request("fee"))
if request.cookies("1dy")("UserName")="" then
	response.Write(escape("超时"))
else
	dim newprice,oldprice,newMoney,ArgMoney
	set oldrs=server.CreateObject("adodb.recordset")
	oldrs.open "select [comprice] from [ydy_combo] where id="&tcid,conn,1,1	
		set rs=server.createobject("adodb.recordset")
		rs.open "select [comprice] from [ydy_combo] where id="&fee&" and comprice>"&oldrs("comprice")&"",conn,1,1
		if  rs.eof or rs.bof then
			response.Write(escape("不支持该空间升级"))
		else
			newprice=rs("comprice")
			if fflx=1 then
				ArgMoney=Formatnumber(jiage/365,2)
				countday=365
			elseif fflx=2 then
				ArgMoney=Formatnumber(jiage/30,2)
				countday=30
			end if		
			newMoney=newprice-((countday-workday)*ArgMoney)+0.5
			response.Write(escape(newMoney))
		end if
		rs.close
		set rs=nothing
	oldrs.close
	set oldrs=nothing	 
end if
%>