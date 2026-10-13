namespace UnitedWomen_Production.UnitedWomen_Production;

report 50080 "Recover Sto Loans"
{
    ApplicationArea = All;
    Caption = 'Recover Sto Loans';
    UsageCategory = ReportsAndAnalysis;
    ProcessingOnly = true;
    dataset
    {
        dataitem(SavingsAccounts; "Savings Accounts")
        {
            RequestFilterFields = "Member No.", "Employer Code", "No.";
            DataItemTableView = where("Balance (LCY)" = filter(> 0));
            //AutoCalcFields = "Balance (LCY)";

            trigger OnAfterGetRecord()
            var
                SaccoActivities: Codeunit "Sacco Activities";
                ProductType: Record "Product Setup";
                MemberActivities: Codeunit "Member Activities";
                Bal: decimal;
            begin
                Bal := 0;
                ProductType.Get(SavingsAccounts."Product Type");
                if ProductType."STO Recovery" then begin

                    SavingsAccounts.CalcFields("Balance (LCY)");
                    Bal := MemberActivities.GetAccountBalance(SavingsAccounts."No.");

                    SaccoActivities.RecoverSTOLoans(SavingsAccounts."Member No.", Bal, SavingsAccounts."No.");

                end;
            end;

            trigger OnPostDataItem()
            begin
                Message('Processed Successfully');
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
}
