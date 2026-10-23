<%	
	UserName=CheckStr(request.cookies("1dy")("UserName"))
	UserID=CheckNumeric(request.cookies("1dy")("UserID"))
	tcid=CheckNumeric(Request.Cookies("1dy")("tcid"))
	if not checklogin then
		response.Redirect "index.asp"
	end if
	dim UserMainPath,MainHtml,MainDataPath,MainURL
	MainDataPath="/datafiles/Users/"	
	UserMainPath="/Users/"&UserName&"/"	
	CreatFolder()
	MainURL=GetUserShowPic(UserName,"img")&UserName&"/pic"
	MainHtml=GetUserShowPic(UserName,"img")&UserName&"/Html"
	
	'MainURL="http://img.1dy.cc/"&UserName&"/pic"
	'MainHtml="http://img.1dy.cc/"&UserName&"/Html"
	
	jiage=DBGetValue("ydy_combo","comprice"," id="&tcid&" ")'当前空间价格
	kjdx=DBGetValue("Liu_User","CountBytes"," UserName='"&UserName&"' and id="&UserID&" ")'空间大小	
	fflx=DBGetValue("Liu_User","fflx"," UserName='"&UserName&"' and id="&UserID&" ")'空间类型
	jfrq=DBGetValue("Liu_User","jfrq"," UserName='"&UserName&"' and id="&UserID&" ")'续费日期
	FolderSize=DBGetValue("Liu_User","UsedBytes"," UserName='"&UserName&"' and id="&UserID&" ")'已使用空间大小	
	conn.execute("update [Liu_User] set ResBytes=CountBytes-UsedBytes Where UserName='"&UserName&"' and id="&UserID&"")	
	
	'UpdateFtpSize()
	
	bili=int(FolderSize/kjdx*100)

	workday=DateDiff("d",date(),jfrq)
	if workday<=0 then
	  conn.execute("update [Liu_User] set yjf=0 where UserName='"&UserName&"'")
	  Response.Cookies("1dy")("yjf")=0
	  workday=0
	end if
	
	function UpdateFtpSize()
		Dim rsf,Fso,FolderTempSize
		Set Fso=New DmFso
		FolderTempSize=CheckNumeric(fso.GetFolderInfo(CreatTemp,7))
		Set Fso=Nothing
		CDB()
			ResBytes=DBGetValue("Liu_User","ResBytes"," UserName='"&UserName&"' and id="&UserID&" ")'已使用空间大小
			if 	GetIsNull(ResBytes) then
				contrastini()
				contrastpic()
				contrastcode()				
				ResBytes=CheckNumeric(DBGetValue("Liu_User","ResBytes"," UserName='"&UserName&"' and id="&UserID&" "))'已使用空间大小
			end if
			set rsf=server.CreateObject("adodb.recordset")
			rsf.open "select id from [ftp_users] where ftpUserName='"&UserName&"'",Fconn,1,1
			if not(rsf.eof and rsf.bof) then
				FConn.execute("update [ftp_users] set quotaMax="&ResBytes&",quotaCurrent="&FolderTempSize&" where ftpUserName='"&UserName&"'")
			end if
			rsf.close
			set rsf=nothing
		ClDB()
	end function
	
	Function contrastini()
		Dim rs
		set rs=server.CreateObject("adodb.recordset")
		rs.open "select [countbytes] from [Liu_user] where UserName='"&UserName&"'",conn,1,1
		if not (rs.eof and rs.bof) then
			do while not rs.eof
				conn.execute("update [Liu_User] set UsedBytes=0,ResBytes="&rs("countbytes")&" where UserName='"&UserName&"'")	
			rs.movenext
			loop
		end if
		rs.close
		set rs=nothing
	end Function
	
	Function contrastpic()
		Dim rs
		set rs=server.CreateObject("adodb.recordset")
		rs.open "select [Psize] from [Liu_pic] where kuser='"&UserName&"'",conn,1,1
		if not (rs.eof and rs.bof) then
			do while not rs.eof
				conn.execute("update [Liu_User] set UsedBytes=UsedBytes+"&cdbl(rs("Psize"))&",ResBytes=ResBytes-"&cdbl(rs("Psize"))&" where UserName='"&UserName&"'")	
			rs.movenext
			loop
		end if
		rs.close
		set rs=nothing
	end Function
	
	Function contrastcode()
		Dim rs
		set rs=server.CreateObject("adodb.recordset")
		rs.open "select [CodeSize] from [Liu_Code] where kname='"&UserName&"'",conn,1,1
		if not (rs.eof and rs.bof) then
			do while not rs.eof
				conn.execute("update [Liu_User] set UsedBytes=UsedBytes+"&cdbl(rs("CodeSize"))&",ResBytes=ResBytes-"&cdbl(rs("CodeSize"))&" where UserName='"&UserName&"'")	
			rs.movenext
			loop
		end if
		rs.close
		set rs=nothing
	end Function
	
	function checklogin()
		if GetIsNull(UserName) or UserID=0 then
			checklogin=false
		else
			checklogin=true
		end if
	end function

	function CreatFolder()
		Dim Fso
		Dim base
		CreatFolder=""
		Set Fso=New DmFso
		base=MainDataPath
		if Not Fso.CheckFolder(base) then
			Fso.CreateFolder(base)
		end if
		if Not Fso.CheckFolder(base&UserName) then
			Fso.CreateFolder(base&UserName)
		end if
		if Not Fso.CheckFolder(base&UserName&"/Html") then
			Fso.CreateFolder(base&UserName&"/Html")
		end if
		if Not Fso.CheckFolder(base&UserName&"/Temp") then
			Fso.CreateFolder(base&UserName&"/Temp")
		end if
		if Not Fso.CheckFolder(base&UserName&"/Pic") then
			Fso.CreateFolder(base&UserName&"/Pic")
		end if
		set Fso=Nothing
		CreatFolder=base&UserName&"/Pic"
	end function
	
	function CreatHtml()
		Dim Fso
		Dim base
		CreatHtml=""
		Set Fso=New DmFso
		base=MainDataPath
		if Not Fso.CheckFolder(base) then
			Fso.CreateFolder(base)
		end if
		if Not Fso.CheckFolder(base&UserName) then
			Fso.CreateFolder(base&UserName)
		end if
		if Not Fso.CheckFolder(base&UserName&"/Html") then
			Fso.CreateFolder(base&UserName&"/Html")
		end if
		if Not Fso.CheckFolder(base&UserName&"/Temp") then
			Fso.CreateFolder(base&UserName&"/Temp")
		end if
		if Not Fso.CheckFolder(base&UserName&"/Pic") then
			Fso.CreateFolder(base&UserName&"/Pic")
		end if
		set Fso=Nothing
		CreatHtml=base&UserName&"/Html"
	end function
	
	function CreatTemp()
		Dim Fso
		Dim base
		CreatTemp=""
		Set Fso=New DmFso
		base=MainDataPath
		if Not Fso.CheckFolder(base) then
			Fso.CreateFolder(base)
		end if
		if Not Fso.CheckFolder(base&UserName) then
			Fso.CreateFolder(base&UserName)
		end if
		if Not Fso.CheckFolder(base&UserName&"/Html") then
			Fso.CreateFolder(base&UserName&"/Html")
		end if
		if Not Fso.CheckFolder(base&UserName&"/Temp") then
			Fso.CreateFolder(base&UserName&"/Temp")
		end if
		if Not Fso.CheckFolder(base&UserName&"/Pic") then
			Fso.CreateFolder(base&UserName&"/Pic")
		end if
		set Fso=Nothing
		CreatTemp=base&UserName&"/Temp"
	end function
	
	function CreatMain()
		Dim Fso
		Dim base
		CreatMain=""
		Set Fso=New DmFso
		base=MainDataPath
		if Not Fso.CheckFolder(base) then
			Fso.CreateFolder(base)
		end if
		if Not Fso.CheckFolder(base&UserName) then
			Fso.CreateFolder(base&UserName)
		end if
		if Not Fso.CheckFolder(base&UserName&"/Html") then
			Fso.CreateFolder(base&UserName&"/Html")
		end if
		if Not Fso.CheckFolder(base&UserName&"/Temp") then
			Fso.CreateFolder(base&UserName&"/Temp")
		end if
		if Not Fso.CheckFolder(base&UserName&"/Pic") then
			Fso.CreateFolder(base&UserName&"/Pic")
		end if
		set Fso=Nothing
		CreatMain=base&UserName
	end function
%>
