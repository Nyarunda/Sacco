
Report 50141 "Insert Penalty Buffer-ent"
{
    DefaultLayout = RDLC;
    RDLCLayout = './src/Layouts/Insert Penalty Buffer-ent.rdlc';

    dataset
    {
        dataitem("Credit Ledger Entry"; "Credit Ledger Entry")
        {
            DataItemTableView = where("Transaction Type" = const("Penalty Due"));
            column(ReportForNavId_1; 1)
            {
            }

            trigger OnAfterGetRecord()
            begin
                Loans.Reset;
                Loans.SetRange("Loan No.", "Credit Ledger Entry"."Loan No.");
                if Loans.Find('-') then begin
                    Loans.CalcFields("Outstanding Interest", "Total Outstanding Balance");

                    "Penalty Buffer".Init;
                    "Penalty Buffer"."Entry No" := "Credit Ledger Entry"."Entry No.";
                    "Penalty Buffer"."Member No" := Loans."Member No.";
                    "Penalty Buffer"."Loan No" := "Credit Ledger Entry"."Loan No.";
                    "Penalty Buffer".Amount := "Credit Ledger Entry".Amount;
                    "Penalty Buffer".Description := "Credit Ledger Entry".Description;
                    "Penalty Buffer"."GL Account" := "Credit Ledger Entry"."Bal. Account No.";
                    "Penalty Buffer"."Outstanding Interest" := Loans."Outstanding Interest";
                    "Penalty Buffer"."Outstanding Balance" := Loans."Total Outstanding Balance";
                    "Penalty Buffer"."Product Type" := Loans."Loan Product Type";
                    "Penalty Buffer"."Penalty Date" := "Credit Ledger Entry"."Posting Date";
                    "Penalty Buffer"."Loan Issue Date" := Loans."Disbursement Date";
                    "Penalty Buffer".Insert(true);
                end;
            end;

            trigger OnPostDataItem()
            begin
                Message('Done');
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
        Loans: Record Loans;
        "Penalty Buffer": Record "Loans Penalty Buffer";
}

