<div class='QQbox' id='divQQbox' >

<div class='Qlist' id='divOnline' onmouseout='hideMsgBox(event);' style='display : none;'>

 <div class='t'></div>

<div class='con'>

<h2>在线客服</h2>

<ul>

 

<li><a href="http://sighttp.qq.com/cgi-bin/check?sigkey=YOUR_QQ_SIGKEY_1"; target=_blank; onclick="var tempSrc='http://sighttp.qq.com/wpa.js?rantime='+Math.random()+'&sigkey=YOUR_QQ_SIGKEY_1';var oldscript=document.getElementById('testJs');var newscript=document.createElement('script');newscript.setAttribute('type','text/javascript'); newscript.setAttribute('id', 'testJs');newscript.setAttribute('src',tempSrc);if(oldscript == null){document.body.appendChild(newscript);}else{oldscript.parentNode.replaceChild(newscript, oldscript);}return false;"><img border="0" SRC='http://wpa.qq.com/pa?p=1:111111:44' alt="联系我购买"></a></li>

 <li><a href="http://sighttp.qq.com/cgi-bin/check?sigkey=YOUR_QQ_SIGKEY_2"; target=_blank; onclick="var tempSrc='http://sighttp.qq.com/wpa.js?rantime='+Math.random()+'&sigkey=YOUR_QQ_SIGKEY_2';var oldscript=document.getElementById('testJs');var newscript=document.createElement('script');newscript.setAttribute('type','text/javascript'); newscript.setAttribute('id', 'testJs');newscript.setAttribute('src',tempSrc);if(oldscript == null){document.body.appendChild(newscript);}else{oldscript.parentNode.replaceChild(newscript, oldscript);}return false;"><img border="0" SRC='http://wpa.qq.com/pa?p=1:111111:44' alt="请联系我购买"></a></li>
 
 <li><a href=" http://sighttp.qq.com/cgi-bin/check?sigkey=YOUR_QQ_SIGKEY_3"; target=_blank; onclick="var tempSrc=' http://sighttp.qq.com/wpa.js?rantime='+Math.random()+'&sigkey=YOUR_QQ_SIGKEY_3';var oldscript=document.getElementById('testJs');var newscript=document.createElement('script');newscript.setAttribute('type','text/javascript'); newscript.setAttribute('id', 'testJs');newscript.setAttribute('src',tempSrc);if(oldscript == null){document.body.appendChild(newscript);}else{oldscript.parentNode.replaceChild(newscript, oldscript);}return false;"><img border="0" SRC=' http://wpa.qq.com/pa?p=1:111111:44' alt=" 请联系我购买"></a></li> 
 
  <li><a href="http://sighttp.qq.com/cgi-bin/check?sigkey=YOUR_QQ_SIGKEY_4"; target=_blank; onclick="var tempSrc='http://sighttp.qq.com/wpa.js?rantime='+Math.random()+'&sigkey=YOUR_QQ_SIGKEY_4';var oldscript=document.getElementById('testJs');var newscript=document.createElement('script');newscript.setAttribute('type','text/javascript'); newscript.setAttribute('id', 'testJs');newscript.setAttribute('src',tempSrc);if(oldscript == null){document.body.appendChild(newscript);}else{oldscript.parentNode.replaceChild(newscript, oldscript);}return false;"><img border="0" SRC='http://wpa.qq.com/pa?p=1:111111:44' alt="联系我"></a></li>
<tr><td><li> <img src="/online/style1/images/qq/ww_online.gif" alt="旺旺在线" width="72" height="21"> </li>
             
             <li><img src="/online/style1/images/qq/ww_online.gif" alt="旺旺在线" width="72" height="21"></li>

             
             <li><img src="/online/style1/images/qq/ww_online.gif" alt="旺旺在线" width="72" height="21"></li>

             
             <li><img src="/online/style1/images/qq/ww_online.gif" alt="旺旺在线" width="72" height="21"></li>
             
             
             
             <li>全国免费电话：</li>
             <li><span style="color:#F00" class="fb">123 456 7890</span></li>
              </td></tr>

</ul></div>

<div class='b'></div>

</div>

<div id='divMenu' onmouseover='OnlineOver();'><img src='/online/style1/images/qq/qq_1.png' class='press' alt='QQ客服热线'></div>

</div>


<SCRIPT >

//<![CDATA[

// 面板垂直居中：position:fixed + top:50% + 负 margin，不用 transform，兼容 IE6+。
function centerQQ(){

var box=document.getElementById('divQQbox');

if(!box){return;}

var panel=document.getElementById('divOnline');

var menu=document.getElementById('divMenu');

var h=0;

if(panel&&panel.style.display!='none'){

h=panel.offsetHeight;

}else if(menu){

var im=menu.getElementsByTagName('img');

h=(im&&im.length)?im[0].offsetHeight:menu.offsetHeight;

}

if(h>0){box.style.marginTop=(-(h/2))+'px';}

};

centerQQ();

if(window.attachEvent){window.attachEvent('onresize',centerQQ);}
else{window.onresize=centerQQ;}

//!]]>







function OnlineOver(){

document.getElementById("divMenu").style.display = "none";

document.getElementById("divOnline").style.display = "block";

document.getElementById("divQQbox").style.width = "145px";

centerQQ();

}



function OnlineOut(){

document.getElementById("divMenu").style.display = "block";

document.getElementById("divOnline").style.display = "none";

centerQQ();



}



function hideMsgBox(theEvent){
var e=theEvent || window.event;
var rel=e.relatedTarget || e.toElement;
if (rel && document.getElementById('divOnline').contains(rel)) { return; }

/*要执行的操作*/

document.getElementById("divMenu").style.display = "block";

document.getElementById("divOnline").style.display = "none";

centerQQ();

}
</SCRIPT>
