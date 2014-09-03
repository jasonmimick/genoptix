Class GDemo.SQLSnapShotToORU Extends Ens.DataTransformDTL [ DependsOn = (EnsLib.SQL.Snapshot, EnsLib.HL7.Message) ]
{

Parameter IGNOREMISSINGSOURCE = 1;

Parameter REPORTERRORS = 1;

XData DTL [ XMLNamespace = "http://www.intersystems.com/dtl" ]
{
<transform sourceClass='EnsLib.SQL.Snapshot' targetClass='EnsLib.HL7.Message' targetDocType='2.5:ORU_R01' create='existing' language='objectscript' >
<if condition='source.Next()' >
<true>
<trace value='source.Get("Name")' />
<assign value='source.Get("Name")' property='name' action='set' />
<assign value='..Piece(name)' property='target.{PIDgrpgrp(1).PIDgrp.PID:PatientName(1).FamilyName}' action='set' />
<assign value='..Piece(..Piece(name,,2)," ",1)' property='target.{PIDgrpgrp(1).PIDgrp.PID:PatientName(1).GivenName}' action='set' />
</true>
</if>
</transform>
}

}

