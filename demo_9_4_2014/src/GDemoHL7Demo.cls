Class GDemo.HL7Demo Extends Ens.Production
{

XData ProductionDefinition
{
<Production Name="GDemo.HL7Demo" TestingEnabled="true" LogGeneralTraceEvents="true">
  <Description></Description>
  <ActorPoolSize>2</ActorPoolSize>
  <Item Name="GDemo.FetchPatientDataOperation" Category="" ClassName="GDemo.FetchPatientDataOperation" PoolSize="1" Enabled="true" Foreground="false" Comment="" LogTraceEvents="true" Schedule="">
    <Setting Target="Adapter" Name="DSN">SamplesSQL</Setting>
    <Setting Target="Host" Name="ArchiveIO">1</Setting>
  </Item>
  <Item Name="EnsLib.HTTP.GenericService" Category="" ClassName="EnsLib.HTTP.GenericService" PoolSize="1" Enabled="true" Foreground="false" Comment="" LogTraceEvents="true" Schedule="">
    <Setting Target="Adapter" Name="Port">9919</Setting>
    <Setting Target="Host" Name="TargetConfigName">GDemo.ORUProcess</Setting>
    <Setting Target="Host" Name="ArchiveIO">1</Setting>
    <Setting Target="Host" Name="OneWay">0</Setting>
    <Setting Target="Host" Name="EnableStandardRequests">0</Setting>
  </Item>
  <Item Name="GDemo.ORUProcess" Category="" ClassName="GDemo.ORUProcess" PoolSize="0" Enabled="true" Foreground="false" Comment="" LogTraceEvents="true" Schedule="">
  </Item>
  <Item Name="EnsUtils.SQL.SQLGatewayOperation" Category="" ClassName="EnsUtils.SQL.SQLGatewayOperation" PoolSize="1" Enabled="true" Foreground="false" Comment="" LogTraceEvents="false" Schedule="">
    <Setting Target="Host" Name="SQL">select * from Sample.Person where ID = ?</Setting>
    <Setting Target="Adapter" Name="DSN">SamplesSQL</Setting>
  </Item>
</Production>
}

}

