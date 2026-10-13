
Report 50148 "Dummy Update Collateral"
{
    DefaultLayout = RDLC;
    RDLCLayout = './src/Layouts/Dummy Update Collateral.rdlc';

    dataset
    {
        dataitem(coll; "Dummy Upload Collateral")
        {
            column(ReportForNavId_1; 1)
            {
            }

            trigger OnAfterGetRecord()
            begin

                Register.Init;
                Register."No." := CollNo;
                Register."Account No." := coll."Member No";
                Register."Account Name" := coll.Name;
                Register."Collateral Name" := coll.Security;
                Register."Collateral Value" := coll.Value;
                Register."Collateral Limit" := coll.Value;
                Register.Status := Register.Status::Approved;
                Register."Inward/Outward" := Register."inward/outward"::"In-Store";
                Register."Collateral Details" := coll.Security;
                Register."Charged Value" := coll.Value;
                Register.Insert;

                Register.Reset;
                Register.SetRange("No.", CollNo);
                if Register.FindFirst then begin
                    LoanSecurity.Init;
                    LoanSecurity."Loan No." := coll."Loan No";
                    LoanSecurity."Account No." := coll."Member No";
                    LoanSecurity."Collateral Reg. No." := Register."No.";
                    LoanSecurity.Name := Register."Account Name";
                    LoanSecurity."Amount Guaranteed" := coll."Security Guaranteed";
                    LoanSecurity."Available Guarantorship" := coll.Value;
                    LoanSecurity."Guarantor Type" := LoanSecurity."guarantor type"::Collateral;
                    LoanSecurity.Insert;
                end;

                CollNo := IncStr(CollNo);
            end;

            trigger OnPreDataItem()
            begin

                CollNo := 'HLS00001';
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
        Register: Record "Loan Collateral Register";
        CollNo: Code[20];
        LoanSecurity: Record "Loan Security";
}

