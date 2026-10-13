//namespace CentralDB.CentralDB;

page 50650 "Next of Kin App. Group"
{
    ApplicationArea = All;
    Caption = 'Next of Kin App. Group';
    PageType = ListPart;
    SourceTable = "Next of Kin.";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Principal ID No."; Rec."Principal ID No.")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(IDNo; Rec."ID No.")
                {
                    Caption = 'ID No./Birth Cert. No.';
                    ApplicationArea = Basic;
                }
                field(Name; Rec.Name)
                {
                    ApplicationArea = Basic;
                }
                field(DateofBirth; Rec."Date of Birth")
                {
                    ApplicationArea = Basic;
                }
                field(Email; Rec.Email)
                {
                    ApplicationArea = Basic;
                }

                field(MobilePhoneNo; Rec."Mobile Phone No.")
                {
                    ApplicationArea = Basic;
                }
                field(Relationship; Rec.Relationship)
                {
                    ApplicationArea = Basic;
                }
                field("Next Of Kin"; Rec."Next Of Kin")
                {
                    ApplicationArea = Basic;

                }
                field(Beneficiary; Rec.Beneficiary)
                {
                    ApplicationArea = Basic;
                }
                field("%Allocation"; Rec."%Allocation")
                {
                    ApplicationArea = Basic;
                }
            }
        }
    }
}
