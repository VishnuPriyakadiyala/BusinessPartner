@AccessControl.authorizationCheck: #CHECK
@Metadata.allowExtensions: true
@EndUserText.label: 'CDS View forZBUT0ID'
define view entity ZR_ZBUT0IDTP
  as select from ZBUT0ID
  association to parent ZR_ZBUT000TP as _ZBUT000 on $projection.Partner = _ZBUT000.Partner
{
  key PARTNER as Partner,
  key TYPE as Type,
  key IDNUMBER as Idnumber,
  VALID_TO as ValidTo,
  VALID_FROM as ValidFrom,
  _ZBUT000
  
}
