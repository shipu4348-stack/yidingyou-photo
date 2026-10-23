var Speed_1=10;//速度(毫秒)
var Space_1=8;//每次移动(px)
var PageWidth_1=80;//翻页宽度
var MoveLock_1=false;
var MoveTimeObj_1;
var MoveWay_1="right";
var _Space_1=0;
//-----------------------------------------------
//获取ID
function GetObj(objName){
	if(document.getElementById){
		return eval('document.getElementById("'+objName+'")')
	}else {
		return eval('document.all.'+objName)
	}
}
//-----------------------------------------------
//向左滚动
function ISL_GoUp_1()
{
	if(MoveLock_1)return ;
	MoveLock_1=true;
	MoveWay_1="left";
	_Space_1=0;
	ISL_ScrUp_1();
	MoveTimeObj_1=setInterval('ISL_ScrUp_1();',Speed_1);
	GetObj('PicPlayNext').innerHTML="<a href='javascript:void(0)' hidefocus='hidefocus' onclick='ISL_GoDown_1()'>下一张</a>";
}
function ISL_ScrUp_1()
{
	_Space_1=_Space_1+Space_1;	
	if (_Space_1==80)
	{
		_Space_1=0;
		MoveLock_1=false;
		clearInterval(MoveTimeObj_1);
	}
	if(GetObj('ISL_Cont_1').scrollLeft<=0)
	{
		GetObj('ISL_Cont_1').scrollLeft=0;
		GetObj('PicPlayPre').innerHTML='上一张';
		clearInterval(MoveTimeObj_1);
		MoveLock_1=false;
	}
	else
	{
		GetObj('PicPlayPre').innerHTML="<a href='javascript:void(0)' hidefocus='hidefocus' onclick='ISL_GoUp_1()'>上一张</a>";
	}
	GetObj('ISL_Cont_1').scrollLeft-=Space_1;
}
//---------------------------------------------------
//向右滚动
function ISL_GoDown_1(){
	if(MoveLock_1)return ;
	MoveLock_1=true;
	MoveWay_1="right";
	_Space_1=0;
	ISL_ScrDown_1();
	MoveTimeObj_1=setInterval('ISL_ScrDown_1()',Speed_1)
	GetObj('PicPlayPre').innerHTML="<a href='javascript:void(0)' hidefocus='hidefocus' onclick='ISL_GoUp_1()'>上一张</a>";
}

function ISL_ScrDown_1()
{
	_Space_1=_Space_1+Space_1;
	if (_Space_1==80)
	{		
		_Space_1=0;
		MoveLock_1=false;		
		clearInterval(MoveTimeObj_1);
	}
	if(GetObj('ISL_Cont_1').scrollLeft>=GetObj('List1_1').offsetWidth-240)
	{	
		GetObj('ISL_Cont_1').scrollLeft=GetObj('List1_1').offsetWidth-167;
		GetObj('PicPlayNext').innerHTML='下一张';
		clearInterval(MoveTimeObj_1);
		MoveLock_1=false;
		
	}
	else
	{
		GetObj('PicPlayNext').innerHTML="<a href='javascript:void(0)' hidefocus='hidefocus' onclick='ISL_GoDown_1()'>下一张</a>";
	}
	GetObj('ISL_Cont_1').scrollLeft+=Space_1;
}
//-------------------------------------------------------
function picrun_ini(SelectId,arrPidLength)
{
	var _SelectId=SelectId;
	if(_SelectId>0 && arrPidLength>2)
	{
		if(_SelectId>1){
			GetObj('ISL_Cont_1').scrollLeft=(_SelectId-1)*80;
		}
		else{
			GetObj('ISL_Cont_1').scrollLeft=_SelectId*80;
		}
		if(GetObj('ISL_Cont_1').scrollLeft>=GetObj('List1_1').scrollWidth-240 && _SelectId==arrPidLength){	
			GetObj('PicPlayNext').innerHTML="下一张";
		}
		else{
			GetObj('PicPlayNext').innerHTML="<a href='javascript:void(0)' hidefocus='hidefocus' onclick='ISL_GoDown_1()'>下一张</a>";
		}
	}
	else{
		GetObj('ISL_Cont_1').scrollLeft=0;
	}
	if(GetObj('ISL_Cont_1').scrollLeft<=0 && arrPidLength<=2){
		GetObj('ISL_Cont_1').scrollLeft=0;
		GetObj('PicPlayPre').innerHTML="上一张";
		GetObj('PicPlayNext').innerHTML="下一张";
	}
	else if(GetObj('ISL_Cont_1').scrollLeft<=0){
		GetObj('ISL_Cont_1').scrollLeft=0;
		GetObj('PicPlayPre').innerHTML="上一张";
	}
	else{
		GetObj('PicPlayPre').innerHTML="<a href='javascript:void(0)' hidefocus='hidefocus' onclick='ISL_GoUp_1()'>上一张</a>";
	}	
}

function Filter(image)
{
	image.style.filter="";
}

function LoadViewImage(image,width,height)
{	
	var Img=new Image();
	Img.src=image.src;
	var w = Img.width;
	var h = Img.height;
	if(w>width && w>h)
	{
	 image.width=width;
	 image.height = parseInt(h*(width/w));
	 }
	if(h>height && h>w)
	{
	 image.width = parseInt(w*(height/h));
	 image.height = height;
	 }
	 document.getElementById('viewImage').style.display='';
}