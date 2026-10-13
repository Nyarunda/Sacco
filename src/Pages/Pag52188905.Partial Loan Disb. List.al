page 50774 "Partial Loan Disb. List"
{
    Caption = 'Partial Loan Disb. List';
    Editable = false;
    InsertAllowed = false;
    PageType = List;
    SourceTable = "Partial Loans Disb. Header";
    CardPageId = "Partial Disb. Card";
    SourceTableView = where(Posted = filter(false));


    layout
    {
        area(content)
        {
            repeater(Group)
            {
                Caption = 'General';

                field(No; Rec."No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the No field.';
                }
                field("Member Name"; Rec."Member Name")
                {
                    ApplicationArea = All;
                }
                field("Loan No."; Rec."Loan No.")
                {
                    ApplicationArea = All;
                }
                field("Loan Product Name"; Rec."Loan Product Name")
                {
                    ApplicationArea = All;
                }
                field("Document Date"; Rec."Document Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Document Date field.';
                }

                field("Posting Date"; Rec."Posting Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Posting Date field.';
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                    ToolTip = 'Shows the approval status of the partial disbursement.';
                }
                field(Reversed; Rec.Reversed)
                {
                    ApplicationArea = All;
                    ToolTip = 'Shows whether the related credit ledger entry for this partial disbursement has been reversed.';
                }
                field(Reason; Rec.Reason)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Reason field.';
                }
                field("Captured By"; Rec."Captured By")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Captured By field.';
                }
                field("Time Captured"; Rec."Time Captured")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Time Captured field.';
                }
            }

        }
    }
}
