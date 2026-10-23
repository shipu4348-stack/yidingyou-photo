var imgs,img,Fcous;
Fcous=false;
var Util = {};
Util.Event = {
    stop: function(ent){           
        var e = ent||window.event;
        if (e.preventDefault){
          e.preventDefault();
          e.stopPropagation();
        } 
        else{
          e.returnValue = false;
          e.cancelBubble = true;
        }
    },
    add:function(elem,name,fn,useCapture){
        if (name == 'keypress' &&
        (navigator.appVersion.match(/Konqueror|Safari|KHTML/)
        || elem.attachEvent))
            name = 'keydown';
        if(elem.addEventListener){
            elem.addEventListener(name,fn,useCapture);
        }
        if(elem.attachEvent){
            elem.attachEvent("on"+name,fn);
        }
    },
    getEvent:function() {
        if (window.event) {
            return this.formatEvent(window.event);
        } else {
            return this.getEvent.caller.arguments[0];
        }
    },
    formatEvent:function (oEvent) {
        if (document.all) {
            oEvent.charCode = (oEvent.type == "keypress") ? oEvent.keyCode : 0;
            oEvent.eventPhase = 2;
            oEvent.isChar = (oEvent.charCode > 0);
            oEvent.pageX = oEvent.clientX + document.body.scrollLeft;
            oEvent.pageY = oEvent.clientY + document.documentElement.scrollTop;
            oEvent.layerX = oEvent.offsetX;
            oEvent.layerY = oEvent.offsetY;
            oEvent.preventDefault = function () {
                this.returnValue = false;
            }
            


            if (oEvent.type == "mouseout") {
                oEvent.relatedTarget = oEvent.toElement;
            } else if (oEvent.type == "mouseover") {
                oEvent.relatedTarget = oEvent.fromElement;
            }
            oEvent.stopPropagation = function () {
                this.cancelBubble = true;
            };
            oEvent.target = oEvent.srcElement;
            oEvent.time = (new Date).getTime();
        }
        return oEvent;
    }
}
function $$(element) {
	return document.getElementById(element);
}

var arrowImage1 = new Image();arrowImage1.src = "images/photo/arrow001.gif";
var arrowImage2 = new Image();arrowImage2.src = "images/photo/arrow002.gif";
var NextPageTips = function(kname,obj,obj2){
    
    var str = new String('\<div style="width:103px;height:27px; text-align:center;"><img id="cursorImg" style="cursor:url(images/photo/transMouse.cur),auto" src="images/photo/arrow001.gif" /></div>\
                                ');

    Util.Event.add(obj,"mousemove",function(){    
       var ObjectX = 0;
       ObjectX = Util.Event.getEvent().layerX;
       
            
        if($$('NextPageTips')==null) {
			var oDiv = document.createElement("div");
			oDiv.style.position = "absolute";
			oDiv.style.left = Util.Event.getEvent().pageX + "px";
			oDiv.style.top = Util.Event.getEvent().pageY  + "px";

			oDiv.id = "NextPageTips";
			oDiv.style.height="20px";
			oDiv.style.width="103px";
			document.body.appendChild(oDiv);			
			$$('NextPageTips').innerHTML = str;
		}
            
		$$('NextPageTips').style.left = Util.Event.getEvent().pageX - 45  + "px";
		$$('NextPageTips').style.top = Util.Event.getEvent().pageY + 5  + "px";
		if(document.all)
		{
		     Util.Event.stop(); 
		}

		var image = new Image();
		image.src = Util.Event.getEvent().target.src; 
		width = image.width;
                    
		 if(ObjectX<Math.floor(width/2)) {
			$$('cursorImg').src = "images/photo/arrow001.gif";
			   
			Util.Event.getEvent().target.onclick = function(){
				prePic(kname);
			}
		 }
		 else
		 {
			$$('cursorImg').src = "images/photo/arrow002.gif";
			
			Util.Event.getEvent().target.onclick = function(){
			    nextPic(kname);
			}
		 }
    },false);
                        
	Util.Event.add(obj,"mouseout",function(){
	   if($$('NextPageTips')!=null)
		  document.body.removeChild($$('NextPageTips'));
	},false);
	
};
function prePic(kname) {
	if (i==0){
	alert('已经是第一张了');
	}else{
	$$("num").innerHTML=i;
	ChangePicArrayInfo(kname,--i);
	}
}
function nextPic(kname) {
	if (i==imgs.length-1) {
	$$("num").innerHTML=imgs.length;
	alert('已经是最后一张了');	
	}
	else{
	ChangePicArrayInfo(kname,++i);
	$$("num").innerHTML=i+1;
	}
}

function ChangePicArrayInfo(kname,i){
	var Images=new Image();
	Images.src=imgs[i];
	img.src = Images.src;
	PicProOther(kname,arrPid[i]);
	ShowPicInfo(kname,arrPid[i]);
	picrun_ini(i,arrPid.length);
	}
	
function InitList(kname,Kid,Pid,selected){
	img = $$('img1');
	img.style.cursor = "url(/images/photo/transMouse.cur),auto";
	i=selected;
	img.src = imgs[i];
	new NextPageTips(kname,img,arrPid);
	picrun_ini(selected,arrPid.length);
	$$("num").innerHTML=++selected;
	$$("allnum").innerHTML=imgs.length;
}