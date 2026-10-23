<!--#include file="incs/conn.asp"-->
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
	<%
	Function Checkstr(Str)
	If Isnull(Str) Then
		CheckStr = ""
		Exit Function 
	End If
	Str = Replace(Str,Chr(0),"")
	CheckStr = Replace(Str,"'","''")
End Function

Function CheckNumeric(Byval CHECK_ID)
	If CHECK_ID<>"" and IsNumeric(CHECK_ID) Then _
		CHECK_ID = cCur(CHECK_ID) _
	Else _
		CHECK_ID = 0
	CheckNumeric = CHECK_ID
End Function

id=CheckNumeric(request.QueryString("id"))
set rs=server.CreateObject("adodb.recordset")
rs.open "select * from ydy_notice where id="&id&"",conn,1,1
if rs.eof or rs.bof then
  response.write "<script language='javascript'>alert('此内容已被删除或不存!');history.back();</script>"
else
  title=rs("title")
   content=rs("content")
end if
rs.close
set rs=nothing
%>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
<title><%=title%>--一定呦图片存储</title>
<meta name="keywords" content="存储空间，图片存储" />
<meta http-equiv="X-UA-Compatible" content="IE=EmulateIE7" />
<meta name="Description" content="一定呦-网络图片存储，提供淘宝，拍拍，有啊等店铺宝贝图片存储空间!" />
<link href="images/2010/Global.css" type="text/css" rel="stylesheet"/>
 <link rel="stylesheet" type="text/css" href="images/2010/top_bar.css" />
<link href="images/2010/main.css" type="text/css" rel="stylesheet"/>
<link href="images/2010/login.css" type="text/css" rel="stylesheet"/>
<script src="js/jquery-1.4.2.min.js" type="text/javascript"></script>
<script src="js/yl_common.js" type="text/javascript"></script>
<script type="text/javascript" src="js/indexlogin.js?v=2"></script>
<script type="text/javascript" src="js/sindexagent.js"></script>

</head>
<body>
<a name="top"></a>
<!--topbar-->

<!--#include File="top.asp"-->
 
 <div id="content">
        <div class="layout lay-ms">
            <div class="lay-main">
                <div class="main-wrap">

                    <div class="mod-box-a">
                        <div class="bh-a"><h3><%=title%></h3></div>
                        <div class="bc-a">
                            <div class="mod-tab-a">
                                
                                <div id="tab_company_con" class="tc-a">

                                    <div style="display: block;" class="tab-content">
                                        <div class="con-txt">
										<%= content %>
                                        </div>
                                       
                                    </div>

                                    
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div><!-- /.lay-main-->
            <div class="lay-side">
                               <div class="mod-left-menu">    
                                <ul>
                                    <li><a href="About.asp?ac=aboutus">公司简介</a></li>
                                     <li><a href="help.asp">帮助信息</a></li>
                                      <li><a href="Note.asp?ac=note" class="current" >网站公告</a></li>
                                    <li><a href="About.asp?ac=events">大事记</a></li>
                                 </ul>              
                                </div> 
            </div><!-- /.lay-side -->
        </div><!-- /.lay-ms-->
        
    </div>
    
<script>
tabPage("tab_company","li");
</script>
 <!--/test -->
 <!--#include file="foot.asp"-->
</body>
</html> 