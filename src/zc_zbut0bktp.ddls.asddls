@AccessControl.authorizationCheck: #CHECK
@Metadata.allowExtensions: true
@EndUserText.label: 'Projection View forZBUT0BK'
@ObjectModel.semanticKey: [ 'BkvID' ]
@Search.searchable: true
define view entity ZC_ZBUT0BKTP
  as projection on ZR_ZBUT0BKTP
{
  @Search.defaultSearchElement: true
  @Search.fuzzinessThreshold: 0.90 
  key Partner,
  @Search.defaultSearchElement: true
  @Search.fuzzinessThreshold: 0.90 
  key BkvID,
  Banks,
  Bankl,
  Bankn,
  Koinh,
  _ZBUT000 : redirected to parent ZC_ZBUT000TP
  
}
