report 50166 "Recover Loans From Savings"
{
    ProcessingOnly = true;

    dataset
    {
        dataitem(Loans; Loans)
        {
            DataItemTableView = where("Outstanding Principal" = filter(> 0));
            RequestFilterFields = "Loan No.";


            trigger OnAfterGetRecord()
            var
                UserSetup: Record "User Setup";
            begin
                CurrentRecordNo += 1;
                dWindow.Update(2, CurrentRecordNo);
                dWindow.Update(3, NoOfRecords);
                dWindow.Update(1, ROUND(CurrentRecordNo / NoOfRecords * 10000, 1));

                //ProductSetup.GET(Loans."Loan Product Type");


                if Loans."Disbursement Account No" = '' then begin

                    SavingsAccounts.Reset;
                    SavingsAccounts.SetRange("Member No.", Loans."Member No.");
                    SavingsAccounts.SetRange("Product Category", SavingsAccounts."product category"::"Ordinary Savings");
                    if (SavingsAccounts.FindFirst) then begin
                        Loans."Disbursement Account No" := SavingsAccounts."No.";
                        Loans.Modify();
                    end;
                end;

                SaccoActivities.RecoverLoanFromSavingsAccounts(Loans."Loan No.", Loans."Loan Product Type", true, false, UserSetup."Dimension Set ID");
            end;

            trigger OnPostDataItem()
            begin
                dWindow.Close;
            end;

            trigger OnPreDataItem()
            begin

                if Category = Category::"Defaulted Loans" then
                    Loans.SetFilter("Loans Category-SACCO", '%1|%2|%3', Loans."Loans Category-SACCO"::Substandard, Loans."Loans Category-SACCO"::Doubtful, Loans."Loans Category-SACCO"::Loss);

                dWindow.Open('Generating Schedules:     @1@@@@@@@@@\'
                                            + 'Counter   #2#########'
                                            + 'Total     #3#########'
                                            + 'Press Esc to abort');

                NoOfRecords := Loans.Count;
            end;
        }
    }

    requestpage
    {


        layout
        {
            area(content)
            {
                group(Options)
                {
                    Caption = 'Options';
                    field(Category; Category)
                    {
                        ApplicationArea = Basic;
                    }
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
        LoansCaptionLbl: label 'Loans';
        CurrReport_PAGENOCaptionLbl: label 'Page';
        VarienceCaptionLbl: label 'Varience';
        Text001: label 'Document No. Must be equal to No.';
        GeneratesuccMSG: label 'Interest Posted Successfully';
        AlreadyPostedErr: label 'This transaction Has already been posted';
        NoTemplateErr: label 'Ensure the Bills Template is set up in banking setup';
        NoBatchErr: label 'Ensure the Bills Batch is set up in the banking setup';
        SaccoActivities: Codeunit "Sacco Activities";
        dWindow: Dialog;
        NoOfRecords: Integer;
        CurrentRecordNo: Integer;
        Updated: Boolean;
        ProductSetup: Record "Product Setup";
        SavingsAccounts: Record "Savings Accounts";

        Category: Option "Defaulted Loans","All Loans";
}

