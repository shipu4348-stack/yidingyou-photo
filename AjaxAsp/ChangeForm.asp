<% Response.ContentType = "text/html; charset=gb2312" %>
<%
	kid=int(request.QueryString("kid"))
	shortpath=cint(request.QueryString("shortpath"))
	overall=cint(request.QueryString("overall"))
	shuiyin=cint(request.QueryString("shuiyin"))
	response.Cookies("liu")("kid")=kid
	response.Cookies("liu")("shortpath")=shortpath
	response.Cookies("liu")("overall")=overall
	response.Cookies("liu")("shuiyin")=shuiyin
	'response.Write kid&"--"&tag&"--"&shortpath&"--"&overall&"--"&shuiyin
%>