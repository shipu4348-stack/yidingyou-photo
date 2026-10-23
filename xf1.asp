<!--#include file="incs/SysCode.asp"-->
<!--#include file="alipayto/alipay_payto.asp"-->
<%
	if Request.Cookies("1dy")("yjf")=0  then
		response.Redirect "kt1.asp"
	end if
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
<title>自助续费</title>
<link rel="stylesheet" type="text/css" media="all" href="css/common.css" />

</head>
<body>

<table width="100%" border="0" cellpadding="0" cellspacing="0">
  <tr>
    <td height="40" valign="bottom" background="images/0018.gif" class="emm">自助续费</td>
  </tr>
</table>
<table width="100%" border="0" cellspacing="0" cellpadding="0">
<tr>
    <td height="1" bgcolor="#e1e1e1"></td>
  </tr>
  <tr><td class="dirnotice">注意：如果您已经联系销售人员并在其店内付款，请停止当前页面的任何操作，请联系为您服务的销售人员为您做续费服务。</td></tr>
<tr>
<tr>
    <td height="1" bgcolor="#e1e1e1"></td>
  </tr>

<form  method="post"  action="ktpay.asp?action=xf" name="jiaofei">
	<%
	if fflx=1 then
	 tclxwz="年"
	 elseif fflx=2 then
	 tclxwz="月"
	 end if
	 %>
<tr>
    <td class="makdir2" height="50" >&nbsp;&nbsp;用户类别：续费[无限通]<%=FolderCountSize%>/￥<%=jiage%>/<%=tclxwz%>
</td>
</tr>
<tr>
    <td class="makdir2">&nbsp;&nbsp;剩余时间：<%=workday%>天</td>
  </tr>
<tr>
<td class="makdir2" height="50">&nbsp;&nbsp;<font color=red>应付金额：<%=jiage%>元</font>
</td>
</tr>
<tr>
<td class="makdir2" height="50" valign="top">&nbsp;<input id="upbt" name="upbt" type="submit" value="  支付宝付款" class="alipay_b" style="cursor:hand;" ></td>
  </tr>
</form>
<tr>
    <td height="1" colspan="2" bgcolor="#e1e1e1"></td>
  </tr>
<tr>
    <td style="padding:15px; line-height:180%; color:#999999">
<font color="red">续费相关说明及注意事项</font><br />
1、续费定义：是指在成功完成一次缴费后则延长一个使用周期，即：剩余天数 + 一个周期天数，空间类别不变；<br />
　 如：10M年付型剩余天数为8天，成功完成一次缴费后，剩余天数为8+365=373天；<br />
　 注：负天数代表已经欠费并该帐户处于冻结阶段，是可以恢复的；剩余天数为-8天，续费后为 -8+365=357天；<br />
2、欠费冻结、销户原则：一定呦对用户到期前10天就开始在用户登陆的时候，提示用户续费了；如果用户帐户到期后1天内，用户帐户还可以正常登陆使用，图片也能正常浏览；如果自用户到期后超过1天，用户不能登陆，也就不能维护了，图片不能浏览，但用户资料保留；自用户到期后超过10天，还未续费，则删除该用户所有存储资料，不在保留，也不负责恢复。<br />
3、如果您对续费仍存在疑问可以联系一定呦销售代表为您服务；[ <a href="/pay.htm" target="_blank">点击联系官方销售代表</a> ] 单位：1年=365天；1月=31天。
</td>
  </tr>

    </table>

</body>
</html>
