Page 50967 "HR Asset Transfer Lines"
{
    DeleteAllowed = false;
    PageType = ListPart;
    SourceTable = "HR Asset Transfer Lines";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(No; Rec."No.")
                {
                    ApplicationArea = Basic;
                }
                field(AssetNo; Rec."Asset No.")
                {
                    ApplicationArea = Basic;
                }
                field(AssetBarCode; Rec."Asset Bar Code")
                {
                    ApplicationArea = Basic;
                }
                field(AssetDescription; Rec."Asset Description")
                {
                    ApplicationArea = Basic;
                }
                field(FALocation; Rec."FA Location")
                {
                    ApplicationArea = Basic;
                }
                field(AssetSerialNo; Rec."Asset Serial No")
                {
                    ApplicationArea = Basic;
                }
                field(ResponsibleEmployeeCode; Rec."Responsible Employee Code")
                {
                    ApplicationArea = Basic;
                }
                field(EmployeeName; Rec."Employee Name")
                {
                    ApplicationArea = Basic;
                }
                field(NewResponsibleEmployeeCode; Rec."New Responsible Employee Code")
                {
                    ApplicationArea = Basic;
                }
                field(NewEmployeeName; Rec."New Employee Name")
                {
                    ApplicationArea = Basic;
                }
                field(GlobalDimension1Code; Rec."Global Dimension 1 Code")
                {
                    ApplicationArea = Basic;
                }
                field(Dimension1Name; Rec."Dimension 1 Name")
                {
                    ApplicationArea = Basic;
                }
                field(NewGlobalDimension1Code; Rec."New Global Dimension 1 Code")
                {
                    ApplicationArea = Basic;
                }
                field(NewDimension1Name; Rec."New  Dimension 1 Name")
                {
                    ApplicationArea = Basic;
                }
                field(GlobalDimension2Code; Rec."Global Dimension 2 Code")
                {
                    ApplicationArea = Basic;
                }
                field(Dimension2Name; Rec."Dimension 2 Name")
                {
                    ApplicationArea = Basic;
                }
                field(NewGlobalDimension2Code; Rec."New Global Dimension 2 Code")
                {
                    ApplicationArea = Basic;
                }
                field(NewDimension2Name; Rec."New  Dimension 2 Name")
                {
                    ApplicationArea = Basic;
                }
                field(GlobalDimension3Code; Rec."Global Dimension 3 Code")
                {
                    ApplicationArea = Basic;
                }
                field(Dimension3Name; Rec."Dimension 3 Name")
                {
                    ApplicationArea = Basic;
                }
                field(NewGlobalDimension3Code; Rec."New Global Dimension 3 Code")
                {
                    ApplicationArea = Basic;
                }
                field(NewDimension3Name; Rec."New  Dimension 3 Name")
                {
                    ApplicationArea = Basic;
                }
                field(IsAssetExpectedBack; Rec."Is Asset Expected Back?")
                {
                    ApplicationArea = Basic;
                }
                field(NewAssetLocation; Rec."New Asset Location")
                {
                    ApplicationArea = Basic;
                }
                field(ReasonforTransfer; Rec."Reason for Transfer")
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

