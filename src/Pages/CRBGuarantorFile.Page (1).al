Page 50215 "CRB Guarantor File"
{
    Editable = false;
    PageType = List;
    SourceTable = "CRB Main Data";
    SourceTableView = where("Client Type" = const(Guarantor));

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(LendersRegisteredName; Rec."Lenders Registered Name")
                {
                    ApplicationArea = Basic;
                }
                field(LendersTradingName; Rec."Lenders Trading Name")
                {
                    ApplicationArea = Basic;
                }
                field(LendersBranchName; Rec."Lenders Branch Name")
                {
                    ApplicationArea = Basic;
                }
                field(ClientCode; Rec."Client Code")
                {
                    ApplicationArea = Basic;
                }
                field(AccountNo; Rec."Account No.")
                {
                    ApplicationArea = Basic;
                }
                field(Surname; Rec.Surname)
                {
                    ApplicationArea = Basic;
                }
                field(Name2; Rec."Name 2")
                {
                    ApplicationArea = Basic;
                }
                field(Name3; Rec."Name 3")
                {
                    ApplicationArea = Basic;
                }
                field(Name4; Rec."Name 4")
                {
                    ApplicationArea = Basic;
                }
                field(DateofBirth; Rec."Date of Birth")
                {
                    ApplicationArea = Basic;
                }
                field(Gender; Rec.Gender)
                {
                    ApplicationArea = Basic;
                }
                field(Nationality; Rec.Nationality)
                {
                    ApplicationArea = Basic;
                }
                field(MaritalStatus; Rec."Marital Status")
                {
                    ApplicationArea = Basic;
                }
                field(GuaranteeType; Rec."Guarantee Type")
                {
                    ApplicationArea = Basic;
                }
                field(GroupName; Rec."Group Name")
                {
                    ApplicationArea = Basic;
                }
                field(GuarantorRelationship; Rec."Guarantor Relationship")
                {
                    ApplicationArea = Basic;
                }
                field(GuaranteeLimit; Rec."Guarantee Limit")
                {
                    ApplicationArea = Basic;
                }
                field(PrimaryIdentification1; Rec."Primary Identification 1")
                {
                    ApplicationArea = Basic;
                }
                field(SecondaryIdentification1; Rec."Secondary Identification 1")
                {
                    ApplicationArea = Basic;
                }
                field(PlotNo; Rec."Plot No.")
                {
                    ApplicationArea = Basic;
                }
                field(LocationTown; Rec."Location Town")
                {
                    ApplicationArea = Basic;
                }
                field(LocationCountry; Rec."Location Country")
                {
                    ApplicationArea = Basic;
                }
            }
        }
    }

    actions
    {
    }
}

