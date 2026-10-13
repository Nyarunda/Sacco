Report 50265 "User profiling Report"
{
    DefaultLayout = RDLC;
    RDLCLayout = './src/Layouts/User profiling Report.rdlc';

    dataset
    {
        dataitem("Savings Ledger Entry"; "Savings Ledger Entry")
        {
            RequestFilterFields = "Account No.", "Posting Date", Amount, "User ID";
            column(ReportForNavId_1; 1)
            {
            }
            column(CompanyInfoName; CompanyInfo.Name)
            {
            }
            column(CompanyInfoPicture; CompanyInfo.Picture)
            {
            }
            column(MemberName_SavingsLedgerEntry; MName)
            {
            }
            column(MemberNo_SavingsLedgerEntry; "Savings Ledger Entry"."Member No.")
            {
            }
            column(UserID_SavingsLedgerEntry; "Savings Ledger Entry"."User ID")
            {
            }
            column(EntryNo_SavingsLedgerEntry; "Savings Ledger Entry"."Entry No.")
            {
            }
            column(CustomerNo_SavingsLedgerEntry; "Savings Ledger Entry"."Account No.")
            {
            }
            column(PostingDate_SavingsLedgerEntry; Format("Savings Ledger Entry"."Posting Date"))
            {
            }
            column(DocumentNo_SavingsLedgerEntry; "Savings Ledger Entry"."Document No.")
            {
            }
            column(Description_SavingsLedgerEntry; "Savings Ledger Entry".Description)
            {
            }
            column(Amount_SavingsLedgerEntry; "Savings Ledger Entry".Amount)
            {
            }
            column(Reversed_SavingsLedgerEntry; Rev)
            {
            }
            column(DebitAmount_SavingsLedgerEntry; "Savings Ledger Entry"."Debit Amount")
            {
            }
            column(CreditAmount_SavingsLedgerEntry; "Savings Ledger Entry"."Credit Amount")
            {
            }

            trigger OnAfterGetRecord()
            begin
                Rev := '';


                if Abs("Savings Ledger Entry".Amount) < Amt then
                    CurrReport.Skip;

                if "Savings Ledger Entry".Reversed then
                    Rev := 'Yes';


                MName := '';
                if Cust.Get("Savings Ledger Entry"."Member No.") then
                    MName := Cust.Name;
            end;

            trigger OnPreDataItem()
            begin
                CompanyInfo.Get;
                CompanyInfo.CalcFields(Picture);
            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                field(Amount; Amt)
                {
                    ApplicationArea = Basic;
                }
            }
        }

        actions
        {
        }
    }

    labels
    {
    }

    var
        Amt: Decimal;
        CompanyInfo: Record "Company Information";
        Rev: Text;
        Cust: Record Members;
        MName: Text;
}

