Class GDemo.HTTPMessageToHL7 Extends Ens.DataTransformDTL [ DependsOn = (EnsLib.HTTP.GenericMessage, EnsLib.HL7.Message) ]
{

Parameter IGNOREMISSINGSOURCE = 1;

Parameter REPORTERRORS = 1;

XData DTL [ XMLNamespace = "http://www.intersystems.com/dtl" ]
{
<transform sourceClass='EnsLib.HTTP.GenericMessage' targetClass='EnsLib.HL7.Message' targetDocType='2.5:ORU_R01' create='new' language='objectscript' >
<assign value='"ORU"' property='target.{MSH:MessageType.MessageCode}' action='set' />
<assign value='"R01"' property='target.{MSH:MessageType.TriggerEvent}' action='set' />
<assign value='..CurrentDateTime()' property='target.{MSH:DateTimeOfMessage}' action='set' />
<assign value='##class(EnsUtils.Rule.FunctionSet).BLOBToBase64RFC2045MIMELines(source.Stream)' property='b64' action='set' />
<assign value='1' property='target.{PIDgrpgrp(1).PIDgrp.PID:SetIDPID}' action='set' />
<foreach property='b64' key='li' >
<assign value='li' property='target.{PIDgrpgrp(1).ORCgrp(1).OBXgrp(li).OBX:SetIDOBX}' action='set' />
<assign value='b64.GetAt(li)' property='target.{PIDgrpgrp(1).ORCgrp(1).OBXgrp(li).OBX:ObservationValue(1)}' action='set' />
</foreach>
</transform>
}

}

