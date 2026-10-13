page 50364 "Reject Portal Loan Application"
{
    Caption = 'Reject Portal Loan Application';
    PageType = Card;
    SourceTable = "Portal Loans";
    DeleteAllowed = false;
    InsertAllowed = false;
    ModifyAllowed = true;

    layout
    {

        area(content)
        {

            group(General)
            {
                field(Remarks; Rec.Remarks)
                {

                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Remarks field.';
                    Editable = true;

                    trigger OnValidate()
                    begin
                        if StrLen(Rec.Remarks) <= 5 then
                            Error('Invalid Rejection Reason');

                        Rec.Status := Rec.Status::Failed;
                        Rec.Modify();
                    end;
                }
            }
        }
    }
}
