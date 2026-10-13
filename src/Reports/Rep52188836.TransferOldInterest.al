namespace UnitedWomen_Production.UnitedWomen_Production;

report 50538 "Transfer Old Interest"
{
    Caption = 'Transfer Old Interest';
    ProcessingOnly = true;
    dataset
    {
        dataitem(SavingsInterestLines; "Savings Interest Lines")
        {


            trigger OnPreDataItem()
            begin
                SavingsInterestLines.SetRange("No", No);

                SavingsInterestLines.SetRange("Interest Date", DMY2Date(31, 12, 2025));

            end;

            trigger OnAfterGetRecord()
            begin

                SavAccount.Reset();
                SavAccount.SetRange("No.", SavingsInterestLines."Account No");
                if SavAccount.FindFirst() then begin

                    OldSavingsInterestLine.Reset();
                    OldSavingsInterestLine.SetRange("Account No", SavAccount."Old Account No.");
                    if OldSavingsInterestLine.FindFirst() then begin
                        SavingsInterestLines."Old Interest Amount" := OldSavingsInterestLine."Interest Amount";
                        SavingsInterestLines.Modify();
                    end;

                end;
            end;

            trigger OnPostDataItem()
            begin

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
                    field(No; SavingsInterestLines."No")
                    {
                        ApplicationArea = All;
                        ToolTip = 'Specifies the value of the No. field.';
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
        OldSavingsInterestLine: Record "Old Fosa Interest";
        SavAccount: Record "Savings Accounts";
        OldAcc: Code[20];

    trigger OnPreReport()
    begin
    end;


    trigger OnPostReport()
    begin
        Message('Old Interest Amount Transfer Completed');
    end;


}
