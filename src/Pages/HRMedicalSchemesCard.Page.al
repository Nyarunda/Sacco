Page 50986 "HR Medical Schemes Card"
{
    PageType = Card;
    PromotedActionCategories = 'Manage,Process,Report,Members';
    SourceTable = "HR Medical Schemes";

    layout
    {
        area(content)
        {
            group(General)
            {
                field(SchemeNo; Rec."Scheme No")
                {
                    ApplicationArea = Basic;
                }
                field(MedicalInsurer; Rec."Medical Insurer")
                {
                    ApplicationArea = Basic;
                }
                field(InsurerName; Rec."Insurer Name")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(SchemeName; Rec."Scheme Name")
                {
                    ApplicationArea = Basic;
                }
                field(Inpatientlimit; Rec."In-patient limit")
                {
                    ApplicationArea = Basic;
                }
                field(Outpatientlimit; Rec."Out-patient limit")
                {
                    ApplicationArea = Basic;
                }
                field(AreaCovered; Rec."Area Covered")
                {
                    ApplicationArea = Basic;
                }
                field(DependantsIncluded; Rec."Dependants Included")
                {
                    ApplicationArea = Basic;
                }
                field(Comments; Rec.Comments)
                {
                    ApplicationArea = Basic;
                }
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group(Functions)
            {
                Caption = '&Functions';
                action(MedicalSchemeMembers)
                {
                    ApplicationArea = Basic;
                    Caption = 'Medical Scheme Members';
                    Image = PersonInCharge;
                    Promoted = true;
                    PromotedCategory = Category4;
                    RunObject = Page "HR Medical Scheme Members List";
                    RunPageLink = "Scheme No" = field("Scheme No");
                }
            }
        }
    }
}

