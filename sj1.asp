<!--#include file="./incs/SysCode.asp"-->
<%
	if Request.Cookies("1dy")("yjf")=0 and workday=0  then
		response.Redirect "kt1.asp"
	end if
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>自助扩容升级</title>
<link rel="stylesheet" type="text/css" media="all" href="css/common.css" />

</head>
<body>
<table width="100%" border="0" cellpadding="0" cellspacing="0">
  <tr>
    <td height="40" valign="bottom" background="images/0018.gif" class="emm">
	自助扩容升级</td>
  </tr>
</table>
<table width="100%" border="0" cellspacing="0" cellpadding="0">
<tr>
    <td height="1" bgcolor="#e1e1e1"></td>
  </tr>
  <tr><td class="dirnotice">注意：如果您已经联系销售人员并在其店内付款，请停止当前页面的任何操作，请联系为您服务的销售人员为您做升级扩容服务。</td></tr>
<tr>
<tr>
    <td height="1" bgcolor="#e1e1e1"></td>
  </tr>

<form  method="post" name="jiaofei" action="ktpay.asp?action=sj">
  <%if fflx=1 then
   tclxwz="年"
   elseif fflx=2 then
   tclxwz="月"
   end if
   %>
<tr>
    <td class="makdir2" height="50" >&nbsp;&nbsp;用户类别：[无限通]<%=FolderCountSize%>/￥<%=jiage%>/<%=tclxwz%>
</td>
</tr>
<tr>
    <td class="makdir2">&nbsp;&nbsp;剩余时间：<%=workday%>天</td>
</tr>
<tr>
    <td class="makdir2" height="50">&nbsp;&nbsp;新的类型：
    <select size="1" name="fee" onchange="checkfee(this.options[selectedIndex].value);">
    <%
		set Fso=new DmFso
		set rs=server.CreateObject("adodb.recordset")
		sql="select [id],[comsize],[comprice],[comkind] from [ydy_combo] where comkind="&fflx&" order by comprice desc"
		rs.open sql,conn,1,1
		if not rs.eof or not rs.bof then
			do while not rs.eof
			response.Write("<option value='"&rs("id")&"'")
			if tcid=rs("id") then
			response.Write("selected")
			end if	
			if rs("comkind")=1 then
			response.Write(">[无限通]"&Fso.FormatFileSize(rs("comsize"))&"/￥"&rs("comprice")&"/年</option>")
			elseif rs("comkind")=2 then
			response.Write(">[无限通]"&Fso.FormatFileSize(rs("comsize"))&"/￥"&rs("comprice")&"/月</option>")
			end if
			rs.movenext
			loop
		else
			response.Write("<option value=''>无可升级的空间</option>")
		end if
		rs.close
		set rs=nothing
	%>
	</select>&nbsp;&nbsp;</td>
  </tr>
<tr>
    <td class="makdir2">&nbsp;&nbsp;<font color=red>应付金额：<span id=sjfh></span></font></td>
</tr>
<tr>
    <td class="makdir2" height="60">&nbsp;<input id="upbt" name="upbt" disabled="disabled" type="submit" value="  支付宝付款" class="alipay_b" style="cursor:hand;"></td>
</tr>


</form>
<tr>
    <td height="1" colspan="2" bgcolor="#e1e1e1"></td>
  </tr>
<tr>
    <td style="padding:15px; line-height:180%; color:#999999">
<font color="red">扩容升级相关说明及注意事项</font><br />
1、扩容升级定义：是指一定呦空间从 当前类型 扩容升级 <b>到</b> 新的类型，是扩容到某类型而不是在原有基础上增加了多少；<br />
　 例如：当前类型为10M年付，选择的新的类型为20M年付，系统会给出一个金额。升级完毕后总容量是20M，在原有基础上增加了10M；<br />
2、扩容升级原则：小容量月付型可升级到同等容量或大容量年付型；小容量年付型可升级到大容量年付型；在现有类型上进行扩容升级；<br />
　 注：不能进行的升级操作，系统也不会给出相应的金额，付款按扭也不会被激活；<br />
3、扩容升级费率计算：<br />
A：月付型升级到年付型：应付金额=升级到的类型一年资费，升级完毕状态=新的类型容量；使用时间=剩余时间+365天；<br />
　 注：月付天数剩余天数必须小数31天才允许升级到年付；<br />
B：年付型升级到年付型：应付金额= 新资费－[原资费－(原资费÷365)×已使用天数]，升级完毕状态=新的类型容量；使用时间=365天；<br />
　 注：已使用天数=365-剩余天数；单位：1年=365天；1月=31天。<br />
4、如果您对扩容升级仍存在疑问可以联系一定呦销售代表为您服务；[ <a href="/pay.htm" target="_blank">点击联系官方销售代表</a> ]
</td>
  </tr>
    </table>
</body>
</html>

<script>
var xmlHttp;
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


function updatePage() {
  if (xmlHttp.readyState < 4) {

  }
  if (xmlHttp.readyState == 4) {
    var response = unescape(xmlHttp.responseText);
	//alert(response);
	if(response.indexOf("超时")>=0)
	{
		alert('超时');
		window.location.href='index.asp';
	}
    else if(response.indexOf("不")>=0)
    {
     document.getElementById("sjfh").innerHTML=response;
     document.getElementById("upbt").disabled=true;
    }
    else
    {
     document.getElementById("sjfh").innerHTML=response+"元";
     document.getElementById("upbt").disabled=false;
    }
    
    }  
}

function checkfee(fee)
{
 
	xmlHttp=GetXmlHttpObject();
    var url = "onlinepay_checkfee.asp?fee="+fee;
    xmlHttp.open("GET", url, true);
    xmlHttp.onreadystatechange = updatePage;
    xmlHttp.send(null);  
    return true;
}
</script>