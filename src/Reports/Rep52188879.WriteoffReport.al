report 50581 "Write-off Report"
{
    Caption = 'Write-off Report';
    DefaultLayout = RDLC;
    RDLCLayout = './src/Layouts/Write-off.rdlc';
    dataset
    {
        dataitem(Writeoffs; "Write offs")
        {
            RequestFilterFields = "Date Posted";

            column(Depostis; Depostis)
            {
            }
            column(FIleComments; "FIle Comments")
            {
            }
            column(InterestBalance; "Interest Balance")
            {
            }
            column(LoanInterestAmount; "Loan + Interest Amount")
            {
            }
            column(LoanBalance; "Loan Balance")
            {
            }
            column(OldMemberNo; "Old Member No")
            {
            }
            column(Member_Name; "Member Name")
            {
            }
            column(ShareCapital; "Share Capital")
            {
            }

            column(TotalShareAmount; "Total Share Amount")
            {
            }
            column(TotalWriteOffAmount; "Total Write Off Amount")
            {
            }
            column(UnpaidDividend; "Unpaid Dividend")
            {
            }
            column(WriteOffNo; "Write Off No")
            {
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
