page 55096 "Old Mpesa Transactions"
{
    Caption = 'Old Mpesa Transactions';
    PageType = List;
    SourceTable = "MPESA Transactions";
    SourceTableView = where(Posted = const(false));

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Document No."; Rec."Document No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Document No. field.';
                }
                field("Transaction Date"; Rec."Transaction Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Transaction Date field.';
                }
                field("Account No."; Rec."Account No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Account No. field.';
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
                field(Posted; Rec.Posted)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Posted field.';
                }
                field("Transaction Type"; Rec."Transaction Type")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Transaction Type field.';
                }
                field("Transaction Time"; Rec."Transaction Time")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Transaction Time field.';
                }
                field("Bal. Account No."; Rec."Bal. Account No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Bal. Account No. field.';
                }
                field("Document Date"; Rec."Document Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Document Date field.';
                }
                field("Date Posted"; Rec."Date Posted")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Date Posted field.';
                }
                field("Time Posted"; Rec."Time Posted")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Time Posted field.';
                }
                field("Account Status"; Rec."Account Status")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Account Status field.';
                }
                field(Messages; Rec.Messages)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Messages field.';
                }
                field("Needs Change"; Rec."Needs Change")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Needs Change field.';
                }
                field("Change Transaction No"; Rec."Change Transaction No")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Change Transaction No field.';
                }
                field("Old Account No"; Rec."Old Account No")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Old Account No field.';
                }
                field(Changed; Rec.Changed)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Changed field.';
                }
                field("Date Changed"; Rec."Date Changed")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Date Changed field.';
                }
                field("Time Changed"; Rec."Time Changed")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Time Changed field.';
                }
                field("Changed By"; Rec."Changed By")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Changed By field.';
                }
                field("Approved By"; Rec."Approved By")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Approved By field.';
                }
                field("Original Account No"; Rec."Original Account No")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Original Account No field.';
                }
                field("Account Balance"; Rec."Account Balance")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Account Balance field.';
                }
                field("Key Word"; Rec."Key Word")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Key Word field.';
                }
                field("Telephone No"; Rec."Telephone No")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Telephone No field.';
                }
                field(TraceId; Rec.TraceId)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the TraceId field.';
                }
            }
        }
    }
}
