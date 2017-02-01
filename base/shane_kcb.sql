if object_id('[KenyaTestBenchmarking].[dbo].[b_kcb]', 'U') is not null drop table [KenyaTestBenchmarking].[dbo].[b_kcb]

select distinct

coalesce(ii.FullName, ci.CompanyName) as NAMES,
ii.NationalID as [ID NUMBER],
ci.RegistrationNumber as [REG NUMBER],
bbb.Name as [SUBSCRIBER NAME],
gg.Code as [GENDER],
[DateOfBirth/EstablishmentDate] as [D.O.B / ESTABLISHMENT],
ii.EmployerName as [EMPLOYER],
isnull(ii.MainAddress, ii.SecAddress) as [POSTAL ADD],
case when len(
(case when len(ii.MobilePhone)<9 then ii.FixedLine else ii.MobilePhone end) )<9 then ii.WorkPhone else (case when len(ii.MobilePhone)<9 then ii.FixedLine else ii.MobilePhone end) end
as [TELEPHONE NUMBERS],
isnull(ii.MainAddress, ii.SecAddress) as [PHYSICAL ADDRESS ],
ii.Email as [EMAIL],
a.ContractCode as [CONTRACT CODE],
a.CustomerCode as [CUSTOMER CODE],
bbbbb.Code as [PHASE OF CONTRACT],
cc.Code as [ACCOUNT STATUS],
bbbb.Code as [ACCOUNT PRODUCT TYPE],
ee.CurrencyCode as [CURRENCY],
[TotalAmount] as [ORIGINAL AMOUNT],
a.OutstandingAmount as [CURRENT BALANCE],
a.PastDueAmount as [OVERDUE BALANCE],
a.PastDueDays as [DAYS IN ARREAS],
e.[DateOfLastPayment] as [DATE OF LAST PAYMENT],
a.LastSnapshotDate as [LAST DATA UPDATE],
a.StartDate as [DATE ACCOUNT OPENED],
[ExpectedEndDate] as [EXPECTED END DATE ],
ns.Code as [NEGATIVE STATUS OF THE CONTRACT]

into [KenyaTestBenchmarking].[dbo].[b_kcb]

from [KenyaTestBenchmarking].[dbo].[b_cc_complete] a

left join [KenyaLiveMaster].[dbo].Subscriber bbb
on a.Subscriber=bbb.SubscriberId

left join [KenyaLiveBanking].[dbo].[Gender] gg
on a.[Gender]=gg.[GenderId]

left join [KenyaLiveBanking].[dbo].PhaseOfContract bbbbb
on a.[PhaseOfContract]=bbbbb.[PhaseOfContractId]

left join [KenyaLiveBanking].[dbo].ContractStatus cc
on a.ContractStatus=cc.ContractStatusId

left join [KenyaLiveBanking].[dbo].TypeOfContract bbbb
on a.[TypeOfContract]=bbbb.[TypeOfContractId]

left join [KenyaLiveBanking].[dbo].Currency ee
on a.TotalAmountCurrency= ee.CurrencyId

left join [KenyaLiveBanking].[dbo].[NegativeStatusOfContract] ns
on a.[NegativeStatusOfContract]=ns.[NegativeStatusOfContractId]

left join [KenyaLiveBanking].[dbo].[ContractDataUpdate] e
on a.[ContractDataUpdateVersionId]=e.[ContractDataUpdateVersionId]

left join [KenyaLiveSubjects].[dbo].[CurrentIndividual] ii
on a.CreditinfoId=ii.CreditinfoId

left join [KenyaLiveSubjects].[dbo].[CurrentCompany] ci
on a.CreditinfoId=ci.CreditinfoId


where a.Subscriber=33 and a.[PhaseOfContract]=1

--select top 1000 * from [KenyaTestBenchmarking].[dbo].[b_kcb]
