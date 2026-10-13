page 50624 "Member Exit Loans"
{
    ApplicationArea = All;
    Caption = 'Member Exit Loans';
    PageType = ListPart;
    Editable = false;
    SourceTable = Loans;
    SourceTableView = where(Posted = const(true), "Total Outstanding Balance" = filter(> 0));

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Loan No."; Rec."Loan No.")
                {
                    ToolTip = 'Specifies the value of the Loan No. field.';
                }
                field("Loan Product"; Rec."Loan Product Type Name")
                {
                    ToolTip = 'Specifies the value of the Loan Product field.';
                }
                field("Outstanding Principal"; Rec."Outstanding Principal")
                {
                    ToolTip = 'Specifies the value of the Outstanding Principal field.';
                }
                field("Outstanding Interest"; Rec."Outstanding Interest")
                {
                    ToolTip = 'Specifies the value of the Outstanding Interest field.';
                }
                field("Outstanding Insurance"; Rec."Outstanding Insurance")
                {
                    ToolTip = 'Specifies the value of the Outstanding Insurance field.';
                }
                field("Outstanding Penalty"; Rec."Outstanding Penalty")
                {
                    ToolTip = 'Specifies the value of the Outstanding Penalty field.';
                }
                field("Total Outstanding Balance"; Rec."Total Outstanding Balance")
                {
                    ToolTip = 'Specifies the value of the Total Outstanding Balance field.';
                }
                field("Member No."; Rec."Member No.")
                {
                    ToolTip = 'Specifies the value of the Member No. field.';
                    Visible = false;
                }
            }
        }
    }
}
