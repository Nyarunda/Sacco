page 50488 "Loan Defaulter Analysis"
{
    Caption = 'Loan Defaulter Analysis';
    PageType = List;
    SourceTable = "Sasra Categorization";
    Editable = false;
    InsertAllowed = false;
    DeleteAllowed = false;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Loan No."; Rec."Loan No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Loan No. field.';
                }
                field("Member No."; Rec."Member No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Member No. field.';
                }
                field("Member Name"; Rec."Member Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Member Name field.';
                }
                field("Employer Code"; Rec."Employer Code")
                {
                    ApplicationArea = All;
                }
                field("Loan Product Type"; Rec."Loan Product Type")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Loan Product Type field.';
                }
                field("Approved Amount"; Rec."Approved Amount")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Approved Amount field.';
                }
                field("Outstanding Principal"; Rec."Outstanding Principal")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Outstanding Principal field.';
                }
                field("Outstanding Interest"; Rec."Outstanding Interest")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Outstanding Interest field.';
                }
                field("Total Outstanding Balance"; Rec."Total Outstanding Balance")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Total Outstanding Balance field.';
                }
                field("Principal Expected"; Rec."Principal Expected")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Principal Expected field.';
                }
                field("Principal Paid"; Rec."Principal Paid")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Principal Paid field.';
                }
                field("Principal Arrears"; Rec."Principal Arrears")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Principal Arrears field.';
                }
                field("Months in Arrears"; Rec."Months in Arrears")
                {
                    ApplicationArea = all;
                }
                field("Loan Category"; Rec."Loan Category")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Loan Category field.';
                }
                field("Total Arrears"; Rec."Total Arrears")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Total Arrears field.';
                }
                field("Arrears Date"; Rec."As At")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Arrears Date field.';
                }
                field("As At"; Rec."As At")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the As At field.';
                }
                field("User Name"; Rec."User Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the User Name field.';
                }
                field("Deposit Balance"; Rec."Deposit Balance")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Deposit Balance field.';
                }
                field("Fosa Balance"; Rec.Balance)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Balance field.';
                }
                field("Next Run Date"; Rec."As At")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the As At field.';
                }
            }
        }
    }



    actions
    {
        area(Processing)
        {

            action("Update Arrears")
            {
                ApplicationArea = Basic;
                Image = Account;
                RunObject = report "SASRA Loan Categorization";
            }
        }
    }
}
