namespace UnitedWomen_Production.UnitedWomen_Production;

report 50025 "Charge Savings Penalty"
{
    Caption = 'Charge Savings Penalty';

    ProcessingOnly = true;
    dataset
    {

        dataitem("Savings Accounts"; "Savings Accounts")
        {
            DataItemTableView = where("Product Category" = filter(<> "Deposit Contribution"), "Balance (LCY)" = filter(> 0));
            trigger OnAfterGetRecord()
            var
                MemberActivitie: Codeunit "Member Activities";
                PSetup: Record "Product Setup";
            begin
                "Savings Accounts".CalcFields("Balance (LCY)");
                PSetup.Get("Product Type");
                if PSetup."Penalty Fee" > 0 then begin
                    if PSetup."Minimum Account Balance" > 0 then
                        if "Savings Accounts"."Balance (LCY)" > PSetup."Minimum Account Balance" then
                            CurrReport.skip();

                    MemberActivitie.ChargePenalty("Savings Accounts"."No.", PDate, "Savings Accounts"."Balance (LCY)");
                end;
            end;

            trigger OnPreDataItem()
            var
                Template: Code[10];
                Batch: Code[10];
                SAactivities: Codeunit "Sacco Activities";
                SBuffer: Record "Monthly Processes Buffer";
            begin
                SBuffer.Reset();
                SBuffer.SetRange(Posted, false);
                if SBuffer.FindFirst() then
                    SBuffer.DeleteAll();

                SAactivities.GetPaymentJournalTemplate(Template, Batch);
                Message('Template %1, Batch %2', Template, Batch);
            end;
        }
    }
    requestpage
    {
        layout
        {
            area(Content)
            {
                group(GroupName)
                {
                    field(PDate; PDate)
                    {
                        ApplicationArea = Basic;
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
    var
        PDate: Date;
}
