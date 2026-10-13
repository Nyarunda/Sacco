Report 50198 "Dividend progression Report"
{
    DefaultLayout = RDLC;
    RDLCLayout = './src/Layouts/Dividend progression list.rdlc';

    dataset
    {
        dataitem("Dividend Progressions List"; "Dividends Progression")
        {
            column(ReportForNavId_1; 1)
            {
            }
            column(MemberNo_DividendProgressionsList; "Dividend Progressions List"."Member No")
            {
            }
            column(Name_DividendProgressionsList; "Dividend Progressions List".Name)
            {
            }
            column(Shares_DividendProgressionsList; "Dividend Progressions List".Shares)
            {
            }
            column(QualifyingShares_DividendProgressionsList; "Dividend Progressions List"."Qualifying Shares")
            {
            }
            column(GrossInterest_DividendProgressionsList; "Dividend Progressions List"."Gross Dividends")
            {
            }
            column(WithholdingTaxInterest_DividendProgressionsList; "Dividend Progressions List"."Witholding Tax")
            {
            }
            column(NetInterest_DividendProgressionsList; "Dividend Progressions List"."Net Dividends")
            {
            }
            column(GrossDividend_DividendProgressionsList; "Dividend Progressions List"."Gross Dividends")
            {
            }
            column(WithholdingTaxDividend_DividendProgressionsList; "Dividend Progressions List"."Witholding Tax")
            {
            }
            column(NetDividend_DividendProgressionsList; "Dividend Progressions List"."Net Dividends")
            {
            }
            column(NetPay_DividendProgressionsList; "Dividend Progressions List"."Net Dividends")
            {
            }
            dataitem("Sacco General Set-Up"; "Sacco Setup")//UnknownTable50339;UnknownTable50339
            {
                column(ReportForNavId_10; 10)
                {
                }
                column(WithholdingTax_SaccoGeneralSetUp; "Sacco General Set-Up"."Dividend Processing Charge")//Withholding Tax (%)
                {
                }
                column(Dividend_SaccoGeneralSetUp; "Sacco General Set-Up"."Dividend Year Date")//Dividend (%)
                {
                }
                column(InterestonDeposits_SaccoGeneralSetUp; "Sacco General Set-Up"."Dividend Charge")//Interest on Deposits (%)
                {
                }
                column(memberName; memberName)
                {
                }
                column(NetPay; NetPay)
                {
                }
            }

            trigger OnAfterGetRecord()
            begin
                NetPay := "Dividend Progressions List"."Gross Dividends" + "Dividend Progressions List"."Net Dividends";//Was net interest + Net dividends
                memberList.Reset;
                memberList.SetRange("No.", "Dividend Progressions List"."Member No");//is it account number or entry number???
                if memberList.FindFirst then
                    memberName := memberList.Name;
            end;
        }
    }

    requestpage
    {

        layout
        {
        }

        actions
        {
        }
    }

    labels
    {
    }

    var
        memberList: Record "Member Accounts";
        memberName: Text;
        NetPay: Decimal;
        dividenlist: Record "Dividends Progression";
}

