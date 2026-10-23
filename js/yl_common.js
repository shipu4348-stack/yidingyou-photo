function tabPage(obj,el){
	var menu = document.getElementById(obj).getElementsByTagName(el);
	var con = document.getElementById(obj+"_con").getElementsByTagName("div");
	var conArr = [];
	var m = 0;
	for(var n=0;n<con.length;n++){		
		if(con[n].className == 'tab-content'){
			conArr[m]= con[n];
			m++;
		}
	}	
	for(var i=0;i<menu.length;i++){
		menu[i].onmouseover = function(){
			var num = this.getAttribute("rel");
			resetTab(num);
		}	
	}
	function resetTab(current){
		for(var i=0;i<menu.length;i++){
			menu[i].className = "";	
			conArr[i].style.display = "";			
		}
		menu[current].className = "selected";
		conArr[current].style.display = "block";
	}
	
}



function setWantSize(img,_w,_h){
    var image = new Image();
    image.onload = function(){
        var w = image.width,
            h = image.height,
            ow = 0,
            oh = 0;
        if(w>_w || w>_h){
            var rx = w/_w,
                ry = h/_h,
                rr = 0;
            if(rx>ry)
                rr = rx;
            else
                rr = ry;
            img.width = Math.round(w/rr);
            img.height = Math.round(h/rr);
        } 
    }
    image.src = img.src;
}


  
function Logout()
{
	if(confirm('确定要退出一定呦吗？'))
	{
		window.location.href="exit.asp";
	}
	else
	{
		return false;
	}
}
 
 
