
report 50482 "Dividends To Deposits"
{
    Caption = 'Dividends To Deposits';
    ProcessingOnly = true;
    dataset
    {
        dataitem(SavingsAccounts; "Savings Accounts")
        {
            DataItemTableView = where("Balance (LCY)" = filter(> 0), "Product Category" = filter("Dividend Account"));
            RequestFilterFields = "No.", Status, "Member No.";

            trigger OnPreDataItem()
            var
                myInt: Integer;
            begin
                SaccoActivities.GetGeneralJournalTemplate(template, Batch);
                if (Template = '') and (Batch = '') then
                    Error('Template and batch missing');

                SaccoActivities.JournalInit(Template, Batch);

                if PDate = 0D then
                    Error('Posting Date missing');
            end;

            trigger OnAfterGetRecord()
            var
                OfficeTemp: Record "User Setup";
                ClaimLines: Record "BBF Entitlement Lines";
                GeneralSetUp: Record "Sacco SetUp";
                LineNo: Integer;
                MsgOnCompletePosting: Label 'Application No. -%1- successfully posted.';
                AccType: Integer;
                BBFRequisationLines: Record "BBF Entitlement Header";
                Temp: Record "Banking User Setup";
                Jtemplate: Code[10];
                JBatch: Code[10];
                MsgOnConfirmDialog: Label 'Are you want to Post this Claim?';
                AccTypes: Enum "Gen. Journal Account Type";
                BalAcctType: Enum "Gen. Journal Account Type";
                TransType: Enum "Transaction Type Enum";
                DimID: Integer;
                Acc: Code[20];
                SADepsits: Record "Savings Accounts";
                DocNo: Text[20];
                RunBal: Decimal;
                Desc: Text[100];
                CurrContrib: Decimal;
                ExpContrib: Decimal;
                SaccoSetup: Record "Sacco Setup";
                PSetup: Record "Product Setup";
                TTotalAmt: Decimal;
                Legacy: Codeunit Legacy;

            begin
                SavingsAccounts.CalcFields("Balance (LCY)");

                SADepsits.Reset();
                SADepsits.SetRange("Member No.", SavingsAccounts."Member No.");
                SADepsits.SetRange("Product Category", SADepsits."Product Category"::"Deposit Contribution");
                if SADepsits.FindFirst() then begin

                    SaccoSetup.Get();
                    RunBal := 0;
                    Desc := '';


                    RunBal := SavingsAccounts."Balance (LCY)";


                    Desc := 'Dividend Capitilization :' + Format(PDate);
                    DocNo := 'DIV CAP: ' + Format(PDate);
                    //Debit Bank
                    SaccoActivities.JournalInsert(Template, Batch, DocNo, PDate, AccTypes::Savings, SavingsAccounts."No.", PadStr(Desc + ': ' + SavingsAccounts.Name, 50), BalAcctType::Savings, SADepsits."No.", RunBal, '', '', TransType::" ", SavingsAccounts."Global Dimension 1 Code", SavingsAccounts."Global Dimension 2 Code", false, TChannel::" ", DimID);

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
                        ApplicationArea = basic;
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

    trigger OnPostReport()
    var
        myInt: Integer;
    begin
        Message('Done Processing');
    end;

    var
        PDate: Date;
        Template: Code[10];
        Batch: Code[10];
        SaccoActivities: Codeunit "Sacco Activities";
        TChannel: Enum "Transaction Channel";
}
