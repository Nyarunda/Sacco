namespace UnitedWomen_Production.UnitedWomen_Production;

report 50518 "Test Portal"
{
    ApplicationArea = All;
    Caption = 'Test Portal';
    UsageCategory = Tasks;
    ProcessingOnly = true;
    dataset
    {
    }
    requestpage
    {
        layout
        {
            area(Content)
            {
                group(GroupName)
                {

                    field(RegRequest; RegRequest)
                    {
                        ApplicationArea = All;
                        MultiLine = true;
                    }
                    field(Request; Request)
                    {
                        ApplicationArea = All;
                        MultiLine = true;
                    }
                    field(ATMTrans; ATMTrans)
                    {
                        ApplicationArea = All;
                        MultiLine = true;
                    }

                }
            }
        }
        actions
        {
            area(Processing)
            {
            }
        }
    }



    trigger OnPreReport();
    begin
        if Request <> '' then
            Message(Sky.ProcessRequest(Request));
        if RegRequest <> '' then
            Message(Sky.ProcessRegistrationRequest(RegRequest));


        if ATMTrans <> '' then begin

            CoopTrans.Reset();
            CoopTrans.SetRange("Transaction ID", ATMTrans);
            CoopTrans.SetRange(Posted, false);
            if CoopTrans.FindFirst() then begin
                repeat
                    Coop.PostATM(CoopTrans."Transaction ID");
                until CoopTrans.Next() = 0;
            end;
        end;

    end;

    var
        CoopTrans: Record "Coop ATM Transaction";
        Coop: Codeunit "Coop Processing";
        Request: Text;
        RegRequest: Text;
        ATMTrans: Text;
        Sky: Codeunit "sacco portal";
        SkyTrans: Codeunit "Sky M-Banking Transactions";
        TestDeposit: Code[20];
        TestWithdrawal: Code[20];
        TestIFT: Code[20];
}
