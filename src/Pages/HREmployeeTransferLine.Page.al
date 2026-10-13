Page 51027 "HR Employee Transfer Line"
{
    PageType = ListPart;
    SourceTable = "HR Employee Transfer Lines";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(RequestNo; Rec."Request No")
                {
                    ApplicationArea = Basic;
                }
                field(EmployeeNo; Rec."Employee No")
                {
                    ApplicationArea = Basic;
                }
                field(EmployeeName; Rec."Employee Name")
                {
                    ApplicationArea = Basic;
                }
                field(GlobalDimension1Code; Rec."Global Dimension 1 Code")
                {
                    ApplicationArea = Basic;
                }
                field(GlobalDimension2Code; Rec."Global Dimension 2 Code")
                {
                    ApplicationArea = Basic;
                }
                field(ShortcutDimension3Code; Rec."Shortcut Dimension 3 Code")
                {
                    ApplicationArea = Basic;
                }
                field(NewGlobalDimension1Code; Rec."New Global Dimension 1 Code")
                {
                    ApplicationArea = Basic;
                }
                field(RequestedNewRegionCode; Rec."New Global Dimension 2 Code")
                {
                    ApplicationArea = Basic;
                    Caption = 'Requested New Region Code';
                }
                field(NewShortcutDimension3Code; Rec."New Shortcut Dimension 3 Code")
                {
                    ApplicationArea = Basic;
                }
                field(Dimension1Description; Rec."Dimension 1 Description")
                {
                    ApplicationArea = Basic;
                }
                field(NewDimension1Description; Rec."New Dimension 1 Description")
                {
                    ApplicationArea = Basic;
                }
                field(Dimension2Description; Rec."Dimension 2 Description")
                {
                    ApplicationArea = Basic;
                }
                field(NewDimension2Description; Rec."New Dimension 2 Description")
                {
                    ApplicationArea = Basic;
                }
                field(Dimension3Description; Rec."Dimension 3 Description")
                {
                    ApplicationArea = Basic;
                }
                field(NewDimension3Description; Rec."New Dimension 3 Description")
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

