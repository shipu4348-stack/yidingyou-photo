var lxids=new Array();
var lxidnum=0;
var del_search_num=0;
 
 
function changeoption(id)
{
 if(pics.kind[0].selectedIndex!=id)
  {
   pics.kind[0].selectedIndex=id;
  }

 if(pics.kind[1].selectedIndex!=id)
  {
   pics.kind[1].selectedIndex=id;
  }


}
function copylink(url)
{
	window.clipboardData.setData("Text",url);
	alert("网络地址已拷贝到剪贴板，可以使用粘贴或Ctrl+V调用。\n\n"+url);
}

function copyall(form)
{
	  var str="";
	  if(pics.pid.length==undefined)
	  {
		alert('请使用单张复制!');
	  }
	  else
	  {
		for(i=0;i<pics.pid.length;i++)
		{
			if (pics.pid[i].checked)
			{
				str=str+"<img src="+pics.url[i].value+"><br>";
			}
		
		}
		alert("网络地址已拷贝到剪贴板，可以在编辑源文件形式下使用粘贴或Ctrl+V调用。\n\n"+str);
		window.clipboardData.setData("Text",str);
	  }
}


function DelSearchAll(form,type)
{
  var str="";
  if(confirm('此操作将删除所选文件并不能恢复！\n\n确认删除吗？')) 
  {
	  if(!(pics.pid.length))
	  {
		   if (pics.pid.checked)
		   {
			   del_search_num=del_search_num+1;
			   deletesearch0(pics.pid.value,type,pics.kid[1].value);
		   }
	  }
	  else
	  {
		for(i=0;i<pics.pid.length;i++)
		{
			if (pics.pid[i].checked)
			{
			  del_search_num=del_search_num+1;
			  deletesearch0(pics.pid[i].value,type,pics.kid[i].value);     
			}
		}
	  }
    }    
    if(type==5)
    {
    top.document.search.submit();
    }
    else
    {
    window.location="top50.asp";
    }

}

function deletesingle(pid,type,klevel)
{
  var str="";
  var j=0;
  var seldelid=new Array();
  seldelid[0]=pid;
  DelAllFiles(seldelid,type,klevel,pics.kid.value,pics.upid.value,0);
}


function deletesearch(pid,type,kid)
{
  var str="";
  var j=0;
  var seldelid=new Array();
  seldelid[0]=pid;
  DelAllFiles(seldelid,type,kid,pics.upid.value);

}

function deletesearch0(pid,type,kid)
{
  var str="";
  var j=0;
  var seldelid=new Array();
  seldelid[0]=pid;
  DelAllsearch(seldelid,type,kid,pics.upid.value);
}

function removeall(form,type,klevel)
{
  var j=0;
  var seldelid=new Array();
  if(!(pics.pid.length))
  {
   if (pics.pid.checked)
   {
	   seldelid[j]=pics.pid.value;
	   j++;
   }
  }
  else
  {
	  for(i=0;i<pics.pid.length;i++)
		{
			if (pics.pid[i].checked)
			{
			  seldelid[j]=pics.pid[i].value;
			  j++;  
			}
		}
   }
  //alert(pics.kindtext.value);
  if (j>0 && pics.kid.value!=pics.kindtext.value)
  {	  
	  RMAllFiles(klevel,seldelid,type,pics.kid.value,pics.upid.value,pics.kindtext.value);
  }
}


function addalllx(form,type)
{
  var str="";
  var j=0;
  lxids.length=0;
  for(i=0;i<pics.pid.length;i++)
    {
    if (pics.pid[i].checked)
{
      lxids[j]=pics.pid[i].value;
            //alert(pics.pid[i].value);
      j++;
      //lxop(1,1,pics.pid[i].value);
      //str=str+pics.pid[i].value;      
}

    }
    lxidnum=j;
    if (lxidnum>0)
    {
     lxopPl(lxids,type,pics.kid.value);
    }
    
}

function deleteall(form,type,klevel)
{

  
  var str="";
  var j=0;
  var seldelid=new Array();
  if(!(pics.pid.length))
  {
   if (pics.pid.checked)
   {
   seldelid[j]=pics.pid.value;
   j++;
   }
  }
  else
  {
	for(i=0;i<pics.pid.length;i++)
		{
			if (pics.pid[i].checked)
			{
				  seldelid[j]=pics.pid[i].value;
				  j++;
			}
		}
   }
    if (j>0)
    {
    DelAllFiles(seldelid,type,klevel,pics.kid.value,pics.upid.value,1);
    }
}

function ChangerOptionKind(kind)
{
	var obj=document.getElementById("kindtext");
	obj.value=kind;
}