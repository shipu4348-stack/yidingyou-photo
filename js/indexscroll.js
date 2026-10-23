function newsPlayer(props){
	this.newsId=props.id?props.id:null;
	this.lineHeight=props.lineHeight?props.lineHeight:0;
	this.interval=props.interval?props.interval:5000;
	this.currentId=0;
	this.pause=false;
	var self=this;
	if(this.newsId){
		var newsbox=document.getElementById(this.newsId).getElementsByTagName('UL')[0];
		var li_arr=newsbox.getElementsByTagName('LI');
		this.newsObj=newsbox;
		this.newsCount=li_arr.length;
		this.newsGroup=li_arr;
		var newsA_arr=newsbox.getElementsByTagName('A');
		for(var i=0;i<newsA_arr.length;i++){
			(function(i){
				newsA_arr[i].onmouseover=function(){self.pause=true};
				newsA_arr[i].onmouseout=function(){self.pause=false};
			})(i);
		}
		var handle=document.createElement('ol');
		handle.className='handle';
		for(var i=0;i<li_arr.length;i++){
			if(this.currentId==i){
				handle.innerHTML+='<li><a class="current" href="javascript:void(0)"></a></li>';
			}else{
				handle.innerHTML+='<li><a href="javascript:void(0)"></a></li>';
			}
		}
		newsbox.parentNode.appendChild(handle);
		var handleA_arr=handle.getElementsByTagName('A');
		this.handleGroup=handleA_arr;
		for(var i=0;i<handleA_arr.length;i++){
			(function(i){
				handleA_arr[i].onclick=function(){self.next(i);};
				handleA_arr[i].onfocus=function(){this.blur();};
				
			})(i);
		}
		this.play();
	}
	this.next=function(i){
		this.currentId=i;
		clearTimeout(this.handleInterval);
		clearTimeout(this.handleInterval2);
		this.play();
	}
}
newsPlayer.prototype.play=function(){
	var self=this;
	var currObj=null;
	function event(){
		if(!self.pause){
			var li_arr=self.newsGroup;
			for(var i=0;i<li_arr.length;i++){
				if(self.currentId==i){
					li_arr[i].style.display='block';
					li_arr[i].style.marginTop=self.lineHeight+'px';
					self.handleGroup[i].className='current';
					currObj=li_arr[i];
				}else{
					li_arr[i].style.display='none';
					li_arr[i].style.marginTop='0px';
					self.handleGroup[i].className='none';
				}
			}
			event2();
			self.currentId=(self.currentId==self.newsCount-1?0:++self.currentId);
		}
		self.handleInterval=setTimeout(event,self.interval);
	}
	function event2(){
		currObj.style.marginTop=parseFloat(currObj.style.marginTop)-1+'px';
		if(parseFloat(currObj.style.marginTop)>0){
			self.handleInterval2=setTimeout(event2,10);
		}
	}
	event();
}


var news=new newsPlayer({'id':'news','lineHeight':'26','interval':'5000'});