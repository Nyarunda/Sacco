page 50818 "Coop B2B Transactions"
{
    //was 50671
    ApplicationArea = All;
    Caption = 'Coop B2B Transactions';
    PageType = List;
    SourceTable = "Coop B2B Transactions";
    UsageCategory = Lists;
    Editable = false;
    InsertAllowed = false;
    DeleteAllowed = false;
    ModifyAllowed = false;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Transaction Reference Code"; Rec."Transaction Reference Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Transaction Reference Code field.';
                }
                field("Service Name"; Rec."Service Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Service Name field.';
                }
                field("Transaction Date"; Rec."Transaction Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Transaction Date field.';
                }
                field("Transaction Time"; Rec."Transaction Time")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Transaction Time field.';
                }
                field("Payment Date"; Rec."Payment Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Payment Date field.';
                }
                field("Document Reference Code"; Rec."Document Reference Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Document Reference Code field.';
                }
                field("Additional Info"; Rec."Additional Info")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Additional Info field.';
                }
                field("Account Number"; Rec."Account Number")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Account Number field.';
                }
                field("Institution Code"; Rec."Institution Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Institution Code field.';
                }
                field("Institution Name"; Rec."Institution Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Institution Name field.';
                }
                field("Bank Code"; Rec."Bank Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Bank Code field.';
                }
                field("Branch Code"; Rec."Branch Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Branch Code field.';
                }
                field("Payment Reference Code"; Rec."Payment Reference Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Payment Reference Code field.';
                }
                field(Currency; Rec.Currency)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Currency field.';
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Description field.';
                }
                field("Payment Code"; Rec."Payment Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Payment Code field.';
                }
                field("Total Amount"; Rec."Total Amount")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Total Amount field.';
                }
                field(Posted; Rec.Posted)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Posted field.';
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
                field("Posted By"; Rec."Posted By")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Posted By field.';
                }
                field(Reversed; Rec.Reversed)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Reversed field.';
                }
                field("Date Reversed"; Rec."Date Reversed")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Date Reversed field.';
                }
                field("Time Reversed"; Rec."Time Reversed")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Time Reversed field.';
                }
                field("Reversed By"; Rec."Reversed By")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Reversed By field.';
                }
                field("Reversal ID"; Rec."Reversal ID")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Reversal ID field.';
                }
                field("Transaction Type"; Rec."Transaction Type")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Transaction Type field.';
                }
                field("Transaction Name"; Rec."Transaction Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Transaction Name field.';
                }
                field("Payment Mode"; Rec."Payment Mode")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Payment Mode field.';
                }
                field("Payment Amount"; Rec."Payment Amount")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Payment Amount field.';
                }
                field("Account Name"; Rec."Account Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Account Name field.';
                }
                field("Line No."; Rec."Line No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Line No. field.';
                }
                field("Coop Fee"; Rec."Coop Fee")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Coop Fee field.';
                }
                field("Sacco Fee"; Rec."Sacco Fee")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Sacco Fee field.';
                }
                field("Sacco Excise Duty"; Rec."Sacco Excise Duty")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Sacco Excise Duty field.';
                }
                field("Total Charges"; Rec."Total Charges")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Total Charges field.';
                }
                field("Sacco Reference"; Rec."Sacco Reference")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Sacco Reference field.';
                }
            }
        }
    }




    actions
    {
        area(processing)
        {
            action("Post B2B Transactions")
            {
                ApplicationArea = Basic;

                trigger OnAction()
                begin

                    if Confirm('Are you sure you want to Post B2B Entries?') then begin
                        B2B.PostTransaction('');
                    end;
                    Message('Process Completed');
                end;
            }
        }
    }

    var
        B2B: Codeunit "Coop B2B_P2F";
}
