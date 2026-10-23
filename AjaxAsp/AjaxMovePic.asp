<!--#include virtual="/Incs/SysCode.asp"-->
<% Response.ContentType = "text/html; charset=gb2312" %>
<%
	Server.ScriptTimeOut=99999
	Dim Rs,ErrorText,Path,cid,fso,TempPath,kid,Jpeg,FileSize,FolderkSize
	Dim currentpage,maxPageSize,totalrecords,totalpage,strFileName,ErrNum,N,surl
	Dim NewPerPic,NewPhotoPic '创建浏览缩略图 '创建相册浏览缩略图
	cid=CheckNumeric(Request("cid"))
	currentpage=CheckNumeric(Request("page"))
	ErrNum=CheckNumeric(Request("ErrNum"))
	if CheckNumeric(currentpage)<=0 then
		currentpage=1
		conn.execute("update [Liu_Csv] set Flag=1 where UserName='"&UserName&"' and cid="&cid&"")		
	end if
	
	maxPageSize=3
	totalrecords=0
	totalpage=1	
	N=0
	
	Set fso=New Dmfso
	Set Rs=Server.CreateObject("Adodb.Recordset")
	Rs.Open "select [PicPath],[ServerPath],[FileName],[Tid],[flag] from [Liu_TempPic] where ParentID="&cid&" and UserName='"&UserName&"' order by tid",Conn,1,3
	if Not (Rs.eof and Rs.bof) then
		Rs.pagesize=maxPageSize
		Rs.absolutepage=currentpage
		totalpage=Rs.pagecount
		totalrecords=Rs.recordcount
				
		do while Not Rs.eof and N<maxPageSize
		If Response.IsClientConnected Then		
			if Rs(4)=0 then
				ErrorText="<a href="""&Rs("PicPath")&""" target=""_blank"">"&Rs("PicPath")&"</a>"
				if CheckURL(Rs("PicPath")) then					
						kid=GetFolder("movepic"&cid&"/"&Rs(1))
						TempPath=CreatFolder&"/movepic"&cid&"/"&Rs(1)&"/"
						if Not GetIsNull(TempPath) then
							FileName=Rs(2)
							if SaveImages(Rs(0),TempPath&FileName) then								
								if fso.CheckFile(TempPath&FileName) then
									FileSize=fso.GetFileInfo(TempPath&FileName,7)
									if FileSize=false then FileSize=0
									FolderkSize=DBGetValue("Liu_User","ResBytes","  UserName='"&UserName&"'")
									if CheckNumeric(FolderkSize)>CheckNumeric(FileSize) then
										Set Jpeg=New DmImg
										if Jpeg.IsImage(TempPath&FileName) then	
											NewPerPic=Jpeg.CreatePerPic(TempPath&FileName,TempPath,1,100,100,"Thum_")
											NewPhotoPic=Jpeg.CreatePerPic(TempPath&FileName,TempPath,2,75,75,"Photo_")
											conn.execute("insert into [Liu_Pic] (Kid,Kuser,Pname,Purl,PthUrl,PhotoUrl,Pdesc,Psize,Pdate) values("&kid&",'"&UserName&"','"&FileName&"','"&FileName&"','Thum_"&FileName&"','Photo_"&FileName&"','"&FileName&"','"&FileSize&"','"&now()&"')")
											if CheckNumeric(kid)<>0 then
												conn.execute("update [Liu_Folder] set kcount=kcount+1 where kid="&kid&"")
											end if
											conn.execute("update [Liu_User] set UsedBytes=UsedBytes+"&cdbl(CheckNumeric(FileSize))&",ResBytes=ResBytes-"&cdbl(CheckNumeric(FileSize))&" where UserName='"&UserName&"'")
											conn.execute("update [Liu_TempPic] set Flag=1 where Tid="&Rs("Tid")&" and UserName='"&UserName&"' and ParentID="&cid&"")
										else
											fso.DelFile(TempPath&FileName)
											ErrNum=ErrNum+1
											Rw "<script>parent.document.getElementById('itemErrorPic').innerHTML+="""&ErrorText&"图片异常错误，请确认图片是否为有效图片！<br/>"";</script>"
										end if
										Set Jpeg=Nothing
										If Not Response.IsClientConnected Then Response.End()
									else
										fso.DelFile(TempPath&FileName)
										ErrNum=ErrNum+1
										Rw "<script>parent.document.getElementById('itemErrorPic').innerHTML+="""&ErrorText&"存储容量不足，请扩充容量！<br/>"";</script>"
										Exit Do
									end if									
								else
									ErrNum=ErrNum+1
									Rw "<script>parent.document.getElementById('itemErrorPic').innerHTML+="""&ErrorText&"不支持JPEG组件！<br/>"";</script>"
									Exit Do
								end if
							else
								ErrNum=ErrNum+1
								Rw "<script>parent.document.getElementById('itemErrorPic').innerHTML+="""&ErrorText&"保存图片失败！<br/>"";</script>"
								If Not Response.IsClientConnected Then Response.End()
							end if
						end if
				else
					ErrNum=ErrNum+1
					Rw "<script>parent.document.getElementById('itemErrorPic').innerHTML+="""&ErrorText&"图片不存在！<br/>"";</script>"
					If Not Response.IsClientConnected Then Response.End()
				end if
			end if
			Rw "<script>parent.document.getElementById('itemNum').innerHTML=parseInt(parent.document.getElementById('itemNum').innerHTML)+1;</script>"	
			response.Flush()		
			N=N+1
		else
			Response.End()
		end if	
		Rs.MoveNext		
		Loop
		strFileName="AjaxMovePic.asp?cid="&cid&"&ErrNum="&ErrNum&""
		if totalrecords>0 then   
			surl=showpages(strFileName,totalrecords,maxPageSize,currentpage)
			Rw surl&"<br/>"
			if surl<>"end" then
				'Rw "1秒后将自动继续生成下一页！"
				Rw "<meta http-equiv=""refresh"" content=1;url='"&surl&"'>"
			else
				if ErrNum>0 then
					Rw "<script>parent.document.getElementById('loading').style.display='none';</script>"
					Rw "<script>parent.document.getElementById('replay').style.display='';</script>"
				else
					Rw "<script>parent.window.location.href='/movepic.asp?action=replacecsv&cid="&cid&"';</script>"
				end if
			end if
		End If
		
	end if
	Rs.close
	Set Rs=Nothing
	Set fso=Nothing
	conn.close
	set conn=nothing
	
	
	function showpages(sfilename,totalnumber,maxperpage,currentpage)
		dim n, i,strTemp,strUrl
		if totalnumber mod maxperpage=0 then
			n= totalnumber \ maxperpage
		else
			n= totalnumber \ maxperpage+1
		end if	 
		strUrl=JoinChar(sfilename)
		if n-currentpage<1 then
			showpages="end"
		else
			showpages= strUrl & "page=" & (currentpage+1)	 
		end if	   
	end function
	
	function JoinChar(strUrl)
		if strUrl="" then
			JoinChar=""
			exit function
		end if
		if InStr(strUrl,"?")<len(strUrl) then 
			if InStr(strUrl,"?")>1 then
				if InStr(strUrl,"&")<len(strUrl) then 
					JoinChar=strUrl & "&"
				else
					JoinChar=strUrl
				end if
			else
				JoinChar=strUrl & "?"
			end if
		else
			JoinChar=strUrl
		end if
	end function
%>