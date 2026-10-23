<html>
<head>
<title>文件上传</title>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<link rel="stylesheet" type="text/css" href="imageS/Admin_Style.Css">
<style type="text/css">
<!--
body {
	margin-left: 0px;
	margin-right: 0px;
	margin-bottom: 0px;
}
-->
</style></head>

<body >
<form name="form1" method="post" action="admin_upfile.asp?formName=<%=request.QueryString("formName")%>&amp;textName=<%=request.QueryString("textName")%>&amp;classtype=<%=request.QueryString("classtype")%>" enctype="multipart/form-data"  class="tdbg">
		<input type="hidden" name="act" value="upload">
		<input type="file" name="file1" style="width:300" value="">
		<input type="submit" name="Submit" value="提交"  >
		<input type="reset" name="Submit2" value="重执"  >
</form>

</body>
</html>
<script language="javascript">
 setid();
</script>