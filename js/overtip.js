
//***********默认设置定义.*********************
var tPopWait=50;		//停留tWait豪秒后显示提示。
var tPopShow=90000;		//显示tShow豪秒后关闭提示
var showPopStep=20;
var popOpacity=95;
var tfontcolor="#A88824";
var tbgcolor="#FFFfff";
var tbordercolor="#B5B2B5";

//***************内部变量定义*****************
var sPop=null,curShow=null,tFadeOut=null,tFadeIn=null,tFadeWaiting=null;


document.write("<div id='dypopLayer' style='z-index:1000; position: absolute; padding:0 0 0 7px; width:132px; margin:-16px 0 0 14px; background:url(images/0030.gif) no-repeat 0 0;'></div>");

function showPopupText()
{
  var o=event.srcElement;
  MouseX=event.x;
  MouseY=event.y;
  if(o.alt!=null && o.alt!=""){o.dypop=o.alt;o.alt=""};
  if(o.title!=null && o.title!=""){o.dypop=o.title;o.title=""};
  if(o.dypop!=sPop)
  {
    sPop=o.dypop;
    clearTimeout(curShow);
    clearTimeout(tFadeOut);
    clearTimeout(tFadeIn);
    clearTimeout(tFadeWaiting);  
    if(sPop==null || sPop=="")
    {
      dypopLayer.innerHTML="";
      dypopLayer.style.filter="Alpha()";
      dypopLayer.filters.Alpha.opacity=0;  
    }
    else
    {
      if(o.dyclass!=null) popStyle=o.dyclass 
      else popStyle="cPopText";
      curShow=setTimeout("showIt()",tPopWait);
    }
  }
}

function showIt()
{
  dypopLayer.className=popStyle;
  dypopLayer.innerHTML="<div style='padding:5px 5px 5px 5px;border:1px solid #a9ddf5;background-color:#f2fbff;text-align:center;'>"+sPop+"</div>";
  popWidth=dypopLayer.clientWidth;
  popHeight=dypopLayer.clientHeight;
  if(MouseX+12+popWidth>document.body.clientWidth) popLeftAdjust=-popWidth-24
    else popLeftAdjust=0;
  if(MouseY+12+popHeight>document.body.clientHeight) popTopAdjust=-popHeight-24
    else popTopAdjust=0;
  dypopLayer.style.left=MouseX+12+document.body.scrollLeft+popLeftAdjust;
  dypopLayer.style.top=MouseY+12+document.body.scrollTop+popTopAdjust;
  dypopLayer.style.filter="Alpha(Opacity=0)";
  fadeOut();
}

function fadeOut(){
  if(dypopLayer.filters.Alpha.opacity<popOpacity)
  {
    dypopLayer.filters.Alpha.opacity+=showPopStep;
    tFadeOut=setTimeout("fadeOut()",1);
  }
  else
  {
    dypopLayer.filters.Alpha.opacity=popOpacity;
    tFadeWaiting=setTimeout("fadeIn()",tPopShow);
  }
}

function fadeIn()
{
  if(dypopLayer.filters.Alpha.opacity>0)
  {
    dypopLayer.filters.Alpha.opacity-=1;
    tFadeIn=setTimeout("fadeIn()",1);
  }
}

document.onmouseover=showPopupText;