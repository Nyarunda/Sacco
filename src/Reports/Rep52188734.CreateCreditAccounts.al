report 50397 "Create Credit Accounts"
{
    ApplicationArea = All;
    Caption = 'Create Credit Accounts';
    UsageCategory = ReportsAndAnalysis;
    DefaultLayout = RDLC;
    RDLCLayout = './src/Layouts/Create Credit Accounts.rdlc';

    dataset
    {
        dataitem(Members; Members)
        {
            column(ReportForNavId_1; 1)
            {
            }
            dataitem(Loans; Loans)
            {
                DataItemLink = "Member No." = field("No.");

                trigger OnAfterGetRecord()
                begin
                    Acc := '';
                    Acc := SaccoActivities.CreateCreditAccount(Loans); //Create Loan Credit Account
                    Loans."Loan Account" := Acc;
                    Loans.Modify();
                end;
            }
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
        ProductSetup: Record "Product Setup";
        SaccoActivities: Codeunit "Sacco Activities";
        Acc: Code[20];
}

