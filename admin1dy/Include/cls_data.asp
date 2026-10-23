<%
'****************************************************
'函数名：DBDel
'作  用：删除指定条件的数据
'****************************************************
Function DBDel(Table,WhereStr)
	Dim Sql
	Sql="Delete From "&Table&" Where "&WhereStr&""
	Conn.Execute(Sql)
End Function
'****************************************************
'函数名：DBUpdate
'作  用：修改指定条件和字段的内容
'****************************************************
Function DBUpdate(Table,UpVale,WhereStr)
	Dim Sql
	Sql="Update "&Table&" Set "&UpVale&" Where "&WhereStr&""
	Conn.Execute(Sql)
End Function
'****************************************************
'函数名：DBGetNum
'作  用：查询某字段数量 最大值或最小值
'****************************************************
Function DBGetNum(Table,FieldName,sType,WhereStr)
	Dim Rs,Sql
	Select Case sType
		Case 0
			Sql="Select Count("&FieldName&") From "&Table&" "&WhereStr&""
		Case 1
			Sql="Select Max("&FieldName&") From "&Table&" "&WhereStr&""
		Case 2
			Sql="Select Min("&FieldName&") From "&Table&" "&WhereStr&""
	End Select
	Set Rs=Conn.Execute(Sql)
	If Rs.Bof And Rs.Eof Then
		DBGetNum=0
	Else
		DBGetNum=Rs(0)
	End If
	Rs.Close
	Set Rs=Nothing
End Function
'****************************************************
'函数名：DBExist
'作  用：查询某字段的内容是否有重复
'****************************************************
Function DBExist(Table,FieldName,WhereStr)
	Dim Rs,Sql
	Sql="Select "&FieldName&" From "&Table&" Where "&WhereStr&""
	Set Rs=Conn.Execute(Sql)
	If Rs.Bof And Rs.Eof Then
		DBExist=False
	Else
		DBExist=True
	End If
	Rs.Close
	Set Rs=Nothing
End Function
'****************************************************
'函数名：DBGetValue
'作  用：查询指定条件某字段的内容
'****************************************************
Function DBGetValue(Table,FieldName,WhereStr)
	Dim Rs,Sql
	Sql="Select "&FieldName&" From "&Table&" Where "&WhereStr&""
	Set Rs=Conn.Execute(Sql)
	If Rs.Bof And Rs.Eof Then
		DBGetValue=""
	Else
		DBGetValue=Rs(0)
	End If
	Rs.Close
	Set Rs=Nothing
End Function 
%>
 