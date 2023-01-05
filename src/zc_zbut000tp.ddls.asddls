@AccessControl.authorizationCheck: #CHECK
@Metadata.allowExtensions: true
@EndUserText.label: 'Projection View forZBUT000'
@ObjectModel.semanticKey: [ 'Partner' ]
@Search.searchable: true
define root view entity ZC_ZBUT000TP
  as projection on ZR_ZBUT000TP
{
  @Search.defaultSearchElement: true
  @Search.fuzzinessThreshold: 0.90 
  key Partner,
  Type,
  Bpkind,
  BuGroup,
  Bpext,
  BuSort1,
  BuSort2,
  Source,
  Title,
  Xdele,
  Xblck,
  Augrp,
  Rate,
  NameOrg1,
  NameOrg2,
  NameOrg3,
  NameOrg4,
  LegalEnty,
  IndSector,
  LegalOrg,
  FoundDat,
  LiquidDat,
  Location1,
  Location2,
  Location3,
  NameLast,
  NameFirst,
  NameLst2,
  NameLast2,
  Namemiddle,
  TitleAca1,
  TitleAca2,
  TitleRoyl,
  Prefix1,
  Prefix2,
  Name1Text,
  Nickname,
  Initials,
  Nameformat,
  Namcountry,
  LanguCorr,
  Birthdt,
  Deathdt,
  Perno,
  Children,
  MemHouse,
  Partgrptyp,
  Crusr,
  Crdat,
  Crtim,
  Chusr,
  Chdat,
  Chtim,
  PartnerGuID,
  Addrcomm,
  _ZBUT0BK : redirected to composition child ZC_ZBUT0BKTP,
  _ZBUT0ID : redirected to composition child ZC_ZBUT0IDTP
  
}
