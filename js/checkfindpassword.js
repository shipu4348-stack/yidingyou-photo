function check_forgot()
{
	if(document.forgot.username.value=="")
	{
	alert("用户名输入错误！");
	document.forgot.username.focus();
	return false;
	}	
	
	if(document.forgot.question.value=="")
	{
	alert("请点击显示问题答案！");
	document.forgot.check_username.focus();
	return false;
	}
	
	if(document.forgot.answer.value=="")
	{
	alert("问题答案不能为空！");
	document.forgot.answer.focus();
	return false;
	}	
	
	if(document.forgot.email.value=="")
	{
	alert("Email输入错误！");
	document.forgot.email.focus();
	return false;
	}
	else
	{
		if (( document.forgot.email.value.indexOf("@") == -1) || (document.forgot.email.value.indexOf(".") == -1) ) 
		{
    	alert("请您确认您输入的信箱地址是否有效！");
    	document.forgot.email.focus();
    	return false ;
    	}	
	}
	
	if(document.forgot.verify.value=="")
	{
	alert("请输入验证码！");
	document.forgot.verify.focus();
	return false;
	}
	return true;
}

function check_password()
{
	if(document.forgot.password.value=="")
	{
		alert("密码不能为空！");
		document.forgot.password.focus();
		return false;
	}	
	
	if(document.forgot.compassword.value=="")
	{
		alert("确认密码不能为空！");
		document.forgot.compassword.focus();
		return false;
	}
	if(document.forgot.password.value!=document.forgot.compassword.value)
	{
		alert("两次输入密码不一致！");
		document.forgot.compassword.focus();
		return false;
	}
	if( ! /^[\w]+$/.test( document.forgot.password.value ) )
	{
		alert("密码只能字母，数字组成!");
		document.forgot.password.focus();
		return false;
	}
	return true;
}