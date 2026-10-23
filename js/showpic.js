
function showpic(id,url)
{
var content,id,url,alertcontent,tempexts;
content='';
if(top.document.getElementById('dispic'+id)==undefined)
{
content=content+'<DIV class="dispic" id="dispic'+id+'" style="display:none;position: absolute;">';
content=content+'<iframe src="javascript:false" style="position:absolute; top:0px; left:-1px; width:100%; height:100%; z-index:-1; filter=\'progid:DXImageTransform.Microsoft.Alpha(style=0,opacity=0)\';"></iframe>';
content=content+'<table cellSpacing="0" class="ttable">';
content=content+'<tr>';
content=content+'<td onMousedown="initializedragie('+id+')" class="ppptd">';
content=content+'<ilayer width="100%" onSelectStart="return false"><layer width="100%" onMouseover="ID='+id+';dragswitch=1;drag_dropns(dispic'+id+')" onMouseout="dragswitch=0">';

content=content+'<a href="'+url+'" target=_blank><img border=0 style="CURSOR: hand" height="16" src="images/0038.gif" width="50"></a>';
var temp;
temp=url.replace("'","%27");
content=content+' &nbsp; <img style="CURSOR: hand" onclick=\'javascript:showurl("'+temp+'");\' height="16" src="images/0036.gif" width="50">';

exts="jpg;gif;png;bmp";

if(exts.indexOf(url.toLowerCase().substr(url.length-3,3))>=0)
{
content=content+' &nbsp; <img style="CURSOR: hand" onclick=\'javascript:showurl1("'+temp+'");\' height="16" src="images/0037.gif" width="50"> ';

}


content=content+'&nbsp; <img style="CURSOR: hand" onclick="closeshowpic('+id+');" height="16" src="images/0039.gif" width="50">';
content=content+'</layer></ilayer></td>';
content=content+'</tr>';
content=content+'<tr><td align="center">';
content=content+'<div class="pppic">';
exts="jpg;gif;png;bmp";

if(exts.indexOf(url.toLowerCase().substr(url.length-3,3))>=0)
{
content=content+'<img style="cursor:hand;" onmousewheel="return bbimg(this)" onclick="closeshowpic('+id+');" src="'+url+'" />';

}

exts="swf";

if(exts.indexOf(url.toLowerCase().substr(url.length-3,3))>=0)
{
content=content+'<embed src="'+url+'" quality="high" width=370 height=280 pluginspage="http://www.macromedia.com/go/getflashplayer" type="application/x-shockwave-flash"></embed>';
}


exts="ani";

if(exts.indexOf(url.toLowerCase().substr(url.length-3,3))>=0)
{
content=content+'<table width="100%" style="CURSOR: url(\''+url+'\')">       <tr><td height="260"></td></tr></table>';
}


content=content+'</div></td></tr>';
content=content+'</TABLE></DIV>';
top.document.getElementById('dispics').innerHTML=top.document.getElementById('dispics').innerHTML+content;
if((window.event.y-document.body.scrollTop-(top.document.body.clientHeight-400)/2+450)>top.document.body.clientHeight)
{
top.document.getElementById('dispic'+id).style.top = top.document.body.scrollTop+window.event.y-(top.document.body.clientHeight-400)/2-(window.event.y-(top.document.body.clientHeight-400)/2+450)+top.document.body.clientHeight-50;
}
else
{
if(window.event.y-document.body.scrollTop<300)
{
top.document.getElementById('dispic'+id).style.top = top.document.body.scrollTop+100;
}
else
{
top.document.getElementById('dispic'+id).style.top = window.event.y-(top.document.body.clientHeight-400)/2;
}
}
if(window.event.x<400)
{
top.document.getElementById('dispic'+id).style.left =50;
}
else if((window.event.x-document.body.scrollLeft-(top.document.body.clientWidth-600)/2+770)>top.document.body.clientWidth)
{
top.document.getElementById('dispic'+id).style.left=top.document.body.scrollLeft+window.event.x-(top.document.body.clientWidth-600)/2-(window.event.x-(top.document.body.clientWidth-600)/2+750)+top.document.body.clientWidth;
}
else
{
top.document.getElementById('dispic'+id).style.left =window.event.x-(top.document.body.clientWidth-600)/2+186;
}
top.document.getElementById('dispic'+id).style.display='block';
}
else
{
content=content+'<iframe src="javascript:false" style="position:absolute; top:0px; left:-1px; width:100%; height:100%; z-index:-1; filter=\'progid:DXImageTransform.Microsoft.Alpha(style=0,opacity=0)\';"></iframe>';
content=content+'<table cellSpacing="0" class="ttable">';
content=content+'<tr>';
content=content+'<td onMousedown="initializedragie('+id+')" class="ppptd">';
content=content+'<ilayer width="100%" onSelectStart="return false"><layer width="100%" onMouseover="ID='+id+';dragswitch=1;drag_dropns(dispic'+id+')" onMouseout="dragswitch=0">';

content=content+'<a href="'+url+'" target=_blank><img border=0 style="CURSOR: hand" height="16" src="images/0038.gif" width="50"></a>';

var temp;
temp=url.replace("'","%27");
content=content+' &nbsp; <img style="CURSOR: hand" onclick="javascript:showurl(\''+temp+'\');" height="16" src="images/0036.gif" width="50">';
exts="jpg;gif;png;bmp";

if(exts.indexOf(url.toLowerCase().substr(url.length-3,3))>=0)
{
content=content+' &nbsp; <img style="CURSOR: hand" onclick="javascript:showurl1(\''+temp+'\');" height="16" src="images/0037.gif" width="50"> ';

}

content=content+' &nbsp; <img style="CURSOR: hand" onclick="closeshowpic('+id+');" height="16" src="images/0039.gif" width="50">';
content=content+'</layer></ilayer></td>';
content=content+'</tr>';
content=content+'<tr><td align="center">';
content=content+'<div class="pppic"> ';


exts="jpg;gif;png;bmp";

if(exts.indexOf(url.toLowerCase().substr(url.length-3,3))>=0)
{
content=content+'<img style="cursor:hand;" onmousewheel="return bbimg(this)" onclick="closeshowpic('+id+');" src="'+url+'" />';

}

exts="swf";

if(exts.indexOf(url.toLowerCase().substr(url.length-3,3))>=0)
{
content=content+'<embed src="'+url+'" quality="high" width=370 height=280 pluginspage="http://www.macromedia.com/go/getflashplayer" type="application/x-shockwave-flash"></embed>';
}


exts="ani";

if(exts.indexOf(url.toLowerCase().substr(url.length-3,3))>=0)
{
content=content+'<table width="100%" style="CURSOR: url(\''+url+'\')">       <tr><td height="260"></td></tr></table>';
}


content=content+'</div></td></tr>';
content=content+'</TABLE>';
top.document.getElementById('dispic'+id).innerHTML=content;
//top.document.getElementById('dispics').innerHTML=top.document.getElementById('dispics').innerHTML+content;
if((window.event.y-document.body.scrollTop-(top.document.body.clientHeight-400)/2+450)>top.document.body.clientHeight)
{
top.document.getElementById('dispic'+id).style.top = top.document.body.scrollTop+window.event.y-(top.document.body.clientHeight-400)/2-(window.event.y-(top.document.body.clientHeight-400)/2+450)+top.document.body.clientHeight-50;
}
else
{
if(window.event.y-document.body.scrollTop<300)
{
top.document.getElementById('dispic'+id).style.top = top.document.body.scrollTop+100;
}
else
{
top.document.getElementById('dispic'+id).style.top = window.event.y-(top.document.body.clientHeight-400)/2;
}
}


if(window.event.x<400)
{
top.document.getElementById('dispic'+id).style.left =50;
}
else if((window.event.x-document.body.scrollLeft-(top.document.body.clientWidth-600)/2+770)>top.document.body.clientWidth)
{
top.document.getElementById('dispic'+id).style.left=top.document.body.scrollLeft+window.event.x-(top.document.body.clientWidth-600)/2-(window.event.x-(top.document.body.clientWidth-600)/2+750)+top.document.body.clientWidth;
}
else
{
top.document.getElementById('dispic'+id).style.left =window.event.x-(top.document.body.clientWidth-600)/2+186;
}
top.document.getElementById('dispic'+id).style.display='block';
}
}
