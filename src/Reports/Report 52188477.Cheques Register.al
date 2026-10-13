
Report 50140 "Cheques Register"
{
    DefaultLayout = RDLC;
    RDLCLayout = './src/Layouts/Cheques Register.rdlc';
    UsageCategory = ReportsandAnalysis;

    dataset
    {
        dataitem(Cheques; "Ordinary Cheque Register")
        {
            column(ReportForNavId_1; 1)
            {
            }
            column(ChequeNo; Cheques."Ordinary Cheque No.")
            {
            }
            column(Issued; Iss)
            {
            }
            column(Cancelled; Canc)
            {
            }
            column(BranchCode_Cheques; Cheques."Branch Code")
            {
            }
            column(Source_Cheques; Cheques.Source)
            {
            }

            trigger OnAfterGetRecord()
            begin
                Iss := '';
                Canc := '';

                if Cheques.Cancelled then
                    Canc := 'Yes';

                if Cheques.Issued then
                    Iss := 'Yes';
            end;

            trigger OnPreDataItem()
            begin

                if Option = Option::Bankers then
                    Cheques.SetRange("Ordinary Cheque No.", 'XXX');
            end;
        }
        dataitem(BCheques; "Bankers Cheque Register")
        {
            column(ReportForNavId_12; 12)
            {
            }
            column(BChequeNo; "Cheque No.")
            {
            }
            column(BIssued; Iss)
            {
            }
            column(BCancelled; Canc)
            {
            }

            trigger OnAfterGetRecord()
            begin
                Iss := '';
                Canc := '';

                if BCheques.Status = BCheques.Status::Cancelled then
                    Canc := 'Yes';
                if BCheques.Status = BCheques.Status::stopped then
                    Canc := 'Yes';

                if BCheques.Status = BCheques.Status::Approved then
                    Iss := 'Yes';
            end;

            trigger OnPreDataItem()
            begin

                if Option = Option::Ordinary then
                    BCheques.SetRange("Cheque No.", 'XXX');
            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                field(Option; Option)
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
        Iss: Text;
        Canc: Text;
        Option: Option Bankers,Ordinary;
}

