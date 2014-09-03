Class GDemo.FetchPatientDataOperation Extends Ens.BusinessOperation
{

Parameter ADAPTER = "EnsLib.SQL.OutboundAdapter";

Property Adapter As EnsLib.SQL.OutboundAdapter;

Parameter INVOCATION = "InProc";

Method FetchPatientData(pRequest As Ens.StringRequest, Output pResponse As Ens.StringResponse) As %Status
{
	Set pResponse = ##class(Ens.StringResponse).%New()
	set id = pRequest.StringValue
	
	$$$TRACE("id="_id)
	set sql = "select * from Sample.Person where ID = (?)"
	#dim rs as EnsLib.SQL.Snapshot	
	set rs=##class(EnsLib.SQL.Snapshot).%New()
	do ..Adapter.ExecuteQuery(.rs,sql,id)
	$$$TRACE(rs)
	$$$TRACE("rs.RowCount="_rs.RowCount)
	set ddd=$lb(),rowCount=0
	$$$THROWONERROR(sc,rs.Next())
	set data = $lb()
	for i=1:1:rs.GetColumnCount() {
		set $list(data,i)=$lb(rs.GetColumnName(i),rs.GetData(i))
	}
	set result = ""
	for i=1:1:$listlength(data) {
		set $piece(result,"~",i)=$listtostring( $list( data,i ),"=" )
	}
	$$$TRACE(result)
	
	set pResponse.StringValue = result
	Quit pResponse
}

XData MessageMap
{
<MapItems>
	<MapItem MessageType="Ens.StringRequest"> 
		<Method>FetchPatientData</Method>
	</MapItem>
</MapItems>
}

}

