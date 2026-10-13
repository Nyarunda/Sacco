Page 50987 "HR Medical Schemes List"
{
    CardPageID = "HR Medical Schemes Card";
    DeleteAllowed = false;
    PageType = List;
    SourceTable = "HR Medical Schemes";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(SchemeNo; Rec."Scheme No")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(MedicalInsurer; Rec."Medical Insurer")
                {
                    ApplicationArea = Basic;
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
    }
}

