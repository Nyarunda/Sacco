page 50771 "Partial Disb. Lines"
{
    Caption = 'Partial Disb. Lines';
    PageType = ListPart;
    SourceTable = "Partial Loans Disb. Lines";

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Header No."; Rec."Header No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Header No field.';
                }
                field("Member No"; Rec."Member No")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Member No field.';
                    LookupPageId = "Member Listing";
                    Editable = false;
                }
                field("Loan No."; Rec."Loan No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Loan No. field.';
                    Editable = false;
                }
                field("Loan Product Type"; Rec."Loan Product Type")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Approved Amount"; Rec."Approved Amount")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Approved Amount field.';
                }
                field("Disbursed Amount"; Rec."Disbused Amount")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Disbused Amount field.';
                }
                field("Amount to Disburse"; Rec."Amount to Disbuse")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Amount to Disbuse field.';
                }
                field("Total Charges Applied"; Rec."Total Charges Applied")
                {
                    ApplicationArea = All;
                    Editable = false;
                    Style = Unfavorable;
                    StyleExpr = Rec."Total Charges Applied" > 0;
                    ToolTip = 'Shows the total loan charges applied to this partial disbursement.';
                }
                field("Expected Net Take Home"; Rec."Expected Net Take Home")
                {
                    ApplicationArea = All;
                    Editable = false;
                    Style = Favorable;
                    StyleExpr = Rec."Expected Net Take Home" > 0;
                    ToolTip = 'Shows the expected net take home after deducting total charges from the amount to disburse.';
                }
                field("Total Guaranteed"; Rec."Total Guaranteed")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Total Guaranteed field.';
                    Editable = false;
                }
                field("Amount Not Guaranteed"; Rec."Amount Not Guaranteed")
                {
                    ApplicationArea = All;
                    Editable = false;
                    ToolTip = 'Specifies the value of the Amount Not Guaranteed field.';
                }
                field("Outstanding Principal"; Rec."Outstanding Principal")
                {
                    ApplicationArea = all;
                }
                field("New Repyament Amount"; Rec."New Repyament Amount")
                {
                    Caption = 'Amount committed';
                    ApplicationArea = Basic;
                }
                field("Remaining Period"; Rec."Remaining Period")
                {
                    ApplicationArea = all;
                }
                field("Interest Calculation Method"; Rec."Interest Calculation Method")
                {
                    ApplicationArea = all;
                }


            }

        }

    }

    trigger OnAfterGetRecord()
    begin
        Rec.UpdateExpectedNetTakeHome();
    end;
}
