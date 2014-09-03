/// 
Class GDemo.ORUProcess Extends Ens.BusinessProcessBPL
{

/// BPL Definition
XData BPL [ XMLNamespace = "http://www.intersystems.com/bpl" ]
{
<process language='objectscript' request='EnsLib.HTTP.GenericMessage' response='EnsLib.HTTP.GenericMessage' height='2000' width='2000' >
<context>
<property name='rs' type='%GlobalBinaryStream' instantiate='1' >
</property>
<property name='patientId' type='%String' instantiate='0' >
<parameters>
<parameter name='MAXLEN'  value='50' />
</parameters>
</property>
<property name='patientData' type='%String' instantiate='0' >
<parameters>
<parameter name='MAXLEN'  value='10000' />
</parameters>
</property>
<property name='obxMessage' type='EnsLib.HL7.Message' instantiate='1' >
</property>
<property name='patientDataSnapshot' type='EnsLib.SQL.Snapshot' instantiate='1' >
</property>
</context>
<sequence xend='200' yend='1050' >
<assign name="Get patientId from URL" property="context.patientId" value="$piece(request.HTTPHeaders.GetAt(&quot;URL&quot;),&quot;/&quot;,*)" action="set" xpos='200' ypos='250' />
<trace name='patientId' value='"context.patientId="_context.patientId' xpos='200' ypos='350' />
<call name='Call SQL' target='EnsUtils.SQL.SQLGatewayOperation' async='0' xpos='200' ypos='450' >
<request type='EnsUtils.ListOfDataTypeRequest' >
<assign property="callrequest.Data" value="context.patientId" action="insert" key="1" />
</request>
<response type='EnsUtils.SQL.SQLGatewayResponse' >
<assign property="context.patientDataSnapshot" value="callresponse" action="set" />
</response>
</call>
<transform name='Build OBX from PDF' class='GDemo.HTTPMessageToHL7' source='request' target='context.obxMessage' xpos='200' ypos='550' />
<transform name='Add patient data from SQL' class='GDemo.SQLSnapShotToORU' source='context.patientDataSnapshot' target='context.obxMessage' xpos='200' ypos='650' />
<trace name='obxMessage' value='context.obxMessage.RawContent' xpos='200' ypos='750' />
<assign name="Build Response" property="response.Stream" value="##class(%GlobalBinaryStream).%New()" action="set" xpos='200' ypos='850' />
<code name='write response' xpos='200' ypos='950' >
<![CDATA[ do response.Stream.Write(context.obxMessage.RawContent)
 //do response.Stream.Rewind()
 
 ]]>
</code>
</sequence>
</process>
}

<Storage name="Default">
<Type>%Library.CacheStorage</Type>
</Storage>
}

