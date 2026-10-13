page 50432 "Salary Appraisal"
{
    Caption = 'Salary Appraisal List';
    PageType = List;
    SourceTable = "Member Salary Appraisal";
    CardPageId = "Salary Appraisal Card";
    DeleteAllowed = false;
    InsertAllowed = false;
    editable = false;
    SourceTableView = where("Appraisal Completed" = const(false), "Loan Stage" = filter("Loan Application"));

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Appraisal No."; Rec."Appraisal No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Appraisal No. field.';
                }
                field("Date"; Rec."Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Date field.';
                }
                field("Member No."; Rec."Member No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Member No. field.';
                }
                field(Name; Rec.Name)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Member No. field.';
                }
                field("Loan Product Type"; Rec."Loan Product Type")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Loan Product Type field.';
                }
                field("Requested Amount"; Rec."Requested Amount")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Requested Amount field.';
                }
                field("Total Loan to Pay"; Rec."Total Loan to Pay")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the Total Loan Amount to be paid';
                }

                field("Captured By"; Rec."Captured By")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the User who has captured information';
                    Caption = 'Appraised By';
                }

            }
        }
    }


    trigger OnOpenPage()
    var
        myInt: Integer;
    begin
        Rec.SetRange("Captured By", UserId);
    end;
}
