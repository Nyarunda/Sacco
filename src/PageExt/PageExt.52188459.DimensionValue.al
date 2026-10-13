pageextension 50122 DimensionValueExt extends "Dimension Values"
{

    layout
    {


        addafter("Consolidation Code")
        {

            field("Guarantor Multiplier"; Rec."Guarantor Multiplier")
            {
                ApplicationArea = Basic;
            }

            field("CRB Code"; Rec."CRB Code")
            {
                ApplicationArea = Basic;
            }
            field(ShowOnPortal; Rec."Show On Portal")
            {
                ApplicationArea = Basic;
            }
            field(PortalName; Rec."Portal Name")
            {
                ApplicationArea = Basic;
            }
            field(PostalAddress; Rec."Postal Address")
            {
                ApplicationArea = Basic;
            }
            field(Location; Rec.Location)
            {
                ApplicationArea = Basic;
            }
            field(PhoneNo; Rec."Phone No.")
            {
                ApplicationArea = Basic;
            }
            field(EMail; Rec."E-Mail")
            {
                ApplicationArea = Basic;
            }
            field(WorkingHours; Rec."Working Hours")
            {
                ApplicationArea = Basic;
            }
        }

    }

}

