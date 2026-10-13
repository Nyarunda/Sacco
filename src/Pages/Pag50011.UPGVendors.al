page 50021 UPG_Vendors
{
    Caption = 'UPG_Vendors';
    PageType = List;
    SourceTable = UPG_Vendors;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("No,"; Rec."No,")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the No, field.';
                }
                field(Name; Rec.Name)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Name field.';
                }
                field("Posting group"; Rec."Posting group")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Posting group field.';
                }
                field(Balance; Rec.Balance)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Balance field.';
                }
                /*
                field(Phone; Rec.Phone)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Phone field.';
                }
                field(Contact; Rec.Contact)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Contact field.';
                }
                */
            }
        }
    }
}
