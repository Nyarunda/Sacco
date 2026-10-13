report 50298 "Charge Statement"
{
    Caption = 'Charge Statement';
    ProcessingOnly = true;

    dataset
    {
        dataitem(Acc; "Savings Accounts")
        {
            //DataItemTableView = where("Product Category"="Product Category"::or)

            trigger OnAfterGetRecord()
            var
                TChannel: Enum "Transaction Channel";
                DimID: Integer;
                UserSetup: Record "User Setup";
            begin
                AccBal := SaccoActivities.GetAccountBalance(Acc."No.");

                ProdSetup.Get(Acc."Product Type");
                ProdSetup.TestField("Statement Charge");

                ChargesLines.reset();
                ChargesLines.SetRange("Transaction Type", ProdSetup."Statement Charge");
                if ChargesLines.FindSet() then begin
                    SaccoActivities.JournalInit(JTemplate, JBatch);
                    UserSetup.Get(UserId);
                    DimID := UserSetup."Dimension Set ID";
                    repeat

                        MemberActivities.GetLineChargeAmount(ProdSetup."Statement Charge", 0, ChargeAmt, ChargeDuty, ChargeAcctType, ChargeAcct, ChargesLines.Description);

                        AccBal -= (ChargeAmt + ChargeDuty);

                        if AccBal < 0 then Error('The transaction will lead to overdrawing of Acc. %1', Acc."No.");

                        SaccoActivities.JournalInsert(Jtemplate, JBatch, 'STMT-CHARGE', Today, ChargeAcctType::Savings, Acc."No.", ChargesLines.Description,
                                                        ChargeAcctType, ChargeAcct, ChargeAmt * NoOfPages, Acc."No.", '', TType::" ",
                                                        Acc."Global Dimension 1 Code", Acc."Global Dimension 2 Code", true, TChannel::" ", DimID);
                        //Excise Duty

                        SaccoSetup.TestField("Excise Duty GL");
                        SaccoActivities.JournalInsert(Jtemplate, JBatch, 'STMT-CHARGE', Today, ChargeAcctType::Savings, Acc."No.", 'Excise Duty',
                                                            ChargeAcctType::"G/L Account", SaccoSetup."Excise Duty GL", ChargeDuty * NoOfPages, Acc."No.", '', TType::" ",
                                                            Acc."Global Dimension 1 Code", Acc."Global Dimension 2 Code", true, TChannel::" ", DimID);


                    until ChargesLines.next = 0;
                end;
            end;



        }
    }
    requestpage
    {
        layout
        {
            area(content)
            {
                group(Filters)
                {
                    field(NoOfPages; NoOfPages)
                    {
                        ApplicationArea = All;
                    }

                }
            }
        }
        actions
        {
            area(processing)
            {
            }
        }
    }
    trigger OnPreReport()
    begin
        IF (NoOfPages <= 0) then
            Error('The no of pages must have a valid value!');
        SaccoSetup.Get();
        BankingUserSetup.Get(UserId);
        BankingUserSetup.TestField("Cashier Journal Template");
        BankingUserSetup.TestField("Cashier Journal Batch");
        JTemplate := BankingUserSetup."Cashier Journal Template";
        JBatch := BankingUserSetup."Cashier Journal Batch";
        SaccoActivities.JournalInit(JTemplate, JBatch);
    end;

    trigger OnPostReport()
    begin
        SaccoActivities.JournalPost(JTemplate, JBatch);
        Message('The charge was successful');
    end;

    var
        NoOfPages: Integer;
        ChargesLines: Record "Transaction Charges Lines";

        MemberActivities: Codeunit "Member Activities";

        ChargeAcctType: Enum "Gen. Journal Account Type";
        SaccoSetup: Record "Sacco Setup";
        SaccoActivities: Codeunit "Sacco Activities";
        ChargeAmt: Decimal;
        ChargeDuty: Decimal;
        ChargeAcct: Code[20];

        JTemplate: Code[10];
        JBatch: Code[10];

        TType: Enum "Transaction Type Enum";

        RunBal: Decimal;

        AccBal: Decimal;

        BankingUserSetup: Record "Banking User Setup";

        ProdSetup: Record "Product Setup";

}