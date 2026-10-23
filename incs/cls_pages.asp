<%
Class Record09
	Private nCurrSize,nRecCount,nPageCount,nPageSize,nCurrPage,sPageSign
	Private sNavFormat,bForm,sFields,sFieldNames
	Private oConn,oRs,sSql,bRsEmpty
	Private Sub Class_initialize
		nPageSize=20
		sPageSign="pageNo"
		bForm=False
		sNavFormat=""
		bRsEmpty=False
	End Sub
	Public Property Set Connection(ByRef o_Conn)
		Set oConn=o_Conn
	End Property
	Public Property Set RecordSet(ByRef o_Rs)
		Set oRs=o_Rs
	End Property
	Public Property Let PageSize(ByVal n_PageSize)
		If Not isNumeric(n_PageSize) Then Exit Property
		If 0 > n_PageSize Then Exit Property
		nPageSize=n_PageSize
	End Property
	Public property Let PageSign(Byval s_PageSign)
		sPageSign=s_PageSign
	End Property
	Public Property Let SQL(ByVal s_SQL)
		sSql=s_SQL
	End Property
	Public Property Let Form(ByVal b_Form)
		bForm=Cbool(b_Form)
	End Property
	Public Property Let Format(ByVal s_Format)
		sNavFormat=s_Format
	End Property
	Public Property Get PageSize
		PageSize=nPageSize
	End Property
	Public Property Get CurrSize
		CurrSize=nCurrSize
	End Property
	Public Property Get RecordCount
		RecordCount=nRecCount
	End Property
	Public Property Get PageCount
		PageCount=nPageCount
	End Property
	Public Property Get CurrPage
		CurrPage=nCurrPage
	End Property
	Public Property Get EOF
		EOF=bRsEmpty
	End Property
	Public Property Get Fields
		Fields=sFieldNames
	End Property
	Public Sub OpenX(ByVal s_SQL,ByVal n_PageSize)
		nPageSize=n_PageSize : sSql=s_SQL : Open
	End Sub
	Public Sub Open
		CheckInit
		oRs.Open sSql,oConn,1,1
		nRecCount=oRs.RecordCount
		oRs.PageSize=nPageSize
		nPageCount=oRs.PageCount
		nCurrPage=FixNum(Trim(Request(sPageSign)),1,nPageCount)
		If nCurrPage=nPageCount Then
			nCurrSize=(nRecCount mod nPageSize)
		Else
			nCurrSize=nPageSize
		End If
		If not oRs.Eof Then
			oRs.AbsolutePage=nCurrPage
			Dim nPoint:For nPoint=0 To oRs.Fields.Count-1
				If nPoint<>0 Then sFieldNames=sFieldNames&","
				sFieldNames=sFieldNames&oRs(nPoint).name
			Next
		Else
			bRsEmpty=True
			nCurrSize=-1
			oRs.Close
		End If
	End Sub
	Public Sub Scroll : Response.Write NavStr : End Sub
	Public Sub pagestr : call NavStr : End Sub
	Public Sub PrintDSO(s_Format) : Response.Write DSO(s_Format) : End Sub
	Public Sub PrintXML : Response.Write XML : End Sub
	Public Function NavStr
		Dim sNavExts:sNavExts=Cstr(Request.ServerVariables("QUERY_STRING"))
		If bForm And Cstr(Request.Form)<>"" Then sNavExts=sNavExts&"&"&Request.Form
		Dim regEx:Set regEx=new RegExp
		If sNavExts<>"" Then
			regEx.Pattern="(&)?"&sPageSign&"=\d*"
			regEx.IgnoreCase=True
			regEx.Global=True
			sNavExts=regEx.Replace(sNavExts,"")
		End If
		If Left(sNavExts,1)<>"&" Then sNavExts="&"&sNavExts
		If Right(sNavExts,1)="&" Then sNavExts=Left(sNavExts,Len(sNavExts)-1)
		If sNavFormat="" Then sNavFormat="<nobr>共$n1条记录，$n4条/页 $a1<font face=webdings "&_ 	
				"style='font-size:12pt'>9</font>$ae$a2<font face=webdings style='font-size:12pt'>"&_
				"7</font>$ae $n3/$n2 $a3<font face=webdings style='font-size:12pt'>8<"&_
				"/font>$ae$a4<font face=webdings style='font-size:12pt'>:</font>$ae $x2"&_ 
				"</nobr>"
		'End If
		Dim Xa1,Xa2,Xa3,Xa4,Xx1,Xx2,nPoint
		Xa1="<a href=""?"&sPageSign&"=1"&sNavExts&""">"
		Xa2="<a href=?"&sPageSign&"="&(nCurrPage-1)&sNavExts&">"
		Xa3="<a href=?"&sPageSign&"="&(nCurrPage+1)&sNavExts&">"
		Xa4="<a href=?"&sPageSign&"="&nPageCount&sNavExts&">"
		If nCurrPage<2 Then Xa1="":Xa2=""'<a><a>
		If nCurrPage=nPageCount Then Xa3="<a>":Xa4=""'<a><a>
		Xx1="<select style='font-family:verdana' onchange=""window.location='?"&sPageSign&"="&_
			"'+this.value+'"&sNavExts&"';""><option value="""">↑转到↓</option>"
		For nPoint=1 To nPageCount
			Xx1=Xx1&"<option value="""&nPoint&""">第 "&nPoint&" 页</option>"
		Next
		Xx1=Xx1&"</select>"
		Xx2="<span><input type=""text"" style=""width:40px"" /><input type=button value=""转到"" "&_
			"onclick=""window.location='?"&sPageSign&"='+"&_
			"this.parentNode.children[0].value+'"&sNavExts&"'"" /></span>"
		sNavFormat=Replace(sNavFormat,"$n1",nRecCount)
		sNavFormat=Replace(sNavFormat,"$n2",nPageCount)
		sNavFormat=Replace(sNavFormat,"$n3",nCurrPage)
		sNavFormat=Replace(sNavFormat,"$n4",nPageSize)
		sNavFormat=Replace(sNavFormat,"$a1",Xa1)
		sNavFormat=Replace(sNavFormat,"$a2",Xa2)
		sNavFormat=Replace(sNavFormat,"$a3",Xa3)
		sNavFormat=Replace(sNavFormat,"$a4",Xa4)
		sNavFormat=Replace(sNavFormat,"$ae","</a>")
		sNavFormat=Replace(sNavFormat,"$x1",Xx1)
		sNavFormat=Replace(sNavFormat,"$x2",Xx2)
		If instr(sNavFormat,"$z")<>0 Then
			Dim SpaceLen,SpaceStr,SpacePoint
			If Not bRsEmpty Then
				regEx.Pattern="(.*\$z)(\d*)(.*)"
				regEx.IgnoreCase=False
				regEx.Global=False
				SpaceLen=regEx.Replace(sNavFormat,"$2")
				If SpaceLen="" Then : SpaceLen=5 : Else :SpaceLen=Cint(SpaceLen)
				If nCurrPage Mod SpaceLen = 0 Then
					SpacePoint=nCurrPage-SpaceLen
				Else
					SpacePoint=Abs(nCurrPage-(nCurrPage Mod SpaceLen))
				End If
				'Response.Write nCurrPage
				For nPoint=SpacePoint To (SpacePoint+SpaceLen+1)
					If nPoint>nPageCount Then Exit For
					If nPoint=0 Then nPoint=1
					if nPoint = nCurrPage then
					SpaceStr=SpaceStr&"<span class=""current"">"&nPoint&"</span>&nbsp;"
					else
					SpaceStr=SpaceStr&"<a href=""?"&sPageSign&"="&nPoint&sNavExts&""" class=ls>"&nPoint&"</a>&nbsp;"
					end if
				Next
			Else
				SpaceStr=""
			End If
			regEx.Pattern="\$z(\d*)"
			regEx.IgnoreCase=False
			regEx.Global=True
			sNavFormat=regEx.Replace(sNavFormat,SpaceStr)
		End If
		NavStr=sNavFormat
	End Function
	Public Function DataClass
		If bRsEmpty Then DataClass=Array():Exit Function
		oRs.AbsolutePosition=(nCurrPage-1)*nPageSize+1
		Dim rsArray(),nPoint
		nPoint=0
		Do while Not oRs.Eof And nPoint<nPageSize
			Redim Preserve rsArray(nPoint)
			Set rsArray(nPoint)=AsObject
			nPoint=nPoint+1
			oRs.MoveNext
		Loop
		DataClass=rsArray
	End Function
	Public Function DataRow
		If bRsEmpty Then Dim ErrArr(0,0):DataRow=ErrArr:Exit Function
		oRs.AbsolutePosition=(nCurrPage-1)*nPageSize+1
		DataRow=oRs.GetRows(nPageSize)
	End Function
	Public Function DSO(ByVal s_Format)
		If bRsEmpty Then Exit Function
		oRs.AbsolutePosition=(nCurrPage-1)*nPageSize+1
		If s_Format="" Then DSO=TableDSO:Exit Function
		Dim nPoint,nPoin_,sResult,sResul_
		nPoint=0
		Do while Not oRs.Eof And nPoint<nPageSize
			sResul_=s_Format
			For nPoin_=0 To oRs.Fields.Count-1
				sResul_=Replace(sResul_,"$"&Lcase(oRs(nPoin_).name),oRs(nPoin_).value&"")
				sResul_=Replace(sResul_,"$"&nPoin_,oRs(nPoin_).value&"")
			Next
			sResult=sResult&sResul_
			nPoint=nPoint+1
			oRs.MoveNext
		Loop
		DSO=sResult
	End Function
	Public Function XML
		If bRsEmpty Then Exit Function
		oRs.AbsolutePosition=(nCurrPage-1)*nPageSize+1
		Dim nPoint,sResult,aFieldsType,sFieldsType,aFieldsName,sFieldsName
		sResult="<rows sign=""ScriptLibrary.Record06"">"&chr(10)
		Redim aFieldsType(oRs.Fields.Count-1)
		Redim aFieldsName(oRs.Fields.Count-1)
		For nPoint=0 To oRs.Fields.Count-1
			aFieldsType(nPoint)=oRs.Fields(nPoint).Type
			If Lcase(oRs.Fields(nPoint).Name)="rows" Then
				aFieldsName(nPoint)="rowsX"
			ElseIf Lcase(oRs.Fields(nPoint).Name)="row" Then
				aFieldsName(nPoint)="rowX"
			Else
				aFieldsName(nPoint)=Lcase(oRs.Fields(nPoint).Name)
			End If
		Next
		nPoint=0:Dim nPoin_
		Do while Not oRs.Eof And nPoint<nPageSize
			sResult=sResult&"<row>"&chr(10)
			For nPoin_=0 To oRs.Fields.Count-1
				sFieldsType=aFieldsType(nPoin_)
				sFieldsName=aFieldsName(nPoin_)
				sResult=sResult&"<"&sFieldsName&">"
				If (1<sFieldsType and sFieldsType<8) Or sFieldsType=11 Then
					sResult=sResult&oRs(nPoin_).Value
				Else
					sResult=sResult&"<![CDATA["&oRs(nPoin_).Value&"]]>"
				End If
				sResult=sResult&"</"&sFieldsName&">"&chr(10)
			Next
			sResult=sResult&"</row>"&chr(10)
			nPoint=nPoint+1
			oRs.MoveNext
		Loop
		sResult=sResult&"</rows>"
		XML=sResult
	End Function
	Public Function OBJ : Set OBJ=oRs : End Function
	Public Function Close
		If bRsEmpty Then Exit Function
		oRs.Close
		Set oRs=Nothing
		Close=True
	End Function
	Private Function TableDSO
		Dim sResult,nPoint,nPoin_
		sResult="<table sign=""ScriptLibrary.Record06""><tr>"
		For nPoint=0 To oRs.Fields.Count-1
			sResult=sResult&"<td>"&oRs(nPoint).name&"</td>"
		Next
		sResult=sResult&"</tr>"
		nPoin_=0
		Do while Not oRs.Eof And nPoin_<nPageSize
			sResult=sResult&"<tr>"
			For nPoint=0 To oRs.Fields.Count-1
				sResult=sResult&"<td>"&oRs(nPoint).value&"</td>"
			Next
			sResult=sResult&"</tr>"
			nPoin_=nPoin_+1
			oRs.MoveNext
		Loop
		sResult=sResult&"</table>"
		TableDSO=sResult
	End Function
	Private Function AsObject
		Dim objectName,strObject,nPoint
		objectName="RSObject"
		strObject="Class "&objectName&chr(10)&"Public "&sFieldNames&chr(10)&"End Class"
		Execute strObject
		Execute "Set AsObject=new "&objectName
		If Not oRs.Eof Then
			For nPoint=0 To oRs.Fields.Count-1
				Execute "AsObject."&oRs(nPoint).name&"=oRs(nPoint).value"
			Next
		End If
	End Function
	Private Function CheckInit
		If isEmpty(oConn) Then
			If lcase(typeName(myConn))="connection" Then
				Set oConn=myConn
			Else
				Response.Write "错误：请指定Connect对象，ScriptLibrary.Record06-0001"
				Response.End
			End If
		End If
		If lcase(typeName(oRs))<>"recordset" Then
			Set oRs=Server.CreateObject("ADODB.RecordSet")
		End If
	End Function
	Private Function FixNum(ByVal iNum,ByVal iMin,ByVal iMax)  
        If IsNumeric(iNum) Then
            FixNum=Clng(iNum)
        Else
            FixNum=iMin
        End If
        If iMax>-1 Then
            If FixNum<iMin Then FixNum=iMin
            If FixNum>iMax Then FixNum=iMax 	 
        End If  
    End Function
End Class
%> 
