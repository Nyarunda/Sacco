
Report 50221 "Stop Interest"
{
    DefaultLayout = RDLC;
    RDLCLayout = './src/Layouts/Stop Interest.rdlc';

    dataset
    {
        dataitem("Loans Buffer."; "Loans Buffer.")
        {
            RequestFilterFields = "Loan No";
            column(ReportForNavId_1; 1)
            {
            }

            trigger OnAfterGetRecord()
            begin
                Loans.Reset;
                Loans.SetRange("Loan No.", "Loans Buffer."."Loan No");
                if Loans.Find('-') then begin

                    Loans."Stop Interest Due" := true;
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
        Loans: Record Loans;
}

