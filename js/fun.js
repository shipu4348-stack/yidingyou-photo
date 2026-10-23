function ShowParentPic(imgurl)
{
	var ShowPicInfo=window.parent.document.getElementById("Pic");
   ShowPicInfo.style.display='none';
   ShowPicInfo.style.display='';
   ShowPicInfo.style.left=(document.body.clientWidth/2)-(ShowPicInfo.offsetWidth/2)+'px';
   ShowPicInfo.style.top="50px";
   var str="";
   str="<div class='PicTitle'><img src='images/0039.gif' onClick='CloseParentPic();'><a href='"+imgurl+"' target='_blank'><img src='images/0038.gif'></a><img src='images/0037.gif' onClick=showurl1('"+imgurl+"')><img src='images/0036.gif' onClick=showurl('"+imgurl+"')></div>";
   str+="<div class='PicContent'><img src='"+imgurl+"'></div>";
   ShowPicInfo.innerHTML=str;
}

function CloseParentPic()
{
	var ClosePicInfo=document.getElementById("Pic");
	ClosePicInfo.style.display='none';
}

function showurl1(url)
  {
  var content="";
  window.clipboardData.setData('Text','<img src="'+url+'">');
  content='网络地址已拷贝到剪贴板，可以使用粘贴或Ctrl+V调用。\n\n<img src="'+url+'">';
  alert(content);
  }
  
function showurl(url)
  {
  var content;
  window.clipboardData.setData('Text',url);
  content='网络地址已拷贝到剪贴板，可以使用粘贴或Ctrl+V调用。\n\n'+url;
  alert(content);
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
 
function Checked()
{
	var j = 0
	for(i=0;i < document.form.elements.length;i++){
		if(document.form.elements[i].name == "FileId" || document.form.elements[i].name == "FolderId"){
			if(document.form.elements[i].checked){
				j++;
			}
		}
	}
	return j;
}
function CheckAll1()
{
	alert(document.form.elements.length);
	for(i=0;i<document.form.elements.length;i++)
	{
		if(document.form.elements[i].checked){
			document.form.elements[i].checked=false;
			document.form.CheckAll.checked=false;
		}
		else{
			document.form.elements[i].checked = true;
			document.form.CheckAll.checked = true;
		}
	}
}
function DelAll()
{
	if(Checked()  <= 0){
		alert("您必须选择其中的一个文件");
	}	
	else{
		if(confirm("确定要删除选择的文件么？\n此操作不可以恢复！")){
			form.action="?action=Del";
			form.submit();
		}
	}
}

function CopyAll()
{
	if(Checked()  <= 0){
		alert("您必须选择其中的一个文件");
	}	
	else{
		form.action="?action=CPA";
		form.submit();
	}
}

function MoveAll()
{
	if(Checked()  <= 0){
		alert("您必须选择其中的一个文件");
	}	
	else{
		if(confirm("确定要移动选择的文件么？")){
			form.action="?action=YDWJ";
			form.submit();
		}
	}
}


function Rname()
{
	if(Checked() == 0){
		alert("您必须选择一个文件");
	}
	else{
		if(Checked() != 1){
			alert("只能选择一个文件或一个文件夹");
		}
		else{
			for(i=0;i < document.form.elements.length;i++){
				if(document.form.elements[i].name == "FolderId" && document.form.elements[i].checked){
					var j = prompt("请输入新文件夹名",document.form.elements[i].value)
					break;
				}
				else if(document.form.elements[i].name == "FileId" && document.form.elements[i].checked){
					var j = prompt("请输入新文件名",document.form.elements[i].value)
					break;
				}
			}
			if(j != "" && j != null){
				if(IsStr(j) == j.length){
					form.action="?action=Rname&NewName=" + j;
                    form.target="_self";
					form.submit();
				}
				else{
					alert("新名称不符合标准，只能是字母、数字、点和下划线的组合,\n不能含有汉字、空格和其他符号");
				}
			}
		}
	}
}
function IsStr(w)
{
	var str = "abcdefghijklmnopqrstuvwxyz_1234567890."
	 w = w.toLowerCase();
	var j = 0;
	for(i=0;i < w.length;i++){
		if(str.indexOf(w.substr(i,1)) != -1){
			j++;
		}
	}
	return j;
}
function NewFile(form,i)
{
	if(i == 1){
		if(form.NewFolderName.value == ""){
			alert("文件夹名不能为空");
		}
		else{
			if(IsStr(form.NewFolderName.value) == form.NewFolderName.value.length){
				form.action="?action=NewFolder";
				form.submit();
			}
			else{
				alert("文件夹名不符合标准，只能是字母、数字、点和下划线的组合,\n不能含有汉字、空格和其他符号");
			}
		}
	}
	else{
		if(form.NewFileName.value == ""){
			alert("文件名不能为空");
		}
		else{
			if(IsStr(form.NewFileName.value) == form.NewFileName.value.length){
				form.action="?action=NewFile";
				form.submit();
			}
			else{
				alert("文件名不符合标准，只能是字母、数字、点和下划线的组合,\n不能含有汉字、空格和其他符号");
			}
		}
	}
}
function changedir(id)
{
	for(i=1;i<8;i++)
	{
		if(i==id)
		{
			document.getElementById("dir0"+i).className="dir0"+i+"_1";
		}
		else
		{
			document.getElementById("dir0"+i).className="dir0"+i;
		}
	}
}