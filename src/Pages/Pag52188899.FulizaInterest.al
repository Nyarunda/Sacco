page 50601 "Fuuza Interest"
{
    Caption = 'Fuuza Interest';
    PageType = List;
    SourceTable = "Fuuza Interest Buffer";

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field(No; Rec.No)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the No field.';
                }
                field("Account Type"; Rec."Account Type")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Account Type field.';
                }
                field("Account No"; Rec."Account No")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Account No field.';
                }
                field("Interest Date"; Rec."Interest Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Interest Date field.';
                }
                field("Interest Rate"; Rec."Interest Rate")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Interest Rate field.';
                }
                field("Interest Amount"; Rec."Interest Amount")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Interest Amount field.';
                }
                field("User ID"; Rec."User ID")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the User ID field.';
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Description field.';
                }
                field("Product Setup Code"; Rec."Product Setup Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Product Setup Code field.';
                }
                field("Bal. Account Type"; Rec."Bal. Account Type")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Bal. Account Type field.';
                }
                field("Payable Account"; Rec."Payable Account")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Payable Account field.';
                }
                field("Shortcut Dimension 1 Code"; Rec."Shortcut Dimension 1 Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Shortcut Dimension 1 Code field.';
                }
                field("Shortcut Dimension 2 Code"; Rec."Shortcut Dimension 2 Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Shortcut Dimension 2 Code field.';
                }
                field(Blocked; Rec.Blocked)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Blocked field.';
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Status field.';
                }
                field("Account Balance"; Rec."Account Balance")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Account Balance field.';
                }
                field(Posted; Rec.Posted)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Posted field.';
                }
                field("Expense Account"; Rec."Expense Account")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Expense Account field.';
                }
                field(Name; Rec.Name)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Name field.';
                }
                field("Entry No."; Rec."Entry No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Entry No. field.';
                }
                field("Auto Interest"; Rec."Auto Interest")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Auto Interest field.';
                }
            }
        }
    }
}
