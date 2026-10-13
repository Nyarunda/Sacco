xmlport 51002 "UPG_Member Balances"
{
    Caption = 'UPG_Member Balances';
    Format = VariableText;
    schema
    {
        textelement(RootNodeName)
        {
            tableelement(UPG_MemberBalances; "UPG_Member Balances")
            {
                fieldelement(No; UPG_MemberBalances."No.")
                {
                }
                fieldelement(Name; UPG_MemberBalances."FOSA Shares")
                {
                }
                /*
                fieldelement(MonthlyContribution; UPG_MemberBalances."Monthly Contribution")
                {
                }
                fieldelement(MonthlyHousingContribution; UPG_MemberBalances." Monthly Housing Contribution")
                {
                }
                fieldelement(MonthlySFeesContribution; UPG_MemberBalances."Monthly SFees Contribution")
                {
                }
                fieldelement(MonthlyHolidayContribution; UPG_MemberBalances."Monthly Holiday Contribution")
                {
                }
                fieldelement(SharesRetained; UPG_MemberBalances."Shares Retained")
                {
                }
                fieldelement(CurrentShares; UPG_MemberBalances."Current Shares")
                {
                }
                fieldelement(SchoolFees; UPG_MemberBalances." School Fees")
                {
                }
                fieldelement(Holiday; UPG_MemberBalances.Holiday)
                {
                }
                fieldelement(Housing; UPG_MemberBalances.Housing)
                {
                }
                fieldelement(Retirement; UPG_MemberBalances.Retirement)
                {
                }
                fieldelement(LoanSettlementAccount; UPG_MemberBalances."Loan Settlement Account")
                {
                }
                fieldelement(NS; UPG_MemberBalances."FOSA Shares")
                {
                }
                fieldelement(UnallocatedFunds; UPG_MemberBalances."Un-allocated Funds")
                {
                }
                fieldelement(DividendAmount; UPG_MemberBalances."Dividend Amount")
                {
                }
                fieldelement(InterestOnDeposits; UPG_MemberBalances."Interest On Deposits")
                {
                }
                fieldelement(RegistrationFeePaid; UPG_MemberBalances."Registration Fee Paid")
                {
                }
                fieldelement(RecruitmentComissionAmount; UPG_MemberBalances."Recruitment Comission Amount")
                {
                }
                */
            }
        }
    }
    requestpage
    {
        layout
        {
            area(content)
            {
                group(GroupName)
                {
                }
            }
        }
        actions
        {
            area(processing)
            {
            }
        }
    }
}
