
Report 50142 "Update Loans Change Date"
{
    DefaultLayout = RDLC;
    RDLCLayout = './src/Layouts/Update Loans Change Date.rdlc';

    dataset
    {
        dataitem(Loans; Loans)
        {
            DataItemTableView = where("Stop Interest Due" = const(true));
            RequestFilterFields = "Loan No.";
            column(ReportForNavId_1; 1)
            {
            }

            trigger OnAfterGetRecord()
            begin

                LoanChanges.Reset;
                LoanChanges.SetRange("Loan No.", Loans."Loan No.");
                if LoanChanges.Find('-') then begin
                    Loans."Int Stop Date" := LoanChanges."Rescheduling Date";
                    Loans.Modify;
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
        LoanChanges: Record "Loan Changes";
        Setup: Record "Sacco Setup";
}

