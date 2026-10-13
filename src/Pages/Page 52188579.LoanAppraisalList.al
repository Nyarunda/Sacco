
Page 50600 "Loan Appraisal List"
{
    Caption = 'Loan Appraisal';
    PageType = List;
    SourceTable = "Member Salary Appraisal";
    CardPageId = "Loan Appraisal Card";
    DeleteAllowed = false;
    InsertAllowed = false;
    SourceTableView = where("Appraisal Completed" = const(false), "Loan Stage" = filter("Loan Appraisal"), "Appraisal Type" = filter(<> Staff), Status = filter(Open));

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
                field("Date Captured"; Rec."Date Captured")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Date field.';
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

                field("Appraiser ID"; Rec."Appraiser ID")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the User who has captured information';
                }
                field("Captured By"; Rec."Captured By")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the User who has captured information';
                }

            }
        }
    }


    trigger OnOpenPage()
    var
        myInt: Integer;
    begin
        Rec.SetRange("Appraiser ID", UserId);
    end;


}

