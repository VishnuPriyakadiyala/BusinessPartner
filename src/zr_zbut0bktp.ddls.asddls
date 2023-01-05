@AccessControl.authorizationCheck: #CHECK
@Metadata.allowExtensions: true
@EndUserText.label: 'CDS View forZBUT0BK'
define view entity ZR_ZBUT0BKTP
  as select from ZBUT0BK
  association to parent ZR_ZBUT000TP as _ZBUT000 on $projection.Partner = _ZBUT000.Partner
{
  key PARTNER as Partner,
  key BKVID as BkvID,
  BANKS as Banks,
  BANKL as Bankl,
  BANKN as Bankn,
  KOINH as Koinh,
  _ZBUT000
  
}
