<div id="top_bar">
	<div id="top_bar_c">
		<div id="userinfo">
        <% If request.cookies("1dy")("UserName")<>"" Then %>
			欢迎您，<%=request.cookies("1dy")("UserName")%> <a href="maininfo.asp" target="tx8_mainbody">登录首页</a>，<a href="#" onClick="javascript:Logout();">安全退出</a> 
            <% Else %>
          您好，欢迎来到一定哟!<a href=index.asp>请登陆</a><a href=register.asp>免费注册</a>  
		<% End If %>

		</div>
		<div id="toolsbar">
        <% If username<>"" Then %>
			<ul class="top_se">
				<span class="tip"></span>
				<h5><a href="#">我的用户</a><span></span></h5>
				<p>
					<a href="Photo.asp?kname=<%=username%>">我的相册</a>
 					<u></u>
					<a href="Home.asp">我的图片存储</a>
                    
 				</p>
				<s class="s_t"></s>
				<s class="s_b"></s>
			</ul>
			<ul class="line"><u></u></ul>
        <% End If %>
            <ul style="white-space:nowrap;"><a href="javascript:alert('\u5DF2\u5173\u95ED')">店铺统计</a></ul>
			<ul class="line"><u></u></ul>
	<!--		
			<ul class="top_sh">
				<form action=" http://search.$.com/search/" method="get" style="margin:0px;"> 
				<h5 class="top_sh_pic">搜索<span></span></h5>
				<p>
					<input class="top_text" type="text" name="q" value="输入关键字..."/>
					<input class="top_buts" type="submit" value="搜索"/>
					<input type="hidden" value="0" name="p">
				</p>
				<s class="s_t"></s>
				<s class="s_b"></s>
				</form>
			</ul><ul class="line"><u></u></ul> -->
			
			<ul class="top_nn">
				<h5>车车写代码<span></span></h5>
				<p>
					<span class="nn_team">
						<a class="nn_title" href="javascript:void(0)">xxxxxx</a>
						<em>
							<a href="http://#/" target="_blank">xxxxxx</a>
							<a href="http://#/" target="_blank">xxxxxx</a>
							<a href="http://#/" target="_blank" class="red_c">xxxxxx</a>
							<a href="http://#/" target="_blank">xxxxxx</a>
		 
						</em>
					</span>
					<span class="nn_team">
						<a class="nn_title" href="javascript:void(0)">xxxxxx</a>
						<em>
							<a href="http://#/" target="_blank">xxxxxx</a>
							<a href="http://#/" target="_blank">xxxxxx</a>
						</em>
					</span>
					 
					<!--<span class="nn_team no">
						<a class="nn_title" href="/zt/fuwu/">所有服务</a>
					</span> -->
				</p>
				<s class="s_t"></s>
				<s class="s_b"></s>
			</ul>
			<ul class="line"><u></u></ul>
		 
		</div>
	</div>
</div>
<script src="/js/yl_top_bar.js" language="JavaScript" type="text/javascript"></script>

 <div id="web_head" class="web_head"  >
   <div   id="web_logo"  class="fl">  </div>
   <div class="web_nav" id="web_nav" >
       <ul>
            <li><a href="index.asp">首页</a>&nbsp;&nbsp;&nbsp;|</li>
            <li><a href="register.asp">用户注册</a>&nbsp;&nbsp;&nbsp;|</li>
            <li><a href="forget.asp">找回密码</a>&nbsp;&nbsp;&nbsp;|</li>
            <li><a href="jiaofei.asp">缴费开通</a>&nbsp;&nbsp;&nbsp;|</li>
            <li><a href="about.asp">关于我们</a>&nbsp;&nbsp;&nbsp;|</li>
            <li><a href="Help.asp">帮助信息</a></li>
     
       </ul>
   </div>
    
 </div> 
<div class="clearfix"></div>