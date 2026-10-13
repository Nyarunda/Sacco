page 50024 UPG_STO
{
    ApplicationArea = All;
    Caption = 'UPG_STO';
    PageType = List;
    SourceTable = UPG_STO;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the No. field.';
                }
                field("Source Account No."; Rec."Source Account No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Source Account No. field.';
                }
                field("Standing Order Type"; Rec."Standing Order Type")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Standing Order Type field.';
                }
                field("Destination Account No."; Rec."Destination Account No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Destination Account No. field.';
                }
                field("Effective/Start Date"; Rec."Effective/Start Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Effective/Start Date field.';
                }
                field("End Date"; Rec."End Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the End Date field.';
                }
                field("Duration"; Rec."Duration")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Duration field.';
                }
                field(Frequency; Rec.Frequency)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Frequency field.';
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Status field.';
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Description field.';
                }
                field(Amount; Rec.Amount)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Amount field.';
                }
                field("Bank Code"; Rec."Bank Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Bank Code field.';
                }
                field("None Salary"; Rec."None Salary")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the None Salary field.';
                }
                field("Responsibility Center"; Rec."Responsibility Center")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Responsibility Center field.';
                }
                field("Bank Name"; Rec."Bank Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Bank Name field.';
                }
                field("Bank Branch"; Rec."Bank Branch")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Bank Branch field.';
                }
                field("Destination Account"; Rec."Destination Account")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Destination Account field.';
                }
                field(Priority; Rec.Priority)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Priority field.';
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action(Clear)
            {
                trigger OnAction()
                var
                    STO: Record UPG_sto;

                begin
                    sto.DeleteAll();
                    Message('Deleted');
                end;
            }
            action(Upload)
            {
                trigger OnAction()
                var
                    STO: XmlPort UploadSTO;

                begin
                    STO.Run();
                end;
            }
            action(Import)
            {
                trigger OnAction()
                var
                    myInt: Integer;
                begin
                    Rec.ImportBankStatementLinesFromExcel();
                end;
            }
        }
    }

}
