namespace UnitedWomen_Production.UnitedWomen_Production;

report 50510 "Test Mbanking"
{
    ApplicationArea = All;
    Caption = 'Test Mbanking';
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

                    field(Request; Request)
                    {
                        ApplicationArea = All;
                        MultiLine = true;
                    }

                    field(TestDeposit; TestDeposit)
                    {
                        ApplicationArea = All;
                    }
                    field(TestWithdrawal; TestWithdrawal)
                    {
                        ApplicationArea = All;
                    }
                    field(TestIFT; TestIFT)
                    {
                        ApplicationArea = All;
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
            Message(Sky.HandleRequest(Request));
        if TestDeposit <> '' then
            SkyTrans.PostMpesaDepositsTransaction(TestDeposit);
        if TestIFT <> '' then
            SkyTrans.PostAccountTransferTransaction(TestIFT);
        if TestWithdrawal <> '' then
            SkyTrans.PostWithdrawalTransaction(TestWithdrawal);
    end;

    var
        Request: Text;
        Sky: Codeunit "Sky Mobile Banking Integration";
        SkyTrans: Codeunit "Sky M-Banking Transactions";
        TestDeposit: Code[20];
        TestWithdrawal: Code[20];
        TestIFT: Code[20];
}
