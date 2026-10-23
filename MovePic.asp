<!--#include file="incs/syscode.asp"-->
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
<title>图片搬家</title>
<link rel="stylesheet" type="text/css" media="all" href="css/common.css" />
<script type="text/javascript" language="javascript" src="js/jquery-1.4.2.min.js"></script>
<script language="javascript">
function chkFrm(){
	var upnum=0;
	var upcount=0;
	var objFrm=document.csvform;	
	var exts="csv";	
	var filename;
	var tempstr="";
	var obj;
	var errornum=0;
	
	var e = objFrm.csvfile;
	filename=e.value;
	tempstr=filename;
	if(exts.indexOf(filename.toLowerCase().substr(filename.length-3,3))<0)
	{
		document.getElementById("ErrorInfo").innerHTML="&nbsp; <font color=red>错误：只允许上传文件类型为CSV！</font>";
		errornum=errornum+1;
	}else{
		document.getElementById("ErrorInfo").innerHTML="";
	}

	if(tempstr==""){
		alert("请选择一个文件");
		objFrm.csvfile.focus();
		return false;
	}

	if(errornum>0){
		return false;
	}else{
		document.getElementById("uploadstate").style.display='';
		objFrm.upbt.disabled=false;
		objFrm.action = "MovePic.asp?action=uploadcsv";
		objFrm.submit();
	}	
	return true;
}
function CheckDomain(){
	var objFrm=document.csvform;
	var obj=document.getElementsByName("domain");
	var tempstr="";
	for(var i=0;i<obj.length;i++){
		if(obj[i].checked){
			tempstr+=obj[i].value;
			}
	}
	var cid=document.getElementById("cid").value;
	if(tempstr==""){
		if(confirm("确定要停止搬家吗?")){
				objFrm.action="MovePic.asp?action=stopmove&cid="+cid;
				objFrm.submit();
				return true;
			}else{
				return false;
				}
		}else{
			objFrm.action="MovePic.asp?action=starmove&cid="+cid;
			objFrm.submit();
			return true;
		}
	}
function copylink(url){
	window.clipboardData.setData("Text",url);
	alert("网络地址已拷贝到剪贴板，可以使用粘贴或Ctrl+V调用。\n\n"+url);
}
</script>
</head>

<body>
<div class="brotypeTag">
<ul class="tagUl">
<li class="onTag"><b>助理图片搬家</b></li>
</ul>
</div>
<br />
<%
Dim action
action=Checkstr(Request("action"))
select case action
case "uploadcsv":uploadcsv
case "checkdomain":checkdomain
case "stopmove":stopmove
case "starmove":starmove
case "replaymove":replaymove
case "replacecsv":replacecsv
case "delcsv":delcsv
case else
	main()
end select
sub main()
%>
<form id="csvform" name="csvform" method="POST" action=""  ENCTYPE="multipart/form-data">
<table width="100%" border="0" cellspacing="0" cellpadding="0">
    <tr>
    <td height="32" background="images/0025.gif"><span class="itemlist"><b>上传新CSV文件</b>(上传的CSV文件存储占本用户空间,服务器默认保存三次以做备份)</span></td>
  </tr>
<tr>
    <td bgcolor="#fafafa" class="itemlist" >选择CSV文件<input type="File" name="csvfile" style="width:300px; height:22px;" class="text"  /><span id="ErrorInfo"></span></td>
  </tr>
    <tr>
    	<td class="itemlist"><input id="upbt" name="upbt" type="button" value="上传" class="btnt2" onclick="return chkFrm();" />&nbsp;<span id="uploadstate" style=" display:none; color:red;"><img src="Images/loader.gif" />正在上传请稍后...</span></td>
	</tr>
   </table>
   <table class="dirlist">
	<tr>
	<th width="30%">文件名</th>
	<th width="10%">文件大小</th>
    <th width="10%">上传时间</th>
    <th width="10%">状态</th>
	<th width="40%">操作</th>
	</tr>
    <%
		Dim Rs
		Set Rs=Server.CreateObject("adodb.recordset")
		Rs.Open "select cid,oldfilename,filename,filesize,flag,newfilename,posttime from [Liu_Csv] where UserName='"&UserName&"' order by cid desc",conn,1,1
		if Not(Rs.eof and Rs.bof) then
		do while not rs.eof
	%>
    <tr>
    <td><%=Rs("oldfilename")%></td>
    <td><%=FormatFileSize(Rs("filesize"))%></td>
    <td><%=Rs("posttime")%></td>
    <td><%
		if rs("flag")=0 then
			Response.Write("<font color=""red"">从未搬家</font>")
		elseif rs("flag")=1 then
			Response.Write("<font color=""red"">尚未完成</font>")
		elseif rs("flag")=2 then
			Response.Write("<font color=""red"">搬家成功</font>")
		end if
	%></td>
    <td>
    <%if rs("flag")=0 then%>
    	<a href="movepic.asp?action=replaymove&cid=<%=rs("cid")%>">开始搬家</a>
	<%elseif rs("flag")=1 then%>
    	<a href="movepic.asp?action=replaymove&cid=<%=rs("cid")%>">继续搬家</a>
    <%elseif rs("flag")=2 then%>
    	搬家完成
    <%end if%>    
	<a href="<%=MainHtml%>/<%=rs("filename")%>">下载原数所包</a>
    
    <%if Not GetIsNull(Rs("newfilename")) and rs("flag")=2 then%>
    	<a href="movepic.asp?action=replacecsv&cid=<%=rs("cid")%>">重新生成CSV文件</a>
    	<a href="<%=MainHtml%>/<%=rs("newfilename")%>">下载新数据包</a>
    <%else%>
    	重新生成CSV文件
    	下载新数据包
    <%end if%>
    
    <a href="movepic.asp?action=delcsv&cid=<%=rs("cid")%>" onClick="javascript:if(confirm('确定删除吗？\n\n系统提示：删除后不可恢复！')){return true;}else{return false;}">删除</a></td>
    </tr>
    <%
		rs.movenext
		loop
		else
		%>
    <tr><td colspan="5">暂无搬家记录</td></tr>
        <%
		end if
		rs.close
		set rs=nothing
	%>
    </table>
</form>
<%
end sub
sub uploadcsv()
	On Error Resume Next
	Server.ScriptTimeOut=999999999
	Dim FileUp,Fso,Rs
	Dim F_File,F_FileSize,FileName,OldFileName
	Dim UploadPath,FolderkSize,Cid,CsvCount
	Set FileUp=New Upload_File
	Set Fso=New DmFso
	set F_File=FileUp.file("csvfile")
		F_FileSize=F_File.FileSize
		OldFileName=F_File.FileName
		OldFileName=Replace(OldFileName,"."&F_File.FileExt,"")
		FileName="csv"&FormatTime(Now(),6)&RandNumber(1,1000)&"."&F_File.FileExt
		UploadPath=CreatHtml&"/"&FileName
		FolderkSize=DBGetValue("Liu_User","ResBytes","  UserName='"&UserName&"'")
		if cdbl(CheckNumeric(F_FileSize)) > cdbl(CheckNumeric(FolderkSize)) then
			response.Write("<script language='javascript'>alert('您的空间不足,请扩冲空间!');location.href='MovePic.asp';</script>")
			response.end()
		end if
		F_File.SaveAs Server.MapPath(UploadPath)
		If Fso.CheckFile(UploadPath) then
			response.Write "上传成功"
			CsvCount=DBGetNum("Liu_Csv","Cid",0,"where UserName='"&UserName&"'")
			if CheckNumeric(CsvCount)=3 then
				set Rs=Server.CreateObject("adodb.recordset")
				Rs.open "select top 1 [cid],[FileName] from [Liu_Csv] where UserName='"&UserName&"' order by cid",conn,1,3
				if not (Rs.eof and Rs.bof) then
					conn.execute("delete from [Liu_TempPic] where ParentID="&Rs("cid")&"")
					Fso.DelFile(CreatHtml&"/"&Rs("FileName"))
					Rs.delete
				end if
				Rs.close
				set Rs=nothing
			end if
			conn.execute("insert into [Liu_Csv] ([UserName],[OldFileName],[FileName],[FileSize]) values('"&UserName&"','"&OldFileName&"','"&FileName&"','"&F_FileSize&"')")
			Cid=DBGetNum("Liu_Csv","Cid",1,"where UserName='"&UserName&"'")
			conn.execute("update [Liu_User] set UsedBytes=UsedBytes+"&cdbl(CheckNumeric(F_FileSize))&",ResBytes=ResBytes-"&cdbl(CheckNumeric(F_FileSize))&" where UserName='"&UserName&"'")
		end if
	Set Fso=Nothing
	Set FilUp=Nothing
	if Err then
		response.Write("<script language='javascript'>alert('发生异常错误，请重新上传Csv文件!');location.href='MovePic.asp';</script>")
		response.end()
	else
		Response.Redirect("MovePic.asp?action=checkdomain&cid="&Cid&"")
	end if
end sub
sub checkdomain()
	Dim Cid,Rs,Rsp
	Dim FilePath,TempBody,Key,TempMessage
	Dim TempUrl,FileName,Servers,Path,KeyFile,KeyFileExt
	Cid=CheckNumeric(Request("cid"))
	if Cid>0 then
		Set Rs=Server.CreateObject("Adodb.Recordset")
		Rs.Open "select cid,FileName from [Liu_Csv] where cid="&cid&" and UserName='"&UserName&"'",Conn,1,1
		if Not (Rs.eof and Rs.bof) then
			Cid=Rs("cid")
			FilePath=CreatHtml&"/"&Rs("FileName")
			TempBody= LoadFile(FilePath)
			TempBody= ShowPic(TempBody)
			Key=Split(TempBody,"||$$$||")
			
			if UBound(Key) > 0 Then
				for i=0 to UBound(Key)-1
					KeyFileExt=Cstr(mid(key(I),instrrev(key(I),".")))
					KeyFileExt=Replace(KeyFileExt,".","")
					if Not GetIsNull(KeyFileExt) and CheckFileExt(KeyFileExt,"jpg;gif;png;bmp") then
						FileName=""
						TempUrl=key(I)'图片URl地址
						Servers=ParseURL(TempUrl,"server")'所属域名
						Path=ParseURL(TempUrl,"path")				 
						if InStr(Path,"//") then
							Path=Replace(Path,"//","/")
						end if
						KeyFile=split(Key(I),"/")
						if UBound(KeyFile) > 0 Then
						  FileName=KeyFile(UBound(KeyFile))									
						end if					
						Path=Replace(Path,Servers&"/","")
						if InStr(Path, "/") then
						  if Right(Path,1)="/" then
							  Path=left(Path,len(Path)-1)
						  end if						  
						end if
						if InStr(Servers, "1dy.cc")=0 then
							set Rsp=Server.CreateObject("Adodb.Recordset")
							Rsp.open "select [Tid] from [Liu_TempPic] where PicPath='"&TempUrl&"' and UserName='"&UserName&"' and ParentID="&Cid&"",Conn,1,1
							if Rsp.eof and Rsp.bof then
								conn.execute("insert into [Liu_TempPic] ([ParentID],[UserName],[PicPath],[Server],[ServerPath],[FileName]) values("&Cid&",'"&UserName&"','"&key(I)&"','"&Servers&"','"&Path&"','"&FileName&"')")
							end if
							Rsp.close
							Set Rsp=Nothing
						end if
					end if
				next
			end if
		else		
			Response.Write("搬家文件不存在")
			Response.End()
		end if
		Rs.Close
		Set Rs=Nothing
	else
		Response.Write("参数错误")
		Response.End()
	end if	
%>
<form id="csvform" name="csvform" method="POST" action="" >
<input type="hidden" name="cid" id="cid" value="<%=Cid%>" />
<table width="100%" border="0" cellspacing="0" cellpadding="0">
    <tr>
    <td height="32" background="images/0025.gif"><span class="itemlist"><b>选择要搬家的图片域名</b></span></td>
  </tr>
<tr>
    <td bgcolor="#fafafa" class="itemlist">
    	<%
			Dim countpic
			Set Rs=Server.CreateObject("Adodb.recordset")
			Rs.Open "Select distinct [Server] from [Liu_TempPic] Where ParentID="&Cid&" and UserName='"&UserName&"'",Conn,1,3
			if Not (Rs.eof and Rs.bof) then
				do while Not Rs.eof
					countpic=DBGetNum("Liu_TempPic","Tid",0,"where UserName='"&UserName&"' and Server='"&Rs("Server")&"' and ParentID="&Cid&"")
					Response.Write "<input type=""checkbox"" name=""domain"" id=""domain"" value="""&Rs("Server")&""" checked />"&Rs("Server")&"<font color=""red"">&nbsp;共有"&countpic&"个不重复文件</font><br/>"
				Rs.MoveNext
				loop
			else
				Response.Write("没有要搬家的域名")
			end if
			Rs.close
			Set Rs=Nothing
		%>
    </td>
  </tr>
    <tr>
    	<td class="itemlist">
        <input id="upbt" name="upbt" type="button" value="开始搬家" class="btnt2" onclick="return CheckDomain();" /></td>
	</tr>
   </table>
</form>
<%
end sub

sub stopmove()
	Dim Rs,cid
	cid=CheckNumeric(Request("cid"))
	Conn.execute("delete from [Liu_TempPic] Where ParentID="&cid&" and UserName='"&UserName&"'")
	Response.Redirect "Movepic.asp"
end sub

sub starmove()
	Dim Rs,cid,domain,CountPic
	cid=CheckNumeric(Request("cid"))
	domain=CheckStr(Request("domain"))
	set Rs=server.CreateObject("Adodb.Recordset")
	Rs.open "select [server] from [Liu_TempPic] where ParentID="&Cid&" and UserName='"&UserName&"'",conn,1,3
	if Not (Rs.eof and Rs.bof) then
		do while Not Rs.eof
			if InStr(domain,Rs("server"))=0 then
				'Response.Write InStr(domain,Rs("server"))&"-------------------------"&Rs("server")&"<br/>"
				Rs.delete
			end if
		Rs.MoveNext
		loop
	end if
	Rs.close
	Set Rs=Nothing
	CountPic=DBGetNum("Liu_TempPic","Tid",0,"Where ParentID="&Cid&" and UserName='"&UserName&"'")
%>
<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td height="32" background="images/0025.gif"><span class="itemlist"><b>开始搬家</b></span></td>
  </tr>
<tr>
    <td bgcolor="#fafafa" class="itemlist">
    	<div id="itemText">
        	<span id="loading"><img src="Images/loader.gif" /></span>正在下载图片，请稍后，共<%=CountPic%>张，已下载<span id="itemNum">0</span>张<br />
            处进过程中请勿刷新或关闭本页！<br />
            下载失败列表：<br />
            <div id="itemErrorPic"></div>
        </div>
    </td>
  </tr>
  <%if CountPic=0 then%>
  	<tr>
    <td bgcolor="#fafafa" class="itemlist">
    	<a href="Movepic.asp?action=movepic">没有可替换的地址，请重新上传CSV文件</a></td>
    </td>
  </tr>
  <%end if%>
  <tr>
    <td id="replay" bgcolor="#fafafa" class="itemlist" style="display:none;">
    	<a href="Movepic.asp?action=replaymove&cid=<%=cid%>">重新下载失败的图片</a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a href="Movepic.asp?action=replacecsv&cid=<%=cid%>">马上替换原图地址</a></td>
    </td>
  </tr>
</table>
<iframe src="/AjaxAsp/AjaxMovePic.asp?cid=<%=cid%>" width="0" height="0" scrolling="no"></iframe>
<script type="text/javascript">
//	window.onbeforeunload = function(event){
//         event = event || window.event;
//         event.returnValue = "页面正在进行搬家,确定要离开吗?";
//    }
</script>
<%	
end sub

sub replaymove()
	Dim cid,CountPic
	cid=CheckNumeric(Request("cid"))
	CountPic=DBGetNum("Liu_TempPic","Tid",0,"Where ParentID="&cid&" and UserName='"&UserName&"'")
%>
<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td height="32" background="images/0025.gif"><span class="itemlist"><b>开始搬家</b></span></td>
  </tr>
<tr>
    <td bgcolor="#fafafa" class="itemlist">
    	<div id="itemText">
        	<span id="loading"><img src="Images/loader.gif" /></span>正在下载图片，请稍后，共<%=CountPic%>张，已下载<span id="itemNum">0</span>张<br />
            处进过程中请勿刷新或关闭本页！<br />
            下载失败列表：<br />
            <div id="itemErrorPic"></div>
        </div>
    </td>
  </tr>
  <%if CountPic=0 then%>
  	<tr>
    <td bgcolor="#fafafa" class="itemlist">
    	<a href="Movepic.asp?action=movepic">没有可替换的地址，请重新上传CSV文件</a></td>
    </td>
  </tr>
  <%end if%>
  <tr>
    <td id="replay" bgcolor="#fafafa" class="itemlist" style="display:none;">
    	<a href="Movepic.asp?action=replaymove&cid=<%=cid%>">重新下载失败的图片</a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a href="Movepic.asp?action=replacecsv&cid=<%=cid%>">马上替换原图地址</a></td>
    </td>
  </tr>
</table>
<iframe src="/AjaxAsp/AjaxMovePic.asp?cid=<%=cid%>" width="0" height="0" scrolling="no"></iframe>
<%	
end sub
sub replacecsv()
dim cid,Rs,OldFileName,NewFileName,Domain,m,KeyDomain,I
Dim FilePath,TempBody
cid=CheckNumeric(Request("cid"))
Set Rs=Server.CreateObject("adodb.recordset")
Rs.open "select top 1 [OldFileName],[FileName] from [Liu_Csv] where cid="&cid&"",conn,1,1
if Not(Rs.eof and Rs.bof) then
	OldFileName=Rs("OldFileName")
	NewFileName=Rs("FileName")
end if
Rs.close
Set Rs=nothing
m=1
Set Rs=Server.CreateObject("Adodb.recordset")
Rs.Open "Select distinct [Server] from [Liu_TempPic] Where ParentID="&Cid&" and UserName='"&UserName&"'",Conn,1,3
if Not (Rs.eof and Rs.bof) then
	do while Not Rs.eof
		if m=1 then
			Domain=Domain&Rs("Server")
		else
			Domain=Domain&"|$$|"&Rs("Server")
		end if
		m=m+1
	Rs.MoveNext
	loop
end if
Rs.close
Set Rs=Nothing

FilePath=CreatHtml&"/"&NewFileName
TempBody= LoadFile(FilePath)

if Not GetIsNull(Domain) then
	KeyDomain=split(Domain,"|$$|")
	for I=0 to UBound(KeyDomain)
		TempBody=Replace(TempBody,"http://"&KeyDomain(I),MainURL&"/movepic"&cid)
	next
end if
OldFileName=OldFileName&UserName&cid&".csv"
%>
<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td height="32" background="images/0025.gif"><span class="itemlist"><b>您店铺的图片已经下载到<font color="#FF0000">一定呦</font>,现在请您使用淘宝助理做以下操作，即可批量替换图片地址。</b></span></td>
  </tr>
<tr>
    <td bgcolor="#fafafa" class="itemlist">
    	<div id="itemText">
        <%
		if SaveCsv(TempBody,CreatHtml&"/"&OldFileName) then
		conn.execute("update [Liu_Csv] set Flag=2,NewFileName='"&OldFileName&"' where UserName='"&UserName&"' and cid="&cid&"")
		%>
    	方案一：直接<a href="<%=MainHtml%>/<%=OldFileName%>"><font color="red">下载替换好的CSV文件</font></a>，重新导入到淘宝助理中替换原有宝贝并上传即可。<br />
        <%end if%>
        <%
			if Not GetIsNull(Domain) then
		%>
        方案二：可手动在淘宝助里里面替换原图片的域名<font color="red">(点击文本框可直接复制地址)</font>： <br />
        <%
			KeyDomain=split(Domain,"|$$|")
			for I=0 to UBound(KeyDomain)
		%>       
        将<input type="text" class="text" onclick="copylink(this.value);" value="http://<%=KeyDomain(I)%>" size="70" /> 替换为 <input type="text" class="text" onclick="copylink(this.value);" value="<%=MainURL%>/movepic<%=cid%>" size="80" /><br />
        <%
			next
			end if
		%>
        </div>
    </td>
  </tr>
</table>
<%
end sub
sub delcsv()
	dim cid,Rs,fso	
	cid=CheckNumeric(Request("cid"))
	if cid>0 then
		set fso=new dmfso
		Set Rs=server.CreateObject("adodb.recordset")
		Rs.open "select top 1 [FileName],[NewFileName],[FileSize] from [Liu_Csv] where cid="&cid&" and UserName='"&UserName&"'",conn,1,3
		if Not (Rs.eof and Rs.bof) then
			fso.DelFile(CreatHtml&"/"&rs("FileName"))
			fso.DelFile(CreatHtml&"/"&rs("NewFileName"))
			conn.execute("update [Liu_User] set UsedBytes=UsedBytes-"&cdbl(CheckNumeric(Rs("FileSize")))&",ResBytes=ResBytes+"&cdbl(CheckNumeric(Rs("FileSize")))&" where UserName='"&UserName&"'")
			conn.execute("delete from [Liu_TempPic] where ParentID="&cid&" and UserName='"&UserName&"'")
			Rs.delete
		end if
		Rs.close
		Set Rs=nothing
		set fso=nothing
	end if
	Response.Redirect("movepic.asp")
end sub
%>
</body>
</html>