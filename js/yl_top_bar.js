/*
  	ÇëÎðÉ¾³ý´Ë²¿·Ö×¢ÊÍ.Ð»Ð»!
	date£º2010-4-15

 
	¼æÈÝÐÔ: all
*/
var top_bar = function() {
	this.container = document.getElementById("top_bar_c");
	var child = this.container.children;
	this.info = child[0];
	this.buts = child[1];
	this.list = null;
	this.timer = [];
	this.nn_shadow = null;
	this.nn_p = null;
	this.tip = null;
	this.tipCookie = false;
	this.state = false;
	this.init();
}
top_bar.prototype.init = function() {
	//if(this.getCookie("userid")) {
//		this.state = true;
//		var username = decodeURIComponent(this.getCookie("username"));
//		var userid = this.getCookie("userid");
//		var msgstate = this.getCookie("msgcount");
//		this.info.innerHTML = "ÄúºÃ£¬"+username+"£¡<a href=#  onClick=javascript:Logout();>ÍË³ö</a>";
//	} else {
//		this.info.innerHTML = "ÄúºÃ£¬»¶Ó­À´µ½Ò»¶¨Ó´!<a href=index.asp>ÇëµÇÂ½</a><a href=register.asp>Ãâ·Ñ×¢²á</a>";
//	}
	this.setNn_shadow();
	this.bindEvent();
}
top_bar.prototype.setNn_shadow = function() {
	var container = document.getElementById("toolsbar");
	var ul = container.getElementsByTagName("ul"); //top_nn
	var topnn = (function(){
		for(var i=0; i<ul.length; i++) {
			if(ul[i].className == "top_nn") return ul[i];
		}
	})();
	this.nn_p = topnn.getElementsByTagName("p")[0];
	this.nn_shadow = topnn.getElementsByTagName("s")[1];
}
top_bar.prototype.addCookie = function(n, v) {
	if(!s)var s=86400000000;
	var d=new Date();
	d.setTime(d.getTime()+s);
	document.cookie=n+"="+v+";expires="+d.toGMTString();
}
top_bar.prototype.getCookie = function(n){
	var c=document.cookie.match(new RegExp("(^| )"+n+"=([^;]*)(;|$)"));
	if(c==null){
		return false;
	}else{
		return c[2];
	}
}
top_bar.prototype.bindEvent = function() {
	var ul = this.list = this.buts.getElementsByTagName("ul");
	var si = null;
	var me = this;
	for(var i=0; i<ul.length; i++) {
		this.tipCookie = this.getCookie("top_se_tip");
		if (ul[i].className == "top_se") {
			this.tip = ul[i].getElementsByTagName("span")[0];
			if (!this.tipCookie) {
				window.setTimeout(function(){
					me.tip.style.display = "none";
				},1500)
			}
		}
		(function(i) {
			if(ul[i].className.toLowerCase().indexOf("line")<0 && ul[i].className != "" && ul[i].className != null) {
				if (ul[i].className.toLowerCase() == "top_sh") {
					si = ul[i].getElementsByTagName("input")[0];
					si.onfocus = function() { si.value = "" }
					si.onblur = function() { if(si.value == "")si.value = "ÊäÈë¹Ø¼ü×Ö..." }
				}
				ul[i].onmouseover = function() {
					window.clearTimeout(me.timer[i]);
					me.timer[i] = window.setTimeout(function(){ me.show(i) },200);
				}
				ul[i].onmouseout = function() { 
					window.clearTimeout(me.timer[i]);
					me.timer[i] = window.setTimeout(function(){ me.hide(i) },150);
					if(si) si.blur();
				}
			}
		})(i);
	}
}
top_bar.prototype.show = function(i) {
	if (this.list[i].className == "top_se") {
		this.addCookie("top_se_tip", true);
		this.tip.style.display = "none";
	}
	this.list[i].className = this.list[i].className.replace(/(?:\bselect\b)|(\s+)/ig, "") + " select";
	if (this.list[i].className.indexOf("top_nn") >= 0) {
		this.nn_shadow.style.height = (this.nn_p.offsetHeight-4) + "px";
	}
}
top_bar.prototype.hide = function(i) {
	this.list[i].className = this.list[i].className.replace(/(?:\bselect\b)|(\s+)/ig,"");
}
new top_bar();