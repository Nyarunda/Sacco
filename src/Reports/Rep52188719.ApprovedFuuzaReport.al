report 50382 "Approved Fuuza Report"
{
    Caption = 'Approved Fuuza Report';
    ApplicationArea = All;
    DefaultLayout = RDLC;
    RDLCLayout = './src/Layouts/Approved Fuuza Report.rdlc';
    UsageCategory = ReportsAndAnalysis;
    dataset
    {
        dataitem(Fuliza; Fuliza)
        {
            DataItemTableView = where(Status = const(Approved), Posted = const(true), Expired = const(false), "Virtual Balance (LCY)" = filter(< 0));

            column(No; "No.")
            {
            }
            column(AccountNo; "Account No.")
            {
            }
            column(AccountName; "Account Name")
            {
            }
            column(FOSA_Account; "FOSA Account")
            {
            }
            column(Product_Name; "Product Name")
            {
            }

            column(Accrued_Interest; "Accrued Interest")
            {
            }
            column(Virtual_Balance__LCY_; "Virtual Balance (LCY)")
            {
            }
            column(EffectiveStartDate; "Effective/Start Date")
            {
            }
            column(ExpiryDate; "Expiry Date")
            {
            }
            column(Duration; "Duration")
            {
            }
            column(Status; Status)
            {
            }
            column(Remarks; Remarks)
            {
            }
            column(ApprovedAmount; "Approved Amount")
            {
            }
            column(NoSeries; "No. Series")
            {
            }
            column(CreatedBy; "Created By")
            {
            }
            column(DateApproved; "Date Approved")
            {
            }
            column(TransactionType; "Transaction Type")
            {
            }
            column(Liquidated; Liquidated)
            {
            }
            column(DateLiquidated; "Date Liquidated")
            {
            }
            column(LiquidatedBy; "Liquidated By")
            {
            }
            column(Posted; Posted)
            {
            }
            column(ResponsibilityCenter; "Responsibility Center")
            {
            }
            column(GlobalDimension1Code; "Global Dimension 1 Code")
            {
            }
            column(ApprovedBy; "Approved By")
            {
            }
            column(CanceledBy; "Canceled By")
            {
            }
            column(FuuzaMonthlyInterest; "Fuuza Monthly Interest %")
            {
            }
            column(GlobalDimension2Code; "Global Dimension 2 Code")
            {
            }
            column(ApplicationDate; "Application Date")
            {
            }
            column(ProductType; "Product Type")
            {
            }
            column(Issueto; "Issue to")
            {
            }
            column(RequestedAmount; "Requested Amount")
            {
            }
            column(Expired; Expired)
            {
            }
            column(AvailableBalance; "Available Balance")
            {
            }
            column(RecommendedBy; "Recommended By")
            {
            }
            column(MemberNo; "Member No.")
            {
            }
            column(FOSAAccount; "FOSA Account")
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
