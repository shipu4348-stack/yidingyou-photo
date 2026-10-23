<%
set rs=server.CreateObject("adodb.recordset")
Sql="select top 1 [id], [username],[email],[dpname],[dplink],[wwname],[qqhm],[xingming],[phone],[card],[addtime],[jfrq],[LostTime],[LostIp],[isftp] from [Liu_User] where username='"&UserName&"'"
rs.open Sql,conn,1,1
	userid=rs("id")
	email=rs("email")
	dpname=rs("dpname")
	dplink=rs("dplink")
	wwname=rs("wwname")
	qqhm=rs("qqhm")
	xingming=rs("xingming")
	phone=rs("phone")
	card=rs("card")
	addtime=rs("addtime")
	jfrq=rs("jfrq")
	LostTime=rs("LostTime")
	LostIp=rs("LostIp")
	IsUserFtp=rs("isftp")
rs.close
set rs=nothing
%>