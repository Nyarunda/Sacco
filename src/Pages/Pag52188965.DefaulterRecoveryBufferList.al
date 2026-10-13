namespace CentralDB.CentralDB;

page 50667 "Defaulter Recovery Buffer List"
{
    ApplicationArea = All;
    Caption = 'Defaulter Recovery Buffer List';
    PageType = List;
    SourceTable = "Defaulter Loan Recovery";
    CardPageId = "Defaulter Recovery Buffer Card";
    UsageCategory = Lists;
    DeleteAllowed = false;
    Editable = false;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("No."; Rec."No.")
                {
                    ToolTip = 'Specifies the value of the No. field.';
                }
                field("Date Entered"; Rec."Date Entered")
                {
                    ToolTip = 'Specifies the value of the Date Entered field.';
                }
                field("Total Deduction"; Rec."Total Deduction Loans")
                {
                    ToolTip = 'Specifies the value of the Total Deduction field.';
                }

                field("Total Count"; Rec."Total Count")
                {
                    ToolTip = 'Specifies the value of the SystemModifiedBy field.';
                }
                field(Description; Rec.Description)
                {
                    ToolTip = 'Specifies the value of the SystemModifiedBy field.';
                }
                field("Posting Date"; Rec."Posting Date")
                {
                    ToolTip = 'Specifies the value of the SystemModifiedBy field.';
                }
                field("Entered By"; Rec."Entered By")
                {
                    ToolTip = 'Specifies the value of the Entered By field.';
                }
            }
        }
    }
    trigger OnOpenPage()
    var
        myInt: Integer;
    begin
        Rec.SetFilter(Source, '%1', Rec.Source::Buffer);
    end;
}



