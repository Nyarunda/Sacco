page 50022 UPG_Customer
{
    Caption = 'UPG_Customer';
    PageType = List;
    SourceTable = UPG_Customers;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the No. field.';
                }

                field(Name; Rec.Name)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Balance field.';
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
                field(Phone;Rec.Rec.Phone)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Phone field.';
                }
                field(Contact;Rec.Rec.Contact)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Contact field.';
                }
                field(Name;Rec.Rec.Name)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Contact field.';
                }
                */
            }
        }
    }
}
