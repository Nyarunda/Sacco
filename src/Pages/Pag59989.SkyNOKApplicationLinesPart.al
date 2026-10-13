page 59989 "Sky NOK Application Lines"
{
    ApplicationArea = All;
    Caption = 'Sky NOK Application Lines';
    PageType = ListPart;
    SourceTable = "NOK Application Lines";

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Action Type"; Rec."Action Type")
                {
                    ApplicationArea = All;
                }
                field(Name; Rec.Name)
                {
                    ApplicationArea = All;
                }
                field(Relationship; Rec.Relationship)
                {
                    ApplicationArea = All;
                }
                field("ID No."; Rec."ID No.")
                {
                    ApplicationArea = All;
                }
                field("Mobile No."; Rec."Mobile No.")
                {
                    ApplicationArea = All;
                }
                field(Email; Rec.Email)
                {
                    ApplicationArea = All;
                }
                field("Date of Birth"; Rec."Date of Birth")
                {
                    ApplicationArea = All;
                }
                field(Gender; Rec.Gender)
                {
                    ApplicationArea = All;
                }
                field("Is Next of Kin"; Rec."Is Next of Kin")
                {
                    ApplicationArea = All;
                }
                field("Is Beneficiary"; Rec."Is Beneficiary")
                {
                    ApplicationArea = All;
                }
                field("%Allocation"; Rec."%Allocation")
                {
                    ApplicationArea = All;
                }
                field(Deceased; Rec.Deceased)
                {
                    ApplicationArea = All;
                }
                field("Entry No Reference"; Rec."Entry No Reference")
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}
