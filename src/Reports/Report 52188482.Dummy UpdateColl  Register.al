
Report 50145 "Dummy UpdateColl  Register"
{
    DefaultLayout = RDLC;
    RDLCLayout = './src/Layouts/Dummy UpdateColl  Register.rdlc';

    dataset
    {
        dataitem("Collateral Buffer1"; "Collateral Buffer1")
        {
            column(ReportForNavId_1; 1)
            {
            }

            trigger OnAfterGetRecord()
            begin
                CollateralReg.Reset;
                CollateralReg.SetRange("No.", "Collateral Buffer1"."Collateral No");
                if CollateralReg.Find('-') then begin

                    CollateralReg.Collateral := "Collateral Buffer1".Type;
                    CollateralReg.Modify;
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
        CollateralReg: Record "Loan Collateral Register";
}

