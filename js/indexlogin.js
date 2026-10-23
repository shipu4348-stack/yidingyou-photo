var xmlHttp,xmlHttp2;

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

function checkform()
{
	var errormsg;
	errormsg=true;
	if(document.getElementById("username").value==null || document.getElementById("username").value=="")
	{
		document.getElementById("username_d").innerHTML="<font color=red>用户名不能为空</font>";
		document.getElementById("username").focus();
		errormsg=false;
		return false;
	}
	else
	{
		document.getElementById("username_d").innerHTML="";
	}

	if(document.getElementById("password").value==null || document.getElementById("password").value=="")
	{
		document.getElementById("password_d").innerHTML="<font color=red>密码不能为空</font>";
		document.getElementById("password").focus();
		errormsg=false;
		return false;
	}
	else
	{
		document.getElementById("password_d").innerHTML="";
	}

	if(document.getElementById("verify").value==null || document.getElementById("verify").value=="")
	{
		document.getElementById("verify_d").innerHTML="<font color=red>验证码不能为空</font>";
		document.getElementById("verify").focus();
		errormsg=false;
		return false;
	}
	else
	{
		document.getElementById("verify_d").innerHTML="请将下面的文字输入框中";
	}
	if(errormsg)
	{
		CheckLogin();
	}
		return true;
}

function CheckLogin(){
    xmlHttp=GetXmlHttpObject();
	var username=document.getElementById("username").value;
	var password=document.getElementById("password").value;
	var verify=document.getElementById("verify").value;
    var url = "ajaxasp/checklogin.asp?action=first&username="+username+"&password="+password+"&verify="+verify;
    //window.clipboardData.setData("Text",url);	
    xmlHttp.open("GET", url, true);
    xmlHttp.onreadystatechange = updatePage;
    xmlHttp.send(null);  
	return true;
}

function updatePage() {	
  if (xmlHttp.readyState < 4) {
    if(document.getElementById("username").value!=null&&document.getElementById("username").value!="")
     {
	  	document.getElementById("loginbtn").value="正在登录";
        document.getElementById("loginbtn").disabled=true;
	 }
  }
  if (xmlHttp.readyState == 4) {
    var response = unescape(xmlHttp.responseText);
	//alert(response);
    if (response.indexOf("1dy.cc")>=0){
		//CheckLogin2(response,document.getElementById("username").value)
		//alert(response+'ajaxasp/checklogin.asp?action=second&username='+document.getElementById("username").value+'&password='+document.getElementById("password").value+'');
		document.login.action=(location.hostname=="localhost"||location.hostname=="127.0.0.1"?"":response)+"ajaxasp/checklogin.asp?action=second&username="+document.getElementById("username").value+"&password="+document.getElementById("password").value;		
		document.login.submit();
    }
    else{
		if(response.indexOf("验证码")>=0){
			document.getElementById("password_d").innerHTML="登录密码";
			document.getElementById("username_d").innerHTML="帐户名";
			document.getElementById("verify_d").innerHTML="<font color=red>验证码错误</font>";
			document.getElementById("verify").focus();
			document.getElementById("loginbtn").value="登 录";
			document.getElementById("loginbtn").disabled=false;
			//location.reload();
    	}
		else if(response.indexOf("用户名")>=0){
			document.getElementById("password_d").innerHTML="登录密码";
			document.getElementById("username_d").innerHTML="<font color=red>用户名无效</font>";
			document.getElementById("verify_d").innerHTML="请将下面的文字输入框中";
			document.getElementById("username").focus();    
			document.getElementById("loginbtn").value="登 录";
			document.getElementById("loginbtn").disabled=false;
			//location.reload();
		}
		else if(response.indexOf("密码")>=0){
			document.getElementById("password_d").innerHTML="<font color=red>密码无效</font>";
			document.getElementById("username_d").innerHTML="帐户名";
			document.getElementById("verify_d").innerHTML="请将下面的文字输入框中";
			document.getElementById("password").focus();
			document.getElementById("loginbtn").value="登 录";
			document.getElementById("loginbtn").disabled=false;
			//location.reload();
		}
		else if(response.indexOf("冻结")>=0){
			document.getElementById("password_d").innerHTML="登录密码";
			document.getElementById("username_d").innerHTML="<font color=red>帐号处于冻结状态,请您与客服联系</font>";
			document.getElementById("verify_d").innerHTML="请将下面的文字输入框中";
			document.getElementById("username").focus();		
			document.getElementById("loginbtn").value="登 录";
			document.getElementById("loginbtn").disabled=false;
			//location.reload();
		}
    }
  }
}

function tabit(id,cid) {
tabagent.className="taboff";tabprice.className="taboff";tabkehu.className="taboff";id.className="tabon";
cagent.style.display="none";cprice.style.display="none";ckehu.style.display="none";cid.style.display="block";
//winname=cid;
}
function showall() {
tabagent.className="tabon";tabprice.className="tabon";tabkehu.className="tabon";
cagent.style.display="block";cprice.style.display="block";ckehu.style.display="block";
}

function testid()
{
   document.login.username.value='fcxzfcxz';
   document.login.password.value='123456';
   document.login.verify.focus();
   alert("欢迎光临，现在您只须输入验证码即可登录体验！");
}

function killErrors() {
return true;
}

if (top.location != location)
top.location.href = location.href;

window.onerror = killErrors;