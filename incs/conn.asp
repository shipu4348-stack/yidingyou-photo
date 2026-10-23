<%
Response.Buffer = True 
Response.ExpiresAbsolute = Now() - 1 
Response.Expires = 0 
Response.CacheControl = "no-cache" 
Response.AddHeader "Pragma", "No-Cache"
'On Error Resume Next

'option explicit
'dim startime,conn,connstr,db,rs,rs_s,rs_s1
'Dim SqlDatabaseName, SqlPassword, SqlUsername, SqlHostIP
const server_id=0 '0为总站  分站填写 分站编号

startime=timer()
Set conn = Server.CreateObject("ADODB.Connection")
SqlUsername = "sa"           'SQL数据库用户名
SqlPassword = "123456"     'SQL数据库用户密码   
SqlDatabaseName = "yidingyou_Data"       'SQL数据库名
SqlHostIP = "192.168.66.5"  'SQL主机IP地址（本地可用“127.0.0.1”或“(local)”，非本机请用真实IP）
connStr = "Provider = Sqloledb; User ID = " & SqlUsername & "; Password = " & SqlPassword & "; Initial Catalog = " & SqlDatabaseName & "; Data Source = " & SqlHostIP & ";"



conn.Open connstr

If Err Then
	Err.Clear
	Set Conn = Nothing
	Response.Write "数据库连接出错，请检查Conn.asp文件中的数据库参数设置。"
	Response.End
End If
%>