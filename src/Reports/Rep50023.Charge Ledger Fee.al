namespace UnitedWomen_Production.UnitedWomen_Production;

report 50023 "Charge Ledger Fee"
{
    Caption = 'Charge Ledger Fee';
    ProcessingOnly = true;
    dataset
    {

        dataitem("Savings Accounts"; "Savings Accounts")
        {
            DataItemTableView = where("Exempt Charges" = const(false), "Balance (LCY)" = filter(> 0));
            trigger OnAfterGetRecord()
            var
                MemberActivitie: Codeunit "Member Activities";
                PSetup: Record "Product Setup";
            begin
                "Savings Accounts".CalcFields("Balance (LCY)");
                PSetup.Get("Product Type");
                if PSetup."Charge Ledger Fee" then
                    MemberActivitie.LedgerFeeRecoveryFromDeposits("Savings Accounts"."No.", PDate, "Savings Accounts"."Balance (LCY)");
            end;

            trigger OnPreDataItem()
            var
                Template: Code[10];
                Batch: Code[10];
                SAactivities: Codeunit "Sacco Activities";
                IntBuffer: Record "Monthly Processes Buffer";
            begin
                SAactivities.GetPaymentJournalTemplate(Template, Batch);
                Message('Template %1, Batch %2', Template, Batch);
                IntBuffer.Reset;
                IntBuffer.SetRange(Posted, false);
                if IntBuffer.FindFirst then begin
                    IntBuffer.DeleteAll;
                end;
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
