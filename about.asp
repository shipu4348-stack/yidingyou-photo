<!--#include file="incs/conn.asp"-->
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
<title>一定呦图片存储</title>
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
                        <div class="bh-a"><h3>公司简介</h3></div>
                        <div class="bc-a">
                            <div class="mod-tab-a">
                                
                                <div id="tab_company_con" class="tc-a">

                                    <div style="display: block;" class="tab-content">
                                        <div class="con-txt">
											<%
                                            set rs=server.createobject("adodb.recordset")
                                            rs.open "select top 1 [content] from ydy_info where id=3",conn,1,1
                                            if rs.eof or rs.bof then
                                          	  response.write "请在后台添加内容"
                                            else
                                           	 response.write rs("content")
                                            end if
                                            rs.close
                                            set rs=nothing
                                            %>
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
                                    <li><a class="current" href="About.asp?ac=aboutus">公司简介</a></li>
                                     <li><a href="help.asp">帮助信息</a></li>
                                      <li><a href="Note.asp?ac=note">网站公告</a></li>
                                    <li><a href="affairs.asp">大事记</a></li>
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