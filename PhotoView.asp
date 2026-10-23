<!--#include file="./incs/model.asp"-->
<%
	Dim UserName,Pid,Kid,MainURL
	UserName=trim(request.QueryString("kname"))
	if  GetIsNull(UserName) then
		if GetIsNull(request.cookies("1dy")("UserName")) then
			UserName=request.cookies("1dy")("UserName")
		else
			response.Write("<script>alert('地址不存在!');location.href='index.asp';</script>")
			response.End()
		end if
	end if
	Pid=int(request.QueryString("Pid"))
	Kid=int(request.QueryString("Kid"))

	function ShowPhotoName()
		DIm Sqlstr
		Sqlstr="select top 1 [kid],[kname],[IsOpen] from [Liu_Folder] where IsPhoto=1 and kid="&kid&" and  kuser='"&UserName&"'"
		set Rs=conn.execute(Sqlstr)
		if Not(Rs.eof and Rs.bof) then
			ShowPhotoName=Rs(1)
		else
			response.Redirect "Photo.asp?kname="&UserName&""
			exit function
		end if
		Rs.close
		set Rs=nothing
	end function

	function ShowPhotoList()
		DIm TempStr,StrTable,StrText,StrWhere,StrOrder,indexOrder
		StrTable=" [Liu_Pic]"
		StrText=" [pid],[kid],[photoUrl],[photopic],[purl],[pdesc],[psize],[pdate] "
		StrWhere=" and kid="&kid&" and  kuser='"&UserName&"' "
		StrOrder=" Pid "
		indexOrder=1
		set cmd=Server.CreateObject("ADODB.Command")
		with cmd
			.ActiveConnection = conn
			.CommandText = "liu_PageAll"
			.CommandType = 4
			.Prepared = true
			.Parameters.append .CreateParameter("@StrTable",200,1,200,StrTable)
			.Parameters.append .CreateParameter("@StrText",200,1,1000,StrText)
			.Parameters.append .CreateParameter("@StrWhere",200,1,1000,StrWhere)
			.Parameters.append .CreateParameter("@StrOrder",200,1,100,StrOrder)
			.Parameters.append .CreateParameter("@indexOrder",3,1,4,indexOrder)
			.Parameters.append .CreateParameter("@StrSql",200,2,2000)
			set rs= .Execute
		end with
		if not (rs.eof and rs.bof) then
			do while not rs.eof
				Dim kpath,kupid,kname
				kupid=DBGetValue("liu_folder","upid"," kid="&rs("kid")&" and kuser='"&UserName&"'")
				kname=DBGetValue("liu_folder","[kname]","kid="&rs("kid")&" and kuser='"&UserName&"'")

				if kupid="0" then
					MainUrl=GetUserShowPic(UserName,"img")&UserName&"/pic/"&kname&"/"
				else
					kpath=DBGetValue("liu_folder","kpath","kid="&kupid&" and kuser='"&UserName&"'")
					MainUrl=GetUserShowPic(UserName,"img")&UserName&"/pic"&kpath&kname&"/"
				end if
				TempStr=TempStr&"{showtit:'"&ShowPhotoName()&"',showtxt:'<p>"&Rs("Pdesc")&"</p>',smallpic:'"&MainURL&Rs("Photourl")&"','bigpic':'"&MainUrl&Rs("purl")&"',thumper:'"&MainURL&Rs("purl")&"',posttime:'"&FormatDateTime(rs("Pdate"),2)&"',psize:'"&FormatFileSize(Rs("Psize"))&"'},"
			rs.movenext
			loop
		end if
		rs.close
		set rs=nothing
		if TempStr<>"" then
			ShowPhotoList=left(TempStr,len(TempStr)-1)
		end if
	end function

	function ShowMorePhoto()
		DIm Sqlstr,Tempstr
		Sqlstr="select top 11 [kid],[kname],[kuser],[upid] from [liu_Folder] where IsPhoto=1 and kuser='"&UserName&"'"
		set Rs=conn.execute(Sqlstr)
		if Not (Rs.eof and Rs.bof) then
			do while not Rs.eof
				Dim kpath,kupid,kname
				if rs(3)="0" then
					MainUrl=GetUserShowPic(UserName,"img")&UserName&"/pic/"&rs(1)&"/"
				else
					kpath=DBGetValue("liu_folder","kpath","kid="&rs(3)&" and kuser='"&UserName&"'")
					MainUrl=GetUserShowPic(UserName,"img")&UserName&"/pic"&kpath&rs(1)&"/"
				end if
				PthUrl=DBGetValue("[Liu_Pic]","[PthUrl]"," kid="&Rs(0)&" and kuser='"&UserName&"'")
				if PthUrl="" then
				PthUrl="images/photo/nocvb.jpg"
				else
				PthUrl=MainURL&PthUrl
				end if
				Tempstr=Tempstr&"<LI><div class=img><A target=_blank href=""PhotoView.asp?Kname="&Rs(2)&"&kid="&Rs(0)&"#p=1""><p><IMG alt="""&Rs(1)&""" src="""&PthUrl&"""></p></A></div><A class=link target=_blank href=""PhotoView.asp?Kname="&Rs(2)&"&kid="&Rs(0)&"#p=1"">"&Rs(1)&"</A></LI>"
			Rs.movenext
			loop
		end if
		Rs.close
		Set Rs=nothing
		ShowMorePhoto=Tempstr
	end function
%>
<html>
<head>
<meta content="text/html; charset=gb2312" http-equiv="Content-Type">
<META HTTP-EQUIV="pragma" CONTENT="no-cache">
<META HTTP-EQUIV="Cache-Control" CONTENT="no-cache, must-revalidate">
<title>我的一定呦相册- 网络图片存储系统 www.1dy.cc</title>
<style>
body, div, dl, dt, dd, ul, ol, li, h1, h2, h3, h4, h5, h6, pre, form, fieldset, input, textarea, p, blockquote, th, td { margin:0; padding:0; }
ul, ol, li { list-style:none; }
img { border:0; }
body { background:#0D0D0D; text-align:center; overflow-x:hidden; }
.wrap-QQ { width:100%; text-align:center; }
#miniNav { width:100%; background:#111111; position:relative; line-height:47px; text-align:left; height:47px; }
#miniNav #logo { margin-left:10px; height:50px; }
#miniNav #lMenu { position:absolute; left:170px; top:0px; color:#fff; font-size:12px; }
#miniNav #lMenu a { font-size:12px; color:#fff; text-decoration:none; }
#miniNav #lMenu a:hover { text-decoration:underline; }
#miniNav #rMenu { position:absolute; right:40px; top:0px; font-size:12px; color:#747474; }
#miniNav #rMenu a { font-size:12px; color:#B3B3B3; text-decoration:none; }
#miniNav #rMenu a:hover { color:#B3B3B3; text-decoration:underline; }
#picPlayer { position:relative; width:100%; background:#000; }
#picPlayer h1 { font:800 26px/30px "宋体", arial; line-height:22px; color:#fff; padding:24px 0 10px 0; margin:0 auto; }
.leftdiv { float:left; width:126px; height:445px; text-align:center; display:none; }
.middlediv { margin:0 126px; margin-right:0px; overflow:visible; }
.rightdiv { float:right; width:126px; height:445px; display:block; }
.clearfix { clear:both; font-size:0; height:0; line-height:0px; }
.sideMenu { width:108px; height:445px; background:#0D0D0D; margin:0 auto; border:1px solid #212121; }
.digtitle_r { width:108px; height:21px; background:url(showPic/titlebg2.png) no-repeat center center; border-bottom:1px solid #212121; }
.arrTop { display:block; width:108px; height:34px; line-height:22px; background:url(showPic/arrowTop.png) no-repeat center center; cursor:pointer; }
.arrBottom { display:block; width:108px; height:34px; line-height:22px; background:url(showPic/arrowBottom.png) no-repeat center center; cursor:pointer; }
.sildBox { width:108px; height:350px; overflow-y:auto; overflow-x:hidden; margin:0 auto; }
.sildBox li { width:88px; height:58px; margin:0px auto 13px; text-align:right; position:relative; padding-left:4px; }
.sildBox li div.inner { width:88px; height:58px; text-align:center; overflow:hidden; border:1px solid #484848; cursor:pointer; }
.sildBox li.select { background:url(showPic/arrow.png) no-repeat left; }
.sildBox li.select div.inner { border:3px #F9AF10 solid; }
.sildBox li img { width:88px; }
.hiddMiddle { width:26px; float:left; margin-top:0px; text-align:left; padding:0; position:relative; z-index:2; }
.textMiddle { width:106px; float:left; margin-top:0px; text-align:left; padding:12px; position:relative; border:1px solid #000; z-index:2; background:#000; height:619px; }
.textMiddle h2 { font-size:14px; color:#fff; font-weight:bold; padding-top:14px; padding-bottom:14px; }
.textMiddle span { margin:0; padding:0; font-size:12px; color:#747474; line-height:22px; }
.textMiddle p { line-height:22px; padding:0px; font-size:12px; color:#FFF; }
.stage { height:645px; background:#000; overflow:hidden; line-height:645px; }
.stage img { max-width:95%; max-height:640px; vertical-align:middle; cursor:pointer; }
.stage .emptytip { color:#555; font-size:14px; line-height:645px; }
.deDivHeight { height:36px; line-height:20px; background:#000; width:100%; margin:0 auto; }
.tool { width:80%; font-size:12px; color:#747474; text-align:left; padding:0; margin:0 auto; position:relative; }
.tool a { color:#B4B4B4; font-size:12px; text-decoration:none; padding-bottom:9px; cursor:pointer; }
.tool a:hover { text-decoration:underline; }
.showList { width:100%; background:#151515; margin:0 auto; border:1px solid #1B1B1B; border-left:0px; border-right:0px; }
.showList .header h2 { float:right; width:12px; line-height:26px; margin-top:22px; font-size:14px; color:#6B6B6B; }
.showList .body { width:95%; margin:0 auto; height:148px; text-align:justify; text-justify:inter-ideograph; float:right; }
.showList .body li { width:160px; height:120px; display:inline-table; *display:inline; margin-top:28px; margin-bottom:9px; margin-right:20px; text-align:center; vertical-align:middle; }
.showList .body li .img { width:120px; height:90px; overflow:hidden; line-height:90px; vertical-align:middle; position:relative; text-align:center; }
.showList .body li .img img { vertical-align:middle; max-width:120px; max-height:90px; }
.showList .body li a.link { display:block; width:160px; font-size:12px; color:#FFFFFF; text-decoration:none; line-height:30px; }
.showList .body li a:hover { text-decoration:underline; }
</style>
</head>
<body>
<div class="wrap-QQ" id="wrap-QQ">
  <div id="miniNav"> <img src="images/logo3.jpg" id="logo"/>
    <div id="lMenu"> 返回：<a href="Photo.asp?kname=<%=UserName%>">相册列表</a>&nbsp;&gt;&gt;&nbsp;<%=ShowPhotoName()%> </div>
    <div id="rMenu"> <a href="home.asp" target="_self">我的一定呦</a>&nbsp;|&nbsp;<a href="pay.asp" target="_self">缴费中心</a>&nbsp;|&nbsp;<a href="UserMessage.asp" target="_self">纸条箱</a> </div>
  </div>
  <div class="wrap-QQ" id="picPlayer">
    <h1><%=ShowPhotoName()%></h1>
    <div class="rightdiv">
      <div class="sideMenu">
        <div class="digtitle_r"></div>
        <div class="sideBox"> <a class="arrTop" href="javascript:void(0);" id="perPicPage" title="上一张"></a>
          <div class="sildBox" id="sildBox">
            <ul id="strip"></ul>
          </div>
          <a class="arrBottom" href="javascript:void(0);" id="nextPicPage" title="下一张"></a> </div>
      </div>
    </div>
    <div class="middlediv">
      <div class="textMiddle">
        <h2 id="titleStr"></h2>
        <span>发表日期：<span id="postStr"></span></span>
        <span>大小：<span id="sizeStr"></span></span>
        <p id="descriptStr"></p>
      </div>
      <div class="stage" id="stage"><span class="emptytip">本相册暂无照片</span></div>
    </div>
    <div class="clearfix"></div>
    <div class="deDivHeight">
      <div class="tool"> <a href="javascript:void(0);" id="thumper">查看原图</a> | <a href="javascript:void(0);" id="downLoad">下载此照片</a> | <a href="javascript:void(0);" id="copypic">复制地址</a> </div>
    </div>
    <div class="clearfix"></div>
  </div>
  <div class="showList">
    <DIV class="header">
      <H2>更多相册</H2>
    </DIV>
    <DIV class="body">
      <UL>
        <%=ShowMorePhoto()%>
      </UL>
    </DIV>
    <div class="clearfix"></div>
  </div>
</div>
<div id="footer">
  <table cellspacing="0" cellpadding="0" border="0" align="center" width="100%" id="CopyRight2008" style="font-size:12px;color:#4C4C4C;clear:both;margin:0 auto;">
    <tr>
      <td height="30" align="right">Copyright &copy; 2009 一定呦版权所有 </td>
      <td width="20"></td>
    </tr>
  </table>
</div>
<script type="text/javascript">
var photoJson = [<%=ShowPhotoList()%>];
var cur = 0;

function el(id){ return document.getElementById(id); }

function buildStrip(){
	var ul = el('strip');
	ul.innerHTML = '';
	for (var i=0;i<photoJson.length;i++){
		var li = document.createElement('li');
		if (i==cur) li.className = 'select';
		var div = document.createElement('div');
		div.className = 'inner';
		var img = document.createElement('img');
		img.src = photoJson[i].smallpic;
		img.title = '第' + (i+1) + '张';
		(function(idx){ img.onclick = function(){ show(idx); }; })(i);
		div.appendChild(img);
		li.appendChild(div);
		ul.appendChild(li);
	}
}

function show(i){
	if (photoJson.length==0) return;
	if (i<0) i = photoJson.length-1;
	if (i>=photoJson.length) i = 0;
	cur = i;
	var p = photoJson[i];
	var stage = el('stage');
	stage.innerHTML = '';
	var img = document.createElement('img');
	img.src = p.bigpic;
	img.onclick = function(){ show(cur+1); };
	stage.appendChild(img);
	el('titleStr').innerHTML = p.showtit;
	el('postStr').innerHTML = p.posttime;
	el('sizeStr').innerHTML = p.psize;
	el('descriptStr').innerHTML = p.showtxt;
	var lis = el('strip').getElementsByTagName('li');
	for (var j=0;j<lis.length;j++){ lis[j].className = (j==cur) ? 'select' : ''; }
	if (lis[cur]) lis[cur].scrollIntoView(false);
	try { history.replaceState(null, '', '#p=' + cur); } catch(e) { location.hash = 'p=' + cur; }
}

function init(){
	if (photoJson.length==0){
		el('stage').innerHTML = '<span class="emptytip">本相册暂无照片</span>';
		return;
	}
	var h = (location.hash || '').replace('#p=','');
	var start = parseInt(h, 10);
	if (isNaN(start) || start<0 || start>=photoJson.length) start = 0;
	buildStrip();
	show(start);
	el('perPicPage').onclick = function(){ show(cur-1); };
	el('nextPicPage').onclick = function(){ show(cur+1); };
	el('thumper').onclick = function(){ window.open(photoJson[cur].bigpic, '_blank'); };
	el('downLoad').onclick = function(){ window.open(photoJson[cur].bigpic, '_blank'); };
	el('copypic').onclick = function(){
		var url = photoJson[cur].bigpic;
		if (window.clipboardData && window.clipboardData.setData) {
			window.clipboardData.setData('Text', url);
			alert('图片地址已复制');
		} else if (navigator.clipboard && navigator.clipboard.writeText) {
			navigator.clipboard.writeText(url).then(function(){ alert('图片地址已复制'); }, function(){ prompt('请手动复制地址：', url); });
		} else {
			prompt('请手动复制地址：', url);
		}
	};
	document.onkeydown = function(e){
		var k = e ? e.keyCode : window.event.keyCode;
		if (k==37) show(cur-1);
		if (k==39) show(cur+1);
	};
}
init();
</script>
</body>
</html>
