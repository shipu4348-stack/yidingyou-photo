<!--#include file="include/cls_safety.asp"--> 
<!--#include file="include/cls_data.asp"--> 
<!--#include file="include/cls_other.asp"--> 
<!--#include file="include/cls_time.asp"--> 
<!--#include file="include/cls_char.asp"--> 
<!--#include file="include/cls_file.asp"--> 
<!--#include file="include/cls_alert.asp"--> 
<!--#include file="include/cls_system.asp"-->
 
  <% 
Response.Buffer = True 
Response.ExpiresAbsolute = Now() - 1 
Response.Expires = 0 
Response.CacheControl = "no-cache" 
Response.AddHeader "Pragma", "No-Cache"
response.charset="gb2312"
'option explicit
'dim startime,conn,connstr,db,rs,rs_s,rs_s1
'On Error Resume Next
const Const_FilePath="C:\Program Files\RhinoSoft.com\Serv-U\ServUDaemon.ini"
const server_id=0 '0为总站  分站填写 分站编号

dim datatype,startime
startime=timer()
datatype=1  '1为sql、2为access
if datatype=1 then
Dim SqlDatabaseName, SqlPassword, SqlUsername, SqlHostIP
	Set conn = Server.CreateObject("ADODB.Connection")
	SqlUsername = "sa"           'SQL数据库用户名
	SqlPassword = "123456"     'SQL数据库用户密码125.46.60.252   
	SqlDatabaseName = "yidingyou_Data"       'SQL数据库名
	SqlHostIP = "192.168.66.5"  'SQL主机IP地址（本地可用“127.0.0.1”或“(local)”，非本机请用真实IP）
	connStr = "Provider = Sqloledb; User ID = " & SqlUsername & "; Password = " & SqlPassword & "; Initial Catalog = " & SqlDatabaseName & "; Data Source = " & SqlHostIP & ";"
conn.Open connstr
else
		dbdir="%3c09qijian.mdb"
		'数据库地址
		Set Conn = Server.CreateObject("ADODB.Connection")
		StrCnn = "Driver={Microsoft Access Driver (*.mdb)};DBQ=" & Server.MapPath(dbdir) & ";"
		Conn.Open StrCnn
end if
If Err Then
	Err.Clear
	Rw "<meta http-equiv='Content-Type' content='text/html; charset=gb2312'>"&vbcrlf
	Rw "<div style='font-size:12px;color:#333;height:20px;line-height:20px;border:1px solid #DDCF8F;padding:6px;background:#FFFFED;font-family:verdana'>数据库连接失败，请与管理员联系，谢谢！</div>"
	RwEnd ""
End If
'--------------------数据库处理函数--------------------
'整理：逸乐
'============
'执行一条SQL语句 rs函数
'============
function rsfun(sql,i)
  select case i
    case "1"
'	rwend "select 1"
	  set rsa=server.CreateObject("adodb.recordset")
	  rsa.open sql,conn,1,1
	  set rsfun=rsa
	  set rsa=nothing
	case "3"
'	rwend "select 3"
	  set rsa=server.CreateObject("adodb.recordset")
	  rsa.open sql,conn,1,3
	  set rsfun=rsa
	  set rsa=nothing
  end select 
end function
 

'============
'关闭数据库
'============
sub connclose
conn.close
set conn=nothing
end sub
%> 