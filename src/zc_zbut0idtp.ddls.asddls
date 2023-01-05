@AccessControl.authorizationCheck: #CHECK
@Metadata.allowExtensions: true
@EndUserText.label: 'Projection View forZBUT0ID'
@ObjectModel.semanticKey: [ 'Type' ]
@Search.searchable: true
define view entity ZC_ZBUT0IDTP
  as projection on ZR_ZBUT0IDTP
{
  @Search.defaultSearchElement: true
  @Search.fuzzinessThreshold: 0.90 
  key Partner,
  @Search.defaultSearchElement: true
  @Search.fuzzinessThreshold: 0.90 
  key Type,
  @Search.defaultSearchElement: true
  @Search.fuzzinessThreshold: 0.90 
  key Idnumber,
  ValidTo,
  ValidFrom,
  _ZBUT000 : redirected to parent ZC_ZBUT000TP
  
}
