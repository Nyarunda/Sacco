page 50773 "Loan Charges Partial"
{
    Caption = 'Loan Charges Partial';
    PageType = ListPart;
    SourceTable = "Loan Charges Partial";


    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(ChargeCode; Rec."Charge Code")
                {
                    ApplicationArea = Basic;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = Basic;
                }
                field(Charge; Rec."Charge %")
                {
                    ApplicationArea = Basic;
                }
                field(Amount; Rec.Amount)
                {
                    ApplicationArea = Basic;
                }
                field(ExciseDuty; Rec."Excise Duty")
                {
                    ApplicationArea = Basic;
                }
                field(TotalCharge; Rec."Total Charge")
                {
                    ApplicationArea = Basic;
                }
                field(Posted; Rec.Posted)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
            }
        }
    }

    actions
    {
    }
}