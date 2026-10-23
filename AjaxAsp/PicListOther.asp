<!--#include virtual="/incs/model.asp"-->
<% Response.ContentType = "text/html; charset=gb2312" %>
<%
	Server.ScriptTimeOut =999999
	call stopsql()
	kid=int(request.QueryString("kid"))
	UserName=trim(request.QueryString("kname"))
	MainURL="http://"&request.ServerVariables("Server_Name")
	dim Content,List,Imgurl
	
	
	StrTable=" [Liu_Pic]"
	StrText=" [Pid],[Purl],[PhotoUrl],[kid] "
	StrWhere=" and kid="&kid&" and  kuser='"&UserName&"' "
	StrOrder=" Pid "
	indexOrder=1
	'创建存储过程对象
	set cmd=Server.CreateObject("ADODB.Command")
	with cmd
		.ActiveConnection = conn        '数据库连接字串
		.CommandText = "liu_PageAll"         '指定存储过程名
		.CommandType = 4          '表明这是一个存储过程
		.Prepared = true        '要求将SQL命令先行编译
		.Parameters.append .CreateParameter("@StrTable",200,1,200,StrTable) '指定表名
		.Parameters.append .CreateParameter("@StrText",200,1,1000,StrText) '指定字段名
		.Parameters.append .CreateParameter("@StrWhere",200,1,1000,StrWhere) '指定查询条件
		.Parameters.append .CreateParameter("@StrOrder",200,1,100,StrOrder) '指定排序关键字
		.Parameters.append .CreateParameter("@indexOrder",3,1,4,indexOrder) '指定排序方式，1为降序，0为升序
		.Parameters.append .CreateParameter("@StrSql",200,2,2000) '返回Sql语句output					
		set rs= .Execute
	end with
	if not (rs.eof and rs.bof) then
		i=0
		arrlength=rs.recordcount
		do while not rs.eof				
			PhotoUrl=rs("PhotoUrl")
			'list=list&"<li><img onclick=InitList('"&UserName&"',"&rs("kid")&","&rs("pid")&","&i&",'carousel'); src="&PhotoUrl&" border='0' /></li>"	
			'list=list&"<li><img src="&PhotoUrl&" onclick=InitList('"&UserName&"',"&rs("kid")&","&rs("pid")&","&i&"); style='cursor:pointer;' border='0' /></li>"
			list=list&"<img src="&PhotoUrl&" class='img' onclick=InitList('"&UserName&"',"&rs("kid")&","&rs("pid")&","&i&"); style='cursor:pointer;' border='0' />"
			i=i+1
		rs.movenext
		loop
	end if
	rs.close
	set rs=nothing
	response.Write(escape(left(list,len(list)-1)))
%>