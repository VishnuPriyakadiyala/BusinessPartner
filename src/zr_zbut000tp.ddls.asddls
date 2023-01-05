@AccessControl.authorizationCheck: #CHECK
@Metadata.allowExtensions: true
@EndUserText.label: 'CDS View forZBUT000'
define root view entity ZR_ZBUT000TP
  as select from zbut000
  composition [0..*] of ZR_ZBUT0BKTP as _ZBUT0BK
  composition [0..*] of ZR_ZBUT0IDTP as _ZBUT0ID
{
  key partner as Partner,
  type as Type,
  bpkind as Bpkind,
  bu_group as BuGroup,
  bpext as Bpext,
  bu_sort1 as BuSort1,
  bu_sort2 as BuSort2,
  source as Source,
  title as Title,
  xdele as Xdele,
  xblck as Xblck,
  augrp as Augrp,
  rate as Rate,
  name_org1 as NameOrg1,
  name_org2 as NameOrg2,
  name_org3 as NameOrg3,
  name_org4 as NameOrg4,
  legal_enty as LegalEnty,
  ind_sector as IndSector,
  legal_org as LegalOrg,
  found_dat as FoundDat,
  liquid_dat as LiquidDat,
  location_1 as Location1,
  location_2 as Location2,
  location_3 as Location3,
  name_last as NameLast,
  name_first as NameFirst,
  name_lst2 as NameLst2,
  name_last2 as NameLast2,
  namemiddle as Namemiddle,
  title_aca1 as TitleAca1,
  title_aca2 as TitleAca2,
  title_royl as TitleRoyl,
  prefix1 as Prefix1,
  prefix2 as Prefix2,
  name1_text as Name1Text,
  nickname as Nickname,
  initials as Initials,
  nameformat as Nameformat,
  namcountry as Namcountry,
  langu_corr as LanguCorr,
  birthdt as Birthdt,
  deathdt as Deathdt,
  perno as Perno,
  children as Children,
  mem_house as MemHouse,
  partgrptyp as Partgrptyp,
  @Semantics.user.createdBy: true
  crusr as Crusr,
  @Semantics.systemDateTime.createdAt: true
  crdat as Crdat,
  crtim as Crtim,
  @Semantics.user.lastChangedBy: true
  chusr as Chusr,
  @Semantics.systemDateTime.lastChangedAt: true
  chdat as Chdat,
  chtim as Chtim,
  partner_guid as PartnerGuID,
  addrcomm as Addrcomm,
  _ZBUT0BK,
  _ZBUT0ID
  
}
