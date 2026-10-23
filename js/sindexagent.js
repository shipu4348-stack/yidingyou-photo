
ycn=window.ycn||{};ycn.Event={addEvent:function(obj,evType,fn){if(obj.addEventListener)
{obj.addEventListener(evType,fn,false);return true;}
else if(obj.attachEvent)
{var r=obj.attachEvent("on"+evType,fn);ycn.EventCache.add(obj,evType,fn);return r;}
else
{return false;}},removeEvent:function(obj,evType,fn){if(obj.removeEventListener){obj.removeEventListener(evType,fn,false);return true;}else if(obj.detachEvent){var r=obj.detachEvent("on"+evType,fn);return r;}else{return false;}},getEvent:function(e)
{e=window.event||e;e.leftButton=false;if(e.srcElement==null&&e.target!=null)
{e.srcElement=e.target;e.leftButton=(e.button==1);}
else if(e.target==null&&e.srcElement!=null)
{e.target=e.srcElement;e.leftButton=(e.button==0);}
else if(e.srcElement!=null&&e.target!=null)
{}
else{return null}
if(document.body&&document.documentElement)
{e.mouseX=e.pageX||(e.clientX+Math.max(document.body.scrollLeft,document.documentElement.scrollLeft));e.mouseY=e.pageY||(e.clientY+Math.max(document.body.scrollTop,document.documentElement.scrollTop));}
else
{e.mouseX=-1;e.mouseY=-1;}
return e;},stopEvent:function(e)
{if(e&&e.cancelBubble!=null)
{e.cancelBubble=true;e.returnValue=false;}
if(e&&e.stopPropagation&&e.preventDefault)
{e.stopPropagation();e.preventDefault();}
return false;}};ycn.EventCache=function()
{var listEvents=[];return{listEvents:listEvents,add:function(node,sEventName,fHandler,bCapture){listEvents[listEvents.length]=arguments;},flush:function(){var i,item;for(i=listEvents.length-1;i>=0;i=i-1)
{item=listEvents[i];if(item[0].removeEventListener){item[0].removeEventListener(item[1],item[2],item[3]);};if(item[1].substring(0,2)!="on"){item[1]="on"+item[1];};if(item[0].detachEvent){item[0].detachEvent(item[1],item[2]);};item[0][item[1]]=null;};}};}();ycn.Event.addEvent(window,"unload",ycn.EventCache.flush);function error_handler(a,b,c)
{window.status=(c+"\n"+b+"\n\n"+a+"\n\n"+error_handler.caller);return true;}

scrollVertical.prototype.scrollArea=null;scrollVertical.prototype.scrollMsg=null;scrollVertical.prototype.unitHeight=0;scrollVertical.prototype.msgHeight=0;scrollVertical.prototype.copyMsg=null;scrollVertical.prototype.scrollValue=0;scrollVertical.prototype.scrollHeight=0;scrollVertical.prototype.isStop=true;scrollVertical.prototype.isPause=false;scrollVertical.prototype.scrollTimer=null;scrollVertical.prototype.speed=2000;scrollVertical.prototype.isMoz=function(){return navigator.userAgent.toLowerCase().indexOf('gecko')>0;};scrollVertical.prototype.play=function(o){var s_msg=o.scrollMsg;var c_msg=o.copyMsg;var s_area=o.scrollArea;var msg_h=o.msgHeight;var anim=function(){if(o.scrollTimer)clearTimeout(o.scrollTimer);if(o.isPause){o.scrollTimer=setTimeout(anim,10);return;}
if(msg_h-o.scrollValue<=0){o.scrollValue=0;}else{o.scrollValue+=1;o.scrollHeight+=1;}
if(o.isMoz){s_area.scrollTop=o.scrollValue;}else{s_msg.style.top=-1*o.scrollValue+"px";c_msg.style.top=(msg_h-o.scrollValue)+"px";}
if(o.scrollHeight%s_area.offsetHeight==0){o.scrollTimer=setTimeout(anim,o.speed);}else{o.scrollTimer=setTimeout(anim,10);}};anim();};function scrollVertical(disp,msg,tg){if(typeof(disp)=='string'){this.scrollArea=document.getElementById(disp);}else{this.scrollArea=disp;}
if(typeof(msg)=='string'){this.scrollMsg=document.getElementById(msg);}else{this.scrollMsg=msg;}
var s_msg=this.scrollMsg;var s_area=this.scrollArea;if(!tg)var tg='li';this.unitHeight=s_msg.getElementsByTagName(tg)[0].offsetHeight;this.msgHeight=this.unitHeight*s_msg.getElementsByTagName(tg).length;s_msg.style.position="absolute";s_msg.style.top=0;s_msg.style.left=0;var copydiv=document.createElement('div');copydiv.id=s_area.id+"_copymsgid";copydiv.innerHTML=s_msg.innerHTML;copydiv.style.height=this.msgHeight+"px";s_area.appendChild(copydiv);copydiv.style.position="absolute";copydiv.style.top=this.msgHeight+"px";copydiv.style.left=0;this.copyMsg=copydiv;this.play(this);}

function init_castroom(){
 var s_m_1 = new scrollVertical('castroom','castroom_con','tr');
 s_m_1.speed = 8000;
 s_m_1.isPause = true;
 var timer_start = setTimeout(function(){clearTimeout(timer_start);s_m_1.isPause = false;},8000);
 ycn.Event.addEvent(s_m_1.scrollArea,"mouseover",function(){s_m_1.isPause = true;});
 ycn.Event.addEvent(s_m_1.scrollArea,"mouseout",function(){s_m_1.isPause = false;});
}
ycn.Event.addEvent(window,'load',init_castroom);