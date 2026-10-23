<%
if session("admin")="" then
  response.redirect "admin_login.asp"
end if
%>