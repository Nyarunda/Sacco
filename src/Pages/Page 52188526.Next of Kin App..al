
Page 50189 "Next of Kin App."
{
    PageType = List;
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
                    Visible = false;
                }
                field(Type; Rec.Type)
                {
                    ApplicationArea = Basic;
                }
                field("Member No"; Rec."Member No")
                {
                    ApplicationArea = Basic;
                }
                field(IDNo; Rec."ID No.")
                {
                    Caption = 'ID No.';
                    ApplicationArea = Basic;
                    ShowMandatory = true;
                }

                field(Name; Rec.Name)
                {
                    ApplicationArea = Basic;
                }
                field(DateofBirth; Rec."Date of Birth")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field(Email; Rec.Email)
                {
                    ApplicationArea = Basic;
                    Visible = false;
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
                    Visible = false;
                }
                field(Spouse; Rec.Spouse)
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field(Beneficiary; Rec.Beneficiary)
                {
                    ApplicationArea = Basic;
                    visible = false;
                    trigger OnValidate()
                    var
                        myInt: Integer;
                    begin
                        Rec.TestField(Relationship);
                    end;
                }
                field("%Allocation"; Rec."%Allocation")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
            }
        }
    }

    actions
    {
    }
}

