function $(e){ 
    return "string" == typeof e ? document.getElementById(e) : e; 
    } 
var Event={ 
    add:function (obj,EventType,fn){ 
    if (obj.attachEvent){ 
        obj['e'+EventType+fn] = fn; 
        obj[EventType+fn] = function() {obj['e'+EventType+fn](window.event);} 
        obj.attachEvent('on'+EventType,obj[EventType+fn]); 
        }else if(obj.addEventListener){ 
            obj.addEventListener(EventType,fn,false);     
            }else    { 
                obj['on'+EventType]=fn; 
                } 
    }, 
    remove:function(obj,Event,fn){ 
    if (obj.detachEvent){ 
        obj.detachEvent('on'+EventType,obj[EventType+fn]); 
        }else if(obj.removeEventListener){ 
            obj.removeEventListener(EventType,fn,false); 
            }else    { 
                obj['on'+EventType]=null; 
                } 
    } 
} 
var Each=function(list,fn){ 
        for(var i=0,len=list.length;i<len;i++){ 
                fn(list[i],i) 
            } 
    } 
Function.prototype.bind=function(object){ 
    __method=this;args=Array.prototype.slice.call(arguments);args.shift(); 
    return function (){ 
            __method.apply(object,args.concat(Array.prototype.slice.call(arguments))); 
        } 
    } 
var Class={ 
    create:function (){ 
        return function (){ 
            this.initialize.apply(this,arguments); 
            } 
        } 
    } 
ChangeImages=Class.create(); 
ChangeImages.prototype={ 
    initialize:function (id,loader,kname,arr,pid,para){ 
        var oThis=this; 
        this.idImg=$(id); 
        //this.idLoader=$(loader); 
        this.arr=[]; 
		this.pid=[];
		var kname=kname;
        this.pic=this.setDefault(kname,arr,pid,para);
        Event.add(this.idImg,'load',function(){oThis.getPos()}); 
        Event.add(this.idImg,'mousemove',function (event){oThis.SetHand(event)}); 
        Event.add(this.idImg,'click',function (event){oThis.clickSet(kname,event);}); 
        Event.add(this.idImg,'click',function (event){oThis.SetHand(event)});
        }, 
    setDefault:function(kname,arr,pid,para){ 
//------显示第几张------- 
//var para,n; 
//n=self.location.href.indexOf("#");
//if(n>0) {para=self.location.href.substr(n+1); } else {para=0;}
//------显示第几张End------- 
        this.count=para;//计数器 
        Each(arr,function (o){this.arr.push([o,false])}.bind(this))//这样写的好处是可以限定this的作用域 
		Each(pid,function (o){this.pid.push([o,false])}.bind(this))
		//$("viewImage").style.display="none";
		//$("viewImage").innerHTML="<img src="+this.arr[para][0]+" onload='LoadViewImage(this,730,1000);'>";
		$("viewImage").innerHTML="<img src="+this.arr[para][0]+" style='filter:blur();' onload='Filter(this);' />";
		PicProOther(kname,this.pid[para][0]);
		ShowPicInfo(kname,this.pid[para][0]);
        $("num").innerHTML=parseInt(this.count)+1;
        $("allnum").innerHTML=this.arr.length; 
        }, 
    SetHand:function(event)
	{
        switch (parseInt(this.count)){            
            case 0:
				this.idImg.style.cursor="url(images/Photo/right.cur),auto"; 
            	break; 
            case this.arr.length-1:
				this.idImg.style.cursor="url(images/Photo/left.cur),auto";
            	break; 
			default:
				this.getNx(event); 
            	break; 
            } 
        }, 
    clickSet:function(kname,event)
	{
        if((this.nx<event.clientX || this.count==0) && this.count!=this.arr.length-1)
		{
		  this.count++;
		  PicProOther(kname,this.pid[this.count][0]);
		  ShowPicInfo(kname,this.pid[this.count][0]);
		  $("num").innerHTML=this.count+1;
		  //$("viewImage").style.display="none";
		  //$("viewImage").innerHTML="<img src="+this.arr[this.count][0]+" onload='LoadViewImage(this,730,1000);'>";
		  $("viewImage").innerHTML="<img src="+this.arr[this.count][0]+" style='filter:blur();' onload='Filter(this);' />";
		  picrun_ini(this.count,this.arr.length);
        }
		else if(this.nx>event.clientX || this.count==this.arr.length-1)
		{ 				
		  this.count--; 
		  PicProOther(kname,this.pid[this.count][0]);
		  ShowPicInfo(kname,this.pid[this.count][0]);
		  $("num").innerHTML=this.count+1;
		  //$("viewImage").style.display="none";
		  //$("viewImage").innerHTML="<img src="+this.arr[this.count][0]+" onload='LoadViewImage(this,730,1000);'>";
		  $("viewImage").innerHTML="<img src="+this.arr[this.count][0]+" style='filter:blur();' onload='Filter(this);' />";
		  picrun_ini(this.count,this.arr.length);	
		}
      }, 
    getNx:function(event)
	{ 
	  //this.nx=parseInt(this.idImg.offsetWidth)/2+this.idImg.offsetLeft;
	  this.nx=parseInt(this.idImg.offsetWidth)/2+(this.idImg.offsetLeft+$('PhotoView').offsetLeft);
	  if(event.clientX>this.nx)
	  { 
		  this.idImg.style.cursor="url(images/Photo/right.cur),auto"; 
	  }
	  else
	  { 
		  this.idImg.style.cursor="url(images/Photo/left.cur),auto"; 
	  } 
        }, 
    getPos:function (){ 
            //this.idLoader.style.display="none"; 
            var temp=this.idImg 
            var top=temp.offsetTop; 
            var left=temp.offsetLeft; 
            var height=temp.offsetHeight; 
            var width=temp.offsetWidth; 
            while(temp=temp.offsetParent){ 
                    top+=temp.offsetTop; 
                    left+=temp.offsetLeft; 
                } 
            temp=null; 
         
            this.pic={top:top,left:left,height:height,width:width}; 
        } 
    } 