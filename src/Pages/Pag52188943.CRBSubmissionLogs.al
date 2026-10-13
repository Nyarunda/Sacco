page 50787 "CRB Submission Logs"
{
    ApplicationArea = All;
    Caption = 'CRB Submission Logs';
    PageType = List;
    SourceTable = "CRB Submission Logs";
    UsageCategory = Lists;
    Editable = false;


    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Loan No."; Rec."Loan No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Loan No. field.', Comment = '%';
                }
                field("Member No."; Rec."Member No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Member No. field.', Comment = '%';
                }
                field(Name; Rec.Name)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Name field.', Comment = '%';
                }
                field(column_name; Rec.column_name)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the column_name field.', Comment = '%';
                }
                field(value_provided; Rec.value_provided)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the value_provided field.', Comment = '%';
                }
                field(error_description; Rec.error_description)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the error_description field.', Comment = '%';
                }
            }
        }
    }
}
