<%
Dim FConn,YOUR_FTP_DB_NAMESQLDbN,YOUR_FTP_DB_NAMESqlPw,YOUR_FTP_DB_NAMESqlUN,YOUR_FTP_DB_NAMESqlLN,ConnString,msg,webstr,YOUR_FTP_DB_NAMEsetint
dim YOUR_FTP_DB_NAMEset,YOUR_FTP_DB_NAMEflux,YOUR_FTP_DB_NAMEspeed,YOUR_FTP_DB_NAMEonline
 

Sub CDB()
	'sql数据库连接参数：数据库名、用户密码、用户名、连接名（本地用(local)或127.0.0.1，外地用IP）
	YOUR_FTP_DB_NAMESQLDbN="YOUR_FTP_DB_NAME"
	YOUR_FTP_DB_NAMESqlPw="YOUR_FTP_DB_PASSWORD"
	YOUR_FTP_DB_NAMESqlUN="YOUR_FTP_DB_USER"
	YOUR_FTP_DB_NAMESqlLN="127.0.0.1"
	ConnString="Provider=SQLOLEDB.1;Password="& YOUR_FTP_DB_NAMESqlPw & ";Persist Security Info=True;User ID=" & YOUR_FTP_DB_NAMESqlUN & ";Initial Catalog="& YOUR_FTP_DB_NAMESQLDbN &";Data Source=" & YOUR_FTP_DB_NAMESqlLN
	on error resume next

	Set FConn = Server.CreateObject("ADODB.Connection")
	FConn.open ConnString

	If Err Then
		err.Clear
		Set FConn = Nothing
		Response.Write "数据库连接出错。"
		Response.End
	End If
End Sub

Sub ClDB()
	FConn.close
	Set FConn = Nothing
End Sub

%>