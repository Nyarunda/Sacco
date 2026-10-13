namespace UnitedWomen_Production.UnitedWomen_Production;

using Microsoft.Finance.GeneralLedger.Account;
using Microsoft.Finance.GeneralLedger.Ledger;

report 50542 "Members Branch Update"
{
    Caption = 'Members Branch Update';
    ProcessingOnly = true;
    dataset
    {
        dataitem(GLAccount; "G/L Account")
        {
            trigger OnPreDataItem()
            begin
                GLAccount.SetFilter("No.", AccountNo);

            end;

            trigger OnAfterGetRecord()
            begin
                GLEntry.Reset();
                GLEntry.SetRange("G/L Account No.", GLAccount."No.");
                if GLEntry.FindFirst() then begin
                    repeat
                        Member.Reset();
                        Member.SetRange("No.", GLEntry."Member No.");
                        if Member.FindFirst() then begin
                            //Member.CalcFields("Branch Code");
                            GLEntry."Global Dimension 2 Code" := Member."Global Dimension 2 Code";
                            GLEntry.Modify(true);
                        end;
                    until GLEntry.Next() = 0;
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
                    field("Account No."; AccountNo)
                    {
                        ApplicationArea = All;
                        ToolTip = 'Specifies the G/L Account No.';
                        TableRelation = "G/L Account";
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
    begin
        //Code to execute after the report is processed
        Message('Members Branch Update Completed Successfully');
    end;

    var
        AccountNo: Code[20];
        Member: Record Members;
        GLEntry: Record "G/L Entry";
}
