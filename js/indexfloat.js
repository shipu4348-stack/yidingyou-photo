var nowMT=-42;
var tagMT=0;
var adobj; 
var opendiv; 
var closdiv; 
var addfunc; 
var handobj; 
var reducefunc;         
var speed=2;
function showtopad(){
adobj=document.getElementById("bigad");
opendiv=document.getElementById("opendiv");
closdiv=document.getElementById("closdiv");
if (nowMT<=0){
adobj.style.display="block";
addfunc=setInterval("addheight()",1);
} 
} 
function closetopad(){
if (nowMT<=speed){
callreduceheight();
if (typeof(handobj)=="number"){
clearTimeout(handobj);
}
} 
} 
function addheight(){
nowMT+=speed;
if (nowMT>tagMT){
clearInterval(addfunc);
return;
}
adobj.style.marginTop=nowMT+"px";
} 
function callreduceheight(){
reducefunc=setInterval("reduceheight()",1);
} 
function reduceheight(){
adobj.style.marginTop=nowMT+"px";
nowMT-=speed;
if (nowMT<=-42){
clearInterval(reducefunc);
adobj.style.display="none";
return;
}
}
$(document).ready(function(){showtopad()});
