
Page 50194 "Salary Details"
{
    PageType = List;
    SourceTable = "Appraisal Salary Details";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(AmountCalculationMethod; Rec."Amount Calculation Method")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field(RatePerunit; Rec."Rate Per unit")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field(NoOfUnits; Rec."No Of Units")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field(Type; Rec.Type)
                {
                    ApplicationArea = Basic;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = Basic;
                }
                field(Amount; Rec.Amount)
                {
                    ApplicationArea = Basic;
                }
                field(MultiplierQualification; Rec."Multiplier Qualification")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Visible = false;
                }
            }
        }
    }

    actions
    {
    }
}

