@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Projection View forZBUT0BK'
define view entity ZI_ZBUT0BKTP
  as projection on ZR_ZBUT0BKTP
{
  key Partner,
  key BkvID,
  Banks,
  Bankl,
  Bankn,
  Koinh,
  _ZBUT000 : redirected to parent ZI_ZBUT000TP
  
}
