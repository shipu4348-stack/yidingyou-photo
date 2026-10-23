var selfid=0,usernameExist=0,useremail=0,verifycorrect=0;
var xmlHttp,xmlHttpV;
var selectedStyle = "s3";
function GetXmlHttpObject()
{
	var xmlHttp=null;
	try
	  {
	  // Firefox, Opera 8.0+, Safari
	  xmlHttp=new XMLHttpRequest();
	  }
	catch (e)
	  {
	  // Internet Explorer
	  try
		{
		xmlHttp=new ActiveXObject("Msxml2.XMLHTTP");
		}
	  catch (e)
		{
		xmlHttp=new ActiveXObject("Microsoft.XMLHTTP");
		}
	  }
	return xmlHttp;
}

function checkverify(){	
    if(document.regform.verify.value.length>0)
    {
		xmlHttp=GetXmlHttpObject();
		var url = "ajaxasp/checkcode.asp?verify="+document.regform.verify.value;
		xmlHttp.open("GET", url, true);
		xmlHttp.onreadystatechange = updatecheckV;
		xmlHttp.send(null);  
		return true;
    }
    else
    {
    	document.getElementById("info_verify").innerHTML="<font color=red>请输入验证码！";
    }
}

function updatecheckV() {
  if (xmlHttp.readyState == 4 && xmlHttp.status==200) {
    var response = unescape(xmlHttp.responseText);
    if (response.indexOf("正确")>=0)
    {
    verifycorrect=1;
    document.getElementById("info_verify").innerHTML="<img src='../images/0065.gif' width='20' height='20'>";
    }
	else if(response.indexOf("超时")>=0)
	{
		 verifycorrect=0;
    	document.getElementById("info_verify").innerHTML="<font color=red>超时,请得刷新页面！</font>";
	}
    else
    {
    verifycorrect=0;
    document.getElementById("info_verify").innerHTML="<font color=red>验证码输入错误！</font>";
    }     
  }  
}

function checkusername()
{
    if(document.regform.username.value.length>=5&&document.regform.username.value.length<=20)
    {
    if( ! /^[\w]+$/.test( document.regform.username.value ) ) {
	document.getElementById("info_username").innerHTML="<font color=red>用户名只能由英文字母、数字和下划线（_）组成！</font>";
    	return false;
    }
    xmlHttp=GetXmlHttpObject();
    var url = "ajaxasp/checkusername.asp?username="+document.regform.username.value;
    xmlHttp.open("GET", url, true);
    xmlHttp.onreadystatechange = updatePage;
    xmlHttp.send(null);  
	return true;
    }
    else
    {
    document.getElementById("info_username").innerHTML="<font color=red>用户名长度只能在5到20之间！";
    usernameExist=0;
    return false;
    }
}

function updatePage(){
  if (xmlHttp.readyState == 4 && xmlHttp.status == 200) {
    var response = unescape(xmlHttp.responseText);
    if (response.indexOf("不存在")>=0)
    {
    usernameExist=1;
	//alert(usernameExist);
    document.getElementById("info_username").innerHTML="<img src='../images/0065.gif' width='20' height='20'>";
    }
    else
    {
    usernameExist=0;
    document.getElementById("info_username").innerHTML="<font color=red>该用户名已经存在！</font>";
    }     
  }
  else{
	  usernameExist=0;
	  document.getElementById("info_username").innerHTML="<img src='../images/loading.gif' width='16' height='16'>";
	  }
}


function checkAltEmail() {
    if (document.regform.email.value.length<=0) {
		useremail=0;
		document.getElementById("info_email").innerHTML="<font color=red>邮箱地址不能为空</font>";
		return false;
	}
	if (! /^[^@]+@[^@]+\.[^@]+$/.test( document.regform.email.value )) {
		useremail=0;
		document.getElementById("info_email").innerHTML="<font color=red>邮箱地址格式错误</font>";
		return false;
	}
	else
	{
		xmlHttp=GetXmlHttpObject();
		var url = "ajaxasp/checkuseremail.asp?email="+document.regform.email.value;
		xmlHttp.open("GET", url, true);
		xmlHttp.onreadystatechange = updateEmail;
		xmlHttp.send(null);  
		return true;
	}
}

function updateEmail()
{
	if (xmlHttp.readyState == 4 && xmlHttp.status == 200) {
    var response = unescape(xmlHttp.responseText);
    if (response.indexOf("不存在")>=0)
    {
    useremail=1;
    document.getElementById("info_email").innerHTML="<img src='../images/0065.gif' width='20' height='20'>";
    }
    else
    {
    useremail=0;
    document.getElementById("info_email").innerHTML="<font color=red>该邮箱地址已经存在！</font>";
    }     
  }
  else{
	  useremail=0;
	  document.getElementById("info_email").innerHTML="<img src='../images/loading.gif' width='16' height='16'>";
	  }	
}



function checkform()
{
if(selfid==0)
{
alert("请选择空间类型！");
return false;
}
//checkusername();
//alert(usernameExist);
if(usernameExist==0)
  {
  return false;
  }
else
  {
  document.getElementById("info_username").innerHTML="<img src='../images/0065.gif' width='20' height='20'>";
  }
if(!checkpassword())
 return false;
 //checkAltEmail()
 //alert(useremail);
if(useremail==0)
  {
  return false;
  }
else
  {
  document.getElementById("info_email").innerHTML="<img src='../images/0065.gif' width='20' height='20'>";
  }
//if(!checkquestion())
// return false;
if(!checkanswer())
 return false;
//checkverify();
//alert(verifycorrect);
if(verifycorrect==0)
{
	return false;
}
else
{
	document.getElementById("info_verify").innerHTML="<img src='../images/0065.gif' width='20' height='20'>";
}
var box=document.getElementById("checkbox");
if(!box.checked)
return false;

document.regform.action='http://www.1dy.cc/register.asp?action=reg';

document.regform.submit();

}

function checkpassword()
{
if(document.regform.pwd.value.length==0)
{
//document.regform.pwd.focus();
document.getElementById("info_pwd").innerHTML="<font color=red>请输入密码！</font>";
return false;
}
else
{
document.getElementById("info_pwd").innerHTML="<img src='../images/0065.gif' width='20' height='20'>";
}
if(document.regform.pwd.value!=document.regform.confirmpwd.value)
{
//document.regform.pwd.focus();
document.getElementById("info_confirmpwd").innerHTML="<font color=red>您两次输入的密码不一致！</font>";
return false;
}
else
{
document.getElementById("info_confirmpwd").innerHTML="<img src='../images/0065.gif' width='20' height='20'>";
}
return true;
}

function checkquestion()
{
if(document.regform.question.value=='custom'&&document.regform.question_owner.value.length==0)
{
document.getElementById("info_question_owner").innerHTML="<font color=red>请输入自定义提示问题！</font>";
return false;
}
else
{
document.getElementById("info_question_owner").innerHTML="提示问题长度不超过20个字符，不能包含'%'和'&'";
}

if(document.regform.question.value=='custom'&&(document.regform.question_owner.value.indexOf("&")>=0||document.regform.question_owner.value.indexOf("%")>=0)||document.regform.question_owner.value.length>20)
{
//document.regform.question_owner.focus();
document.getElementById("info_question_owner").innerHTML="<font color=red>提示问题长度不超过20个字符，不能包含'%'和'&'</font>";
return false;
}
else
{
document.getElementById("info_question_owner").innerHTML="<img src='../images/0065.gif' width='20' height='20'>";
}

return true;
}

function checkanswer()
{
if(document.regform.answer.value.length==0)
{
//document.regform.answer.focus();
document.getElementById("info_answer").innerHTML="<font color=red>请输入提示问题答案！</font>";
return false;
}
else
{
document.getElementById("info_answer").innerHTML="<img src='../images/0065.gif' width='20' height='20'>";
}
if(document.regform.answer.value.indexOf("%")>=0||document.regform.answer.value.indexOf("&")>=0)
{
//document.regform.answer.focus();
document.getElementById("info_answer").innerHTML="<font color=red>问题答案不能包含'%'和'&'</font>";
return false;
}
else
{
document.getElementById("info_answer").innerHTML="<img src='../images/0065.gif' width='20' height='20'>";
}
return true;
}
function checkQuestion(question)
{

if(question!='custom')
{
document.getElementById("question_owner").style.display="none";
}
else
{
document.getElementById("question_owner").style.display="block";
}
}
function mailTypeChk() {
	var c = document.getElementsByName('mbstyle');
	for (var i=0;i<c.length ;i++ )
	{	
		var Node=c[i].nextSibling;
		if(Node.nodeType=='3')
		{
			Node=Node.nextSibling;
		}
		if (c[i].checked) {
			Node.className='chked';
		} else {
			Node.className='chk';
		}

	}
}
function chgmtBg(id){
	var $ = function(id){return document.getElementById(id);}
	if(id==0){
		$('dfr1').style.backgroundPosition='0px -190px';
		$('mtDesc1').style.display='block';
		$('mtDesc2').style.display='none';
		//$('mtDesc3').style.display='none';
		minLen=6;
		//selectedStyle='s3';
	}
	if(id==1){
		$('dfr1').style.backgroundPosition='0px -150px';
		$('mtDesc1').style.display='none';
		$('mtDesc2').style.display='block';
		//$('mtDesc3').style.display='none';
		minLen=5;
		//selectedStyle='s4';
	}
	if(id==2){
		$('dfr1').style.backgroundPosition='0px -110px';
		$('mtDesc1').style.display='none';
		$('mtDesc2').style.display='none';
		//$('mtDesc3').style.display='block';
		minLen=3;
		//selectedStyle='s5';
	}
}
function setTab_reg(id){
	var $ = function(id){return document.getElementById(id);}
	if(id==0){
		$('regTab').style.backgroundPosition='0px 0px';
		$('phoneReg').style.display='block';
		$('pageReg').style.display='none';
	}
	if(id==1){
		$('regTab').style.backgroundPosition='0px -110px';
		$('phoneReg').style.display='none';
		$('pageReg').style.display='block';
	}
}
function chgstyle() {
        switch (selectedStyle){
                //case "s5" :
                    //{ mailTypeChk();chgmtBg(2);_('mtype_3').checked = true;_('mtype_2').nextSibling.className='chk';_('mtype_3').nextSibling.className='chked';return;}
                case "s4" :
                    { mailTypeChk();chgmtBg(1);_('mtype_2').checked = true;_('mtype_2').nextSibling.className='chked';return;}
                default :
                    { mailTypeChk();chgmtBg(0);_('mtype_1').checked = true;_('mtype_2').nextSibling.className='chk';_('mtype_1').nextSibling.className='chked';return;}
        }
}

function ShowSelectIn()
{
	var obj=document.getElementById("SelectIn");
	if(obj.style.display=="")
	{
		obj.style.display='none';
	}
	else
	{
		obj.style.display='';
	}
}