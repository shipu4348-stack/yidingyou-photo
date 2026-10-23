
// JavaScript Document
// JavaScript Document
//在鼠标显示一个层，该层的内空为div2的内容 
function showdiv(divname){ 
var div3 = document.getElementById(divname); //将要弹出的层 
div3.style.display="block"; //div3初始状态是不可见的，设置可为可见 
//window.event代表事件状态，如事件发生的元素，键盘状态，鼠标位置和鼠标按钮状. 
//clientX是鼠标指针位置相对于窗口客户区域的 x 坐标，其中客户区域不包括窗口自身的控件和滚动条。 
div3.style.left=event.clientX+10; //鼠标目前在X轴上的位置，加10是为了向右边移动10个px方便看到内容 
div3.style.top=event.clientY+5; 
div3.style.position="absolute"; //必须指定这个属性，否则div3层无法跟着鼠标动 
//var div2 =document.getElementById('div2'); 
//div3.innerText=div2.innerHTML; 
} 
//关闭层div3的显示 
function closediv(divname){ 
var div3 = document.getElementById(divname); 
div3.style.display="none"; 
}

function winshow(pagename,w,h){
  window.open(pagename,null,"width="+w+",height="+h);
}
function checkbox(obj,num){
  var id;
  for (i=1;i<=num;i++){
	id=obj+i;
	if(document.getElementById(id).checked==""){
	  document.getElementById(id).checked="checked";
	}
	else{
	  document.getElementById(id).checked="";
	}
  }
}



var xhr;
function getXHR() {
 try {
  xhr=new ActiveXObject("Msxml2.XMLHTTP");
 } catch (e) {
 try {
  xhr=new ActiveXObject("Microsoft.XMLHTTP");
 } catch (e) {
 xhr=false;
}
}
if(!xhr&&typeof XMLHttpRequest!='undefined') {
xhr=new XMLHttpRequest();
}
return xhr;
}

function openXHR(method,url) {
getXHR();
xhr.open(method,url,true);
xhr.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
xhr.onreadystatechange=function() {
if(xhr.readyState!=4)return;
  document.write(xhr.responseText);//responseBody
}
xhr.send(null);
}

function loadXML(method,url) {
getXHR();
xhr.open(method,url,true);
xhr.setRequestHeader("Content-Type","text/xml");
xhr.setRequestHeader("Content-Type","GBK");
xhr.onreadystatechange=function() {
if(xhr.readyState!=4) return;
   document.write(xhr.responseText);
  //$("abc").innerHTML = xhr.responseText;
}
xhr.send(null);
}

function $(idValue)
{
  return document.getElementById(idValue);
}
