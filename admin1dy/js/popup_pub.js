       var pop =null;
       function ShowIframe(title,contentUrl,width,height)
        {//标题，跳转url地址，宽度，高度
           pop=new Popup({ contentType:1,isReloadOnClose:false,width:width,height:height});
           pop.setContent("contentUrl",contentUrl);
           pop.setContent("title",title);
           pop.build();
           pop.show();
        }
        function ShowHtmlString(title,strHtml,width,height)
        {//标题，html内容，宽度，高度
            pop=new Popup({ contentType:2,isReloadOnClose:false,width:width,height:height});
            pop.setContent("contentHtml",strHtml);
            pop.setContent("title",title);
            pop.build();
            pop.show();
       }
        function ShowConfirm(title,confirmCon,id,str,width,height)
        {//标题，对话框内容，div图层，确定后提示字符串，宽度，高度
            var pop=new Popup({ contentType:3,isReloadOnClose:false,width:width,height:height});
            pop.setContent("title",title);
            pop.setContent("confirmCon",confirmCon);
            pop.setContent("callBack",ShowCallBack);
            pop.setContent("parameter",{id:id,str:str,obj:pop});
            pop.build();
            pop.show();
        }
		function ShowConfirmDel(title,confirmCon,id,str,width,height)
        {//标题，对话框内容，div图层，确定后提示字符串，宽度，高度
            var pop=new Popup({ contentType:3,isReloadOnClose:false,width:width,height:height});
            pop.setContent("title",title);
            pop.setContent("confirmCon",confirmCon);
            pop.setContent("callBack",delCallback);
            pop.setContent("parameter",{id:id,str:str,obj:pop});
            pop.build();
            pop.show();
        }
        function ShowAlert(title,alertCon,width,height)
        {//标题，提示内容，宽度，高度
            pop=new Popup({ contentType:4,isReloadOnClose:false,width:width,height:height});
            pop.setContent("title",title);
            pop.setContent("alertCon",alertCon);
            pop.build();
            pop.show();
        }
        function ShowCallBack(para)
        {
            var o_pop = para["obj"]
            var obj = document.getElementById(para["id"]);
            o_pop.close();
            obj.click();
			obj.innerHTML = para["str"];
        }
		function delCallback(para)
         {
		var o_pop=para["obj"];
		o_pop.config.contentType=1;
		o_pop.setContent("contentUrl","");
		o_pop.reBuild();
		G(para["id"]).target=o_pop.iframeIdName;
		eval("document."+para["id"]).submit();
         }
        function ClosePop()
        {
	        pop.close();
        }
