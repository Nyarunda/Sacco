page 50027 "UPG_Fixed Assets"
{
    Caption = 'UPG_Fixed Assets';
    PageType = List;
    SourceTable = "Fixed Asset";

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the number of the involved entry or record, according to the specified number series.';
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies a description of the fixed asset.';
                }
                field("FA Class Code"; Rec."FA Class Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the class that the fixed asset belongs to.';
                }
                field("FA Subclass Code"; Rec."FA Subclass Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the subclass of the class that the fixed asset belongs to.';
                }
                field("Account No."; Rec."Vendor No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the number of the vendor from which you purchased this fixed asset.';
                }
                field("Main Asset/Component"; Rec."Main Asset/Component")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies if the fixed asset is a main fixed asset or a component of a fixed asset.';
                }
                field("Component of Main Asset"; Rec."Component of Main Asset")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the number of the main fixed asset.';
                }
                field("Serial No."; Rec."Serial No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the fixed asset''s serial number.';
                }
                field("FA Posting Group"; Rec."FA Posting Group")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the FA Posting Group field.';
                }
                field(Custodian; Rec.Custodian)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the FA Posting Group field.';
                }
                field("Depart. / Section"; Rec."Depart. / Section")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the FA Posting Group field.';
                }
                field("Year of Purchase"; Rec."Year of Purchase")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the FA Posting Group field.';
                }
            }
        }
    }
}
