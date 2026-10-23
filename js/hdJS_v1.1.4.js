/*json文件开始*/
JSON=new function(){this.decode=function(){var filter,result,self,tmp;if($$("toString")){switch(arguments.length){case 2:self=arguments[0];filter=arguments[1];break;case 1:if($[typeof arguments[0]](arguments[0])===Function){self=this;filter=arguments[0]}else self=arguments[0];break;default:self=this;break};if(rc.test(self)){try{result=e("(".concat(self,")"));if(filter&&result!==null&&(tmp=$[typeof result](result))&&(tmp===Array||tmp===Object)){for(self in result)result[self]=v(self,result)?filter(self,result[self]):result[self]}}catch(z){}}else{throw new JSONError("bad data");}};return result};this.encode=function(){var self=arguments.length?arguments[0]:this,result,tmp;if(self===null)result="null";else if(self!==undefined&&(tmp=$[typeof self](self))){switch(tmp){case Array:result=[];for(var i=0,j=0,k=self.length;j<k;j++){if(self[j]!==undefined&&(tmp=JSON.encode(self[j])))result[i++]=tmp};result="[".concat(result.join(","),"]");break;case Boolean:result=String(self);break;case Date:result='"'.concat(self.getFullYear(),'-',d(self.getMonth()+1),'-',d(self.getDate()),'T',d(self.getHours()),':',d(self.getMinutes()),':',d(self.getSeconds()),'"');break;case Function:break;case Number:result=isFinite(self)?String(self):"null";break;case String:result='"'.concat(self.replace(rs,s).replace(ru,u),'"');break;default:var i=0,key;result=[];for(key in self){if(self[key]!==undefined&&(tmp=JSON.encode(self[key])))result[i++]='"'.concat(key.replace(rs,s).replace(ru,u),'":',tmp)};result="{".concat(result.join(","),"}");break}};return result};this.toDate=function(){var self=arguments.length?arguments[0]:this,result;if(rd.test(self)){result=new Date;result.setHours(i(self,11,2));result.setMinutes(i(self,14,2));result.setSeconds(i(self,17,2));result.setMonth(i(self,5,2)-1);result.setDate(i(self,8,2));result.setFullYear(i(self,0,4))}else if(rt.test(self))result=new Date(self*1000);return result};var c={"\b":"b","\t":"t","\n":"n","\f":"f","\r":"r",'"':'"',"\\":"\\","/":"/"},d=function(n){return n<10?"0".concat(n):n},e=function(c,f,e){e=eval;delete eval;if(typeof eval==="undefined")eval=e;f=eval(""+c);eval=e;return f},i=function(e,p,l){return 1*e.substr(p,l)},p=["","000","00","0",""],rc=null,rd=/^[0-9]{4}\-[0-9]{2}\-[0-9]{2}T[0-9]{2}:[0-9]{2}:[0-9]{2}$/,rs=/(\x5c|\x2F|\x22|[\x0c-\x0d]|[\x08-\x0a])/g,rt=/^([0-9]+|[0-9]+[,\.][0-9]{1,3})$/,ru=/([\x00-\x07]|\x0b|[\x0e-\x1f])/g,s=function(i,d){return"\\".concat(c[d])},u=function(i,d){var n=d.charCodeAt(0).toString(16);return"\\u".concat(p[n.length],n)},v=function(k,v){return $[typeof result](result)!==Function&&(v.hasOwnProperty?v.hasOwnProperty(k):v.constructor.prototype[k]!==v[k])},$={"boolean":function(){return Boolean},"function":function(){return Function},"number":function(){return Number},"object":function(o){return o instanceof o.constructor?o.constructor:null},"string":function(){return String},"undefined":function(){return null}},$$=function(m){function $(c,t){t=c[m];delete c[m];try{e(c)}catch(z){c[m]=t;return 1}};return $(Array)&&$(Object)};try{rc=new RegExp('^("(\\\\.|[^"\\\\\\n\\r])*?"|[,:{}\\[\\]0-9.\\-+Eaeflnr-u \\n\\r\\t])+?$')}catch(z){rc=/^(true|false|null|\[.*\]|\{.*\}|".*"|\d+|\d+\.\d+)$/}};
/*json文件结束*/
var Browser = {};
Browser.ua = window.navigator.userAgent.toLowerCase();
Browser.ie = /msie/.test(Browser.ua);
Browser.moz = /gecko/.test(Browser.ua);
Browser.tt = /tencent/.test(Browser.ua);
Browser.sa = /safari/.test(Browser.ua);
Browser.op = /opera/.test(Browser.ua);
var loadingProcess = {
	articleTitle : '我的一定呦相册- 网络图片存储系统 www.1dy.cc',
    bJsReady: false,
    bFlashReady: false,
    arrCalledFullScreenPicIndex: new Array(),
    bAutoPlay: false,
	isLastPic:false,
	fHeight:0,
	gotoUrl:'http://www.1dy.cc',
	sitePicUrl:'http://www.1dy.cc',
	endTips: '',
    isFlashReady: function() {
		loadingProcess.bFlashReady = true;
        return loadingProcess.bJsReady;
    },
	disScreen: function() {
		window.document.carShow.disScreen();
	},
	orgPicScreen: function() {
		window.document.carShow.orgPicScreen();
	},
	playerPicHandler: function() {
		window.document.carShow.playerPicHandler();
	},
    callByFullScreen: function(indexId, isExit) {
			if (isExit) {//推出全屏状态
				pageHandler.currentIndex = indexId;
				statisticHandler.addCount(indexId);
				setTimeout("loadingProcess.loadPic(" + indexId + ")", 300);
				urlProcess.setUrlParam(pageHandler.currentIndex);
				loadingProcess.setDocumentTitle();
				pageHandler.nextPage();
				pageHandler.prePage();
				pageHandler.motionHandler();				
			} else{
				pageHandler.currentIndex = indexId;
				if(Browser.tt) {
					if (typeof pgvMain == "function") {
						pvRepeatCount = 1;
						pgvMain();
					}
				} else {
					statisticHandler.addCount(indexId);				
				}
			}
    },
	dragHandler : function () {
		window.document.carShow.dragIsHandler();
	},
    perPic: function() {
		if (pageHandler.currentIndex == 0) {
			return false;
		}
		pageHandler.prePic();
	},
    nextPic: function() {
		if (pageHandler.currentIndex == parseInt(pageHandler.totalPicNums, 10)) {
			loadingProcess.endPicHandler(pageHandler.totalPicNums);
		} else {
			pageHandler.nextPic();
			loadingProcess.isLastPic = false;
		}
    },
	endPicHandler : function (indexId) {
		var picBox = $('sildBox').getElementsByTagName('li');
		var boxLens = picBox.length;
		var indexNums = parseInt(indexId % 5, 10);
		for (var i = 0; i < boxLens; i++) {
			$('sildBox').getElementsByTagName('li')[i].className = '';
		}
		loadingProcess.isLastPic = true;
		window.document.carShow.loadLastPic(loadingProcess.isLastPic, loadingProcess.gotoUrl, loadingProcess.endTips);
		loadingProcess.isLastPic = false;
	},
    nextPicAuto: function() {
		if ((pageHandler.totalPicNums - 1) > pageHandler.currentIndex) {
			loadingProcess.bAutoPlay = true;
			loadingProcess.nextPic();
		} else {
			window.document.carShow.loadLastPic(loadingProcess.isLastPic, loadingProcess.gotoUrl, loadingProcess.endTips);
		}
    },
	backPlayPicHandler : function () {
		var indexId = parseInt(urlProcess.getUrlParam(), 10) - 1;
		urlProcess.setUrlParam(indexId);
		pageHandler.currentIndex = indexId;
		loadingProcess.loadPic(indexId);
		pageHandler.nextPage();
		pageHandler.prePage();
		pageHandler.motionHandler("none");
	},
	rePlayPicHandler: function(indexId) {
			urlProcess.setUrlParam(indexId);
			pageHandler.currentPageNums = indexId;
			pageHandler.currentIndex = indexId;
			loadingProcess.loadPic(indexId);
			pageHandler.motionHandler("none");
			pageHandler.nextPage();
			pageHandler.prePage();
	},
    nextPicInhand: function() {
		loadingProcess.bAutoPlay = false;
        loadingProcess.nextPic();
    },
	loadPicFullHandler : function (indexId) {
		if (typeof (window.document.setSoScreen) != 'undefined'){
			window.document.setSoScreen.loadPicInhand(pageHandler.picUrl[indexId], pageHandler.picUrl[indexId], indexId, parseInt(parseInt(pageHandler.totalPicNums, 10) -1));
		} else {
			setTimeout("loadingProcess.loadPicFullHandler(" + indexId + ")", 400);
		}
	},
    loadPic: function(indexId) {
		if (indexId < pageHandler.totalPicNums) {
			if (typeof (window.document.carShow.loadPicInhand) != 'undefined') {
				pageHandler.viewsPic = indexId - 1;
				window.document.carShow.loadPicInhand(pageHandler.picUrl[indexId], pageHandler.picUrl[indexId], indexId, parseInt(parseInt(pageHandler.totalPicNums, 10) -1));
				if (typeof (window.document.setSoScreen) != 'undefined'){
					window.document.setSoScreen.loadPicInhand(pageHandler.picUrl[indexId], pageHandler.picUrl[indexId], indexId, parseInt(parseInt(pageHandler.totalPicNums, 10) -1));
				} else {
					setTimeout("loadingProcess.loadPicFullHandler(" + indexId + ")", 400);
				}
				statisticHandler.addCount(indexId);
				//window.document.carShow.focus();
			} else {
				setTimeout("loadingProcess.loadPic(" + indexId + ")", 300);
			}
		} else {
			pageHandler.viewsPic = indexId;
			loadingProcess.endPicHandler(pageHandler.totalPicNums);
			var pageObj = $('nextPicPage');
			removeEventHandler(pageObj, "mousedown", pageHandler.nextPageHandler);
		}
		loadingProcess.setDocumentTitle();
    },
    loadFullScreen: function() {
		if (pageHandler.jsonDataStr == '' || pageHandler.jsonDataStr == null) {
			pageHandler.getJsonData();
			window.document.setSoScreen.loadFullScreen(pageHandler.jsonDataStr, pageHandler.currentIndex);
		} else {
			window.document.setSoScreen.loadFullScreen(pageHandler.jsonDataStr, pageHandler.currentIndex);
		}
    },
	picZoomIn : function() {
		if (typeof (window.document.carShow.picZoomIn) != 'undefined') {
			window.document.carShow.picZoomIn();
		}
	},
	picZoomOut : function() {
		if (typeof (window.document.carShow.picZoomOut) != 'undefined') {
			window.document.carShow.picZoomOut();
		}
	},
    setDocumentTitle: function() {
        document.title = loadingProcess.articleTitle;
		if (pageHandler.currentIndex < pageHandler.totalPicNums) {
			$('titleStr').innerHTML = pageHandler.picTitle[parseInt(pageHandler.currentIndex, 10)];
			$('postStr').innerHTML = pageHandler.posttime[parseInt(pageHandler.currentIndex, 10)];
			$('sizeStr').innerHTML = pageHandler.psize[parseInt(pageHandler.currentIndex, 10)];
			$('descriptStr').innerHTML = contentHandler.showDescript();
		}
		if (contentHandler.deCode) {
			removeEventHandler($('cspan'), "click", contentHandler.reString);
			addEventHandler($('cspan'), "click", contentHandler.reString);
		}
    }
}
var contentHandler = {
		maxLens : 99,
		currentLens : 0,
		deCode:false,
		showDescript : function() {
			contentHandler.currentLens = 0;
			contentHandler.currentLens = contentHandler.contentLens();
			var htmlContent = contentHandler.clearHTML();
			var listNums = parseInt(contentHandler.maxLens, 10) * 2;
			if (contentHandler.currentLens > listNums) {
				var showText = '';
				showText = htmlContent.substr(0, contentHandler.maxLens);
				contentHandler.deCode = true;
				return showText + '...<a href="javascript:void(0);" id="cspan" title="点击查看详细">[详细]</a>';
			} else {
				contentHandler.deCode = false;
				return htmlContent;
			}
		},
		reString : function () {
			$('descriptStr').innerHTML = contentHandler.clearHTML();
		},
		contentLens : function() {
			var htmlContent = contentHandler.clearHTML();
			var len = 0;
			for (var i = 0; i < htmlContent.length; i++) {
				if (htmlContent.charCodeAt(i) > 255) { 
					len += 2; 
				} else { 
					len ++;
				}
			}
			return len;
		},
		clearHTML : function() {
			var content = pageHandler.picDesc[parseInt(pageHandler.currentIndex, 10)];
			if (content != 'undefined' || content != '') {
				content = content.replace(/<[^>].*?>/g,"");
			} else {
				content = '';
			}
			return content;
		}
}
var pageHandler =  {
	picUrl : [],
	picSmallUrl : [],
	picTitle : [],
	picDesc : [],
	thumper :[],
	posttime : [],
	psize :[],
	currentIndex : 0,
	currentPageNums : 0,
	totalPicNums : 0,
	jsonDataStr: '',
	totalPage:0,
	isPreHandler:false,
	timer:0,
	showBox : 0,
	viewsPic : 0,
	rollTimer : 0,
	desRollTimer:0,
	imgBoxNums : 1,
	pageLeftNums: 8, 
	isClose:false,
	isLastPic:false,
	cHeight : parseInt(document.body.clientHeight, 10),
	dataProcess: function() {
		pageHandler.totalPicNums = photoJson.length;
		for (var i = 0; i < pageHandler.totalPicNums; i++) {
			pageHandler.picUrl[i] = photoJson[i].bigpic;
			pageHandler.picSmallUrl[i] = photoJson[i].smallpic;
			pageHandler.picTitle[i] = photoJson[i].showtit;
			pageHandler.picDesc[i] = photoJson[i].showtxt;
			pageHandler.thumper[i] = photoJson[i].thumper;
			pageHandler.posttime[i] = photoJson[i].posttime;
			pageHandler.psize[i] = photoJson[i].psize;
		}
		pageHandler.writeCloseBox();
		pageHandler.getJsonData();
		pageHandler.getTotalPage();
		pageHandler.createElements();
		pageHandler.currentPageNums = pageHandler.currentPage();
		pageHandler.nextPage();
		pageHandler.prePage();
		loadingProcess.setDocumentTitle();
		pageHandler.currentIndex = parseInt(urlProcess.getUrlParam(), 10);
		pageHandler.viewsPic = pageHandler.currentIndex;
		pageHandler.addPicInitEvent();
		$('keyBoradTips').style.display = "none";
 
	},
	addPicInitEvent : function () {
		//addEventHandler($('savefavorite'), "click", pageHandler.addFav);
		addEventHandler($('thumper'), "click", pageHandler.opWinPicHandler2);
		addEventHandler($('downLoad'), "click", pageHandler.opWinPicHandler);
		addEventHandler($('copypic'), "click", pageHandler.copyPicHandler);		
		addEventHandler($('closeD'), "click", pageHandler.eventClose);
		addEventHandler($('closeD'), "mouseover", pageHandler.overEventClose);
		addEventHandler($('closeD'), "mouseout", pageHandler.outEventClose);
		addEventHandler($('digtitle_r'), "mouseover", pageHandler.overDragHandler);
		addEventHandler($('digtitle_r'), "mouseout", pageHandler.outDragHandler);
		addEventHandler($('perPicPage'), "mouseover", pageHandler.overPerPicHandler);
		addEventHandler($('perPicPage'), "mouseout", pageHandler.outPerPicHandler);
		addEventHandler($('nextPicPage'), "mouseover", pageHandler.overNextPicHandler);
		addEventHandler($('nextPicPage'), "mouseout", pageHandler.outNextPicHandler);
	},
	overPerPicHandler : function (event) {
		$('perPicPage').style.background = 'url("showPic/arrow_upOver.png") no-repeat center center'; 
		$('keyBoradTips').style.display = "block";
	},
	outPerPicHandler : function (event) {
		$('perPicPage').style.background = 'url("showPic/arrowTop.png") no-repeat center center'; 
		$('keyBoradTips').style.display = "none";
	},
	overNextPicHandler : function (event) {
		$('nextPicPage').style.background = 'url("showPic/arrow_downOver.png") no-repeat center center'; 
		$('keyBoradTips').style.display = "block";
	},
	outNextPicHandler : function (event) {
		$('nextPicPage').style.background = 'url("showPic/arrowBottom.png") no-repeat center center'; 
		$('keyBoradTips').style.display = "none";
	},
	writeCloseBox : function () {
		var domOver = $('disDes');
		if (pageHandler.isClose) {
			$('textMiddle').style.display = 'block';
			domOver.src = 'showPic/gb.png';
		} else {
			domOver.src = 'showPic/ck.png';
			$('textMiddle').style.display = 'none';
		}
	}, 
	eventClose : function (event) {
		pageHandler.isClose = (pageHandler.isClose == false) ? true : false;
		pageHandler.writeCloseBox();
	},
	overEventClose : function (event) {
		var domOver = $('disDes');
		if (pageHandler.isClose == false) {
			domOver.src = 'showPic/ckHover.png';
		}
	},
	outEventClose : function (event) {
		var domOut = $('disDes');
		if (pageHandler.isClose == false) {
			domOut.src = 'showPic/ck.png';
		}
	},
	overDragHandler : function (event) {
		var domOver = $('digtitle_r');
		if (domOver.className == 'digtitle_r') {
			domOver.style.background = 'url("showPic/titlebg2_over.png") no-repeat center center'; 
		} else {
			domOver.style.background = 'url("showPic/titlebg_over.png") no-repeat center center'; 
		}
	},
	outDragHandler : function (event) {
		var domOut = $('digtitle_r');
		if (domOut.className == 'digtitle_r') {
			domOut.style.background = 'url("showPic/titlebg2.png") no-repeat center center';
		} else {
			domOut.style.background = 'url("showPic/titlebg.png") no-repeat center center'; 
		}
	},
	nextPic : function () {
		pageHandler.currentIndex += 1;
		if (pageHandler.currentIndex >= pageHandler.totalPicNums) {
			pageHandler.currentIndex = pageHandler.totalPicNums;
		}
		pageHandler.rollPicHandler();
	},
	prePic : function () {
		pageHandler.currentIndex -= 1;
		if (0 > pageHandler.currentIndex) {
			pageHandler.currentIndex = 0;
		}
		pageHandler.rollPicHandler();
	},
	rollPicHandler : function() {
		pageHandler.motionPicBoxShow('none');
		urlProcess.setUrlParam(pageHandler.currentIndex);
	},
	motionPicBoxShow : function (){
		var showPicId = pageHandler.currentIndex - 1;
		if (pageHandler.currentIndex >= 1) {	
			pageHandler.selectBox(1, showPicId, 'noneStatus');
		} else {
			pageHandler.selectBox(0, 0, 'noneStatus');
		}
	},
	motionPicBox : function (noneStatus) {
		pageHandler.currentIndex = parseInt(pageHandler.currentPage(), 10);
		var showPicId = pageHandler.currentIndex;
		if (pageHandler.currentIndex >= 1) {	
			pageHandler.selectBox(1, showPicId, 'noneStatus');
		} else {
			pageHandler.selectBox(0, 0, 'noneStatus');
		}
	},
	rollOverPicHandler : function () {
		var viewPicNums = pageHandler.viewsPic - pageHandler.currentIndex;
		if (viewPicNums > 1) {
			pageHandler.directionDPicHandler();
		} else {
			pageHandler.directionUPicHandler();
		}
	},
	writeImgBox : function (direction) {
		if (direction == 'down') {
			pageHandler.viewsPic -= 1;
			pageHandler.imgBoxNums += 1;
		} else {
			pageHandler.viewsPic += 1;
			pageHandler.imgBoxNums -= 1;
		}
		if (pageHandler.imgBoxNums > 5) {
			pageHandler.imgBoxNums = 1;
		} else if (pageHandler.imgBoxNums < 1) {
			pageHandler.imgBoxNums = 5;
		}
		var viewPicNums = Math.abs(pageHandler.viewsPic - pageHandler.currentIndex);
		var imgBoxObj = $('show' + pageHandler.imgBoxNums);
		imgBoxObj.src = pageHandler.picSmallUrl[pageHandler.viewsPic];
		if (viewPicNums <= 2) {	
			pageHandler.viewsPic = pageHandler.currentIndex;
			urlProcess.setUrlParam(pageHandler.currentIndex);
			pageHandler.motionHandler('none');
			pageHandler.prePage();
		}
	},
	directionDPicHandler : function () {
		pageHandler.writeImgBox('down');
	},
	directionUPicHandler : function () {
		pageHandler.writeImgBox('up');
	},
	nextPageHandler : function (event) {
		var pageObj = $('nextPicPage');
		addEventHandler(pageObj, "mouseup", pageHandler.clearTimer);
		pageHandler.showBox = setInterval("pageHandler.downPicNext()", 100);
	},
	prePageHandler : function (event) {
		var pageObj = $('perPicPage');
		pageHandler.downPicPre();
		pageHandler.showBox = setInterval("pageHandler.downPicPre()", 100);
		addEventHandler(pageObj, "mouseup", pageHandler.clearTimer);
	},
	downPicNext : function () {
		pageHandler.viewsPic += 5;
		if (pageHandler.viewsPic >= pageHandler.totalPicNums) {
			pageHandler.viewsPic = pageHandler.totalPicNums;
			clearInterval(pageHandler.showBox);
			pageHandler.showBox = 0;
		} else {
			pageHandler.showProcessImg("down");
		}
	},
	downPicPre : function () {
		pageHandler.viewsPic -= 5;
		if (0 > pageHandler.viewsPic) {
			pageHandler.viewsPic = 0;
			clearInterval(pageHandler.showBox);
			pageHandler.showBox = 0;
		} else {
			pageHandler.showProcessImg("up");
		}
	},
	clearTimer : function (event) {
		var perObj  = $('perPicPage');
		var nextObj = $('nextPicPage');
		clearInterval(pageHandler.showBox);
		pageHandler.showBox = 0;
		removeEventHandler(perObj, "mouseup", pageHandler.clearTimer);
		removeEventHandler(nextObj, "mouseup", pageHandler.clearTimer);
	},
	showProcessImg : function (picStatus) {
		var showPicIndex = pageHandler.viewsPic;
		var perObj  = $('perPicPage');
		var nextObj = $('nextPicPage');
		for (var J = 0; J <= 4; J++) {
			if ($('endingPic')) {
				var parentObj = $('endingPic').parentNode;
				parentObj.removeChild($('endingPic'));
			}
		}
		if (picStatus == "down") {
			for (var i = 1; i <= 5; i++) {
				pageHandler.addPicNums(showPicIndex, i);
				var picBox = pageHandler.getPicNums(i);
				var imgObj = $('sildBox').getElementsByTagName('li')[i];
				var imgBoxObj = $('show'+i);
				if ((picBox - 1) == pageHandler.currentIndex) {
					imgObj.className = 'select';
				} else {
					imgObj.className = '';
				}
				if (picBox > pageHandler.totalPicNums) {
					if (picBox == (pageHandler.totalPicNums + 1)) {
						pageHandler.viewsPic = pageHandler.totalPicNums;
						imgBoxObj.src = 'showPic/endingPic.png';
						pageHandler.hiddenElements(showPicIndex, i);
						pageHandler.endingFace(imgObj);
						clearInterval(pageHandler.showBox);
						pageHandler.showBox = 0;
					} else {
						imgObj.style.display = "none";
						clearInterval(pageHandler.showBox);
						pageHandler.showBox = 0;
					}
				} else {
					imgBoxObj.src = pageHandler.picSmallUrl[showPicIndex];
					pageHandler.isLastPic = false;
				}
				showPicIndex++;
			}
		} else {
			showPicIndex = pageHandler.viewsPic; 
			for (var i = 1; i <= 5; i++) {
				var imgObj = $('sildBox').getElementsByTagName('li')[i];
				var imgBoxObj = $('show'+i);
				imgObj.className = '';
				imgObj.style.display = "block";
				if (showPicIndex > -1) {
					if (showPicIndex == pageHandler.totalPicNums) {
						imgBoxObj.src = 'showPic/endingPic.png';
						pageHandler.endingFace(imgObj);
					} else if (showPicIndex > pageHandler.totalPicNums) {
						imgObj.style.display = "none";
					}else {
						imgBoxObj.src = pageHandler.picSmallUrl[showPicIndex];
					}
				} else {
					clearInterval(pageHandler.showBox);
					pageHandler.showBox = 0;
					return null;
				}
				if (showPicIndex == pageHandler.currentIndex) {
					imgObj.className = 'select';
				}
				if (showPicIndex  >= pageHandler.totalPicNums) {
					showPicIndex = pageHandler.totalPicNums;
					pageHandler.hiddenElements(showPicIndex, i);
				} else {
					pageHandler.addPicNums(showPicIndex, i);
				}
				showPicIndex++;
			}
		}
		pageHandler.nextPage();
		pageHandler.prePage();
	},
	endingFace : function (htmlObj) { 
		var linkStr = pageHandler.resetPicInner();
		if (lastUrl == null || lastUrl == '') { 
			htmlObj.innerHTML += '<div class="showEndingTips" id="endingPic"><a href="' + linkStr + '" id="resetPic" target="_top">重新浏览</a><br /><a href="' + loadingProcess.gotoUrl  + '" target="_blank">进入图片站</a></div>';
		} else {
			htmlObj.innerHTML += '<div class="showEndingTips" id="endingPic"><a href="' + linkStr + '" id="resetPic" target="_top">重新浏览</a><br /><a href="' + loadingProcess.gotoUrl  + '" target="_top">播放下一图集</a></div>';
		}
	},
	clearFace : function (htmlObj) {
		htmlObj.innerHTML = "";
	},
	motionHandler : function (noneStatus) {
		pageHandler.currentIndex = parseInt(pageHandler.currentPage(), 10);
		var showPicId = pageHandler.currentIndex - 1;
		if (pageHandler.currentIndex >= 1) {	
			pageHandler.selectBox(1, showPicId, 'noneStatus');
		} else {
			pageHandler.selectBox(0, 0, 'noneStatus');
		}
	},
	selectBox : function (inDivId, picId, picStatus) {
		var showPicIndex = 0;
		var picIndexId = 0;
		showPicIndex = picId;
		inDivId += 1;
		if ($('endingPic')) {
			var parentObj = $('endingPic').parentNode;
			parentObj.removeChild($('endingPic'));
		}
		for (var i = 1; i <= 5; i++) {
			var imgObj = $('sildBox').getElementsByTagName('li')[i];
			var imgBoxObj = $('show'+i);
			imgObj.className = '';
			imgObj.style.display = "block";
			removeEventHandler(imgBoxObj, "click", pageHandler.clickHandler);
			if(showPicIndex <= pageHandler.totalPicNums) {
				if(showPicIndex == pageHandler.totalPicNums) {
					imgBoxObj.src = 'showPic/endingPic.png';
					pageHandler.endingFace(imgObj);
					pageHandler.hiddenElements(showPicIndex, i);
				} else {
					imgBoxObj.src = pageHandler.picSmallUrl[showPicIndex];
					pageHandler.addPicNums(showPicIndex, i);
					addEventHandler(imgBoxObj, "click", pageHandler.clickHandler);
				}
			} else {
				imgObj.style.display = "none";
			}
			showPicIndex++;
		}
		picIndexId = showPicIndex + 1;
		var imgObjNext = $('showb');
		var imgObjPre = $('showa');
		if (inDivId == 1) {
			imgObjNext.src = pageHandler.picSmallUrl[picIndexId];
		} else if (inDivId == 2 && picIndexId <= pageHandler.totalPicNums) {
			imgObjPre.src = pageHandler.picSmallUrl[(picIndexId - 6)];
			imgObjNext.src = pageHandler.picSmallUrl[picIndexId];
		}
		setTimeout("loadingProcess.loadPic(" + pageHandler.currentIndex + ")", 300);
		$('sildBox').getElementsByTagName('li')[inDivId].className = 'select';
		loadingProcess.setDocumentTitle();
	},
	lastImgObj : function (event) {
		if (pageHandler.currentIndex > 0) {
			pageHandler.selectBox(1, showPicId, 'none');
		} else {
			pageHandler.selectBox(0, 0, 'none');
		}
	},
	clickHandler : function (event) {
		var divObj = event.srcElement ? event.srcElement : event.target;
		var divName = divObj.id;
		var tmp = divName.split('ow');
		var em = $('spanOrder' + parseInt(tmp[1], 10));
		var nums = em.innerHTML;
		var tmpNums = nums.split('<em');
		var listNums = parseInt(tmpNums[0], 10);
		var showPicId = listNums - 1;
		pageHandler.currentIndex =  showPicId;
		pageHandler.viewsPic = (pageHandler.currentIndex) - 1;
		pageHandler.nextPage();
		pageHandler.prePage();
		if (pageHandler.currentIndex > 0) {
			pageHandler.selectBox(1, showPicId - 1, 'none');
		} else {
			pageHandler.selectBox(0, 0, 'none');
		}
		urlProcess.setUrlParam(pageHandler.currentIndex);
	},
	resetPicInner : function () {
		var curl =  window.location.href.toString();
		var tmpUrl = curl.split('#');
		return tmpUrl[0];
	},
	addPicNums : function (showPicId, i) {
		var em = $('spanOrder' + i);
		em.style.display = "block";
		em.innerHTML = parseInt(showPicId + 1, 10) +"<em>&nbsp;/ "+pageHandler.totalPicNums+"</em>";
	},
	getPicNums : function (i) {
		var em = $('spanOrder' + i);
		var getHtml = em.innerHTML;
		var tmpNums = getHtml.split('<em>');
		var getNums = parseInt(tmpNums[0], 10);
		return getNums;
	},
	nextPage : function () {
		var pageNums = pageHandler.viewsPic;
		var pageObj = $('nextPicPage');
		removeEventHandler(pageObj, "mousedown", pageHandler.nextPageHandler);
		if (pageHandler.totalPage > pageNums) {
			addEventHandler(pageObj, "mousedown", pageHandler.nextPageHandler);
		}
	},
	prePage : function () {
		var pageNums = pageHandler.viewsPic;
		var pageObj  = $('perPicPage');
		removeEventHandler(pageObj, "mousedown", pageHandler.prePageHandler);
		if (0 < pageNums) {
			addEventHandler(pageObj, "mousedown", pageHandler.prePageHandler);
		}
	},
	getTotalPage : function () {
		pageHandler.totalPage = pageHandler.totalPicNums;
	},
	currentPage : function () {
		var urlPath = window.location.href;
  		d = new Date()
		var year=d.getYear();
		var month=d.getMonth();
		var day=d.getDate();
		
		if (month <10)
		{month="0"+month;	}
 
		if (day <10) 
		{day="0"+day;	}
	 	var timeNow=year+""+month+""+day;
 
		pageHandler.currentPageNums = parseInt(urlProcess.getUrlParam(), 10);
		if(timeNow<20100613){
		return pageHandler.currentPageNums;
		}else{
		return pageHandler.currentPageNums-1;
		}
	},
	getJsonData:function() {
		if (pageHandler.jsonDataStr == '' || pageHandler.jsonDataStr == null) {
			pageHandler.jsonDataStr = JSON.encode(photoJson);
		} else {
			pageHandler.jsonDataStr = pageHandler.jsonDataStr;
		}
	},
	createElements : function () {
		for (var i=1; i <=5; i++) {
			var liObj = $('sildBox').getElementsByTagName('li')[i];
			var em = document.createElement("span");
			em.id = 'spanOrder' + i;
			liObj.appendChild(em);
		}
	},
	addElements : function (indexId, i) {
		var em = $('spanOrder' + i);
		em.style.display = "block";
		em.innerHTML = indexId + "<em>&nbsp;/ "+pageHandler.totalPicNums+"</em>";
	},
	hiddenElements : function (indexId, i) {
		var em = $('spanOrder' + i);
		em.style.display = "none";
	},
	setFullScreen : function () {
		var sofull = new SWFObject("showPic/picViews236.swf?versasd", "setSoScreen", "30", "14", "9.0.28", "#000000"); 
			 sofull.addParam("allowNetworking", "all"); 
			 sofull.addParam("allowScriptAccess", "always"); 
			 sofull.addParam("allowFullScreen", "true"); 
			 sofull.addParam("scale", "noscale");
			 if (Browser.sa || Browser.op) {
				sofull.addParam("wmode", "transparent"); 
			} else {
				sofull.addParam("wmode", "window"); 
			}
			 sofull.addVariable("fristTips", "第一张");
			 sofull.addVariable("lastTips", "最后一张");
			 sofull.addVariable("gotoUrl", loadingProcess.sitePicUrl);
			 sofull.addVariable("picUrl", lastUrl);
			 sofull.write("setfull");
	},
	initPageB : function () {
		var sofocus = new SWFObject("showPic/picViews137.swf?versasd", "carShow", "100%", loadingProcess.fHeight, "9.0.28", "#000000"); 
			 sofocus.addParam("allowNetworking", "all"); 
			 sofocus.addParam("allowScriptAccess", "always"); 
			 sofocus.addParam("allowFullScreen", "false"); 
			 sofocus.addParam("scale", "noscale");
			 if (Browser.sa || Browser.op) {
				sofocus.addParam("wmode", "transparent"); 
			} else {
				sofocus.addParam("wmode", "window"); 
			}
			 sofocus.addVariable("fristTips", "第一张");
			 sofocus.addVariable("lastTips", "最后一张");
			 sofocus.addVariable("gotoUrl", loadingProcess.sitePicUrl);
			 sofocus.addVariable("picUrl", lastUrl);
			 sofocus.write("flash");
		var playerVerObj = sofocus.installedVer;
		var swfPlayerVer = playerVerObj['major'] +'.' + playerVerObj['minor'] + '.' + playerVerObj['rev'];
		var isInstallPlayer = pageHandler.isInstallSwfPlayer(playerVerObj['major'], playerVerObj['rev']);
		var swfContainor = $('flash').innerHTML;
		if (isInstallPlayer == false) {
			if(document.all) {
				$('flash').innerHTML = '请您更新您的flashPlayer解析器。<a href="http://download.macromedia.com/pub/labs/flashplayer10/flashplayer10_1_p3_activex_022310.exe">flashplayer下载(Internet Explorer) (1.87 MB)</a>';
			} else {
				$('flash').innerHTML = '请您更新您的flashPlayer解析器。<a href="http://download.macromedia.com/pub/labs/flashplayer10/flashplayer10_1_p3_plugin_022310.exe">flashplayer下载(Firefox, Safari, Opera) (1.84 MB)</a>';
			}
		} else if (swfContainor == '' ) {
			$('flash').innerHTML = '系统正忙，请您点<a href="javascript:void(0);" onclick="window.location.href" target="_top">这里刷新页面</a>。';
		} else {
			pageHandler.motionHandler("none");
			//pageHandler.setPicHandler();
		}
	},
	initPageW : function () {
		var sofocus = new SWFObject("showPic/picViews_wv_2.008.swf?vers11", "carShow", "100%", "645", "9.0.28", "#F0F0F0"); 
			 sofocus.addParam("allowNetworking", "all"); 
			 sofocus.addParam("allowScriptAccess", "always"); 
			 sofocus.addParam("allowFullScreen", "true"); 
			 sofocus.addParam("scale", "noscale");
			 if (Browser.sa || Browser.op) {
				sofocus.addParam("wmode", "transparent"); 
			} else {
				sofocus.addParam("wmode", "window"); 
			}
			 sofocus.addVariable("fristTips", "第一张");
			 sofocus.addVariable("lastTips", "最后一张");
			 sofocus.addVariable("gotoUrl", loadingProcess.gotoUrl);
			 sofocus.addVariable("picUrl", lastUrl);
			 sofocus.write("flash");
		var playerVerObj = sofocus.installedVer;
		var swfPlayerVer = playerVerObj['major'] +'.' + playerVerObj['minor'] + '.' + playerVerObj['rev'];
		var isInstallPlayer = pageHandler.isInstallSwfPlayer(playerVerObj['major'], playerVerObj['rev']);
		var swfContainor = $('flash').innerHTML;
		if (isInstallPlayer == false) {
			if(document.all) {
				$('flash').innerHTML = '请您更新您的flashPlayer解析器。<a href="http://download.macromedia.com/pub/labs/flashplayer10/flashplayer10_1_p3_activex_022310.exe">flashplayer下载(Internet Explorer) (1.87 MB)</a>';
			} else {
				$('flash').innerHTML = '请您更新您的flashPlayer解析器。<a href="http://download.macromedia.com/pub/labs/flashplayer10/flashplayer10_1_p3_plugin_022310.exe">flashplayer下载(Firefox, Safari, Opera) (1.84 MB)</a>';
			}
		} else if (swfContainor == '' ) {
			$('flash').innerHTML = '系统正忙，请您点<a href="javascript:void(0);" onclick="window.location.href" target="_top">这里刷新页面</a>。';
		} else {
			pageHandler.motionHandler("none");
		}
	},
	isInstallSwfPlayer:function(mainVer, miniVer) {
		if (mainVer < '9') {
			return false;
		} else if (mainVer == '9') {
			if (miniVer < '28') {
				return false;
			} else {
				return true;	
			}
		} else {
			return true;
		}
	},	
	addFav: function(event){
		var pageTitle = $('titleStr').innerHTML.toString();
		if (pageTitle == "" || pageTitle == null) {
			 pageTitle = loadingProcess.articleTitle;
		}
		var pageLink = window.location.href.toString();
		if (document.all) {
			try {
				window.external.addFavorite(pageLink, pageTitle);
			} catch(e) {
				return false;
			}
	    } else if (window.sidebar) {
		  window.sidebar.addPanel(pageTitle, pageLink, "");
	    } else {
			return false;
		} 
	},
	/*加入评论数*/
	commentLoadJs : function (file, callback) {
			var head = document.getElementsByTagName('head')[0];
			var js = document.createElement('script');
			js.setAttribute('type','text/javascript');
			js.setAttribute('src',file);
			head.appendChild(js);
			js.onload = js.onreadystatechange = function() {
				if (js.readyState && js.readyState != 'loaded' && js.readyState != 'complete')
				js.onreadystatechange = js.onload = null;
				if (callback) callback();
			}
			return false;
	},
	getCmtNub : function () {
		var cmt = $("comment1");
		if(cmt){
				var site = cmt.href.split("&")[0].split("=")[1];
				var id = cmt.href.split("&")[1].split("=")[1];
				//pageHandler.commentLoadJs("http://sum.comment.gtimg.com.cn/php_qqcom/gsum.php?site=" + site + "&c_id=" + id, function() {
					//return false;
				//});
		}
	},
	downPicHandler : function (event) {
		window.document.carShow.picDownHandler();
		document.title = loadingProcess.articleTitle;
	},
	opWinPicHandler : function() {
		var picUrlStr = pageHandler.picUrl[parseInt(pageHandler.currentIndex, 10)];
		window.open(picUrlStr, '_blank');
		document.title = loadingProcess.articleTitle;
	},
	opWinPicHandler2 : function() {
		var picUrlStr = pageHandler.thumper[parseInt(pageHandler.currentIndex, 10)];
		window.open(picUrlStr, '_blank');
		document.title = loadingProcess.articleTitle;
	},
	copyPicHandler : function() {
		var picUrlStr = pageHandler.thumper[parseInt(pageHandler.currentIndex, 10)];
			window.clipboardData.setData("Text",picUrlStr);
			alert("网络地址已拷贝到剪贴板，可以使用粘贴或Ctrl+V调用。\n\n"+picUrlStr);
	}
}
var urlProcess = {
	getUrlParam: function() {
		var urlPath = window.location.href;
		var tmpArr = urlPath.split('#p=');
		//2010-7-2 逸乐 修改
		d = new Date()
		var year=d.getYear();
		var month=d.getMonth();
		var day=d.getDate();
		
		if (month <10)
		{month="0"+month;	}
 
		if (day <10) 
		{day="0"+day;	}
	 	var timeNow=year+""+month+""+day;
		
		if (tmpArr.length > 1) {
			if(parseInt(tmpArr[1])==0 && timeNow>=20100613){
				window.location.href = tmpArr[0] + '#p=1'; 
				return 1;
			}else{
				return tmpArr[1];
			}
		} else {
			if(timeNow<20100613){
			window.location.href = urlPath + '#p=0'; 
			return 0;
			}else{
			window.location.href = urlPath + '#p=1'; 
			return 0;
			}
		}
	},
	setUrlParam: function(indexId) {
		var urlPath = window.location.href;
		var tmpArr = urlPath.split('#');
		
		//2010-7-2 逸乐 修改
		d = new Date()
		var year=d.getYear();
		var month=d.getMonth();
		var day=d.getDate();
		
		if (month <10)
		{month="0"+month;	}
 
		if (day <10) 
		{day="0"+day;	}
	 	var timeNow=year+""+month+""+day;
		
		if(timeNow<20100613){
		  pid = indexId;
		}else{
	     pid = indexId+1;
		}
		window.location.href = tmpArr[0] + '#p=' + pid;
		document.title = loadingProcess.articleTitle;
	}
}
//统计代码	 
var statisticHandler = {
	hostsname : 'www',
	initSystem : function() {
		var hostName = statisticHandler.hostsname;
		var F = document.createElement('iframe');
		F.id = 'iframeP';
		F.name = 'iframeP';
		F.src = '';
		F.style.display = "none";
		F.width = '0px';
		F.height = '0px';
		$("PGViframe").appendChild(F);
	}, 
	addCount : function (indexId) {
		var hostName = statisticHandler.hostsname;
		var add_url = "http://" + hostName + ".qq.com/article_qq/hd2009flash/niersen_hd.htm?" + indexId;
		if (typeof pgvMain == "function") {
			pvRepeatCount = 1;
			pgvMain();
		}
		if (isIE) {
			document.all.iframeP.contentWindow.location = add_url
		} else {
			$("iframeP").src = add_url
		}
	}
}
function _cbSum() {
	$("comment1").innerHTML = '评论(' + arguments[0] + ')';
}
/*复制链接*/
function copyLink(){try{var cText=document.location.href.toString();if(window.clipboardData){window.clipboardData.setData("Text",cText);alert("复制完成!");}else if(window.netscape){try{netscape.security.PrivilegeManager.enablePrivilege("UniversalXPConnect");}catch(e){alert("您的浏览器设置为不允许复制！\n如果需要此操作，请在浏览器地址栏输入'about:config'并回车\n然后将'signed.applets.codebase_principal_support'设置为'true',再重试复制操作!");return false;}
var clip=Components.classes['@mozilla.org/widget/clipboard;1'].createInstance(Components.interfaces.nsIClipboard);if(!clip)return;var trans=Components.classes['@mozilla.org/widget/transferable;1'].createInstance(Components.interfaces.nsITransferable);if(!trans){return;}
trans.addDataFlavor('text/unicode');var str=new Object();var len=new Object();var str=Components.classes["@mozilla.org/supports-string;1"].createInstance(Components.interfaces.nsISupportsString);str.data=cText;trans.setTransferData("text/unicode",str,cText.length*2);var clipid=Components.interfaces.nsIClipboard;if(!clip)return false;clip.setData(trans,null,clipid.kGlobalClipboard);alert("复制完成!");}}catch(e){}};
/*基本的一些变量*/
var isIE = (document.all) ? true : false;
var $ = function (id) {
	return "string" == typeof id ? document.getElementById(id) : id;
};
var Class = {
	create: function() {
		return function() { this.initialize.apply(this, arguments); }
	}
}
var Extend = function(destination, source) {
	for (var property in source) {
		destination[property] = source[property];
	}
}
var Bind = function(object, fun) {
	return function() {
		return fun.apply(object, arguments);
	}
}
var BindAsEventListener = function(object, fun) {
	return function(event) {
		return fun.call(object, (event || window.event));
	}
}
function addEventHandler(oTarget, sEventType, fnHandler) {
	if (oTarget.addEventListener) {
		oTarget.addEventListener(sEventType, fnHandler, false);
	} else if (oTarget.attachEvent) {
		oTarget.attachEvent("on" + sEventType, fnHandler);
	} else {
		oTarget["on" + sEventType] = fnHandler;
	}
};
function removeEventHandler(oTarget, sEventType, fnHandler) {
    if (oTarget.removeEventListener) {
        oTarget.removeEventListener(sEventType, fnHandler, false);
    } else if (oTarget.detachEvent) {
        oTarget.detachEvent("on" + sEventType, fnHandler);
    } else { 
        oTarget["on" + sEventType] = null;
    }
};
var Cookie={
	set:function(name,value,expires,path,domain){
		if(typeof expires=="undefined"){
			expires=new Date(new Date().getTime()+24*3600*1000);
		}
		document.cookie=name+"="+escape(value)+((expires)?"; expires="+expires.toGMTString():"")+((path)?"; path="+path:"; path=/")+((domain)?";domain="+domain:"");
	},
	get:function(name){
		var arr=document.cookie.match(new RegExp("(^| )"+name+"=([^;]*)(;|$)"));
		if(arr!=null){
			return unescape(arr[2]);
		}
		return null;
	},
	clear:function(name,path,domain){
		if(this.get(name)){
			document.cookie=name+"="+((path)?"; path="+path:"; path=/")+((domain)?"; domain="+domain:"")+";expires=Fri, 02-Jan-1970 00:00:00 GMT";
		}
	}
};
var Timer =[];//定时器管理器
/*基本变量结束*/
/*拖放程序*/
var TencentDrag = Class.create();//new object
TencentDrag.prototype = {
  warpWidth:function(size){
	return size=="kuan"?parseInt(document.body.clientWidth):960;
  },
  aujTop:57+"px",
	//拖放对象,触发对象
  initialize: function(drag, intObj, MiddleObj) {
	//增加两个对象
	this.TxtBar = $("hiddMiddle");
	this.TxtCot = $("textMiddle");
	this.Drag = $(drag);
	this._Drag = $(drag).parentNode.parentNode;
	this.intObj = $(intObj);
	this.MiddleObj = $(MiddleObj);
	this._x = this._y = 0;
	this._fM = BindAsEventListener(this, this.Move);
	this._fS = Bind(this, this.Stop);
	this._Drag.style.position = "absolute";
	this._Drag.style.left = 0 + "px";
	this._Drag.style.top = this.aujTop;
	this.intObj.style.display = "none";
	this.setLayerCookie(Cookie.get("left_qq_article"));
	addEventHandler(this.Drag, "mousedown", BindAsEventListener(this, this.Start));
  },
  //准备拖动
  Start: function(oEvent) {
	this._x = oEvent.clientX - this._Drag.offsetLeft;
	this._y = oEvent.clientY - this._Drag.offsetTop;
	addEventHandler(document, "mousemove", this._fM);
	addEventHandler(document, "mouseup", this._fS);
  },
  //拖动
  Move: function(oEvent) {
	//window.getSelection ? window.getSelection().removeAllRanges() : document.selection.empty(); 
	this._Drag.style.left = oEvent.clientX - this._x + "px";
	this._Drag.style.top = oEvent.clientY - this._y + "px";
	this.setLayer();
  },
  //停止拖动
  Stop: function() {
	this.creatNew();
	removeEventHandler(document, "mousemove", this._fM);
	removeEventHandler(document, "mouseup", this._fS);
  },
  //
  stopDrg:function(oEvent){
	alert(oEvent)
  },
  setLayer:function(){
	var windowsW = this.warpWidth('kuan');
	if(parseInt(this._Drag.style.left)>Math.ceil(windowsW * 0.5)){
			this.intObj.style.display = "none";
			this.MiddleObj.style.marginRight = 126 + "px";
			this.Drag.className = "digtitle_r";
			this.TxtBar.style.styleFloat = "left";
			this.TxtCot.style.styleFloat = "left";
			this.TxtBar.style.cssFloat = "left";
			this.TxtCot.style.cssFloat = "left";
	}else{
			this.intObj.style.display = "block";
			this.MiddleObj.style.marginLeft = 0 + "px";
			this.MiddleObj.style.marginRight = 0 + "px";
			this.Drag.className = "digtitle";
			this.TxtBar.style.styleFloat = "right";
			this.TxtCot.style.styleFloat = "right";
			this.TxtBar.style.cssFloat = "right";
			this.TxtCot.style.cssFloat = "right";
	}
  },
  creatNew:function(){
	var windowsW = this.warpWidth('kuan');
	if(parseInt(this._Drag.style.left)>Math.ceil(windowsW * 0.5)){
		this._Drag.style.left = windowsW - this._Drag.offsetWidth + "px";
		this._Drag.style.top = this.aujTop;
		this.MiddleObj.style.marginLeft = 0+"px";
	    this.MiddleObj.style.marginRight = this._Drag.offsetWidth+"px";
		this.Drag.className = "digtitle_r";
		$("sildBox").className = "sildBox";
		this.TxtBar.style.styleFloat = "left";
		this.TxtCot.style.styleFloat = "left";
		this.TxtBar.style.cssFloat = "left";
		this.TxtCot.style.cssFloat = "left";
		Cookie.set("left_qq_article","right");
	}else{
		this._Drag.style.left = 0 + "px";
		this._Drag.style.top = this.aujTop;
		this.MiddleObj.style.marginRight = 0+"px";
		this.MiddleObj.style.marginLeft = this._Drag.offsetWidth+"px";
		this.Drag.className = "digtitle";
		$("sildBox").className = "sildBox_l";
		this.TxtBar.style.styleFloat = "right";
		this.TxtCot.style.styleFloat = "right";
		this.TxtBar.style.cssFloat = "right";
		this.TxtCot.style.cssFloat = "right";
		Cookie.set("left_qq_article","left");
	}
  },
  setLayerCookie:function(value){
	var windowsW = this.warpWidth('kuan');
	if(value=="left") {
		this._Drag.style.left = 0 + "px";
		this._Drag.style.top = this.aujTop;
		this.MiddleObj.style.marginLeft = this._Drag.offsetWidth+"px";
		this.MiddleObj.style.marginRight = 0+"px";
		this.Drag.className = "digtitle";
		$("sildBox").className = "sildBox_l";
		this.TxtBar.style.styleFloat = "right";
		this.TxtCot.style.styleFloat = "right";
		this.TxtBar.style.cssFloat = "right";
		this.TxtCot.style.cssFloat = "right";
	} else if(value=="right") {
		this._Drag.style.left = windowsW-this._Drag.offsetWidth + "px";
		this._Drag.style.top = this.aujTop;
		this.MiddleObj.style.marginLeft = 0+"px";
		this.MiddleObj.style.marginRight = this._Drag.offsetWidth+"px";
		this.Drag.className = "digtitle_r";
		$("sildBox").className = "sildBox";
		this.TxtBar.style.styleFloat = "left";
		this.TxtCot.style.styleFloat = "left";
		this.TxtBar.style.cssFloat = "left";
		this.TxtCot.style.cssFloat = "left";
	} else {
		this._Drag.style.left = windowsW-this._Drag.offsetWidth + "px";
		this._Drag.style.top = this.aujTop;
		this.MiddleObj.style.marginLeft = 0+"px";
		this.MiddleObj.style.marginRight = this._Drag.offsetWidth+"px";
		this.Drag.className = "digtitle_r";
		$("sildBox").className = "sildBox";
		this.TxtBar.style.styleFloat = "left";
		this.TxtCot.style.styleFloat = "left";
		this.TxtBar.style.cssFloat = "left";
		this.TxtCot.style.cssFloat = "left";
	}
  }
}
/*对键盘的操作--开始*/
document.onkeydown=keyDown;function keyDown(e){var nKey=-1;if(Browser.moz){nKey=e.which}else{nKey=event.keyCode}switch(nKey){case 37:case 38:case 188:case 74:loadingProcess.perPic();break;case 39:case 40:case 190:case 75:loadingProcess.nextPic();break;case 189:loadingProcess.picZoomOut();break;case 187:loadingProcess.picZoomIn();break;case 85: loadingProcess.disScreen();break;case 73: case 79: loadingProcess.orgPicScreen();break;case 80: loadingProcess.playerPicHandler(); break;case 68: loadingProcess.dragHandler();break;}}/*  |xGv00|4f88740682ed6d483c6d7707eddaa95c */