@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Projection View forZBUT0ID'
define view entity ZI_ZBUT0IDTP
  as projection on ZR_ZBUT0IDTP
{
  key Partner,
  key Type,
  key Idnumber,
  ValidTo,
  ValidFrom,
  _ZBUT000 : redirected to parent ZI_ZBUT000TP
  
}
