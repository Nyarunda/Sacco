
Report 50192 "Create Savings Accounts"
{
    DefaultLayout = RDLC;
    RDLCLayout = './src/Layouts/Create Savings Accounts.rdlc';
    UsageCategory = ReportsAndAnalysis;

    dataset
    {
        dataitem(Members; Members)
        {
            RequestFilterFields = "No.";
            column(ReportForNavId_1; 1)
            {
            }

            trigger OnAfterGetRecord()
            var
                Savings: Record "Savings Accounts";
                ExpectedNo: Code[20];
            begin
                ProductSetup.Reset;
                ProductSetup.SetRange("Product Class", ProductSetup."product class"::Savings);
                ProductSetup.SetRange("Auto Open Member Account", true);
                if ProductSetup.FindFirst then begin
                    repeat
                        Savings.Reset();
                        Savings.SetRange("Member No.", Members."No.");
                        Savings.SetRange("Product Type", ProductSetup."Product ID");
                        if NOT Savings.FindFirst() then begin

                            if not ProductSetup."Allow Multiple Accounts" then begin

                                if (ProductSetup."Account No. Prefix" = '') and (ProductSetup."Account No. Suffix" = '') then
                                    Error('Prefix or Suffix MUST be setup in the %1 "Product Setup".', ProductSetup.Description);

                                ExpectedNo := ProductSetup."Account No. Prefix" + Members."No." + ProductSetup."Account No. Suffix";

                                if Savings."No." <> ExpectedNo then begin
                                    //Savings.Rename("No.", ExpectedNo);
                                end;
                            end;
                            MemberActivities.CreateSavingsAccount(ProductSetup, Members, 0, true, ProductSetup."Repay Mode");
                        end;
                    until ProductSetup.Next = 0;
                end;
            end;

            trigger OnPreDataItem()
            begin

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
        ProductSetup: Record "Product Setup";
        MemberActivities: Codeunit "Member Activities";
}

