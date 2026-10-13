Page 51134 "HR Employee Transfer Effected"
{
    Editable = false;
    PageType = Card;
    SourceTable = Employee;

    layout
    {
        area(content)
        {
            group(General)
            {
                field(No; Rec."No.")
                {
                    ApplicationArea = Basic;
                }
                field(FirstName; Rec."First Name")
                {
                    ApplicationArea = Basic;
                }
                field(MiddleName; Rec."Middle Name")
                {
                    ApplicationArea = Basic;
                }
                field(LastName; Rec."Last Name")
                {
                    ApplicationArea = Basic;
                }
                /*field(PostalAddress;Rec."Postal Address")
                {
                    ApplicationArea = Basic;
                }
                field(HomePhoneNumber;Rec."Home Phone Number")
                {
                    ApplicationArea = Basic;
                }
                field(CellularPhoneNumber;Rec."Cellular Phone Number")
                {
                    ApplicationArea = Basic;
                }
                field(JobID;Rec."Job ID")
                {
                    ApplicationArea = Basic;
                }*/
                field(JobTitle; Rec."Job Title")
                {
                    ApplicationArea = Basic;
                }
                field(GlobalDimension1Code; Rec."Global Dimension 1 Code")
                {
                    ApplicationArea = Basic;
                }
                /*field(GlobalDimension1Name;Rec."Global Dimension 1 Name")
                {
                    ApplicationArea = Basic;
                }*/
                field(GlobalDimension2Code; Rec."Global Dimension 2 Code")
                {
                    ApplicationArea = Basic;
                }
                /*field(GlobalDimension2Name;Rec."Global Dimension 2 Name")
                {
                    ApplicationArea = Basic;
                }*/
            }
            /*part(Control16;Rec."HR Emp Transfers")
            {
                Editable = false;
                SubPageLink = "Employee No" = field("No.");
            }*/
        }
    }

    actions
    {
    }
}

