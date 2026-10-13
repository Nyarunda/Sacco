
Report 50253 "Dummy Update Ledger Entries"
{
    DefaultLayout = RDLC;
    RDLCLayout = './src/Layouts/Dummy Update Ledger Entries.rdlc';

    dataset
    {
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

    trigger OnPreReport()
    begin

        GLedger.Reset;
        GLedger.SetFilter("Posting Date", '<%1', Dmy2date(10, 4, 2021));
        if GLedger.FindFirst then begin
            Message('GL: %1', GLedger.Count);
            //GLedger.MODIFYALL("Posting Date",DMY2DATE(10,04,2021));
        end;


        SLedger.Reset;
        SLedger.SetFilter("Posting Date", '<%1', Dmy2date(10, 4, 2021));
        if SLedger.FindFirst then begin
            Message('SL: %1', SLedger.Count);
            //SLedger.MODIFYALL("Posting Date",DMY2DATE(10,04,2021));
        end;


        BLedger.Reset;
        BLedger.SetFilter("Posting Date", '<%1', Dmy2date(10, 4, 2021));
        if BLedger.FindFirst then begin
            Message('BL: %1', BLedger.Count);
            //BLedger.MODIFYALL("Posting Date",DMY2DATE(10,04,2021));
        end;


        CLedger.Reset;
        CLedger.SetFilter("Posting Date", '<%1', Dmy2date(10, 4, 2021));
        if CLedger.FindFirst then begin
            Message('CL: %1', CLedger.Count);
            //CLedger.MODIFYALL("Posting Date",DMY2DATE(10,04,2021));
        end;
    end;

    var
        GLedger: Record "G/L Entry";
        SLedger: Record "Savings Ledger Entry";
        BLedger: Record "Bank Account Ledger Entry";
        CLedger: Record "Credit Ledger Entry";
}

