page 50096 "UPGX HR Employee Transfer"
{
    Caption = 'UPGX HR Employee Transfer';
    PageType = List;
    SourceTable = "UPGX HR Employee Transfer";

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
                field("Date of Birth"; Rec."Date of Birth")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Date of Birth field.';
                }
                field("Date Of Joining"; Rec."Date Of Joining")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Date Of Joining field.';
                }
                field("Date Of Leaving"; Rec."Date Of Leaving")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Date Of Leaving field.';
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Status field.';
                }
                field("Full / Part Time"; Rec."Full / Part Time")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Full / Part Time field.';
                }
                field("Contract End Date"; Rec."Contract End Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Contract End Date field.';
                }
                field("ID Number"; Rec."ID Number")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the ID Number field.';
                }
                field(NSSF; Rec.NSSF)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the NSSF field.';
                }
                field(NHIF; Rec.NHIF)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the NHIF field.';
                }
                field(PIN; Rec.PIN)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the PIN field.';
                }
                field("Bank Account Number"; Rec."Bank Account Number")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Bank Account Number field.';
                }
                field(Updated; Rec.Updated)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Updated field.';
                }
            }
        }
    }
}
