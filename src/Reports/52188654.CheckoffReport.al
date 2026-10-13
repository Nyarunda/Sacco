report 50317 " Monthly Checkoff Report"
{
    ApplicationArea = All;
    Caption = 'Checkoff Report';
    UsageCategory = ReportsAndAnalysis;
    DefaultLayout = RDLC;
    RDLCLayout = './src/Layouts/Monthly Checkoff Report.rdlc';
    dataset
    {
        dataitem(MonthlyCheckoffHeader; "Monthly Checkoff Header")
        {
            column(AccountName; "Account Name")
            {
            }
            column(AccountNo; "Account No.")
            {
            }
            column(AccountType; "Account Type")
            {
            }
            column(Amount; Amount)
            {
            }
            column(AmountAlreadyPosted; "Amount Already Posted")
            {
            }
            column(AmountPending; "Amount Pending")
            {
            }
            column(BatchEntries; "Batch Entries")
            {
            }
            column(CHKBufferAmount; "CHK Buffer Amount")
            {
            }
            column(CHKLineAmount; "CHK Line Amount")
            {
            }
            column(CapturedBy; "Captured By")
            {
            }
            column(DateEntered; "Date Entered")
            {
            }
            column(Description; Description)
            {
            }
            column(DocumentNo; "Document No.")
            {
            }
            column(EmployerCode; "Employer Code")
            {
            }
            column(EmployerName; "Employer Name")
            {
            }
            column(EnteredBy; "Entered By")
            {
            }
            column(GlobalDimension1Code; "Global Dimension 1 Code")
            {
            }
            column(GlobalDimension2Code; "Global Dimension 2 Code")
            {
            }
            column(Loan; Loan)
            {
            }
            column(No; "No.")
            {
            }
            column(NoOfBatches; "No. Of Batches")
            {
            }
            column(NoSeries; "No. Series")
            {
            }
            column(Posted; Posted)
            {
            }
            column(PostedRecords; "Posted Records")
            {
            }
            column(PostingDate; "Posting Date")
            {
            }
            column(ReceiptAmount; "Receipt Amount")
            {
            }
            column(ReceiptNo; "Receipt No.")
            {
            }
            column(Reversed; Reversed)
            {
            }
            column(Status; Status)
            {
            }
            column(SystemCreatedAt; SystemCreatedAt)
            {
            }
            column(SystemCreatedBy; SystemCreatedBy)
            {
            }
            column(SystemId; SystemId)
            {
            }
            column(SystemModifiedAt; SystemModifiedAt)
            {
            }
            column(SystemModifiedBy; SystemModifiedBy)
            {
            }
            column(TimeEntered; "Time Entered")
            {
            }
            column(TotalCount; "Total Count")
            {
            }
            column(TotalInterest; "Total Interest")
            {
            }
            column(TotalLoan; "Total Loan")
            {
            }
            column(TotalPrincipal; "Total Principal")
            {
            }
            column(TotalSavings; "Total Savings")
            {
            }
            column(VendorNo; "Vendor No")
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
